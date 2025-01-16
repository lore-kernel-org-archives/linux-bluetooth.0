Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE4236A80
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059947; cv=none; b=lrv3YXqD5xqT+vbDcSZW4YV6i/UXwvyR6J+6z5CESY2a21PwIoL+hnCLusKt15//F5AG5DNnuyFq8kMyPOw061zC7qEgJJKdI8E+bNtoYl4hy5l01PkpGhHrJrcS1NMTpRUpgwlbubGJeuTUR0jkeUDAGee4RMeAKuFnM+2Eers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059947; c=relaxed/simple;
	bh=9lcadW6tZSd8cN17h6D8660GjpNjYYeD7aF6iXZQyWY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Dy6INNxPEfChW+BG6JBp/H0aAK87jPCN8e1SUA2jd24Mq1qT+OFfyYgaM/aNuEXpO/vmexCRX9nLjqYRha5OuSTtzIapEzYBZRW2IQL9g7smBK5bUTPJYQK480pFWqkXLKrOZHqOjvWhqxgaM2j0YhbAc6f1FiAuS5kfU0zCCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrWwt8nw; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrWwt8nw"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5187f0b893dso360414e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 12:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737059944; x=1737664744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUxZ0ueQF2P28uNo1Y0C3XzJrgJp/X8AA4Sn9QCSW2M=;
        b=mrWwt8nwT3r/jthMtRYga9B/Xobhi+jCbFs7PYcyuBWrvoxl8UzAXWusruFhefrpiY
         bxTj2dZzgJtmcxv6eW1yN5xI5mnevIBY8DsX4vvueqCqljclgA+05/hb81ys24/oAu+Y
         oDH8fkB2q7lDImk4gjdrTsNcJzQhkhH22nQvbORPMD5ZTx4YW0bLbdM5OZAAxb26G7eK
         kwk2C167BU59G9sM4FTJi4YpgoV1tslm3KTEEK/1b6he2aVMEViUWTVT50ZdWfkwTSdE
         PGQD0zZdlkxdjwM/hS9EMPy+LbMvGYQ13Z6QvHXcRum9WrwaoV3d1oHBOhnZeQDA/2bM
         76tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737059944; x=1737664744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUxZ0ueQF2P28uNo1Y0C3XzJrgJp/X8AA4Sn9QCSW2M=;
        b=Uix0ueT4Q9R/CRy40UvpvSx2uhWlsfORRcqVN/RpvlC0QQupbETK1FbbZRysffHvj1
         OM1H69TDDkD4kZf/BaLwk90KNuEmu8r/rqHMVQYjdzJagdr3hN1H4fWiXbmlqMf2sVFM
         xLxzfcn0MeyNHW1c7mXZ4pDVvydYKWV9GUww75PIjXV+CcItpXxEz2J6OHmrYnCTIaAO
         /jrOlDyrV12s/ViWD/6i6jQPkfJu26Yx5IiDwuTSAr45vNu55bt3rMHdPZ6WWi0X4p2L
         FDGfzeYiB/fakL07N9/FbWL7msnF5dHxgY46+CXqhAxgudc8iQaDTXuajOutmtAKmOCN
         /IDQ==
X-Gm-Message-State: AOJu0YzXFvJgqUeZM2DoDvrVTfOxXQLAEhz5FuC3zI8NkstDo8Bpf4x6
	F99/HXazHYntG+wdh3FthwsG1UU1nLb6IpSOLupFV49CalOvFaiUVR09Lw==
X-Gm-Gg: ASbGncu5xGbjGbQOGh+Q40AxA1mHdTG1s8p+F7TG/xydera8TUG2OFC9SFTQhvuL1Ec
	4rUmJQjWIaUGpx1mBvRFBeLc1xoS5UnoxLcZYig9Lf6sv5Rk9cKJaCuJFxw/qJa60fZ5Ki2yy/K
	0e3PJCmDgJr7e95nVqm2hgFNtafFKA7vjiYyBaICVWvQFNk1eWJLpnzy+OI140Wb6A9YC6La5E/
	NKHggif/LOdTsihXXcbF4UcJr2GI2U4Ul3zKVDDKQVBrz0rKZWIOb2fjxuTkvuL8sMp3t0zqWhK
	KC3Q86hksgokZZ4pYpV1zNZlfjwJ
X-Google-Smtp-Source: AGHT+IGIQyye2DwlmlC4PUszzYJl+oIcc+g0kA8n8sYB4Bprs2aMaPOTWrwDXidmE2FkPCap5qKLJg==
X-Received: by 2002:a05:6122:2389:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-51d51b65c8fmr210572e0c.2.1737059944330;
        Thu, 16 Jan 2025 12:39:04 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cf559edb8sm139208e0c.13.2025.01.16.12.39.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 12:39:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/shell: Always set stdout to be line buffered
Date: Thu, 16 Jan 2025 15:39:00 -0500
Message-ID: <20250116203900.3722253-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This always set stdout to be line buffered to avoid cluttering the
output:

https://github.com/bluez/bluez/issues/747#issuecomment-2596840382
---
 src/shared/shell.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index aa6c16c8c430..37c747f8fa23 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1268,7 +1268,6 @@ static void rl_init(void)
 	/* Allow conditional parsing of the ~/.inputrc file. */
 	rl_readline_name = data.name;
 
-	setlinebuf(stdout);
 	rl_attempted_completion_function = shell_completion;
 
 	rl_erase_empty_line = 1;
@@ -1405,6 +1404,8 @@ done:
 
 	mainloop_init();
 
+	/* Always set stdout as line buffered */
+	setlinebuf(stdout);
 	rl_init();
 
 	data.init = true;
-- 
2.47.1

