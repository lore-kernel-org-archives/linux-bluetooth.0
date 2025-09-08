Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523630CDBB
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372441; cv=none; b=YZ8Di3osLI5RHFBYzRR0dXQOVg5NIyty13F7nmB49rM8/qaQexr4Deu3fQ1W41PHhyasE5yej+Ip1m/7XBjhPlKf7luebWFUSZxK1ptHfO+8PYu4+duF+QCfIuetkMaEkaExxzwswWWRs6Ve/Khu3caXPfx96Q3w4rJhoYMmAHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372441; c=relaxed/simple;
	bh=cMN1U16u173Li7CApqVAHJxTkjY+x7acdHT26ZTN3l8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MUf7na/r3MiHmtp+MyBKjjpYaDI2CDtPHw74ukwoYOvIad08sQg6r4My3qjMdYJuGUfJJuVoBmpNvchQfscvvkuCMKWgp44tN4w/dUI6j5BgfdUhENyAr/PSdRi7tZ3gYFmug6ZekNsN0ZNHjxI7iC3gxLl+R6gneupPIdzXUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdny6rX6; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdny6rX6"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70ba7aa131fso56637076d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Sep 2025 16:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757372439; x=1757977239; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M6L6Od9J9fUwpxJfByjv/mueijSMsMeIPhzLK+FTFQ4=;
        b=Qdny6rX6JdnosrRHNqsJQt99MUGpaebAFZau3h98JA/DSKISpUD3EbnFbiOE2dVXD2
         uF4/D0uQV2mxE/7LkB8yGydp82Oi1+MKPr6dAGwcbfTAqHjzSKSX/Wsvvvr82ceg8Aws
         dnej75nisXkoyQsqgTz7LwGPspB6g8WD90ww+PQX718cZBs605Nhj1BH319g6wNu/05J
         CrDrRHsKNsKBh39+mdQyX8XJD+3wNReVEpHXbqNizrLAIfj9Vqx/QMsu8YUjEnrTEbcb
         L6PeLXVcAziwRjMwAQc6IsOvw1kUAqbGNDZJBhpAAMqbWB7G+Dkj9kwAyzXzcA7iZ/fK
         3PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757372439; x=1757977239;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6L6Od9J9fUwpxJfByjv/mueijSMsMeIPhzLK+FTFQ4=;
        b=c/IGxrcxZIdQr2sim43DBYRzHPzqJ4/IpaEae8GkQ1+5+P/BgTdPMDnkvDM04wVwQK
         f1amBHlPtYY7hyN+xsNxZin+bv6h3jB9KZAQdfzw74uAsnLbl9bAk2lVsQXQjpFMPiWc
         pbp7RciMuZgqZz7LJTMtV9KP+BYveObZf/76+Do5u/F9FNdmARcKEqMCoR0Bz8P8RM7x
         jbH7SvGEjqFKm4x9O6Jq0wyn3uaXSB5GhKXcqJh4FJ7hT3TED+jqoIxAZlBlaJ5E4rBP
         8gHiJvGywJmu8wB+2GkkSsKJLL4biAdnJDpdZ/rzxOFHHDHmS3Vd6avda5KFJgkHhHj/
         rg4w==
X-Gm-Message-State: AOJu0YwfB+73srpAeVFBKcS3rG6a0zWmZlMOTBhKRz845Lmzbb3+oCg5
	j7Mg7S8FXodpv31hvLk1Hxi4hoJcaiBPbRUx4xHcC3Bhyb5Palcvd4GRpJa5jdjW
X-Gm-Gg: ASbGncsObNDsB03F+tylnISBX4xWmYy0IcXVWAitmZ32ogwPJ9Zr8ath3DzK2qyUqw9
	5S8WznNY/R1aGtbtpyrKlAtwYdqEscmSniQpXCbBoWtXik+kRaxVeZWIyRs1KVMqXWJYi20T35y
	oOFBcmfCXiMm+uE94PovoIPbgR7+tDLOHeZVVJOMLO1HGpZTqjz89Ya5cMrUJYRp6NRnsn5Nwh4
	kb835h3BteXpGFWOhIrM4Mnd2YzBt+O2MDzsTbzWp0oXkNTt94cmMuFAa82M27RCUz9IJcKSphB
	Yir4/VZ20kTxpjsCcK10hh5EbeotlgpHCg9/i9t6SGACv3nn1RQ3ca+e94C4i4JgqyPxUvnXcKk
	VqdIgqII0vadhoQv2yzLiT68CcMbLjV1fr62E4xW6+A==
X-Google-Smtp-Source: AGHT+IF3rjUAoJi3jkvHwBPo2sg0yWR1qKTyeWGaU00vdjmz3OhgT9fLMcjq8JoXnYvU9dcUohFPYQ==
X-Received: by 2002:ad4:5ced:0:b0:727:b235:cfa with SMTP id 6a1803df08f44-7393a82f390mr101912866d6.47.1757372438427;
        Mon, 08 Sep 2025 16:00:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.125.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ada84d33sm134902146d6.28.2025.09.08.16.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 16:00:37 -0700 (PDT)
Message-ID: <68bf6015.050a0220.24d537.7689@mx.google.com>
Date: Mon, 08 Sep 2025 16:00:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2018673096084542281=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] main.conf: Add FilterDiscoverable option
In-Reply-To: <20250908213833.1518432-1-luiz.dentz@gmail.com>
References: <20250908213833.1518432-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2018673096084542281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1000203

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      2651.00 seconds
MakeCheck                     PASS      20.71 seconds
MakeDistcheck                 PASS      185.57 seconds
CheckValgrind                 PASS      237.49 seconds
CheckSmatch                   PASS      308.96 seconds
bluezmakeextell               PASS      128.73 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      923.13 seconds

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


--===============2018673096084542281==--
