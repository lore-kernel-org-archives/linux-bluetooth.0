Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C9242922
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369209; cv=none; b=iXz+hNTejbQJzL+X+p2wLZMd0jiW9uw/dIWvIoi23HahkFe1wFkHk+4fffbaJpgI9fWqLmfGAvbbHv6hBmdim9OQfdtj3WtjQdBEZVxNeTVpNM5SZ2Jq3QhjroNKFl8GHEePbO3bnJ7wLwHePMS5GX8zvVTupxiuiEjntq2s0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369209; c=relaxed/simple;
	bh=DH28XdyeXr9l/CCKxJpMjmkPBhQadKk3gxXDrOWmPbs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RbUg5or/h+R1qZNreHQMpLzLuiwgxLa//l/r7RQ3SuucQ4BsaY4tyozqXwj5Hcb1d489u2BtYStnmou+HK8yjSHWrm+5AtyVB1jXe79CVCicj0kLMLJMD3HKH7xRrw4M+eCHPze586Me232BMLGc5+pNAyeeo+Obi0T9kWfUT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYIimXKA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYIimXKA"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3d591e50aso228319485a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Mar 2025 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741369207; x=1741974007; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XmRDTyznPpNooMpqzmeQJCMmEMfLl7XvI6Mvt9swLAw=;
        b=gYIimXKAU64MXFrfMP5CRrdQtq09/WHsfIfJAdNz1X0iCtpTQOlygnk0KEtqVwna24
         INZItV50kaf+M5FoqJl2e8w7gTj1MX8wxQ1Y+4dCYcH228cVZqd65XScmYdeOCCl8my5
         OeLIlNcI5W/g0kCaLl0TWA0Bc2PBe54ayARfQ3+5q4Sgc7M9zExeMdR9cBLM1u1JuMuU
         r8AZGFUlteYbWGG4cGVmxXTFv24AoE4USD7Atn10H2NGM/JkSuMBj2iV9O9cSh+RXin8
         KvUtbNSaN/D0mXyLKzdxv8ye5RV1gcTabA0mNKGCmdtGs2b/ILmDM8qz5XO0Lh4rZOAk
         dgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741369207; x=1741974007;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmRDTyznPpNooMpqzmeQJCMmEMfLl7XvI6Mvt9swLAw=;
        b=tjU6Yc9yyj8aLtM1a39jsVgcniHFL4q0ifGXKwIPFix3m6qumDFuMtdVBy7hTSMkhJ
         hskPvmF7daycioR3QUnvnLDPgz00C61qhZNkLc72Mmz2K35u7t5KPHbsBqHoIwSqCWMm
         vs4Ar3CYV2lr3aYPYUeuHKMkKRKbdhqbZxOhbEoSlPrniq9HC0MAjoTAoEX6I4YkVuWP
         ypME01rsfI4pFsLCJGSNgRt1RjQxSTR3w3XygEWwY1RIM3kri6aRUR0qNpvLopAM5hkc
         ArTqnCBpjVRLiTGSn0nWBPgdY1Eo1HHhkbKDpuseXhXZYru2ezgX0+ZZOT5uh/OpWs1a
         MRHw==
X-Gm-Message-State: AOJu0YxAK0CvquDqmQdetdDQgMzrrc0w0PpgawbANK11eFUOw+Gs1HSB
	4VZiMct/ggt5Q38FkhJANfVUnvgjEMM8bPy5RwfRD0K200ZyAfU1z4dhKw==
X-Gm-Gg: ASbGncs2b0bsSIEHm6zt1oLO/RHR2ddbd+l692HZAJpBH1i0505fD4BSHz+CjSTHEli
	PnDSjxGW8f4j+MGNQOl/AtSNgzFbVL4Kk5Dyo2KpdyjaueVf3hfEj/s6oQNOnlCyyOjQ/ZtZDfY
	R53LxtYttLDImSw+NwQS5N/lV3nz97b3frA9R81vJRgbh+qLa6MVYRuq/g/yHlsPiinDT6qhngv
	81Y1WPwK5a66IDxtOZBxhjcIkyAMOQty1+LM7f0EGoVXwSCu1JxyuF1FKYx9Z71FNOLL/fS18U5
	x0oK82qGqGSpYO59nwbJVooXeOBUdsu1sZoxhcd35HzWXd2CmQ5s
X-Google-Smtp-Source: AGHT+IENQx7xqZvCZ/gCR3n4tlg+zsccG3wg2CqXGAyvOKClv6xxXCTNjoc5qFzY4afK1YXJ9DxO9A==
X-Received: by 2002:a05:620a:2b46:b0:7c3:d6b7:cfa7 with SMTP id af79cd13be357-7c4e619feedmr665955985a.45.1741369206709;
        Fri, 07 Mar 2025 09:40:06 -0800 (PST)
Received: from [172.17.0.2] ([172.183.229.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e550f40esm265740085a.95.2025.03.07.09.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:40:06 -0800 (PST)
Message-ID: <67cb2f76.050a0220.e323c.9f7d@mx.google.com>
Date: Fri, 07 Mar 2025 09:40:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7110458034667463466=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/player: Fix changing preset SDU
In-Reply-To: <20250307163435.49599-1-luiz.dentz@gmail.com>
References: <20250307163435.49599-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7110458034667463466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=941596

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.72 seconds
BluezMake                     PASS      1612.41 seconds
MakeCheck                     PASS      13.27 seconds
MakeDistcheck                 PASS      160.99 seconds
CheckValgrind                 PASS      215.93 seconds
CheckSmatch                   PASS      284.98 seconds
bluezmakeextell               PASS      98.79 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      882.16 seconds

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


--===============7110458034667463466==--
