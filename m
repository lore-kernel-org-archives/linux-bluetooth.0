Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D832EB64D0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 18:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjFMSGQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjFMSGP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 14:06:15 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEA319A7
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 11:06:10 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Qgc1W5WJXzyR6;
        Tue, 13 Jun 2023 21:06:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1686679567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y+NAgyxen7eId9gMkPBhizWri1SMI0z/15SuxX1GiM0=;
        b=i85ufTrAu6D5RpP2Lht7lkGdfYa6h8C5vOG5fU5ErMROmjd90ovknWALSJauOHGousPHH+
        jV5hkbDXBU2ibUBtR0Yo9GFVQ37/Zz2zjssteo0v2O/szKcOXSbnDqsJUSz/ZVZsTBMf9j
        FrL0mbM4lqXmF3TooFQwNUGr5aShOV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1686679567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y+NAgyxen7eId9gMkPBhizWri1SMI0z/15SuxX1GiM0=;
        b=EMF2vuO1JXyQnk/VCKnDWTIEiTm3oPF+osC00brzpYL837Z4xGkCgsHJYCDaDQhZcTI5fN
        MWmoD8sSn7C7YzyqGDYmIdYvhcrGbsw/Kj3jOtOR9G4GIl3xLdOefqpWLylBXRnGVVmG/E
        Sf7VR1TY+z2Uk0sTJWWb2ncngP0PQsY=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1686679567; a=rsa-sha256; cv=none;
        b=BK+kqM5bHgJRLEDnqHSwMMZzoUdSwhY0bsuBuYa/X0uLeY/SZEaOIWeHN9sKz7SMWlHX3L
        H1h5CGbdHSd10dsJB5yanDi77rCti+FZGWxjS8gomVJ3jeEwjKreWTV4cmw2IhzEbWlf7N
        F6jH5WkeqagAxUs2fdN0sNNvAgh9Lxk=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 0/3] Bluetooth: ISO-related concurrency fixes
Date:   Tue, 13 Jun 2023 21:06:01 +0300
Message-Id: <cover.1686589290.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series addresses some concurrency issues (NULL / GPF) in ISO
sockets or related.

v2:
- Use RCU for the pend_le_* lists, avoid using hci_dev_lock.
- Always call disconn_cfm before hci_conn_del (L2CAP also needs it).

These were found while testing patches that make hci_le_set_cig_params
check the validity of the configuration and return false if incorrect.
This causes dropping of hci_conn just created, which apparently makes
hitting race conditions easier.

The test setup was primitive

while true; do bluetoothctl power on; sleep 12; bluetoothctl power off; sleep 1.5; bluetoothctl power off; sleep 2.5; done;
while true; do sudo systemctl restart bluetooth; sleep 110; done
while true; do systemctl --user restart pipewire wireplumber pipewire-pulse; sleep 91; done
while true; do paplay sample.flac & sleep 2; kill %1; sleep 0.7; done

and equivalent operations manually, on VM + connect to TWS earbuds. This
eventually hit the NULL / GFP errors here, but they are hard to
reproduce aside from the first one that appears in iso-tester.

Pauli Virtanen (3):
  Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
  Bluetooth: hci_event: call disconnect callback before deleting conn
  Bluetooth: ISO: fix iso_conn related locking and validity issues

 include/net/bluetooth/hci_core.h |  5 ++
 net/bluetooth/hci_conn.c         |  9 ++--
 net/bluetooth/hci_core.c         | 34 +++++++++---
 net/bluetooth/hci_event.c        | 15 +++---
 net/bluetooth/hci_sync.c         | 93 ++++++++++++++++++++++++++++----
 net/bluetooth/iso.c              | 53 ++++++++++--------
 net/bluetooth/mgmt.c             | 30 +++++------
 7 files changed, 175 insertions(+), 64 deletions(-)

-- 
2.40.1

