Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A97211479
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037244; cv=none; b=P1Sa9avQP1WHiqR6tt0mjnDqAlcc5Regv07gcK6oZcZ3CvrTQCwSZVAwMkEmYHxlKvPQlJC1cYMUw5hCUBvrIMrwU3pCtnrz9+VoXU4/X4EjrXKqhjjBJEF8pVX1rp9KHV1YBXxUkPnvrwtzWT7QFlx4rK58RBv6veIL0pabLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037244; c=relaxed/simple;
	bh=QH9aHIzNxWHKCBJI97e79R1ZXHbM0So+B2EQvjoARMM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GbI8fG74P/qKA9JRA6e7PUKM2WagGJX4Fnt3uvLgoqTuc9uRmheLcwjdDdJOl7O0i7aP/uVnHewdCaRrOnn5k5yfeiUmnCozlhWi6CrtDNQh/PRJnJcQrWPi1sXje2RAwcTFDvIxRIqfSUuwqXVJpMxzIxomCFvpIxuNQ3g7o8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bj9USpNI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj9USpNI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab60e97cf8so8308971cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Aug 2025 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037241; x=1754642041; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jfeS5nqPlc/SVSSyL9Pg2bhvHz+3MJ24Dj6kF7iHjkc=;
        b=bj9USpNIpQttktb8roGes8c1SqDisSR18tALwZU9lRRa61wRQnT8Nv6MXyfX9Z5dpa
         ZnCAFHjo+zQEiLGsGPb7TSQM1f3iFm4Jt9OORGPweaYa7cl5YA8OA9n3wTZNo2DrE6lD
         4OUOfw9mb/3b3U83fAj79g79gDdeOQd46OsOECTSvFJU867EbJBteT47beS55vqpKOeS
         MZ8P0BGd2F+E+CQbPPDkUHB7k7wN8Ejw8rrIHaYADM0vKHveReKUYpSYaxEW6nfOSXrj
         px7SxsehYsFPWkkJIf08Ml3Cd4fPOi+OkpL8HRh7Ewo0qyqFcKLNLtRpQC6gDWrEQlMc
         n2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037241; x=1754642041;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfeS5nqPlc/SVSSyL9Pg2bhvHz+3MJ24Dj6kF7iHjkc=;
        b=YfaoEAiNQLz6wo/qhy0dt2Y2iHUihbTNzzPQuIpjJoc06t51iISzAtygiQ4GHbQK9O
         4vZ0TmahBTZhveErXOunK6cps4Bz5rtNXgKnOFyR6Q6IxpSZ9mXOTlWKoYBolhwmas6M
         vWOyXgvfjJ4/lv2gqsi5ZOpYRjgbnCMJA6IDrXvyaeB6Fb+x/NCCtb4xlNwepaX21zje
         yF0bvcsIu4BOLrfzeJSsWKOFzLyR8wxS1pphMk0Q0gArkMOnF6ZvlDIe24HB1V/FuSIx
         B+ejhqxBcE3v1WhGHS5NKpFF+GtYs/90aYOXFZMZOoK3BVRs8/59BfXn7M2X4eIe9VfM
         5y4Q==
X-Gm-Message-State: AOJu0YyeEfMo1nxcQqjlEEecQVfK4R4VXWpUTQVBdtTNRsSsrRrsWBNE
	bkI0IvhxxSVUuihjoOxAS/u64uhufzEIo/AyNFgZIrjevMgJC9ZxpOlzgLgQJw==
X-Gm-Gg: ASbGncuJMo6xsNpQju+aOklgU/lNFr+1JnBl4923H/v+GbHNDHjPKG3uCqwF+0HTKLA
	JzNamFEP5QFUBmHBlPaHz0SHcw/T0astQiKtP38tw+U7e5WvDkTuwroO03RePgpWwEz6uvEMEZR
	btI2JfS7JaXb235hFbqSAQpRH94QD8/UDmLlBNvGY4upz2tCKQLmRRg/Tj6zDtVvRpUcB8q/cHQ
	obALPk+5YixaA3nzxeqDhTxu6FjmTW0YwtLfHxHfG9+KlSH1ovRgNNHoaW+bxaW3dskKgbXYJkw
	aJvRhPQs/SaC9fAU9A1EHt4csk8HqukYNEPHk/zz5wjKE+5YsT47lbnsFoxK/vmWrKPJeAgmMCl
	JCtyD6ycYRlOFg7W8X28rykpd5JJ3+w==
X-Google-Smtp-Source: AGHT+IHpFnEgJD2y3dyYx+CzygCRoDXEGZ+tX6TQsfTutRajk9KpOmOlB5tiQy5On9PGoDbrLG9XnA==
X-Received: by 2002:ac8:5dc8:0:b0:4ae:cc29:8299 with SMTP id d75a77b69052e-4aedbf7c5e3mr164682081cf.58.1754037240714;
        Fri, 01 Aug 2025 01:34:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.153.33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeebdc99asm18657991cf.12.2025.08.01.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:34:00 -0700 (PDT)
Message-ID: <688c7bf8.050a0220.bfe33.836b@mx.google.com>
Date: Fri, 01 Aug 2025 01:34:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3579676957717469109=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, adrian-constantin.dudau@nxp.com
Subject: RE: tools: Expose the raw advertising data available on D-bus to PTS tester
In-Reply-To: <20250801070909.7890-2-adrian-constantin.dudau@nxp.com>
References: <20250801070909.7890-2-adrian-constantin.dudau@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3579676957717469109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=987581

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      2787.97 seconds
MakeCheck                     PASS      20.68 seconds
MakeDistcheck                 PASS      187.73 seconds
CheckValgrind                 PASS      238.78 seconds
CheckSmatch                   PASS      309.14 seconds
bluezmakeextell               PASS      129.85 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      927.61 seconds

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


--===============3579676957717469109==--
