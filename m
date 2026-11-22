Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372253;
	b=06wLhOS2tRbg5UkujHRY8FBoh9pLb80RDeSD7+0qqhDXaJGGgWRqDQfqCTXYA8hc7Dqc
	 VWI9dMt2/ggYojkVXamIRUnLMrok/GGvNG/2qGxlpyibLIMMl84GPF2VHq5ztTDzilzoo
	 eZaHqTPPA8moetznehx1dIo8m/lsAzywqtibQfg7GyNXtITjSUnlFFNc/pLjNFub+vOAW
	 GJ4UYJM5NnNbjI85kiv9pcoq/ULV1G48vdOQzmSQcyuMwJT16goGGaVQD8decm+qtzGsJ
	 c9jE/n1FRZcl3h916hQDKsJgeIkuFt7Zw0/zmBzGN6vOZwwtpJ7CxfUSDma1ta52J1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=3F/dXbWje0w/7At6ZSXE5KIh0/zwCKZIdva5fltyJgI=;
	b=gyU42HUNyY6rKiTl2JXwftx/Z2SYfvCI7Yb+K5qhffZsCC1QoofPeCDLV+XLqSxvT4x+
	 G/lCEb3vQ5Sg2LMtbFejtiukT8XN/R8BK70hY61yVB7jvR6j6cuxpIcPMZgoj5TO8bxMr
	 o0p6AcGPbtO1rTFlfvzf1StnLETq/zo44qM5ce+KRGUQLyd95xz0gATA61/I1cMLTJQIY
	 3+EgfTPdK8zdRkXQzTtDA1i3ntflT1KzLsL3eGu/+Ct/+NBIMxkN3cuQl6HYMAKUc70Km
	 xdZKUbfUj7J56cWx+F0mbegQq13Vb+CvuuF5jrnHsvsjVY9O5DffwaO+VGWloFVG7uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaAVPAsP;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E5606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 18:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD3E5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xaAVPAsP
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-844a8bf7e25so1486399a34.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795372251; x=1795977051; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3F/dXbWje0w/7At6ZSXE5KIh0/zwCKZIdva5fltyJgI=;
        b=xaAVPAsPDVNf1tVvg/GqDD+ZLy1C1fqDi1MxZgF/vUeCarYKGZYnr+mBr9bbfrja5m
         lel+Nvnydk4nJZMx6w7stuRQo1HqNKUcHbo0cgyRST2zYdGE7lrYAc/Z1zxbgS2moAHC
         IQALUuFajRWzQfuAhGtEzEcEkOr9DMTSkw/pJdoiNegrcH03QwVs6YCiQQb6/w0XURLr
         tZhjZn4EYVGPOJE3fmF9opR6pjpHzHliZUvnlsE7CUBXp8mFe+V7tmQy7z3eNN7CDIik
         9bSMfuAN+9gbTXPa6fsWvhlhgcJNXCmXq0ptxDmx9XhNwws2Er7R49JBCUw1P7QSi5RU
         0Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372251; x=1795977051;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3F/dXbWje0w/7At6ZSXE5KIh0/zwCKZIdva5fltyJgI=;
        b=01FruTq++qKxurpUh1Ni2bsKNt9rqi5cc89ycNAjj4Zc+KXzbPNYKMPxHloa/aCSS0
         BZddVZLnw0+b7qCLQ0puYi7DNF1IQfT3fZHIqNqfzVC+imiqX0WdW45g6Un6MPO9s3k0
         XxNZUpzPk7CknRSpVssQd8ZfmN8jXlL9cjj6QagX5UDMIzrwYhBg8+43CUHEx+ih6fAa
         QbCxhd33HWeyKotg8j772nUWKdH3RGU8KYSfoGclfcCq4SqXofyOH40/g4qdAVZWJqW+
         kgIpz4elxnwICqisHyRD5dcMs/QgNeMly5tQ2r1QNyOBDOPfDSBYro5KHqbmUa+4Y5Kd
         n9pw==
X-Gm-Message-State: APuU4Z8maXDo3tOVpIvK5iwNqG+sJ7/Lum7cb+Y6/qOIBY4O2kDbVSlu
	A1c+6v2rcVYyhr8NQTW+jGpNBZi/7Uw6QcZzGdCCQv2BlHwpkeje5nNd5SGamM8T
X-Gm-Gg: AZFdTZd/aq117XTUICSAfp7+IsgOt1BIkI+WLEByust5UmxA2bzGKhpUmnB/hSuNhxq
	jWQulgWUL5l7S4Kw9/KyHBWMCVSs5og1+RitQY8aoWeH6wr4pYReB7Q1ndPBF/ypimK7K95vtQg
	HKtLARlCMM5sazNmvISlKcmNSH/vxeWpG2Dxaw7SzKrNdQ422sca9cJf4/hgEmZ3Xj46lTMBRJR
	+GAOIPSxgf9cjic3aDtV0L0EvoLjsMStjJH/5R8ALsnN2Ig+SilthFDxNLBOvMKM+PfWrb2i14P
	fbt4LKJNccCeJjl/7TVgk1RsFodV2PxlgPrxKztlC+14eJTi5sPfg/xSG5m7ax5QoQkK56qyLy1
	HtxaZ6irDYW0trnrbahkmMtbTN7GhyyIAcnZf7vvUNSkE4/4UZQi2GNN8MFg43zzM2oIqRD7dKY
	Fxt4RpDfbXm4z8+3BdAfzaEWfV9F1nJd1D1L6uzg1pbtEHY1VXo82OTKjiqbz8EUKrz/nGngAsd
	YE9pwwJ5h8M0HiFUdW65NZVLyNrPziHDJp7JtblBG4IE1kmzmYPFc1wWwb6k8OGpaPduK1j4qq7
	osLgaw==
X-Received: by 2002:a05:6830:3915:b0:80c:d34f:5f66 with SMTP id 46e09a7af769-86315ab1ac7mr10768539a34.31.1795372251490;
        Sun, 22 Nov 2026 10:30:51 -0800 (PST)
Received: from [172.17.0.2] ([20.64.107.9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631692d9f7sm7040104a34.24.2026.11.22.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:30:50 -0800 (PST)
Message-ID: <6b0334da.674ba918.33e30a.a3b0@mx.google.com>
Date: Sun, 22 Nov 2026 10:30:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3191697836003316947=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] shared/att: Confirm indications without a registered handler
In-Reply-To: <20261122103511.647388-1-simon.mikuda@streamunlimited.com>
References: <20261122103511.647388-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3191697836003316947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218568/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.38 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      13.88 seconds
BluezMake                     PASS      185.34 seconds
MakeCheck                     PASS      0.76 seconds
MakeDistcheck                 PASS      112.70 seconds
CheckValgrind                 PASS      111.95 seconds
CheckSmatch                   PASS      197.85 seconds
bluezmakeextell               PASS      68.89 seconds
TestFunctional                PASS      923.61 seconds
IncrementalBuild              PASS      195.72 seconds
ScanBuild                     PASS      654.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/att: Confirm indications without a registered handler
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#174: FILE: src/shared/att.c:1098:
+								NULL, NULL, NULL);

/home/runner/work/bluez/bluez/src/patch/15010044.patch total: 0 errors, 1 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/15010044.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2867

---
Regards,
Linux Bluetooth


--===============3191697836003316947==--
