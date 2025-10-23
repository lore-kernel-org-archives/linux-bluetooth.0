Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23C125A0
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201089; cv=none; b=lWTrXT/5HnX2oah5UTIPgTzwvNj9e7MtEs7CukQQCePeT6vhRU7L6So1yB/iwiV237YcCzF4SK4T1+m4owfhtRCjnoXxbynMEgbZAHwcyl3mcn4x2H2snRDDSoHS4Z2zbYgwqrl5w12srxG3mtXSGmCpdcQ2nYsCDW30Ff5d/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201089; c=relaxed/simple;
	bh=GvI0PLi+oIRCAwKQ5qiFyYqOFd/7PnkS+Rwa1T9QJoI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E30vO14ZEGjCY9XUkyHWSyUITpMxY4L/3EIQU62cOb4bPLwVGCXXhBCpv0LW487m5zumL+k3HydV1lgO/ReXe+te60FAOa1EgmPRIjNpo6MQrpqfEIISXssDQBJ9PuUIaTQGHVTqGcYfUowJaIv2qoEjY5s497ROhj7y74qUAF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvlonHCG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvlonHCG"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8915bd01244so86090385a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761201086; x=1761805886; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OhBlXdcwIVrJKkFAByUZmaySrvvYqbubZTl9H2ecHeI=;
        b=YvlonHCGyg8ym4NsqNsfVfaVwGdO7eODet66CdcGb/nc3GXtRQM4mVmDrv+HFHz2iD
         fX/xS3NCNleALqRTVO0i/WZDkhHFyjPry/ZxqyYKvO6obFuJTzA4/vwHN74e7cAsu5cU
         UgRPchrGV/dJJ9abMmBy0k8ffdh6YeC5dc7hYfjL+NgFO/xGoyFud4tFwhbgUoiMuNV8
         vM7+oMu22CkIBStQbYIOV3kDHcV/oiPyRlms3/6QbvjC0TK/i0Fp1Zf7c95D1KggUVIF
         qnHirTv6iYvW8WWbwiCu21ZBtffFvtO3akps/NUpMheIUhL5SdhdOo3feYtXfalBPgpA
         P/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761201086; x=1761805886;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhBlXdcwIVrJKkFAByUZmaySrvvYqbubZTl9H2ecHeI=;
        b=C8OJjLvD07qsGbe/AFcLUs93ypnTxx51tzFMkIV1FKSU+l4qAzhEmiWe5rQV7re4TR
         X8Z07rrTwhwWG3Cj29J2255nDXYn+tBXYa34JfGDTA9N0jJu14ncqm9dAWFqsARbrKRZ
         JZ8S9PT2d7cXjsSzyzYw8PkZoCTZqgXmIH0pmDeEwqw97MO+sgKBckxEtEdARS3K4eHy
         B0kMx3OBdZVqomV0CeO8vjs/tgddqFLxkKucBJvEG7gyYmGNNTIFPIvHWxSTrRDLfQnr
         zg1/W2TXE6ppWhhAvePZYmey5/pqJEtsEZnoGXI2i7KPdbtemjkVTkA0QQQSreLfxWDF
         pcWg==
X-Gm-Message-State: AOJu0YwnhwlYKwHwSRhRBcTQRn4TJR2qlSN+ZTXMX6ttPOmBEE56N6ga
	x3ISvMBnIDB5YCJT6+POm/JjOSoYCcVrT16oMtZIvj4RDCdXSZeKbspTyU8VNUzG
X-Gm-Gg: ASbGnctRB8MGc15uCJjz5t5T1CRC7Nz/LIgDp5xTPmZTgkng1lhC0Pap8RScXBIt9HO
	8bG6G4n6GdtmfNEskhZJO71SEhmCUDOm8YPbZSN8UN/Zu1KhlPOkq4bQ0gdRx+UiRF3IBybDzeg
	PPzOLBH0A13Ee2pHzABfnxf87rLVvEtCL5BjvMF0PT0X4Gz2We8HK7T9O+0J1g0G0mm30Wbs8FL
	BaYQOkVoLxlnTlbqsgAS7jnsiUbgK2pMUTEkjvivdssjSWgaEZKBJmfFBntfXb1t9/Lh4gXs4xU
	OhEot/vRdl1hZbXbplPqLdT0yhKbJ8f2y+F2WylYfcYBkRiAsg76GDWGfd3Neaj58RKfMPaGgAj
	XoCUJ7acY9qL3r+P5LKRz+oqJDRrPsyt9Lf+2hZ1560tWdjxT0r8Y1e2kdekncIyzJ5Z+r0rACB
	ws9TMc
X-Google-Smtp-Source: AGHT+IFifL46NEx5gXsmkYvgmM32+aKikVJAjm7BTJicjZPOZhVeEkvLr7HxWL4cT+qE9kPVkuUrhg==
X-Received: by 2002:a05:620a:4448:b0:826:f242:e524 with SMTP id af79cd13be357-890707f5d4dmr2775325485a.82.1761201086356;
        Wed, 22 Oct 2025 23:31:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.28.38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11698b74sm102497885a.30.2025.10.22.23.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 23:31:25 -0700 (PDT)
Message-ID: <68f9cbbd.050a0220.5ba04.206f@mx.google.com>
Date: Wed, 22 Oct 2025 23:31:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2483213915175254939=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, parona@protonmail.com
Subject: RE: build: Fix distcheck while installing org.bluez.obex.service with --disable-systemd
In-Reply-To: <DjjfVohXbHW1CnEWPzTVKg1cI0hNqpQsr4lcGCQSp7bGEd94UnW_Ym8lFlBbpOznvDA_7oEcg_txeiG9WbWlIg8Uhh2GpLtkfB6pqZIIVGY=@protonmail.com>
References: <DjjfVohXbHW1CnEWPzTVKg1cI0hNqpQsr4lcGCQSp7bGEd94UnW_Ym8lFlBbpOznvDA_7oEcg_txeiG9WbWlIg8Uhh2GpLtkfB6pqZIIVGY=@protonmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2483213915175254939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1014817

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      2657.25 seconds
MakeCheck                     PASS      19.99 seconds
MakeDistcheck                 PASS      185.42 seconds
CheckValgrind                 PASS      237.78 seconds
CheckSmatch                   PASS      311.08 seconds
bluezmakeextell               PASS      129.46 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      921.52 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2483213915175254939==--
