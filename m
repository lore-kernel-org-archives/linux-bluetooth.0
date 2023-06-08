Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CFDC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 21:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbjFHVGw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjFHVGu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 17:06:50 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D482D42
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 14:06:49 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QccGH3WCZzyW9;
        Fri,  9 Jun 2023 00:06:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1686258407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EGxDCnVTGU8lZ/QjJFg6Onc5fauiPo+ZrNSEJsW593A=;
        b=bu8m+52doo3suhpUFckKVOnT558/ih/QXcXBz+7c1SY/HR9YWWVYEOH492buckbxzP15uY
        GcMEvGcrI9H/BsmSHnrTXjd37+fLbj5WPepBibaOo+Gwc5+ghqj1t1cZaQW7PsRwtPYk/U
        q4ktv1W1tILbqXWgBBSqNGKnLy/qmPk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1686258407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EGxDCnVTGU8lZ/QjJFg6Onc5fauiPo+ZrNSEJsW593A=;
        b=lQeXCfSGrGKlPI73UUSUQEaf20QZy1tZCJAi4NxJ6WP1FLYo3n8cagOyR6uWp9SC7YuzWn
        z6+sssAM4m6CTSDTH+rhk9kbf7G+GiKu3IsoMpjZLR2crMn3v9gh2u1ssLepPHKTmSZXMB
        usD9wSlx0z+zRvvE5IlYgEyR9SJZLfI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1686258407; a=rsa-sha256; cv=none;
        b=XkMttbhb1BgXDVClmqP6CmnqH/ryX6nSUwcEPgn5TiWY0pQ8bkx0GEF7F5nbHbpw6mgyDs
        c+mgURNowFHTIB4EjXop4C//6g8KTUgFcgB7XzCaGTLnMXWFvjwDCRfwr7X6tEPHF00TDy
        /rqjYmnFWf9w3r8eepf2oxbEo+mQiQM=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 0/3] Bluetooth: ISO-related concurrency fixes
Date:   Fri,  9 Jun 2023 00:06:41 +0300
Message-Id: <cover.1686252492.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series addresses some concurrency issues (NULL / GPF) in ISO
sockets or related.

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

This also produces a few other types of crashes / KASAN errors, but not
addressed here.

Pauli Virtanen (3):
  Bluetooth: hci_sync: iterate over hci_conn_params safely
  Bluetooth: hci_event: call ISO disconnect callback before deleting
    conn
  Bluetooth: ISO: fix iso_conn related locking and validity issues

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        |  6 +++
 net/bluetooth/hci_sync.c         | 81 ++++++++++++++++++++++++++++----
 net/bluetooth/iso.c              | 53 ++++++++++++---------
 4 files changed, 111 insertions(+), 30 deletions(-)

-- 
2.40.1

