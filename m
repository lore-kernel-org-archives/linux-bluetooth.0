Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59991C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 12:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjDTMXr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 08:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjDTMXq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 08:23:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA7B59C7
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 05:23:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-555d8c556faso20621207b3.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681993424; x=1684585424;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VyYkUgfpkn7wH0j2BAe1UVwheOGlOiDjxtv8agVE+bw=;
        b=TbQn/Mbd2r9XbgqECjXDNQ1qXc11e+lRv5zVbY5g0fUxU/wBDgi0LWdBvJ5EzfN2vS
         nbC0c3At6RoNmHTkHR7olw8UwMzG78HCLxLcPErHiS/OjPLCaKqfWb4ihfJFtRDkOInk
         5/xJJwjjSRtVs4SvIGI+ija/vJ+OpKQJP/bI64FBBytS2a+frulCCNNKSlQxPdJXjueo
         OwIo0PzvJTH+t14FcAXUSmdH6RsQ1BaU10JvbGZXM8W7dzClnZ0sGZ8dBdbQz3d3oRVB
         idGJUnyeoIQuTUE3Pqa5RYfI3fvc6B1omoFTq6C4av/3vsyTbzJzisxdMsKBZF95I7fQ
         Vvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681993424; x=1684585424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyYkUgfpkn7wH0j2BAe1UVwheOGlOiDjxtv8agVE+bw=;
        b=UKZU7hPR4iASg314kEbyK5abiAL8R2VPEa1YD4rNSQjqByOh1ZWuutOVGO9E+9Q+uX
         NRmJ0lI1Mro28giU8L0SdK2Gt5TlRQuV2P0cAYagiUUn083HIERD3plQpaOMSHM3zFas
         YVGT6B71oamQEYiBpa8x5G2EIwB7jYU8ZG5dJApKQCBcfv+ZWnpWc7PDpwUck9v289ob
         9GZ9AMtLzwf4E+/RcpZT9SH4rmRRlEUk63X8pFJiW1508+Ij0EByRf7VtT8VCaD8C3W/
         DSDKzzD4G65r3Baolhr5uA+3qAreGmK7HK2rsd336L0Gp5PffKvqmT3MMAVeRK4bzCRr
         klvA==
X-Gm-Message-State: AAQBX9cKHvu3zN89rdahWoZg39H7Pm9+2IvaOq0bOE8XpFqKsuwHrn3d
        1mQK2Md9vQzcJ8bBV02QYygGD4rPKsoaEiVBnKhH4TMBa6e40c1QdcUTvRQACIAT98H3iOn8M7Y
        /QL/79H2P3tyZWqj85dWd7L+e7FJGUs2qj8qgFqDs3fCaOaYFrcvIf46cgzOaiugcG188o9P+oW
        64
X-Google-Smtp-Source: AKy350abez9O9onkkWOz4907E7Tm2r2pMZdIYnuyIOpOSJjrHP1NRWsW0B4RvmPmbW4IZX2IfF9GAKPclgfj
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:f314:6a1b:5ed1:38f4])
 (user=apusaka job=sendgmr) by 2002:a25:d796:0:b0:b92:5112:3f53 with SMTP id
 o144-20020a25d796000000b00b9251123f53mr673809ybg.2.1681993424038; Thu, 20 Apr
 2023 05:23:44 -0700 (PDT)
Date:   Thu, 20 Apr 2023 20:23:36 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420202312.1.I53bc906a716045c7474a77d3038bfcb6909094e2@changeid>
Subject: [PATCH] Bluetooth: Cancel sync command before suspend and power off
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Ying Hsu <yinghsu@chromium.org>,
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

Some of the sync commands might take a long time to complete, e.g.
LE Create Connection when the peer device isn't responding might take
20 seconds before it times out. If suspend command is issued during
this time, it will need to wait for completion since both commands are
using the same sync lock.

This patch cancel any running sync commands before attempting to
suspend or adapter power off.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Ying Hsu <yinghsu@chromium.org>

---

 net/bluetooth/hci_core.c | 3 +++
 net/bluetooth/mgmt.c     | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 393b317ae68f6..a856b1051d355 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2803,6 +2803,9 @@ int hci_suspend_dev(struct hci_dev *hdev)
 	if (mgmt_powering_down(hdev))
 		return 0;
 
+	/* Cancel potentially blocking sync operation before suspend */
+	__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
+
 	hci_req_sync_lock(hdev);
 	ret = hci_suspend_sync(hdev);
 	hci_req_sync_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5f8c144c84b88..13c745876b390 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1399,6 +1399,10 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	/* Cancel potentially blocking sync operation before power off */
+	if (cp->val == 0x00)
+		__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
+
 	err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
 				 mgmt_set_powered_complete);
 
-- 
2.40.0.634.g4ca3ef3211-goog

