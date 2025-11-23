Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14E1D6BB
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763918689; cv=none; b=JOWPCeBW/eK+1staw6p0dxzNCiRtFaWm4A9P9m7q154+/+c4Hh/SaLG8Zz8Ah99A0sU7Y/JkX8QwNZseNq7KBZEuimnVaSS6YE7dz9fqrOLStLA10JlfBV1DZF9RelbNLWtNX3jJv8Nl2VI9qhOgIS/AKGn+O1yVryXym2177kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763918689; c=relaxed/simple;
	bh=xY29lfjosfJA/csUnyA4GOYjkwzyM2IwPIp5pCzdr5Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G3ILpl1zxk9QdvnjQX2/ss4lsaOLu0Nwl7f/cY3pvNM0/N1F++hsh/BesV/4HbIKgNC0ikewmdG1FqEcv7ANOLmK9pp9TAA7HRnV1XrIkiD7bh/6x0Q30C8yWHDunm1Kvpwp/zsNC6YEWNZHXLFsNiMIzBpNNVz8ltWp2Oxp26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAZfxALB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAZfxALB"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc59a785697so3181256a12.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 09:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763918687; x=1764523487; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NYNDYd1dDZBp7B1FFxZsZRlrnnYDB2CwGfnk1/BRu7M=;
        b=mAZfxALBg8xZ7v2teDPoAdiJaBSjUJ7a+9FYOwnPzMPmKH5qLPiXwvCTtTSYKes/Cu
         v7AjyF/hnB+bcq2+LfUjWvKfkXM2XhlGxxlob3ad0jsgC9vtHeG0ZSo1kGVCLTu1w5ut
         0c+gEe6Xv5kq4KAY4fiNC+dplNgmrlSPKZfc2w8qhkefSvnmZK1zDgv+3WuU2s/w3YR+
         SEUNKid48FN5jRMUFU12i02qK0eJID1gND3foDozU2j4Wc1+BcY9y2cgLdRQZqSIqW0B
         uzvgUuFiCb/d8WhfZrqiuNFlFXjYscCrmXuWf26ZgSGaaQOkvomG0kdvmqk2FNoYrhPX
         UB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763918687; x=1764523487;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYNDYd1dDZBp7B1FFxZsZRlrnnYDB2CwGfnk1/BRu7M=;
        b=Zif10acqs3urWmkBbiVLFBMZnNRaYqzqT7ki+vVq7A8JUG3KlXgLKCyvV+Sda2zEpF
         V7qEmvVXWwPK/PtGUCdzxivHYIPpsJbHtHi0ZOMOaXZO2s+MCDz6seaUgApHZyBiqHif
         h8OAqxG/mLixuSPy1QO7f+YMUtH7hL6h2XqzVO3k3WBintVwDvNfcuzOf18aWanYjEVR
         G3bNE596YTtEr/jJj/JSs5dqGDcgXw/kG2fq45CILmlWVQTWyK043Eprm+M5evXxM8HI
         da6pKsbkI4L06JXLtQQ6Fc1X5c/dQ8C600i/4DivOOTyr7f2MIsuAwN3OmT2Rjro5eY7
         z3hQ==
X-Gm-Message-State: AOJu0YwYnQ2zpzU1IHA0of904O4iNULCt4FvYQ5nyKw2fJ5Kxsd0a/C0
	7Jphmm3HSmTvbvPOM5+LwId0VyN/VEOEZM9Mb2rD4t7iRjmQ5eFa1o5Own3SqA==
X-Gm-Gg: ASbGnctGeqi6iqKPvphI1Zl4O2cztoezfsbM2b8GTaUsOsOrVNsZjlRLRfC/4mMA+FL
	u0MT6yXdegdDAaKVKtmoRd5fyaU7wSdG0a5AOmnQe429GDCKe/REX2bOKRkEuKTNV8R9CsdHzFp
	4JBW2gUKn05/jfIfWrJhCMvUt2jloFqyKrWpiSJu21BXFJaorwZo/YR6KdUAXTX84Y9RlSgQV21
	td/FQt89urwkZer0m+cdJ8FT6mYH6PKUp7FspsgDGgexW6X/Sx6tKhB/muLS0W2F1gi4myYFnRC
	BO4amgl3Fk5y03BP0KO6v46KzxsvHFfOSm5Rjg629kbCiA7Rfj0XLe/+g+DS4+sospiayRAmgF3
	6ZtG1AslEGCjCPolalONNywgOpJvh9lgKhWzETFFSsZKsfj3f2oebULVzpQ3T45VXxN7jd6roS/
	/+sD9V9pZ2xOHb9L7J/3gi2a3apshu
X-Google-Smtp-Source: AGHT+IGiB9MDeChNz+lacxc5pUFG1SM9hqEb/fthmH84+RLPwc61NTVXZHizmuj0Bq9oO7GmLl/SUA==
X-Received: by 2002:a05:7300:80ca:b0:2a4:5b32:2a4d with SMTP id 5a478bee46e88-2a7192a5b52mr5322895eec.29.1763918687335;
        Sun, 23 Nov 2025 09:24:47 -0800 (PST)
Received: from [172.17.0.2] ([172.184.211.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc38a66bsm43274007eec.1.2025.11.23.09.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 09:24:46 -0800 (PST)
Message-ID: <6923435e.050a0220.2f6e77.8eda@mx.google.com>
Date: Sun, 23 Nov 2025 09:24:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7017640245103620170=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Add TMAP & GMAP information services
In-Reply-To: <f8714ae4192d4f2e745ddd8e76eca552d505dcf6.1763914558.git.pav@iki.fi>
References: <f8714ae4192d4f2e745ddd8e76eca552d505dcf6.1763914558.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7017640245103620170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1026711

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.28 seconds
BluezMake                     PASS      632.28 seconds
MakeCheck                     PASS      22.34 seconds
MakeDistcheck                 PASS      240.84 seconds
CheckValgrind                 PASS      296.97 seconds
CheckSmatch                   PASS      345.77 seconds
bluezmakeextell               PASS      182.29 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      992.33 seconds

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


--===============7017640245103620170==--
