Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B9C32774
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 04:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiHWEoo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 00:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238940AbiHWEon (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 00:44:43 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B1D52FEE
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:44:42 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id s3-20020a17090a5d0300b001fb3ac54a03so1575135pji.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=oAES/CRzxT/8dcoOMmdV0cByj8R02dL73KkeFTknRA4=;
        b=h5S3F1umhD/slt6d+GYuUsnRCqXadhS7WTydLOxjb87Sl6XLjWzvH9PY/pv/15CgZZ
         YIF0pzztMXX3brkyVekY5fBjAr1Q/qaNtYRyW+Np6P9k1C31ZElLKDErvAhOgKNJwTNA
         BO3drL/CuFssDScJpvQr4kx2Fi1GHVVbyphYDLK8X9lO5TW+2Bbm9O5jGt0swPUbCNmC
         oEAkzS3EscyQyrPdluMhWRa8Vdqa0tYzflpauj5PJDBEqH1DctJhbNVqzr4VUppamI6X
         joazzWiCZL9xeLnJxFLkIQgNfiOdh9p+QV5+WzbZhW/X8JtlgMQH2P9O2OqqTNamXQM8
         lQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=oAES/CRzxT/8dcoOMmdV0cByj8R02dL73KkeFTknRA4=;
        b=4/4Wt+dQr0rSt2RgnCJgR8QXGXC0Ybc2pxZEmWmeEk4CtpO4lCWjpP96u4Ts8A5urt
         MTjHKw9v+++abQp5mZ7vPDtUrY5Dt5sqST/oJa4UfiKNx/jLo7cWyRVAoeJ1lVJOGv+R
         WVXecykNbuAQZERS8oOxz7u7vLJoQJ+Bq1YlLVoizdaYAzoDQrIvjp1fHV9A/O8ZLj/d
         F3Cw3Rh12cOjlFqYecq5m5b2nWHdYj0GU4KofPNXq19mYkdNbU8bNMc5kOFZi0bXdld4
         4cbFVmg+aeed6W5rdM//bgQd9nMznfgirvfpVYEaqrSXhQtgLc+cs0cIKWBlUc5Hwnpi
         XhAw==
X-Gm-Message-State: ACgBeo2+tdJUEg3ICJRXG19c4DEi3mbhT+AvcP8bZ7lov13Ua0QQNdQu
        OVqcLdwCcXCtR9ynfCuOIuY5PVrC1t6TX385R8WV/+8YIAQHngqY3Sfb6D7gnQuVWYXbDg2Q++R
        qhHwc6KyJt+b+zOLHwVz6CbPBRQIvbxULqq/2Qhwg/8d8cTphXzzwuNNMSFqSSO43QUHRGksm2v
        6S
X-Google-Smtp-Source: AA6agR7kNeuE7NwOAsEre+MOLXlMtAyvEaMKjInRrNGhrnXofgV4brRKgcPFAjG5rVMLS+4j0s/9/suMIuLn
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90b:4a4b:b0:1fb:18e2:ffbc with SMTP id
 lb11-20020a17090b4a4b00b001fb18e2ffbcmr1565234pjb.96.1661229881508; Mon, 22
 Aug 2022 21:44:41 -0700 (PDT)
Date:   Mon, 22 Aug 2022 21:44:34 -0700
In-Reply-To: <20220823044434.3402413-1-jiangzp@google.com>
Message-Id: <20220822214430.kernel.v2.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
Mime-Version: 1.0
References: <20220823044434.3402413-1-jiangzp@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [kernel PATCH v2 1/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When disconnecting all devices, hci_conn_failed is used to cleanup
hci_conn object when the hci_conn object cannot be aborted.
The function hci_conn_failed requires the caller holds hdev->lock.

Fixes: 9b3628d79b46f ("Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted")

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v2:
- Update commit message

Changes in v1:
- Hold hdev->lock for hci_conn_failed

 net/bluetooth/hci_sync.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 74a0cd5d0b37f..e08c0503027d8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5034,9 +5034,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		/* Cleanup hci_conn object if it cannot be cancelled as it
 		 * likelly means the controller and host stack are out of sync.
 		 */
-		if (err)
+		if (err) {
+			hci_dev_lock(hdev);
 			hci_conn_failed(conn, err);
-
+			hci_dev_unlock(hdev);
+		}
 		return err;
 	case BT_CONNECT2:
 		return hci_reject_conn_sync(hdev, conn, reason);
-- 
2.37.1.595.g718a3a8f04-goog

