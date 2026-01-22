Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90B31577B
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106249; cv=none; b=Tial/AcbhFyVeUxIO4gcAC2q7Wrb8DyugUjVnyBLwIq8ZJVVNUeCv2zrxZvVHL2iOkQ3quY+ckOYBbYoReql5FwBL/XPP49CLyHAtYCeE6im1jSUZzruUhWtfe0IV0Iootu+xggHgmKAorvKOkIwMHq3LVKbw73F5B2pkiQCrZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106249; c=relaxed/simple;
	bh=x1Dd/FV5fkhJwgyG9wUJBCLLWCdzIVd+0v96RtQsVAw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Tz4O5u9d+Cgv1Te2aUE9g0hwGZ1ddSILL6FgWuvCNPOo1TKNwKP8SUor9vp52RuIMTuDS48auaQKC0qDFuBGsMIWMLCfrqVoALtQ+sAd3TsnrfLFs5EDuBMeRnLtTfHN56PX5dvQl2ppN7WzdqryNTSvDMWPEQdnOUSlpXZlFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFT+mIOI; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFT+mIOI"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5018ec2ae21so13404301cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 10:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769106237; x=1769711037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=96Tt5Rtu3BI4T07YRN53NHaTBFADjQvhyuVF10wB8Zc=;
        b=bFT+mIOIQe8LZVghcwTCu1v0baB3IqOxvXixiYry+CQ7IFXe97ej5AyKv7+m8e8GCL
         3v/c3KmyG2H/gXWugofu2cmr2VSGq4/GKg+cT++udfX11TnGxEeM3xWqO21b6AEz4UWu
         r1aPbXtUZNSg4aKDZ+TQ/6SRYr7u7FS2o3dvMPTxpmYWNOif2svX9wrFkImS5JADL+AD
         ehOhXU+SRy9XEv0AYI1wUW4+MTudsOF2KKFTSwVhZGh/e5UyysKvGzyzoNFpRL1v3/SZ
         O/YGBQ4QZwNncrx5fSjwwfuFNp40hUhWWw/w8NVt5NK1UcxjNp3nj75kIdAx7ZLRmdsm
         rwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106237; x=1769711037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96Tt5Rtu3BI4T07YRN53NHaTBFADjQvhyuVF10wB8Zc=;
        b=vd8fXSxCcFkVNOePF/73y+t2Dm+2c5McxRgxnJaLkxz8VpGbZN9sEs/uBlp0m3TdBs
         SAcTJhNZ+0fitVMVopEWkgGqzyhPbnqhIjEPjcd4+kKF/T//479X7ygPnW1NHijz8jOU
         auCT7SHGYaZ+L+5IMKbJSRN93la9sQ3Lie4u42fIfH8LG8Byf8xJOCs4CL69mIb7rNgc
         OyDRxzZwDuax6kVnf8z9Zvdq/kf2DhRvoI+IDCs7lE0XLBRKkktUulwg8a8ScMMOd4RM
         fMvX8OgykHKhFsJw6B/1Ttz77J5tV9lShbjJiqFbsW1rfJ7+ZH85jbejnlkm5EnqC45z
         WNOg==
X-Gm-Message-State: AOJu0YxJzO1bn26daUPD6yG8l/arX0Sf2r2XJpAkjVOkurw+uUAoWGN+
	kBViR8n1rfHdy1HuZOitcLZXym8BV3OQiL3bTtVxcy1z7s7Tp5kMmHxvRfxVAfftTdc=
X-Gm-Gg: AZuq6aICirGsqqP2pCKzNDgN454H9GD4iDELRC9qPtKSp96wK4X0gfsXZVlqIMa1QVC
	G3JkzFgzucvG2nyHC+MBE3nsKfwMnmVNYDkH64mcjzdk6aaGfUm4Uy40cieFAl5JFWjAf3yTdj1
	VEJ41FRF2xFH/zCInZcx8wce7h3HDYwSdBSYyoYYMwXeHWBjTJ/KMDLCS/51yvq+uI3JkS8Th55
	OJRKZB2bhDNeCWRtm7ZaCG6ywtL6Dwx7rsfPXG8wBr+sgUuxuRmPDckK5Yjkg5m0ZxWgJKwRflB
	werlgQwKFIkybfKL5aTBxe2M+gei6KUX+vG64xXXEVbJociGeiaNSbwi3Xd5vroiXwQ4ZOm/v1G
	PChnjBwGXb8PwJR6QNsTw6L0VGy8CqaVYyle4WEATrFQNWx3qUpmuBM0RDRUMfCgP2ncFXVJCE/
	8A13flhnI8O/Aw/w2mYw==
X-Received: by 2002:a05:622a:1892:b0:501:4f38:3d53 with SMTP id d75a77b69052e-502f77d4929mr7383511cf.62.1769106236579;
        Thu, 22 Jan 2026 10:23:56 -0800 (PST)
Received: from [172.17.0.2] ([48.217.140.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491824c7csm189076d6.6.2026.01.22.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:23:56 -0800 (PST)
Message-ID: <69726b3c.050a0220.36f265.437c@mx.google.com>
Date: Thu, 22 Jan 2026 10:23:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5406826008030961212=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Documentation fixups
In-Reply-To: <20260122170001.122052-2-hadess@hadess.net>
References: <20260122170001.122052-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5406826008030961212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1045811

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      650.13 seconds
MakeCheck                     PASS      18.51 seconds
MakeDistcheck                 PASS      244.13 seconds
CheckValgrind                 PASS      296.11 seconds
CheckSmatch                   PASS      350.79 seconds
bluezmakeextell               PASS      181.15 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      1021.52 seconds

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


--===============5406826008030961212==--
