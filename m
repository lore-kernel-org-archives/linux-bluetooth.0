Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82B44CF4A
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460087; cv=none; b=VarTPuuUcjfvcjTz2cWIbdfINZOfbyXms28AHCwY/jKfLw+fJ2MAi5g1dPODBEeFkSJE6srEbIio1rXTBsU0HqO0+ANVhaOx3RiJBT3kpBb4iw2MVthVrWW+yvpWLXJe8M79qEM8mA5mkfY6yg1jJLB3YOfHKwFeI/w1B+H+JHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460087; c=relaxed/simple;
	bh=Pliy9e9NV2UzGA5hTsun37uxe2agoCrlfEtG2ApmquI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tq4uS7XC/sU6b1NsRj8D9I5CFkoSmYnCY0h03Cw0t6IjwGXgpmtYYTJFJEVHinCA1w0JnVqO1OvhdfxlSDgToJnpmZDg4rYF4MizNZbYN3XMiCFqLbBgF7ZK37/tpsOHkgVEejVkd7VBcz2Ft2F+iXCDbWdUi/enlEVqpEJihyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=EARd6uye; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="EARd6uye"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso101750b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1788460082; x=1789064882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NO7zF0z1j5Off+KF7vCbJD8N1UI7rxLz/ZpHd8I61yA=;
        b=EARd6uyeOI/cVvxKL+enJ2o2PO8Wa20za0mQdxvjjM4c0O0HaO0vYTs+LPrxoLEBj/
         MbzyGrhorDctlL89yLY+MGIM0WauBwlStq/csZO8auFHne5jfXPGWsZDSRQSyEyux5aX
         JE/fYued+LpQ9pwoZzfAfzvYszeBGW9fQlS+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788460082; x=1789064882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NO7zF0z1j5Off+KF7vCbJD8N1UI7rxLz/ZpHd8I61yA=;
        b=sE0E2lnQ8aym9E9Yh6tXMBhwBdYY+0qtXAGrrsODveW44W+jl6y94XbuzDnCCSHYL8
         wnuvnVFfLQ34nM44KNxGtcYatOEZE0lxNHk63Cjn2qMyqTVuqQBiiSWmbc30XLDUaVUj
         hiKCmn3w4Ulx71IyKUWRr9Pk8OK/wgjITLzhE8Thz1Z0Br167wi57Qw3qv3paQUIexW+
         +m3YHy7bd4Uhr6+FCRaNkczE6pAvSS3EdMqQEEQPC10iDMSG9JPv1VZrrMhmtXFZFe+y
         +h64UJmjhOgOpABqBFtzaBDcUbGm/ivmWu9nubiX8EXtDN96JwietVIa/A2G76VGDO3U
         Vw0g==
X-Gm-Message-State: AFuF++njxfeY0Z6nOHypBbGF5lN/el6Co4T5wesW5uAgbnnPcmnLj439
	gOMXMyQNbJj8/XnWI8gKjZm4DGAp2T2HDYnuQsU1E8idNfv0ZkDFglVCkAsX+XS98Oix4e4I6Bn
	h/wgT
X-Gm-Gg: AYBFou3TiZ/M3uk8l3Oafz/duXA2br4zaNMRUFMYoXAsgrHfrU/KjzdmjC6at09tQgG
	0r2pETj0ilH8VuGqNSyrWEq1/NcVXJEL5Yo5jMGFjQjnSPnJaPGVgk2L8Pirqb++6VOi72yDxnz
	zTP4rcIYXWgQHLknopuvkJu12EODXHDcsZ+5lAZghPUwl04AY+1oaW06yx8jSFot77rlDE1+5dO
	ZFBHYT60GAPlPPbTt09Fc16HUNfzjXnB72CD0zd2DYzWEnACx+3hhdZ+dLTLxdtSAMcZPMGbbzz
	hRwIdL5E9CLID3uMBQYbcSn9Zc+FAg/AxMl0MvRxQmA954zl8GnE07oJlSbglt4YsNwmhBEXgEl
	TaRcTMUthSnP6duNX134YMXrbwW8sGF1ZmDJyzz0n1FEw9Awt48kdEH/GzinQuC8+k4mrEypV2P
	00lPSvbQq1GWMISlhrNfJmgDxBFnh0uMWZiu+33g8jx2FMCvrjQa+hHt9/Y1jJA7LecdflW8Qt/
	h6QSxxEY5oP7k2FqBT1rI+Qog8+Xk00oukXD9PK
X-Received: by 2002:a17:90b:1c07:b0:399:149a:3f27 with SMTP id 98e67ed59e1d1-39b2617ed8bmr542364a91.9.1788460081721;
        Thu, 03 Sep 2026 11:28:01 -0700 (PDT)
Received: from aaron-desktop.ts-local.net (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm1150630c88.13.2026.09.03.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:28:01 -0700 (PDT)
From: Aaron Brice <aaron@embeddedts.com>
To: linux-bluetooth@vger.kernel.org
Cc: Aaron Brice <aaron@embeddedts.com>
Subject: [PATCH BlueZ 0/1] btattach: Update for glibc 2.42 compatability
Date: Thu,  3 Sep 2026 11:27:08 -0700
Message-ID: <20260903182709.473976-1-aaron@embeddedts.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btattach is not setting the baud rate correctly on systems with newer
glibc such as Ubuntu 26.04. In glibc 2.42 the baud rate termios.h
constants changed value, B115200 was 0x1002 which was the struct
termios c_cflag enum bits, but in 2.42 they changed cfsetspeed() to
accept arbitrary rates and not just the baud enum values, and B115200
was changed to the value 115200. This means you can no longer set the
speed with c_cflag |= B115200 and should use cfsetspeed() to be
compatible with both versions.

Aaron Brice (1):
  btattach: Update for glibc 2.42 compatability

 tools/btattach.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.53.0

