Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D71C5F2C
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091670; cv=none; b=CZrwHKN1c9/kxSqMXOLYDvYygbg5zy18h7q8cO+aMgTFMyrFLvYjfAishEAzgDQNxNFPiTx53PGfbvSeD1xCd2jekt1CAPcjpe5579XJ9jWLLbuaXOkeScpzye0Dbi3n9HfH3skMNqN6YbYaL5stcVOqbkJxRrBRFffibrhx9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091670; c=relaxed/simple;
	bh=P8whYBF+8TcjoRQphOZrcepMmLwJvbeGhQo5h3RmEG4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LlcPNkaGnaT2nZY6rXStHxzby0DG/apSQ5AlCv6gOvheazJ/gZaXKbffOyVgpmIb2F4IR1WGrQm0VeZeoi5Rl8FvKW4AO6xQf9su27no6oBpFP1vQAIBFFuiwFSvVB+Xw5ovzENsNtnaijtWJYT52EF8CDFmLYYMbq7GXl63YuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT+mMpy9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT+mMpy9"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8e8445219so52784086d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 11:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738091668; x=1738696468; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=81st8zglTzL8NcwCkKiIfgH2sBNP3sfC6hDvOT5N5Xw=;
        b=JT+mMpy9dq7+bCg6CuafMWMTzJo8phKCoqbUtyyq0mkcsGhEGZhHLJpQULSAaMzoKF
         hkNuzfGYHsMHvd6sPUM8ZXffnf/zroGjXwwj5cAKyqG+ClDnw0UNypxXMPEGXVGryTeS
         gsBy683lEo0y4Tqksh6JCFrnY8BML7BiTOd2XuDG+TLe4OxmkJrGcpl385Z8p1DBqLrm
         c4zALyE8ODa+g/Y9JW6p1AnlTyei5P2nl3UckG/0kcaL1rKvT539PdICvXl4gnpGkr3D
         HpERo703vAK0aJm2EpURnE801M6xR6aEzUlCbXQ9aCgSAKLKXzoDan9my9z2C0lgNJFR
         5XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738091668; x=1738696468;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81st8zglTzL8NcwCkKiIfgH2sBNP3sfC6hDvOT5N5Xw=;
        b=m3eTN0kE7ppvjDUWLoV2r3NfIYpCu4Kl7z1dDu+Nnx6m5wxXvmYOv1OE0S5288B2i2
         SfQCWkHRTpHlUQ3+gfklas402x7s9Rcih/j3GStu+bENWuYHbUMd8d/VwPjtP9TF39nz
         pBQWxfYDFd8X1qA+f8a+/bsIChQa8Wyxaa6fXSLtQOtMoBFILCrXOQ4MIX60GYl8RkBD
         QRTbNAtJTCucDaZcrumRsaAJADhx3YwhNUiAODnhmuMc0SdqCqbrUpwku5nSREcdIhTs
         KYcfWmrKk4+X5R+vImYvPerZEhTrTlgBc9HWCfQh1uwDqDCwmEX1MbF+Fd786e7OzmVg
         8V2g==
X-Gm-Message-State: AOJu0YwP+xkYZaQie/B7Ff19hpjcroDOKaZQXLB1iamOp11FVNMCYWlO
	YZ1R2kH9/IFf4RGpgstor0TZu2lJWSQhjrGqoru98wbur8EPdWDoD2A2nA==
X-Gm-Gg: ASbGncsDVoqY+OVEJtHVsZ+nfCoVfJGX3kuYtwdkpFbFwQ7OvNg3iaZ/G3HZOghDLJv
	S7xDzoJFtm02Sjk5paKoBnG+j1eI9B8AUpZBEdQjgoG+zRdfoQ7XWpy1Ti61ouKFRUIl/I+FoaL
	PuUsoeMN5CG+EMeQbSZfMtnJ5EhK+6Br0FdDkV5XLPgpcd9Sn9GgiC6aBinKYHSZIb6ICEqLsny
	Q8sbk3AsGTfHyy3x7+DSyVyY4BQL0mLx6YassJ8CmzSYMSwf7qT3qbl+8Kc6OaMjoT9V3ebaR0E
	X6d8hS7NkkB1/1hMfoRPnq+W
X-Google-Smtp-Source: AGHT+IGvu8q3F954W9Qnjz7Cj0jn/XCwHfg33VtANYXSzaYVQOqE/yNMNumoz8ZOgM564N4NeNUECw==
X-Received: by 2002:ad4:5743:0:b0:6df:8112:3e48 with SMTP id 6a1803df08f44-6e243c63837mr5871226d6.36.1738091667974;
        Tue, 28 Jan 2025 11:14:27 -0800 (PST)
Received: from [172.17.0.2] ([172.183.199.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e208f826a9sm45140326d6.100.2025.01.28.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 11:14:27 -0800 (PST)
Message-ID: <67992c93.050a0220.25a65b.20d1@mx.google.com>
Date: Tue, 28 Jan 2025 11:14:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3621228022333047878=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Add supported features tag in MAP Client Connect Request
In-Reply-To: <20250128174327.1477546-1-quic_amisjain@quicinc.com>
References: <20250128174327.1477546-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3621228022333047878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928899

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      1490.18 seconds
MakeCheck                     PASS      12.96 seconds
MakeDistcheck                 PASS      161.08 seconds
CheckValgrind                 PASS      213.47 seconds
CheckSmatch                   PASS      269.20 seconds
bluezmakeextell               PASS      97.88 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      854.20 seconds

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


--===============3621228022333047878==--
