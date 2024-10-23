Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A117ADFA
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716432; cv=none; b=bWsC41BkHSMqkGW9pn2GJvWhzuVb7dXGOlAHGe9fCHQObMXlwXzN6HiWb/+yWvOUhWhCvemyYpM1lbo6DUsE87qHsW3UvxZ6swrV5ngVwJSTmflh1R/5iIECn9BAGw/FtBnDKB1l6+EsBaTf+1MnjKTJyzvrkXKR8hCu4McKFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716432; c=relaxed/simple;
	bh=WNsBf7ia3QJTV61waFrg37dr8Wlki9gyJ5mes2TdbHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kqe2TiCY3HdeYClKnqeu7VkB57Gtmp0vcpkDpmOaW3KtHB3fbMFZj/qDfK10LkiYpV9grUXRys6xSS0n/u3ULTfeZSJp6TTEXE8+ko39fcBeOFlhvQPW67dFWXNsL8CzmN9oL30ueNEn4tzt78enILovINo/fG3qv+EWqvf8AP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNKCW7KZ; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNKCW7KZ"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d35639d0aso64625e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 13:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729716429; x=1730321229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBwbElsJv4sqforD1IGGN29a1mCMzSY8gUSb2DJiL7c=;
        b=hNKCW7KZAPmXysgPtKcoLC/cvLUyAs8RaDF/8Yw4pvQVxXSRAb8Im1O9NEGOP46dGE
         gsdPBuEXw35/WSsw9I/iDX5oKUGWZqNYSZPODKLXzIvEzU4JG9kqoCtx2wOQnsmDJqh3
         BFnB33eI5tHrF6s3wZ9BADDRgQdzKSIxU85NQeCeaZfLIp8dBsrkClOE3N7AgDHyehad
         Sgscurqs+Cci8UUpfWm+3eCxwnbVLRIQiZAX3KpI/qAYcwDFknYi+p7M6z21Q2jYiKsJ
         k5B6QAykhaxvg1e2eqw17/xu8QALtPa8ABiG9q3hu8Ij2Sze0MVlaT/F8vyfYNzKcDtk
         xxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729716429; x=1730321229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBwbElsJv4sqforD1IGGN29a1mCMzSY8gUSb2DJiL7c=;
        b=gTcD/wqmLaVFYQ10+WpLpTasDS4cyFHNjMyKLPMIQB0C95uvB1hbvZEU9QcvEm4PH1
         US0ZGrGGT4+qKAJYOG9ojRoUmsU2RqDeUWby667hhPfr0/bPFPM5cbHkTykKN0sf7GqD
         86gu46AzwU6j4VMP+YpxPlqdurbqQc6TRvLy8UakCYLqyWenPsxxl5ih5kvqXhyNwecW
         yd2HhtsM/qPN2RIqELkX/Uk9wBZ43ovKVEPBKUK8Hkzj+VSp7XLhc9f9EPeCjNi1cUDW
         x2pQMcLQC4TUSCmX6x4UI0W7SZ6Kpkm3Fm1dNzkWN/U+RWtCR0SbjW8CEDwG/mQ+j/Mt
         zHew==
X-Gm-Message-State: AOJu0YyWLEuZQPcLB6JiJJDJ0JSw3lfu82FgjalS43by00cCcQUFPyyG
	l2FduZEDwykwo1aEfpY+nfXAngxSfStA2tf0ubZLVj93icman0NC6K2BEA==
X-Google-Smtp-Source: AGHT+IG0pSg/2mxMXtj8VQtVEnivHS/0xmsircJfeqymHIZDHSAvcI52RW30GzlLuhRV+0Kh2A+YPg==
X-Received: by 2002:a05:6122:32cc:b0:50a:b8aa:93c3 with SMTP id 71dfb90a1353d-50fd01e16d7mr4978041e0c.3.1729716429435;
        Wed, 23 Oct 2024 13:47:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19e0dbe9sm1168436e0c.3.2024.10.23.13.47.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:47:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1 1/5] mgmt-api: Add Send HCI command and wait for event Command
Date: Wed, 23 Oct 2024 16:47:01 -0400
Message-ID: <20241023204705.2422998-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Send HCI command and wait for event Command initial
documentation.
---
 doc/mgmt-api.txt | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 59e61d361dc2..d37eae402861 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3991,6 +3991,36 @@ Cancel Transmit Mesh Packet Command
 	Possible errors:	Failed
 				Invalid Parameters
 
+Send HCI command and wait for event Command
+===========================================
+
+	Command Code:		0x005B
+	Controller Index:	<controller id>
+	Command Parameters:	Opcode (2 Octets)
+				Event (1 Octet)
+				Timeout (1 Octet)
+				Parameter Length (2 Octets)
+				Parameter (variable)
+	Return Parameters:	Response (1-variable Octets)
+
+	This command may be used to send a HCI command and wait for an
+	(optional) event.
+
+	The HCI command is specified by the Opcode, any arbitrary is supported
+	including vendor commands, but contrary to the like of
+	Raw/User channel it is run as an HCI command send by the kernel
+	since it uses its command synchronization thus it is possible to wait
+	for a specific event as a response.
+
+	Setting event to 0x00 will cause the command to wait for either
+	HCI Command Status or HCI Command Complete.
+
+	Timeout is specified in seconds, setting it to 0 will cause the
+	default timeout to be used.
+
+	Possible errors:	Failed
+				Invalid Parameters
+
 Command Complete Event
 ======================
 
-- 
2.47.0

