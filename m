Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0927FB2F
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872428; cv=none; b=BcpuFFdMrPBB1k+8mJBoGVLe3ON48UhJorDyhJtZKCXQoxsKRFRlSH3mlGlcS4VIiqzy+QaeLw1DXTSd9U67GD3oEfDGDth8MXWY4046yFzgR3yox56M5HlRlCv8s201Ww8nkMJf4AhbUGEJLV21HdWyj6ZVrtZf+4mc/LGLaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872428; c=relaxed/simple;
	bh=OIqDNIhawtdN3Oop3hBKhtOCrDcgg1S0SnuDErf0GhM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ORklqpcbDAs9vtZOZf63sVa0hnK5qKHppE4Bf1AmpLdOXy7Dz+8/lhUyv0AhDplGJ6FoySZ7RSfm7YtPeQ/T7790EJmsOl/FXMsRhwT/1G9IR11QfZZg5TAxNg8j8QIzaVyiKozCIPlGtdA1HT7jnUsNhZrycDy1Qk2vKv/m5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JA/xc4mi; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA/xc4mi"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a44b3526e6so44241551cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 00:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751872425; x=1752477225; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CrISdlcnc/fZc7ez5r9me6V1P49yE3CEUg2LaZiuf1w=;
        b=JA/xc4mieyPFTRuv6+CBJt/GMW6etCYjESww8iJlI1+CDshz+hMs+Wzvi1oJoPNakG
         lOBsq7FcNiDA9LlJizBMe+bpPFeYIxhkzCNW/vORLa5Ia4r5fSQ5ep9ii6glYWOfsPto
         G8f5GDWDRIoCLOiCDTlkxzNzrKNCtLfXeFVow6t7nG3ZaRBfx09kOz19Mcj5RY3h5gtD
         zUOtQ3IJ8nfzbuP4FW5V+wbOPrZ3M9czpfVXubFvH4dZHcOl0s9R7zlBsQD8u904OCmW
         ATKLWWcYSUQ9BD3Veo6PtVc1lxMWgz65zNBaGkqHXm27R3Sfq7RjtjspSmdCc13wml2h
         03/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751872425; x=1752477225;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrISdlcnc/fZc7ez5r9me6V1P49yE3CEUg2LaZiuf1w=;
        b=AmuTZ+B6e1yJFtc1/7kNL4kZBAkIeBIPfszmjDnxJCR6A4S2fltIO9TC26ZyakpONm
         TNmk/r9HyyDHKB8tuFmmOPrwrorCYtXP/qq0Wjj9aS9uJ2vpAPHrDvFgf84mzh+aL01l
         H+nIzC8vFhVVil2gtx+Et74maIM3zRKCAKMitXHEVxrJ5u9VIzg7pyD9y1LHxJQ4+qsX
         YBDqEdEcmRogTxQUzESUHv7RslftZHj8aHiv+qnwqPxP0RkYo8GE605+lyAUeWv0Ciuf
         rffeWv32R0QJ8Wj97/jbt9WsdEjs1/qHLczXVO43HYlDd7z8nNHqQJXLmpc7wnuRkFWE
         f7Kw==
X-Gm-Message-State: AOJu0Yy/sfPhqH+HQaU6c7xjbVVnllu8md+0JGKOKFXdsv6qhs5BuQnL
	iVEVxvpFloxHAhrcCvw8Q7Z2qDAdqcgOM1oUcywcSscq8EcmWl24+Dm44JOKGWe1
X-Gm-Gg: ASbGncssll6rVXUS3+nkyvufqNtZzlFsRnuU/h1FO4MizQPbHlMoZrKZBKA5ZHeXN9F
	BNwGQDlfzYDXZ4ri1xuQQOG3niFC1Kq3li1qW5CJZiIbs2JTPIeB0Ln6JeXUGzode5rLmJ2YHFR
	lX63ISuyDJh9J2WzeWVqnrFUjq1esYmra+Lqf5u9xfs6Xx6ctcltr33uIwPBxjD1rbdsUfO89AS
	gTcwLGPsFa3Vmyfa8asGSzAXhUn5xy76WYmUHeH3ZNVle5S5QeuP4cdhM78MynxvoqOemAdi4Bp
	t5Ov6vhKD/vKIgbfUJuF7zhH6vxQMkKQi79g20hsRK+fO+Gy8ivFNZ8QvVc2+uad44bM
X-Google-Smtp-Source: AGHT+IH5Rln/TK4UtsHe0AqRZ2oDncnC4ZjMqqpjQcfX7iZ0w3jZph2qghWHQGkLaqJyPAEhzShdEw==
X-Received: by 2002:ac8:7751:0:b0:4a9:ab9b:65e8 with SMTP id d75a77b69052e-4a9ab9b6a0emr90306871cf.14.1751872425168;
        Mon, 07 Jul 2025 00:13:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.241.28.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994aa88f2sm57683941cf.79.2025.07.07.00.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:13:44 -0700 (PDT)
Message-ID: <686b73a8.050a0220.1d4732.f62b@mx.google.com>
Date: Mon, 07 Jul 2025 00:13:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7645613180942190796=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez,v4] shared/bap: Add stream state check in stream_disable
In-Reply-To: <20250707-bap_for_big_sync_lost-v4-1-bf667d839b72@amlogic.com>
References: <20250707-bap_for_big_sync_lost-v4-1-bf667d839b72@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7645613180942190796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=979547

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      19.85 seconds
BluezMake                     PASS      2477.76 seconds
MakeCheck                     PASS      19.97 seconds
MakeDistcheck                 PASS      182.43 seconds
CheckValgrind                 PASS      232.70 seconds
CheckSmatch                   WARNING   303.74 seconds
bluezmakeextell               PASS      127.88 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      907.80 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7645613180942190796==--
