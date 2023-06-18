Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC9EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Jun 2023 22:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjFRWEt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Jun 2023 18:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFRWEs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Jun 2023 18:04:48 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DFFCF
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Jun 2023 15:04:47 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Qkn4W4nzdzyV2;
        Mon, 19 Jun 2023 01:04:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1687125883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D4l7qWwIQkMCfRXA9sOibFHVNmXVjTzNxQ3qkmTNqaQ=;
        b=GyJ/H/MaeYaKQRxBc7knaeWk2jz/h45qLsoKEQXKB3vORev/CJVhY51T/c3R1XUkTOTBGb
        Tk5es5rS50kIu6Cvp1jYPBNVr3MnSwpk3LIBlX712Z2WYXifUxs9gwNeQTYuLewNkvnzFc
        nX71HdUeR2pwcqMQPnNBioCg0tK9Xz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1687125883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D4l7qWwIQkMCfRXA9sOibFHVNmXVjTzNxQ3qkmTNqaQ=;
        b=qngYgmvR2NfEuBMoXD/EKOQMdSE6MYyOkerP3AxZ1+z7UpLXygUTFZOKf+uygcU3y2EBd5
        X06DZkyTj+9dozU7VMfDehz0OmluKMiltR8cjshEkw6lXXYCPQADNFG2S1pdziP0chjYvv
        M1aArK3KmSfm44FuQsuRc2PZg1bNo6I=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1687125883; a=rsa-sha256; cv=none;
        b=kcqg+05GqM53uh34xo1JQmowbs77bRwaT9g/pQutDT/ja4mdjKTH8C3xG2PNQgGC/U+oEM
        OfGD1sFZajX8saSd66DawZiV7UTPzhnP83PD+a1ps//et99YYMETf1ythDHjy/7/HA0hKT
        EG7L6TLGcNvVwLZPT/IGtM108WHpwO0=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v3 0/3] Bluetooth: ISO-related concurrency fixes
Date:   Mon, 19 Jun 2023 01:04:30 +0300
Message-ID: <cover.1687115142.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series addresses some concurrency issues (NULL / GPF) in ISO
sockets or related.

v3:
- Copy the pend_le_* lists, iterate over copy to make it simple.
- Rename to hci_pend_le_list_*

v2:
- Use RCU for the pend_le_* lists, avoid using hci_dev_lock.
- Always call disconn_cfm before hci_conn_del.

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

 include/net/bluetooth/hci_core.h |   5 ++
 net/bluetooth/hci_conn.c         |  10 +--
 net/bluetooth/hci_core.c         |  38 ++++++++--
 net/bluetooth/hci_event.c        |  15 ++--
 net/bluetooth/hci_sync.c         | 117 ++++++++++++++++++++++++++++---
 net/bluetooth/iso.c              |  53 ++++++++------
 net/bluetooth/mgmt.c             |  26 +++----
 7 files changed, 198 insertions(+), 66 deletions(-)

-- 
2.41.0

