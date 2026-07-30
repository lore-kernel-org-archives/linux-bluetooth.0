Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5487438484
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419951; cv=none; b=GXuxsUUb2bsRo/IiTaX7wnCX46j92set8/Gvqydm3Ui4uQOV0S5Lu+UP1eenB8xnnld6AqigknpDNirr1q6S5+KNmWeGnJy7uZr+L1DGT6wj7BA6DBJCOXAmYUAPrvoFbafUS82tCQEfL7erMR6U+5ZQzt9keL3suS5xRxDM+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419951; c=relaxed/simple;
	bh=BsDcK2NOOgZuR7ta+HDTeGlU63VU4M9Zzzw+RBkYutE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3mvSy4YmoNvFf1+2BZKZTV5r+LcuKEBjiX9sFVTPgMidelVH+lcC6fNnWmgFyZL9Yl2f0mc+uzFchBYv5JqBYnjfarta04yuSEry77dKctn3/flA7aOw7QeIjva1fjPY2A+mRnJ3jh8TvcMtYJU91YYzQqyxKf273Ht9AF36aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl5DU66G; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl5DU66G"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1198278a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419949; x=1786024749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3r1DI7I6rtQk/YWEJBZkN8NXoSoMQqLizKG397wpkYI=;
        b=Hl5DU66GHjtIWWjM0rYup8/50Lo0lpJsw6J9ckh65INqUYSivPLObqD8Y1H34LQ6Vx
         OFmOvb/VxsyvK3CGOEBbyDalFGk4KWRlX7FlwyWdRxfRLyrMGV0UPdJGRRbFyyIjoUaf
         jiHZP1spu/cWL5KV53qJd7G5zE9rC704luQe0NyGsf3FAt05z+bdRVEQsaxqZw/s4CWu
         XBSVXpT3bRYnA/C2vinaNioWkJhYSgcpdOstfxIOLVLEpW2ougVbYOZojWbtfWcHNXJr
         2k58LegCo7RnakdxJBfi5AZN76EOmtwL6GO8z8z7fud7gXdzgxXPDWyUmZYEY0fZgjBC
         bbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419949; x=1786024749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3r1DI7I6rtQk/YWEJBZkN8NXoSoMQqLizKG397wpkYI=;
        b=ALOlEzxazOkd01Z+YHkquy0KjVafZKPJffqev3YmqrfqjPq8R9tP+JUKRQwY3U1Svf
         f5ySUjneE0wwJuy+Ayijg9s1+EedBQAblW1sJ1BZbh+qUPpJIyyZSqlLuJIusiZqjH4l
         UU4priGDv7Ppo+jpU/idCITozMHWFy0Og4mfXpB/QP8C1LnKWmGdOsXabqODDcE2+Nsm
         v3Pe87tdJuM/CYlSZZYCeiFtCoVT6liuSTxNt4FyspOfhRirmxM8hapZJuOQyJfpOphZ
         8ljaO0sUwQ125uzioiHU1Yed/OMzig2IsmJn05HepnJI2Ax0CB9+5KHcejeiGhRAm38+
         1YSw==
X-Gm-Message-State: AOJu0YylARtRwuHaMEElks7hP8ANwO3a/Id5QUmwtUe7Ruv6vUTC2EtW
	kpodfzbY/tRmTkSi1tsO6QTsNoX04sxiOPZyv0I22joUXARhZXm4Qh2x7JLSKEj++mc=
X-Gm-Gg: AR+sD1082kyC6q0D6FIkh+ZxnlWPwp+Gq/ti9jbXXieM2z6TY07GtfxVJFBW1A2rcng
	1kDj1w0ha059qthhId/TkYCZl39hjOliO0PtN+RYiRhYecG6e8E29cj3/sKJdOdzxgBzr0XUOUN
	s2csBWvoPMgw7athVKteq7rmhR1N65HPP0ek7hcXlfaaIdrneVKP6f+1n+UL8rzGJsPo6W2hjQv
	JOEPq4BQnvHcA6YFgE3LKYz2wCIqIJ/UIbv4GXA3O5SqmAlsMSKxr8jExtRMa+UMTjrhb1wVPr3
	SxZlGo73K8lTJ5ydLnrv2obgvk4xRnQjQYis2Wh8bXi78gPNPctPjKrt+Do2eu2V4i5MD0Bb/kO
	KZLRQonPTCIosdkFrwcFLVuzJUFK73PihED7MITsSoXlLduMTv+AIlyzZ7/vfId3MiRoZ5k4vob
	hnIpuDq9CVlaequfeFs4/6dr8GJDpcHIvH5PpPeA4/v4YHqTa85EkNmsZhoixyXKxIX4UU+z4iK
	TInWIyFGLbQvSgNJh1ADyKaeiAjvr0r
X-Received: by 2002:a05:6a21:608a:b0:3c3:b57b:628f with SMTP id adf61e73a8af0-3c90085d314mr2479554637.48.1785419949103;
        Thu, 30 Jul 2026 06:59:09 -0700 (PDT)
Received: from oshada-HP-250-15-6-inch-G10-Notebook-PC ([124.43.23.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm20461446eec.6.2026.07.30.06.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:59:08 -0700 (PDT)
From: oshada imalka <developerimalka@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oshada imalka <developerimalka@gmail.com>
Subject: [PATCH 2/2] Bluetooth: hcli_ldisc: Remove double new lines
Date: Thu, 30 Jul 2026 19:28:51 +0530
Message-ID: <20260730135851.78195-1-developerimalka@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed newline because of double new line

Signed-off-by: oshada imalka <developerimalka@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e7de8a278edd..ae905c3f74dc 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -759,7 +759,6 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 	if (err)
 		return err;
 
-
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 	clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
 
-- 
2.53.0

