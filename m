Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544431DD877
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655536; cv=none; b=fuxyOeBmat6tZMMgudqL92zkdov4ZgcG4CvHo9JtMT/5PSTwEiffwpHuOW90HyDypra0Xy++2TR1XCOYu4lH7A7N1T0KD7B0MUvBs97fWRV2aXukHH2sNBajRp9p41UjZJLFJP3pzXDNCw9LdzkfynlUO/RxV/4nmKdByKpX+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655536; c=relaxed/simple;
	bh=u9Ues3JTHPYHmXb8hzwYxWlyW7a0Wb2s60do+g0KWFU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E1ZSNqtIcuiEbE7Fj1qvTQ5x0yQboFyLQYKSfRI58am62VoWncGo24NYjYHaY7w4XrSwqnEVaFC/3F2M/Us7kzoh6wGvcWDZRK0HjGloms6sdLL8mqOuR4sRkWmbctl1pyWn9IF8EBb74oDC1aQL6v0hnXQ+2cVexRuE60FioFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRHUWwnE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRHUWwnE"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5b8d13f73so44332485a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 May 2025 15:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746655533; x=1747260333; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dDBkzgA/bfG2zW+lE5qKO9Qwdqnx8XftoH5FGJAqEGk=;
        b=mRHUWwnEsxqPpQDNbckg6k68j0bAF41U9yslvtw3ni9yibsAwES8JXD1q/4SxTdugT
         Kd5DDhdH4OhbEOiAC2vR6tqmgA3tRvjaECPFQpwPXfPdWGCtmdY7WG4G6hXda5bYKmb2
         jM2lu8IXfPQC9mUHlZxuWBqvUANXJhHRzC6M98JD2P8/ae01ATou6D6KrehDf8tl2pZW
         N0mpECBLLzLKVJQmq43zRAdDUL6J2/A6Wv96H2Heo9zVPHSoi3YpGb93v0+O3Sp/Vz4Z
         S/T8UkKxYmUbmQkBS6AOgTEpWfkM1Medwvo6T+WwylG1KrWNlaJ7et6RcUekC+vlYYrg
         skdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746655533; x=1747260333;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDBkzgA/bfG2zW+lE5qKO9Qwdqnx8XftoH5FGJAqEGk=;
        b=B/Mybpkw0UAtQmpzXh2+sybhWAOyLFb1Pw4WyY3Kq7cX5TwUPFDCEcHjjkG7hCuLYb
         QzsNKsQ5K4MEQvxwWb2WkNhaVjBELF/rRit+XfjKsvVpCLjBSd1Dt69ISYsIBBC5bKbp
         W8HdUzn9DrZMmnmPYOKCe4lqKJWquKeMq579t0GDum+RDtWymPPnlA4HnbYCnV4+H0ms
         DobNBSqqKVaKl29Bk0jV87WFiha7/HI73dlopAUeQxdsFSB5L9bPZUpFxJMh252VWC5o
         +xHeszKrhBpPIh1rD8/53uuqNSt02pQP4d4d8K9UkpaM9MM7uvp6e1TluI9xodFwCa+J
         iT9A==
X-Gm-Message-State: AOJu0YyzpHZg1yljEhrlP2VJ5JWirtvggYgHVRgHNyImdi+qjrjp2Mhr
	mD8VVZgwwGYu8sH5b48k5y87x0CfNVcHeCFEMUMmzqSaEvdTJDhXYlHUEg==
X-Gm-Gg: ASbGncuivl/PG9sL6e7bxlarJC7XV1PF6hVqMJxZ92zXJpKRjwJ8Vcwu5pC/qWLDHmk
	P8Jf6SXYnHObyRz0xLSCTxD5li9yx4HWQMEl5CZU4KJStctk5ZR/rcf8gqJZltw/D+Jqnc3jp7Z
	rYcliHSdq80DOc20x25+ARPSo/aJVunTDsBHb8Sqb5KcyBfAtGAkqOkOURubUCIZkYL6oH9gepJ
	bWi+wlhs+7L6smUUX474uUGULmjPZN9SbXbJ9zu/fi352p5tJ+Uz9E/7Dhh0J9770yeG/OU8Dx4
	wWytzoCBN5mCvRmgMkxetrhqvceBm9HNrn6YNENSfD9u1g==
X-Google-Smtp-Source: AGHT+IEH39aIil0nYWni7hO8u6uCQuVMUKScpgorJ1hvZHmsBqbRDbJmU4H9vGFTBRrPohy/QbA1vQ==
X-Received: by 2002:a05:620a:2a0b:b0:7c5:5003:81b0 with SMTP id af79cd13be357-7ccf9e06746mr147878885a.23.1746655532919;
        Wed, 07 May 2025 15:05:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.63.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7caf7528fd2sm223651385a.34.2025.05.07.15.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 15:05:32 -0700 (PDT)
Message-ID: <681bd92c.050a0220.2af933.886f@mx.google.com>
Date: Wed, 07 May 2025 15:05:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4950985809302999285=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] avdtp: Fix setting in_use flag for local seps
In-Reply-To: <20250507203819.327673-1-luiz.dentz@gmail.com>
References: <20250507203819.327673-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4950985809302999285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=960647

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.54 seconds
BluezMake                     PASS      2759.65 seconds
MakeCheck                     PASS      20.13 seconds
MakeDistcheck                 PASS      213.20 seconds
CheckValgrind                 PASS      285.54 seconds
CheckSmatch                   PASS      307.94 seconds
bluezmakeextell               PASS      129.01 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      911.75 seconds

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


--===============4950985809302999285==--
