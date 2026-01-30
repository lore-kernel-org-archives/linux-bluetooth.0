Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB12335093
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788610; cv=none; b=krPoFQUVXl6HPJtQrA5HMTvw7Lx5faJSJztmPebUNIdHMLWgx7bp5db7nId7oNEN10Q2ZIMEwiGu+zdbDKHDvSvCYDbhLlxA+cC34FdsovKi0BRBGPHrXZH6VXepf9oNHjw5eWdayCz9j0fVdXSXYheclOmwxuEM11urNkHPIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788610; c=relaxed/simple;
	bh=r8iHb6fewC+0U/qiBZlHizRypYaxPQ2IECyNzxMY7yQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZL4rYH1LVcPOrfSzm+xxLv0xnsWBCQk30h5bOjIbZEvKHpZjfgUXqo7eJXNc+9bn1tKCe434ocWJ2M+hVRTZXA5waxj4A2HwPU2HSammcHviw4DqZ7aKuifdJeBafTA1Gp53H09Mi8kTJY0OiF5Gqm+jQME+b/hv8IUFpp3E9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2zY2Koy; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2zY2Koy"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5f52e500e89so1619339137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 07:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769788608; x=1770393408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B29pbwTHeL5Py15/BW6MFYlVRBdkZiUEw0m33MaPTLc=;
        b=R2zY2KoydjRTyOuwrXzJegapTvYliRMAcFToI1YxVcmxqKiCJibFtCouDYgQTomTp8
         XYaIe4kqpRRtLB4HEgLzNmqmH6odnnWlYWcJy6+5MNdXaYL4ZauaGEr3EQwsgLchjNwo
         /mCsUgaS1a7XNWPquGOCh32igBgjOL8rlM3B9NFzXnLGeIS4jnpf3jOT8EHXE9k4YBq9
         doqnIBXS8S/tbcgEaw/tgZTsEgMw+hwOa40njOpVUQaX84IKLub3YfTjPLTmIrr/JeIO
         hV4s1nqa3nbS33cXLcXcF+gNDRygGD2Lpvij6hbdJJ5NFsWvp7vqXu9jcLoKp156TXHD
         Fcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788608; x=1770393408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B29pbwTHeL5Py15/BW6MFYlVRBdkZiUEw0m33MaPTLc=;
        b=p5RwlXATfHcegrxzh7+lWWWoQOCveS7sc5AQbXtQObZ0lMUt20PODNEOdbaZZFnm+3
         7KdvTLV2TEru7/1EppXAi0noiRqV/UdwcHdlCmK/38J2cXIFkg/3TX1JQN/MOZ6ksizB
         1ckTvB1IuvRSCNbQHSFtkRNdC6RHZVQXZcNcV/wrxnDRbmJBOKemvkAvD2AC/iv3AKe8
         Mixx1TvGsa/cAWeb3R3lxTFRjlTA0x6KngQTlPMuF5pDPHURsTxbsoBYNYPnFg8O8lm1
         TJCRzbKCGcayLxTPf9hgyWBADT7/Rhj4YtVh8CSuKGfMbKh61KEgPEXrGL9s7mfw6raE
         h6Og==
X-Gm-Message-State: AOJu0YwO86SUIRJ9wgCNdx4Q/+DnLkCHxrFUwl3tjHqbvJBW6/Yo+s3M
	NYq5zEHCARrAEXid6pDhbfG1aiphXf24z7FkxtW72H56mqHkwRt/gpTBmkPUug==
X-Gm-Gg: AZuq6aJyjOwFVA5xTx8ndlR5nmONopul5mBFcg4z3Lq16h67s2es9uQb322695WkUJJ
	70o2cUHORGbv835209tqvZB87RqWjQQF09J1+rWiFyMkyKWAhs3/9xuDyGBBSGnktITIM1Hh1rj
	ODVTyFMO0aaN+phax0/OEcalxmgGSmlLzAmUsLbyDkA4h4mLFLF2uCJvoSEfo58EY5b60xFFRfY
	zCLgE/Vcdd6S/h9KQ2OLkVddah+JteESEuNFyZwa+X1IlR6AYemXz33yIWLRTXFlJjlsau8hApv
	S/VWi0euy4AUOoC6t7ptnng1rO60sgsY6hcdL1WEt74RlV7KjtHzok6xRF8ygJlusNUjXOrmyNt
	1hQuwukWkZdqAioysTduvifNZvD0ENZCtEMolUtKaBdVUJne0iI08X6dHUnSeaZGl/jypOvr+6K
	5sR+oeXG/JxvJMcLHUTKDlYBs5PqGUcKPJvdF8lpEyP+jCy+oj7RYIsLk0GEbT4FrhV4q4l/X3F
	PrxrQ==
X-Received: by 2002:a05:6102:5486:b0:5db:d60a:6b1a with SMTP id ada2fe7eead31-5f8e263755bmr1244866137.30.1769788608304;
        Fri, 30 Jan 2026 07:56:48 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f734b71547sm2176035137.3.2026.01.30.07.56.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:56:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] monitor/att: Fix printing data twice
Date: Fri, 30 Jan 2026 10:56:37 -0500
Message-ID: <20260130155637.1150573-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130155637.1150573-1-luiz.dentz@gmail.com>
References: <20260130155637.1150573-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes ATT Read Response printing the data read twice by checking if
there is a dedicated decoder then skip printing the value since it is
latter printed by att_read_func:

== Before ==

> ACL Data RX: Handle 2048 flags 0x02 dlen 7
      ATT: Read Response (0x0b) len 2
        Value[2]:
        11 01
        Handle: 0x0030 Type: Report Reference (0x2908)
        Value Handle: 0x002e Type: Report (0x2a4d)
        Value[2]:
        11 01

== After ==

> ACL Data RX: Handle 2048 flags 0x02 dlen 7
      ATT: Read Response (0x0b) len 2
        Handle: 0x0030 Type: Report Reference (0x2908)
        Value Handle: 0x002e Type: Report (0x2a4d)
        Value[2]:
        11 01
---
 monitor/att.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index b77ffb66e89d..e76cb44d28f5 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -4989,11 +4989,11 @@ static void att_read_rsp(const struct l2cap_frame *frame)
 {
 	struct att_read *read;
 
-	print_hex_field("Value", frame->data, frame->size);
-
 	read = att_get_read(frame);
-	if (!read)
+	if (!read) {
+		print_hex_field("Value", frame->data, frame->size);
 		return;
+	}
 
 	/* Check if the data size is equal to the MTU then read long procedure
 	 * maybe used.
-- 
2.52.0

