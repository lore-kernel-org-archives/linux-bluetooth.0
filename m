Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794772460;
	b=CdVBUC6C73YU5zUb/IA9uzo7mKtiJuDVuqt/J6xyHTWTzNpKpbHNAZ5BS6sJkdoGUwa2
	 uFS1zz9PUq2HOlqKpNSz8ExZYQ6Y6oTMd2FDiB/v2vJzI0jAdqf6W8sE+urszkZG+VMEH
	 IX0OjMnMknYnOLu6FvEhhjcAchHwLkq/XGbymT90iu5ztKG3Q1kAD3APZRSnczqvdYw4W
	 ySG2DTeL8Ft793uGmMv0Rb0HZWO2Q4w/rDM4QAaWkBfDNunLKuvYBFqdLKxALKkHeagmq
	 FwrSL3D+NgBE5p5iuyNWC+OG27J9seFUM3kjjyRSec8S4II08dy7dfY8Mm7rktCtCOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794772460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/561T8b2RxuBwCplKNcYjJeaSc56gqYrUu2RLjDgEug=;
	b=YLqECohra0+FN+TqJkf2R6E4ZSjjYhhBMXW+o/CvHbpPhknlkVjvh1+uZiX5jGrTdN3u
	 PP7o+Rp9Ll7Zu+y1x3Dceo6zsNv3eqIAYq2F8jyjzeiiqVGWhwbJtIhnxcTrjwhmJgPMe
	 DM1UxhoR5LlAYG69uez83QBjlTdLPFlc5f37ZmObyH450YFwkPtf2YAC324+DNChI8SjK
	 TxyoHyWEbi4WoM0bZZ7NbJTg67748G13Y2xwJZ1vBQ2aM7hm5U+bKZ+iirGFZJajOJ9C4
	 mn9XXxIsUiQLU3KL515Jde5Gg1kGWUc06jXW8zftR6zRSexbqT5s2HW6EA1WJwss9BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7TsIVVk;
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621EB606A32F
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 19:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 621EB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7TsIVVk
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67db35e7953so397933d50.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 11:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794772459; x=1795377259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/561T8b2RxuBwCplKNcYjJeaSc56gqYrUu2RLjDgEug=;
        b=Z7TsIVVk19NtVa6edgu2WO3WasqQi0/UtjK8i6SKwOYuQI0j3n7pWeLFfqUaF/T2wv
         OgHRDB7yqwDNLFpScBIvKFJiRx1qK/ynky3RxtN5biukP6oL+vrm28fBbKNxpIP07AHr
         kS+nXU6Go/HOMp2DsgFHt7IV4k4eJr/drDD3Ai1mXKTsZ+fFhAdIaqvzNeERhCNpyhyz
         4LM5a6PsK6ctPFmNRX0aOzDkLyWi9PIL8t+kbrN04PQUd0iLsij5k+7g28p62cZgFcKK
         /1rn5mG3byrBazo6muIsSljvOT3AIh/x7aQs3ImgJdmj3vvxNrdTJH9U4K5A7I8UeGxt
         lUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794772459; x=1795377259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/561T8b2RxuBwCplKNcYjJeaSc56gqYrUu2RLjDgEug=;
        b=eYhGFn9cp3asX/IjQV/Ae7ERjzkeDi+TyJG+LYPBHiivdfrsSeUEOiUZ661yGJoL9D
         mSbDS+PmDUolmGHAXFOeOQFJVXmGhjOSuLthS6yuMTCHDsX/dxziqvjP8TUgcRMBIXD2
         YmqkAnzz2sky9MMZi3lEGCtcjX78TMHGug+jOPn2OvZUhds3Q6z71WKgp7X7kyINMKQc
         7TKKm2yrjhH1FdFnK2y//9ycquQK8rm/BVM9p98sHgEjlFUHrORTxvXPpAzjnFABJT/d
         ZFg5hphi8Tn2hfXHt+0I2JhBnZTzF1Cz2bN4oUY7fYW9eNVvEIG4OjB6mcqfV95khd/b
         hBZA==
X-Forwarded-Encrypted: i=1; AL+hErG7Te66wyCMI6r96obsI6PSgvCgJ018MhhdwPa+AghcKqPGAD3FDtKv3nrh7+OEFab9zWtb+/PzDOY3w1PIyWI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ff+0rWCPcQOUG5pug7oqn3aLgX/LgJFPWRbRoKKsgRaxnlhJy
	3Xrqh9PzC4Rba4EJIDrjt0UmU8NxRlqjMoKgZGzxl95nxDakWsbJbOr8
