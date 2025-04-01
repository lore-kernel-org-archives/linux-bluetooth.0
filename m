Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10471207663
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520283; cv=none; b=Dr8l7xcwavRLPLlneCIz1tjFEIelgeWr9UAtJdN6jHRgiwUb1c809hGlJ8i1wEaRoGfTIMt/b8f+xd2b0TlyBFfxUXVYuZpy7+C2P2kF0rSoSj4xFLCOyctFVRLXjyNzgExpVYkD2tc8uVWMF6pUvRxDC41aBW9/AIjAiIQ0EbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520283; c=relaxed/simple;
	bh=WVH6Qo5d+CG3/IzdUsdydziTXU3COkbf9xnvUPRQfP4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E8VSq0lvq7+4DcvA1MTUe7cmbpOZPslVH6b9m+CoOWlEX6elWPPQcjTIjpC71OO4tEXE5rkQQnMG3uwCbvGCksBQCm857bH64SFhXFb+fRW/8uZj4dBWYJ6vwyvWo7vU6w0Kg4sVIjF1B5StWpx1zLlZK8+Sg9fB+rZLXjp5Gno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNmJ97lP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNmJ97lP"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c560c55bc1so603511585a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Apr 2025 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743520281; x=1744125081; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JBgXRTP/bEgO0pmo1rbHEuGnITBesVZBuLViIyaFIDo=;
        b=cNmJ97lPCMoIyYtOVUnkvLe7LRPYUXCWbpYfuZiM6qR2A+0NUjTkIShQ5S38zFW+Ha
         3+N2VsL1o78H/BjKxGUMPRqyvel+n3OClqj0aC0c7nAww1m6JkBXANeonxjs/6pyd5gm
         f/kebuyLzZebU7XSD9lXMwuhJjhUwbOd3fO7e7o79KQeXpG35/EChGRKFNmmzfrpQLr6
         z8hKt/TXwvM9gmJZzADprdaD6qlLSKiyaDYt4CfR3GGXHL0xq3wYejWpnvGjnot3nCgV
         /ac97MG3S872kn7iTRJpOR+bDhdhN2hrpkdcOAbggzrpwFA0TpS9UOe7yigjUv8fwxMy
         2Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743520281; x=1744125081;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBgXRTP/bEgO0pmo1rbHEuGnITBesVZBuLViIyaFIDo=;
        b=rFJ0ySz7Zzxka8xJNSxR6MkfxTr7406tEkeQOH0dfv3Ch73lDBG40aHZo94+F2zxeI
         M8fkTlvDf9w5zLVjWiYvHmHzuHl4zw1VVYk4tC9uV73e2HWmDSW0cqsPZZ2Xcn/h5NEd
         /2BAE1mdA8tz4jYtCxgky+AAC+hk0y8Q+THx/hANLR70sdB3epineGeX9Aam2vPDC2AJ
         ha8kyoyAKDAePYer1N5aSGmNgUwKxswbufj2qczsqfO87A3LrK+blEx3MwwHkuLjHFx/
         fVzGgcMt1owkQ3ZAaTTBf87E2Wz2HvhdrQO7iiMUrwjeOQi8ZvDvPBEuWTzOyGHpHGl4
         Ga1A==
X-Gm-Message-State: AOJu0Yw/xbINZF3I2Zs/MygclhZ7el59WawoV4NomwQh5KZ8XH++3hDc
	oVC/W95tQWkCouUDAtKvaoRcBdt8Blv4ALCWG2WwNr5BvG2DgzwTwD+N3g==
X-Gm-Gg: ASbGncuPCZi0MXAamilUmGUzkR2QOzCQcLL8l2gGG9/x1vjR3v1DgErEKaj2bL+qFFW
	c8VzuH8nE9XqF/n5oFK6msm2QS/H1HCrcS0uihUV449jF35syRhx55hsZnLMpHu8uVv/tVeBOFY
	XGP7GiCCiSqmZoj+hdkhT1ffY5lUg+zicl4/GU7UwNaFij38AMGZON2615Jx38FkLJFFxaSTzAZ
	FrDXvy7tafklxefbSRTkw05iF0AK20SdZRE3ojJXl6gzhFYtBRqel2dHiPfr4ytWQJUKzOMghwB
	LuoLJM4UrY2GbvrYdB7lFapUEKSHCrYDBiYgAGU5hBE7Vsx5l2E=
X-Google-Smtp-Source: AGHT+IH+SCs4XYTtxRw4zMDgCUBMmsZoDBOeJW29GRlCHQGEAkG82Vqu0S0hgW+wBYwPSq8uhgIj4A==
X-Received: by 2002:a05:620a:f0e:b0:7c5:4463:29a4 with SMTP id af79cd13be357-7c75bbb258dmr405472385a.14.1743520280446;
        Tue, 01 Apr 2025 08:11:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7764e55sm667602685a.89.2025.04.01.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 08:11:20 -0700 (PDT)
Message-ID: <67ec0218.050a0220.a0260.7ee9@mx.google.com>
Date: Tue, 01 Apr 2025 08:11:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7931571385646976475=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] shared/bap: Fix swallowing states transitions
In-Reply-To: <20250401135115.3735533-1-luiz.dentz@gmail.com>
References: <20250401135115.3735533-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7931571385646976475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=948958

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      1498.49 seconds
MakeCheck                     PASS      13.27 seconds
MakeDistcheck                 PASS      157.52 seconds
CheckValgrind                 PASS      217.93 seconds
CheckSmatch                   WARNING   285.93 seconds
bluezmakeextell               PASS      98.39 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      869.65 seconds

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
src/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:314:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7931571385646976475==--
