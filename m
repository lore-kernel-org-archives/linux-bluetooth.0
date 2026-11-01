Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793575304;
	b=hM//fLlTUcdDSDg2HAYen6B8iKXYdoalMp5pK4qmQGZ8SsDk2/1xNtYFcQ9yXvAh37iH
	 9DqNYHEC2oKcckk1ExRh0x8+gjyjtGBK0dCKznDNgCNE2mWlYfERknN9Aj/foDqMDctLY
	 IYqG8doRLGM445U8+T1zycOC7vJlYCvgQKnNOSk8JRq7tDGVpgkLPyHcOmGULlOKvR09q
	 bJf2cpwAfKG3RSqTHqA0vNavTM8Nvo3W4qHVpiDQHGIB3eXEYsltzaOjVZXgnBM9VqwMJ
	 cQjsXsI1Zjf/d2n/vmqJZnAxq9H8fr/6fRn3b+uZ9EgKkmUSn+Jj152BjeBJWJ4KsaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793575304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=edo/XqkvppkOVyWailcacaCpyK91wM3Uikj42kuntCw=;
	b=kpGu4dZr2rekg41jZQbAbPOd5Gc1SmX89TDN6xtPYaNGvoRXnfeGzPxwnKKPx/sYv7g/
	 9MidhMkPhKAQkOCH5sGuC3+StQehOh0wCDxv5DtYvBjrq5uzebjaNBQ8Cq+xDRS8MWyxU
	 df1GplGW1D6c6bSzu3Pume/DhFYH5XUojFtSfP6y7ux4YL3sX4niaH1UO0MTyXpoph0Qs
	 Z8Jl+M5GyG2eqqbYr+jOajUgaLf5tGWDGrt112VoQ6O1NroQvuC+TDhfcyjGog3YRZ18Y
	 JA+yt/KimejCditErkxzrsm/6qLU5wsQ/jRaOhyxhZXNe/1+H5vNDBdGNfDSWelS3Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eIUjQTcn;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50031606A324
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Nov 2026 23:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50031606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eIUjQTcn
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15943c9c005so846676c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Nov 2026 15:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793575303; x=1794180103; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=edo/XqkvppkOVyWailcacaCpyK91wM3Uikj42kuntCw=;
        b=eIUjQTcnc81eooT/9O/yM+85AfvvrvmiV4wU/52seT8dm3iiNOZc7Q03VPRIBGGvlA
         t0iAGez8Xn0WN2rIGRDjiQYtxMk0L4aZwPoi0Pzas97PXVTMqjreq7MafMET4oO2NPkl
         HaG8ZiBcZ7PaM4iCgtm6CXdyTJh0oX1wal2r+fJx9ErB7iTqSRj0MOlhmz4SRYJCUqqd
         G0qy92Qr/wuqLbkaBCdzcxZj1AAqw34AgioNMC28Lr5KRsarmHqcHxFxAqijaXsqE9N7
         gWWpskcEDzrWerbrohavyF25JwUdYMbUqtM/58bqNCjC2GvABWbmdhrbQ9kYOgf9lxnM
         HX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793575303; x=1794180103;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=edo/XqkvppkOVyWailcacaCpyK91wM3Uikj42kuntCw=;
        b=mNuQvZY+CPxtSAGcX08Rar+UwAg/Uju9W239AwFM9QK+5LVfswuYNGeBHHAFPIzuh/
         2lY3aU9Gy6KODNi9oYMJVryZi3rjUNwzx6sL2R+YffIXy2H9pW5Gn1YUt1/S51+tVg/z
         bxZl3+YRg7AMH5KRU1rZY6EuQOjAm8ldNLWDP79WG9EMkCTxRbVZD00wQ6mAzMV0DkEs
         zqZNWIz+sEOodMqBsNHednbteTI3nHl5Xp5MRnWS0SLPT0+TrW64/AIdIxsjPqOAdJ25
         61bO833jshUC1bZhrA69qccSA2Ee7xf1ay3rYasGqT1LaVvHbeWdSX2KXgGb+h4ySqgv
         nk1A==
X-Gm-Message-State: AFq9FYKgK4r0R8FDNpSucmcZSHijFHtLbN2jmrM4px1oil2WUMsuqxbk
	8DQQU96RJvG9051cbyo/E/zqLRMtXo1KC5wJ8hKnfmbjEejVBlqoLM58R3pwHw==
X-Gm-Gg: AYBFou3Gdwhbkg1Kp8Xhs1fr6IrHB3mGqByGtbQabQADwOHPaX5wE5UFcaOLVtXf3/c
	FyM1u5ze6uha0UCu3gqEMVXlXEy80tc68XGRg6ubNVSsGS/a9ZgNF/1RckpTYweW4nr7nIuSDgm
	QUfker7/Gw+ZwtyuWOcRdwWZynxXRav0UlhK5adLEAQ3TNyxtYjeYFV4nNxCG4gjWOlIs4kVwMR
	RzNaDaIFv7772t+UfJgJliYRy31aeQUB9mZW545cGZa5BA4teunD/LbgD7v7s3V97GvnQ3xaD9B
	YVPOlB8yUz+3HdsxpDQKo0/3kp7uzljzVZtvMtzcRR25DMdcFZ0hT59nun0MnmfQOTr+zG604vA
	smTL5QDt19XXgIZ5MSbDfwuLqAd/BKl44fTSF0c6ZFh8FVboGFlJUiwmIRJbxEUYnJ0UvMkMreM
	blWcjlU2zzVcJzLF7GVQ8SVhqUAcNAEfbV02SQBbE0EOGdI2WRbRrEJt3zh1NowJWWahhPobg5P
	1kOrnwJGPBN7ReNb+aBzt3fkZMBDskMB8nMISZXBF2Q2Sq+YZRCwp8w8GRBXw==
X-Received: by 2002:a05:7022:160b:b0:196:e254:db24 with SMTP id a92af1059eb24-1ac5c64cf5amr15814610c88.21.1793575303269;
        Sun, 01 Nov 2026 15:21:43 -0800 (PST)
Received: from [172.17.0.2] ([20.169.63.243])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1845817csm27778343c88.5.2026.11.01.15.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:21:42 -0800 (PST)
Message-ID: <6ae7c986.c02443da.3d0b4e.d521@mx.google.com>
Date: Sun, 01 Nov 2026 15:21:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8087873485829515227=="
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
To: linux-bluetooth@vger.kernel.org, tristmd@gmail.com
Subject: RE: Bluetooth: hci_bcm4377: validate completion ring entry data length
In-Reply-To: <20261101204701.2851941-1-tristan@talencesecurity.com>
References: <20261101204701.2851941-1-tristan@talencesecurity.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8087873485829515227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198289/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.49 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      17.89 seconds
CheckAllWarning               PASS      22.33 seconds
CheckSparse                   PASS      22.51 seconds
BuildKernel32                 PASS      18.23 seconds
CheckKernelLLVM               PASS      18.85 seconds
TestRunnerSetup               PASS      401.49 seconds
IncrementalBuild              PASS      17.63 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_bcm4377: validate completion ring entry data length
WARNING: From:/Signed-off-by: email address mismatch: 'From: Tristan Madani <tristmd@gmail.com>' != 'Signed-off-by: Tristan Madani <tristan@talencesecurity.com>'

total: 0 errors, 1 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14930798.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1038

---
Regards,
Linux Bluetooth


--===============8087873485829515227==--