X-Gm-Gg: AYBFou0GJDamKFWH8cpARUMuu4am27hyjcxI133oPLcvYYIGMId9q37Sg+bMtikmEXp
	EbOskFbKb/PK8ID589RSsr12wlfwL9HCgo0a/n9XrCR+JlYgSd959JldojpwuQdoyvERCSlBCNx
	itSlneB+U8rESCE3E4cK7u/c3aQwv5ONlHwYAlHMzi0Bu2qIhZ0149+eiVVP2uVRTj7I1lLQV3o
	RK+9IY/XLq0XR8FYf7zvPO3ZGd3OJJtYfVerysGkn6aXkf8Ze2BQSgXzlUqTHfN6DsbrxPuok4k
	4dSBQY75MX3yxSeN8hDNXRKwRhAkunfH0k2RHNRGDZwRKcI0rSBxXnIFv2irBy48kpofM4QzdDK
	9TkVqKil4P1c5XU7ARUaCaOAbgi+WtNqsF2jbgNAcPg/GelaEMyZg1SeLV1WCDVe4Ey9Z1k3ZId
	UYhmKAx/8InZOCz9SOv2BXdJGFkYHUJaYuP7/5Yu9nJ/4QEkxVKEZb5oA64/3Ow9/McBkyIqptG
	LUQnu/FbE7XZ1mKbqNLhDRkoeN+713KSgBZagzFGE1CGARcwRDmm4NLg7+vJpLvjKpSwHCFaXRb
	YsGGXAPjyw9auca5kSlr20fe81ZG/OtqcaCaAlXzuhbFW5rqjm6EJl0bWe1FAT5704whrrRP6AJ
	8wwDoo20fUMYOTgCsWGIIwAeWmF4=
X-Received: by 2002:a05:690c:c183:b0:8b4:cd96:e2e5 with SMTP id 00721157ae682-8b4cd96e6femr8657377b3.57.1794772459411;
        Sun, 15 Nov 2026 11:54:19 -0800 (PST)
Received: from localhost.localdomain (179-252-148-65.user3p.v-tal.net.br. [179.252.148.65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9da90bsm69816367b3.37.2026.11.15.11.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 11:54:19 -0800 (PST)
From: Artur <arturfaleiros1254@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur <arturfaleiros1254@gmail.com>
Subject: [PATCH 2/2] Bluetooth: btrtl: Set an error code when skb allocation fails
Date: Sun, 15 Nov 2026 19:53:13 +0000
Message-ID: <20261115195313.20809-3-arturfaleiros1254@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115195313.20809-1-arturfaleiros1254@gmail.com>
References: <20261115195313.20809-1-arturfaleiros1254@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btrtl_initialize() asks the controller to drop its firmware and
bt_skb_alloc() fails, it jumps to its error path without setting 'ret'.
'ret' still holds 0 from the previous successful vendor command, so
btrtl_initialize() returns ERR_PTR(0), which is NULL.

Both callers, btrtl_setup_realtek() and h5_btrtl_setup(), only check
the result with IS_ERR() and then dereference the NULL pointer in
btrtl_download_firmware() and btrtl_get_uart_settings().

This path used to jump to a label that carried on with the setup.
Commit 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
turned it into a failure but did not set an error code.

Set 'ret' to -ENOMEM before jumping to the error path.

The problem was found with smatch, which keeps reporting the following
for this path once the RTL_SEC_PROJ read failure is fixed:

  drivers/bluetooth/btrtl.c:1252 btrtl_initialize() warn: passing zero to 'ERR_PTR'

The analysis, the fix and this description were prepared with the help
of an AI coding assistant (Claude Opus 5.5).

Fixes: 9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")
Cc: Max Chou <max.chou@realtek.com>
Signed-off-by: Artur <arturfaleiros1254@gmail.com>
---

Notes:
    Compile tested only (x86_64, W=1, sparse, smatch). The error path has
    not been exercised at runtime: no Realtek Bluetooth controller was
    available and no reproducer was written.

 drivers/bluetooth/btrtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d2c2e79800fc..35a2c9d3380c 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1143,8 +1143,10 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 
 	if (btrtl_dev->drop_fw) {
 		skb = bt_skb_alloc(sizeof(*cmd), GFP_KERNEL);
-		if (!skb)
+		if (!skb) {
+			ret = -ENOMEM;
 			goto err_free;
+		}
 
 		cmd = skb_put(skb, HCI_COMMAND_HDR_SIZE);
 		cmd->opcode = cpu_to_le16(0xfc66);
-- 
2.43.0

