Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D11DED51
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106820; cv=none; b=flpRZSh8Qmlmxtc5OBslIprSqtVPv13OdSHnIWvNPtbKnqanhMuWc+SqLvBdFsILBpslJHv9ghuC/yJkjDu4NzZBTJTPrBgFeDPZcUNEoE+zFYsMEI6PpvZqSJLP0oai7zARlfiy8euUV0VtxVcx4QPmgMReVVdXFciMpTZ8Pr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106820; c=relaxed/simple;
	bh=WlCg6NZToqvICj6oEc6pOdoO34QK2zKEWuO/sU+7QWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uNwy1J6P5BeSSmpVLB20xvA0N/gDnAkjgHpuyXHRkp5ZvRIp+ieawKEaoFm7ZUnQtgW3toxzprQJMn3SNMpnZrlOhy/e8yFwaWucvP+YLYji0PI7uxCP5sG4Mn2QJiPrpZX3OpJCQc9eEYmjMQFiR9Lzwacoi6iuhBYWRZ6YdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=ZbkbuFCA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="ZbkbuFCA"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-adb47e0644dso158157566b.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 00:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1749106816; x=1749711616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpNqTnsHh2J9UcATk2IxRvfk5rLlDzrVhzcnEhLFB98=;
        b=ZbkbuFCArwSVMWcSxx4xGUrry7JTsk+MN5xPaiUTfZjD+xupQFn1Qqohf9f3p7aqfr
         NBThUK/HV405sZEJlXjQrh9YP9C/CUDRCeGtG18UI1EwHAK81knYU37ZaGvZHjCNx1fl
         0+I3mwbxhl7kYYPKmhU4psL2UBhVs5y6M45Tbrzp4E3pWu0cn+wkVkil6etLOUXE5Bv+
         VJiF/9x38Vf4is/rD7boKvrXFZlzt8yYFaffUv0QrNWCeM6LNc4JnuYkGFrUUP4XYhjW
         +LXTrgG3u8Ld70U2fALd78QhqIs+NHg6pL4oFA6RgYF7N6rmeyhGJSWrUm1d19OJBwoc
         ReYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749106816; x=1749711616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpNqTnsHh2J9UcATk2IxRvfk5rLlDzrVhzcnEhLFB98=;
        b=QF8Lvp9rYg2BOji1oMsNmrpqfEzk4VPrH8uZ3MIFUFVsyUMun56HfmFwNm3lY+F/MG
         IfzYPExUYheZ47wJUdhEfyKnRPeA68OkhjtX9M/JyrEUe6IfJU4GC8SfCtpBpy5qPgRz
         /3Sb+chUXIaKw+D2gQtvMIKwoiE7i4fXfsdFjLttE0tYnMx/OAl742N6fHnvBk7N2+kJ
         C25VzDn8N653pNLCyeO0ff5zt+wGRqssCfClQk6uVEu4uH3K7jAF/jjUt76+B9tNXIXR
         nJWzupz19NtBPlL+gcvHePvSCaQC47nMaj5a10PryYN0ES85TUBQztroW5SxJ+bjFCgo
         V6Pg==
X-Gm-Message-State: AOJu0YwGGrKfNAG7y0O5BVZp2D0OTao/qhR7BiLKUOaDr24+7uXY3Rrk
	CWIsnpdWZcBAHvb14EKAWWz7clkVX4oJEnnaFjpL9/F7oJrT5/PgLzfj5GGqCG6kO8mmGQT/xcq
	l1wmfE0A=
X-Gm-Gg: ASbGncuYKhvP86SZsy/8/e8X45cIz/i0eEKUA//dyss4qMga6oc0gimHNesAOPaXCJT
	J1/i8DPKOsXU8K6HVBk8aa7cta0FmM0cIIhmSDgiaq4hjbE1GhrZ1RJzJVth1vovEl9QQU5W1JS
	W4UkG+WSlvcvwOPlsD8mJGyKGqQNqPzc4/KEjMpBoVI0gvD6swA5aVjPwVhILJkm4UYS9Stk02e
	ntyRoBKbHAhqgt9k78PXgsFPZAgKVHOOxytU3LmTVXEMpfecV0BJMOMo5+Jr2OTDzH86tgK8E/+
	oIBWDSVidHfUHVPISYAA/nNR9y5aWuW5Vm+iPHL9dHT8t9PWurDMHSLkmcavUvxKe+odFo/+cg=
	=
X-Google-Smtp-Source: AGHT+IENZztZaYnbdQSMxT3SuTPuv92NIdst+HwNY11tKkq6zkwo8yykQMOalWyQYzqm0SSmiT9DVQ==
X-Received: by 2002:a17:907:940e:b0:ad8:5595:ce07 with SMTP id a640c23a62f3a-ade07823bf4mr199758366b.19.1749106815968;
        Thu, 05 Jun 2025 00:00:15 -0700 (PDT)
Received: from ThinkPad-Ryzen7.. ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb497704a5sm825746666b.83.2025.06.05.00.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 00:00:15 -0700 (PDT)
From: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Subject: [PATCH BlueZ 0/1] monitor: Add support for decoding Channel Sounding
Date: Thu,  5 Jun 2025 08:59:12 +0200
Message-Id: <20250605065913.1446880-1-magdalena.kasenberg@codecoup.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch adds initial support for decoding commands and events of Channel Sounding, a new feature introduced in Bluetooth 6 specification.

Best regards,
Magda

Magdalena Kasenberg (1):
  monitor: Add support for decoding Channel Sounding

 monitor/bt.h     | 321 ++++++++++++++++
 monitor/packet.c | 978 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1299 insertions(+)

-- 
2.34.1

