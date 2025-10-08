Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69022299AB4
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759888668; cv=none; b=MVoPMp9o+EWpz3VqWDWPekT271BWWiykRVLUhr+PUNY1zq8DcL67PlYsYxOuVJ93fMNArmTUraIPqTYz+s381TBv44gSf7aE6OIB5Z0CM1xwjenJ4CCX1IE+yNkLl+vXmqv6gRfAxVR2emS9qpySQjPLX57FKn4PkydvTAQYkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759888668; c=relaxed/simple;
	bh=nYWUxbqqzq5QQ6EmGRf9P1x3GCe3p++g87Rn6siR5m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvq1fsFw587c0mbNv3t98A6CO2h+L+UBa0jOTmO/F0YAbSlnzl6+F7EfwuW4gFG+ZJSYC5iNIoybyDwZdXvjjRcWfVM+YosnFuYzT+vQKPci6gpididHcP/+bjdT1tHni1fniIcO/9dgY2jBXPW0Ln5DT1/KFpFuxvhw5BcasxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/c90Ws1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/c90Ws1"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-799572d92b0so67433316d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759888665; x=1760493465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTB+YSGmu0bpbLnHjtaDTbYodJCzl2qjGAMNG+RlZjI=;
        b=D/c90Ws1G+GGV44Yzj+RjcvoAc1Zet0BgdzuPGpPaYujFKJst/3ugUE2hhE8Uz8gah
         EbbmQxbZWV0tw/Ry02bUL6v3IHx2pvHW/SlOar74hTdTKPSX4UbVlVms1tShnV0GSuhs
         x547f41Rq60OKnZz4wRJaqoxAEg8lOhg1x4rexoG+jApGLWKRfcL8ks49+GlNp3Yk/MD
         7NpkIIkrd3bM3bZczqtHXSbP8hAjzEqZGSoYosC47ssBZZNN9H2wYti5eBf654L4Xg4l
         h1DS39BZZQu3ORlBuQQZiFXYMz3OYXOsaI4Q7ltPMz7iiGakOc5pPsTuVRJvv8zPFLnc
         jVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759888665; x=1760493465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTB+YSGmu0bpbLnHjtaDTbYodJCzl2qjGAMNG+RlZjI=;
        b=dCnYmC0zj5vcTbAeIi4wF33jaoRuO/K4WcfYVXTQfnCFL1tZJ3IbZbAi9mIaxG7lmE
         xjoo9mJ0VtgnRwcM5eEkMNXUkjPzFGAvOjjq9LNzaFUqNWL3f48TrB24VdCGvRPH+c1y
         S5ykagARE12kWSrzUH+Dx8p+ZhXkkpcBHVC7WwAQ7doK4EebZXPi2YRWNZbk5WpeJCpz
         ZN6LxZ6nAjcRTdyZ4nf31EMCx46T0H6LDpGOS68D3fk14JyFd4GFOl/fCWH4LhJEH+nx
         G10h6p99dH1yVeuu9W4n/bZ8llxOHXD2Jqb6OWnNcZr8RH/ifouYul3rhH5zOa4tsIg6
         pRTA==
X-Forwarded-Encrypted: i=1; AJvYcCUR7L49xxu+YqXpr778wQWvrcRsKtPf2/ipozK9NsLQdMIgRJrjzo0d7f47Z1FuhkbfmYqT4jBC8L2dq/fTp58=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnrz0Yy72r3ToX9tAR02cIcMwkRIgJ98v8+8CCtoNK6rsfGcNf
	uBmVeKArwxx11jSePg+vhZPmKCDVoE4tIFx6HMOYj62bCCKhURx7Vx+l
X-Gm-Gg: ASbGncvr04TCPd4hrAddRdu/JmyB3LH7JkkM9j89xgGXOmMLwe71cp/t2CKTzgNNn2K
	w29AbeqgDNhN5wxhXNkXTiz79ZlsoOcBgab13b+9XHsjs0dZ7tHkDDIUzhtycSrpZcS9BYNd3eu
	/qeC6bfajFNqTAUka6tG/KY7IhjrqUzjQuOjhzZxItPz9tpFLqD7lZrkAsTxb4v9z0vrlCXvro1
	TVQ4HsgWnWYX0R4Q7/MDuMIsit62EbKn1Cnf3BLHb97ofGN9Mcl5UcNL/PFW+c8jwrqI7kHDCdL
	gZzqW3fP+IYE//KRqNcB6kHkpEOJWgmBbXyhptqHNSDE4C7kGslZx+vPkuN6BCI2yHFkdDdLfwU
	H4Xq++KqAmqlJsOarLkHt+zYsqCa+YzdDygsFi21/jKBBJhTWdbWN69d5EGFsJlKxsZ1Q56HgsS
	Awk1TM3jEqYQun9RBS4BHBwE46hfTm203OTqwqRQWZJw==
X-Google-Smtp-Source: AGHT+IGoHjbRgqWNn7pWfYsSMs1tXQxTjaq25oW+rI7yvaco4w9zmjYdtsj6ViMdN47X51D41+1jkQ==
X-Received: by 2002:ad4:5aa4:0:b0:809:19ab:599f with SMTP id 6a1803df08f44-87b2106da26mr22488656d6.27.1759888665253;
        Tue, 07 Oct 2025 18:57:45 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60146sm154303896d6.11.2025.10.07.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 18:57:44 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
Date: Tue,  7 Oct 2025 21:56:41 -0400
Message-ID: <20251008015640.3745834-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007232941.3742133-2-eeodqql09@gmail.com>
References: <20251007232941.3742133-2-eeodqql09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The bfusb_rx_complete() function parses incoming URB data in while loop.
The logic does not sufficiently validate the remaining buffer size(count)
accross loop iterations, which can lead to a buffer over-read.

For example, with 4-bytes remaining buffer, if the first iteration takes
the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
only 2-bytes remain, but the else branch is trying to access the third
byte(buf[2]). This causes an out-of-bounds read and a potential kernel panic.

This patch fixes the vulnerability by adding checks to ensure enough
data remains in the buffer before it is accessed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Fixing the error function name
 
 drivers/bluetooth/bfusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..45f4ec5b6860 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -360,6 +360,10 @@ static void bfusb_rx_complete(struct urb *urb)
 			count -= 2;
 			buf   += 2;
 		} else {
+            if (count < 3) {
+                bt_dev_err(data->hdev, "block header is too short");
+                break;
+            }
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
-- 
2.43.0

