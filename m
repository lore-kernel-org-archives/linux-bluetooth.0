Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F52F42
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175560; cv=none; b=RYijpq6e/+o/tF9s+S5TI4xqE24sEarNVbUsUp77wsZpx84/Qc0orkAi+hTEASl/NUlGaTfZlF1NmeAlbWbqBbDbYofM8FqteA19VogIwjcXC+E+rY4qwu5RSpYMOmVmyPXfmIOJXocky0/M7t4lQB4T3vur56VPIfOvHoQxkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175560; c=relaxed/simple;
	bh=8H9GFZhR+GhLj3MYny1VthLa4q/ezWmm9w63HZSQspQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aX4W0UtGu84mJOGqPb/AvWvRkcM9Afjw4ZbzfB7EKct0/zAd+/xT1GwKnreqpuvx8IYBDMS6/5HMRRs1KpFPw+O5y+zGHm66LpzJiYuHkNi8WkeCcFGRTdLWPGI/9Qp3yHZyks8sdDeTj8T4mfBtbJ6JeyLVfQvSfDpPtb8qsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGrSIQGN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGrSIQGN"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6e9db19c8so689737885a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 10:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738175557; x=1738780357; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+korwEXTbfLCEGgUyGRMh/Qlf26aldPeq3h4nKqmJPA=;
        b=ZGrSIQGNM12aO2jBBi3rRoZQrJ9WMWC1xfp7hvlUcjHSNwBiRYHu/mIsHCp8R2V/Uy
         T6YyHQZANJaiXBRe7n3shSqfmLMaAeufSFoptG1b8PbD+UPPNsU8Xh6kA0Tr5EF4ZSyo
         yzGLp8ofZk25y5kmBvSi43kGO1Z3gWzp/q97ueHwOpeGpKDUvRko5NOpA2p9XAJItQ0D
         ONysZ42zUlLzVdxcU9ngUJmmbjmCruM/PpO4fjBF777bprGyLvm37OyofQvT8natB/Rz
         kGwZLGXcWHy/JEfeS1TM/OHAE52SCwiUwEIAzZRXJ4VMc9OoE+E7QDiHef3D1BvSQPcx
         zn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738175557; x=1738780357;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+korwEXTbfLCEGgUyGRMh/Qlf26aldPeq3h4nKqmJPA=;
        b=NOx05WWI3ibWiNlxBZdBfNWXdC/V2iBx+vXeSBL2E4B11QqmLT+qPvQXLA1Bvw+f/j
         zVkXiJy21RxLYmKhTVT5ZZoe5OkATu3LDi7V3Se+4+e++DEuZEd8pLIc8Xlr7CxUz545
         jsc28b/7Hf2U9BW+u5LGMVvA2xv+LnBr0PzBfikMDK4mMhzT0nPtIpfMz5q+uRjaZoSP
         tUsRxB26Nimb/mEQyfRa74JBT3UQsVkQvsdGZKCL8qzZf/SX1EahsyjDdy0Wt4PiPscq
         ZKcXPBJ1vjswWqsu+tDUHSRglsH0jlplmF0ScQt01TbpHFA7F3XAkS7SvCI2DAMxcGyS
         9ALA==
X-Gm-Message-State: AOJu0Yy3MSX47X8psG/55G1uMDWWlKe5GRr/iDAl966xdvNSU+B7JsuW
	cyTBWCECNug7IgjwRmEHz+FewWXA1LIWdK0iYQcqxi55GU/wbIEUX+yqMJFd
X-Gm-Gg: ASbGncsaw+0skhIb47Qb5iz5HKL3Qiuv5pKGDqvV1RsthiImou2MFL61ElfH91NoKW+
	KJI7ro4Zyk0V2LgNf3mdf0zHdGdvx3SBQbZLat5KYidp0rX95pm2KpvzviI44+lrOu8avbxs2qY
	M2AuqdRYfSoCly1ehJrd/h0QaWIb630Zlnec570UN2UhignndLWKaCLxUHxRrAYZXK+lCWsoZU5
	lfs1/X9QEiz4r3CQ4I+4Vner0e083zx77NWPpoIj8Zzm0nAIJNvTEIeOZUDbBRb/U+cQ7iQabmX
	MnT3pJMIvG2SUVM/AfrrqPlf
X-Google-Smtp-Source: AGHT+IFED7PDcCRksY6zqoU54hyvenU0pmMlO8lPVRxo9uDVun/a1Vdb5X4E52oR8ioiaOmG1UiKBw==
X-Received: by 2002:a05:620a:439b:b0:7b1:45ac:86b7 with SMTP id af79cd13be357-7bffcce85cbmr618123885a.17.1738175557241;
        Wed, 29 Jan 2025 10:32:37 -0800 (PST)
Received: from [172.17.0.2] ([172.214.173.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae7dcf8sm652441385a.5.2025.01.29.10.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:32:36 -0800 (PST)
Message-ID: <679a7444.050a0220.2e5831.af2d@mx.google.com>
Date: Wed, 29 Jan 2025 10:32:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3186354455783037082=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ludovico.denittis@collabora.com
Subject: RE: [BlueZ] device: Clear only the pending flags that have been applied
In-Reply-To: <20250129172231.329172-1-ludovico.denittis@collabora.com>
References: <20250129172231.329172-1-ludovico.denittis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3186354455783037082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929127

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.84 seconds
BluezMake                     PASS      1535.06 seconds
MakeCheck                     PASS      12.86 seconds
MakeDistcheck                 PASS      159.47 seconds
CheckValgrind                 PASS      215.01 seconds
CheckSmatch                   PASS      272.19 seconds
bluezmakeextell               PASS      98.41 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      899.80 seconds

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


--===============3186354455783037082==--
