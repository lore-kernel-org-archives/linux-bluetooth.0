Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCAC678D4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 09:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCFJHm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 04:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCFJHh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 04:07:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342A222A13
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 01:07:36 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a10-20020a056a000c8a00b005fc6b117942so5139786pfv.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Mar 2023 01:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678093655;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4A46wKTC+CcMedW/G9j+SuC/vj+S0/LGxEORBPUqymI=;
        b=jkvSAN8NSy+uLMta6N+AwFqfJL62XqCwN2Bvyh1/a4/UbQHwRL3F/PnRe/nQwArwp+
         pOFb3Q5ynk4fHladF23EbePCt7qkXIXnZz31qzXoKEcyttpIsLznMvMwOYwFrIAZzTaa
         JQ6HYh6KSSQtTZAjFvWY2qaQCCyGsnsU+sQGrAVrIEJMzbMjsSKERgSuP8SFd1AhIIXQ
         nzs4sYU43IKvUecajKYsdYNRSr2m4gS6DyRR2g0M8z4QOplfdoba7KAt0mdbmpReptu/
         kHiIF4rCYUdxPJkcT1kxuhqhIf3ofnBN6ZJjhZayUrHE/t/M+5gSPyyhK14GKyXbNDzB
         lsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678093655;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4A46wKTC+CcMedW/G9j+SuC/vj+S0/LGxEORBPUqymI=;
        b=3NTurkynaFc9x9zc7B23gCPQiAWvPPqr9mE7m5Ibxt6ltI29C2XVGbPkv7BBYKyxbX
         ncQsbMksfJ/yWd2w1C4AcV0BVznNUkBgke+ufLNzZHbm19lVVzQMQFdtelBIQh0zl9F0
         htjVZ/DAoMa7hoJLWnO7Efc5erMXnfFOPqOWVQ9e1JnVTTKpPTisCTLbiFRYpabtjJRy
         gzLLxAkJMloTsVzYRSztbBVtgTWrksbI/3TosGFFYo9WGZPfs3pubrYnLPQ+bxASFx1n
         zvzdfilloPOrE7ZteT1OKc1okAjF36hmnZyAOopNQoKVPXViF0f8a+YO40flyNJhsv8n
         ++Dw==
X-Gm-Message-State: AO0yUKXdK7yuTDaClEiwczgGasOG5XrHfdg3rl2ymPzwKuQtEZwLGj2C
        cLBUjCPi6lOzqWZ3S5WF+ypC/FRcdrdkxXG74KqSXIDcttteOE6iza+JzqiIbQn5g7clCcQmn19
        dFOlT1u5Mu5P0n8pasmOpxnD/Upc0Ur4MopGCm81n7aWF50MOBD+2epdKSXZPeRpua4FHaCQ4QP
        AM
X-Google-Smtp-Source: AK7set/jjFYkNXqa31b0x4vkHuOnIhd4oQL+wq7Pm60LeC6WBNHSXLU9Hyr58Rwz92XV5T/MwzVUExwVqHoS
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:d5f3:860e:1224:5e0a])
 (user=apusaka job=sendgmr) by 2002:a62:ce43:0:b0:593:dc61:2161 with SMTP id
 y64-20020a62ce43000000b00593dc612161mr4272494pfg.2.1678093655488; Mon, 06 Mar
 2023 01:07:35 -0800 (PST)
Date:   Mon,  6 Mar 2023 17:07:07 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306170628.1.I8d0612b2968dd4740a4ceaf42f329fb59d5b9324@changeid>
Subject: [PATCH] Bluetooth: hci_sync: Don't wait peer's reply when powering off
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Currently, when we initiate disconnection, we will wait for the peer's
reply unless when we are suspending, where we fire and forget the
disconnect request.

A similar case is when adapter is powering off. However, we still wait
for the peer's reply in this case. Therefore, if the peer is
unresponsive, the command will time out and the power off sequence
will fail, causing "bluetooth powered on by itself" to users.

This patch makes the host doesn't wait for the peer's reply when the
disconnection reason is powering off.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>

---

 net/bluetooth/hci_sync.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 561a519a11bd6..a6cea389b675f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5103,10 +5103,12 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	cp.handle = cpu_to_le16(conn->handle);
 	cp.reason = reason;
 
-	/* Wait for HCI_EV_DISCONN_COMPLETE not HCI_EV_CMD_STATUS when not
-	 * suspending.
+	/* Wait for HCI_EV_DISCONN_COMPLETE, not HCI_EV_CMD_STATUS, when the
+	 * reason is anything but HCI_ERROR_REMOTE_POWER_OFF. This reason is
+	 * used when suspending or powering off, where we don't want to wait
+	 * for the peer's response.
 	 */
-	if (!hdev->suspended)
+	if (reason != HCI_ERROR_REMOTE_POWER_OFF)
 		return __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
 						sizeof(cp), &cp,
 						HCI_EV_DISCONN_COMPLETE,
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

