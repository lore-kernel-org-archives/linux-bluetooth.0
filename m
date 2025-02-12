Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7620A5FC
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403060; cv=none; b=sx0qtsyPlHrdA+cIw2lbNAwTyOdwrWnnSFZleagMld5Pzl9Y8pEFEoHWRJMnWnO4OdIqptK1f/C1S3hQasHBNJzjFX9UcZfqoY0w8hlZ9BIjg8XjmSOcvWLnH/mlAwt4uh1W6MOe+ouelFXgSRvWLuV1hWt0P4Ctc1NhG56TaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403060; c=relaxed/simple;
	bh=sBCEAAzv7LXLAMoXIPVuc9f1SS6NWNIFs+c+56y5x+I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=baKccCmz1GR1gTjeDswpYoWjysd3QrTHT2TQwvNBi/w47xeayctTvyrelfReG3Hdw9AESt++onbZ7aFGuBh67wKNaixqV37vfygn8RVqqBvYvVY18fp3CMRa2VBKD43U4JcFbsNU25hXno8IsVdVp+zUZ51gXqI0UzBM9JMmtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ouv+dfc1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouv+dfc1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220d132f16dso3214875ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 15:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739403057; x=1740007857; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=El+Ti3XWk8T/8WxW07f6JWD68leKy0NTiD0728iZoLs=;
        b=Ouv+dfc1w9nWwJSoTE3ZkSVH2HV6iI6eoJsb3TaOOtche/Wq54vAqAU4wHsv7PJDiq
         9kBnYLAZeZyJkC6H/bKZm6wOxJEz6SmEOu9hgbX1eSbqqZdWBw8jAgyUCtrzrO9xkSSM
         uEZOwexepTzcvnHycqS5Ksjeb0Zf7iqheQaz3hOpeYQaiCWiyD5gg4Jr5uq+v/S+uIgp
         pIhVGtfb6Z3cDyyD53czKaCs4BknPm6bs52yhZlXMtUo3qGOI2KyRvEILxZT1yYA6iml
         7K7Aa3pHvh72fEeG2RnYvaYTmth8Wq9sp/6KYOWgmsvE0/GsAeU9kJEwYTac1iCdRDXX
         PFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739403057; x=1740007857;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=El+Ti3XWk8T/8WxW07f6JWD68leKy0NTiD0728iZoLs=;
        b=F26OzMZIpW/dAS8DgJsDID1rS+/bApqsJgYzdk7XU1xBvUXLzCCx757tcYhHiIH1ic
         a25/0XDciEdjYMJIACHwbmgLQKKMAhyEWBl3Slp9zy0C1KCNsa60qH6DeHjcnUfulYBb
         fUnWa/PDMESPPpbOBUIK5NfBTfJgzDybpWlESGjBfttf2hoOzt5LgsX85ElXVIb3cgQc
         BDARx+plhc0h2kZAx3nhTa82uDhYQWpaQ0jTsHquy38OZYKIH55+a3NcnIDHSC7LcK00
         O4qtuvWeFz8ioyYUiZAcIMBUmus9SYwVVjbexPjILfdC7PJakArlFoMBOF4gQUQymNfl
         VG2A==
X-Gm-Message-State: AOJu0YxE9U6WMNKsedtUN2Isc1wDbUXKm7vJw8cTTMuJDyNL1G+8Or72
	74R+VCQQBxPDTOp5v9HIax6Euz2xXv2s/Yeo8R/m8kHfZrcx9JaJ7Ubr/A==
X-Gm-Gg: ASbGncuJzm1Ox7NA0vsq1CtrOTYQD2QqmEKGHH4LFxGPeJ6wVg8n3Tu2gsriL8kJYzm
	ZtC3Rg2RvNjPWaYYsZaRihuJuX0RAgKwkU9b5SFIs9ab5452vrj23AAWcgCnGSoMmt9GqUCdDbL
	vGi0P1jUiDvLVyqWFkQkFokXizarSolfWjkUuo+dRlbeywQr93Z+eZ1jWAG9HzcLeuVjq5f4qlm
	IGw8uMNy6eDMzygGJPGz079Pa/2OLr1O79JLsHg0EfTEfUVmpnU0zlZWBS3zfSxUT74Es5bDR/9
	o7eU3BMYnDUBTC/PD9FL
X-Google-Smtp-Source: AGHT+IG3Nr3piposCV4dz+EbOTSzYDAXd+y0QL4NTSrI6TJMBC+ul7/QZ4R11ql1GlFOiSgidIW7QA==
X-Received: by 2002:a05:6a21:6003:b0:1ea:f941:8da0 with SMTP id adf61e73a8af0-1ee5c796270mr9884132637.24.1739403057227;
        Wed, 12 Feb 2025 15:30:57 -0800 (PST)
Received: from [172.17.0.2] ([20.169.15.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324277f3fesm2175b3a.166.2025.02.12.15.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 15:30:56 -0800 (PST)
Message-ID: <67ad2f30.050a0220.141b1c.0025@mx.google.com>
Date: Wed, 12 Feb 2025 15:30:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7957439244274981318=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] build: Add alternate configuration for enabling LE Audio
In-Reply-To: <20250212221156.486006-1-luiz.dentz@gmail.com>
References: <20250212221156.486006-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7957439244274981318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933378

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.48 seconds
BluezMake                     PASS      1431.58 seconds
MakeCheck                     PASS      13.00 seconds
MakeDistcheck                 PASS      159.69 seconds
CheckValgrind                 PASS      214.85 seconds
CheckSmatch                   PASS      283.73 seconds
bluezmakeextell               PASS      98.01 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      857.52 seconds

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


--===============7957439244274981318==--
