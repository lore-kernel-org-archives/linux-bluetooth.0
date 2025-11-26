Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1728314C
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138302; cv=none; b=ShdO9ysfQC4u5QoYkzdOSHyBf1IcM3YpU93IIbd9GZtnaaFovbvkIAZYiN/uJw4yVW2TqHPBQ3ek8Mq+GJuSPndtROR/HZTG9MX3qFcUyNF8XZCQAuAGlD6dNSYAbGk+GbNEq3r/8DYfTjQZf3V49BvYkpfg7SSRnXrxv1kOBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138302; c=relaxed/simple;
	bh=ix+joDaXqeNfUkOuAwfRLHRQz2BK911uYawW2DrHbfQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jcs5gaizPvFvQloCWYM31OqRwL5XDd2UFQj/od+CY98fUQ6dlD+QLlTcn7/mwzi8/h1cbvRsuB/1V02pgSMMe4L0Y3ennlmb4RZFAjGp82qShP01qEqZs4NMrwZRVeT139qDzpiwh3YBLJHDWS+fayaAZ9z53vnzvIw7I84Qh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGy03bH8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGy03bH8"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b1bfd4b3deso525934185a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 22:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764138299; x=1764743099; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ubF0VsOjKKycR+5IX6gLuSzxxyFbVbRSMCLFqycryt0=;
        b=hGy03bH8PZevknAQexC+OwxjYZPxVEuZjK5EjTnqVS3EzP7qkpV1CBrs/7HYh6Bs+Y
         VakVUOouoHh/6zn8BcbwtfvadsCy/sMaaUiybM0T/xeq4k4DiIkBt7Ys9Nrte7ydixxo
         bJhUOwmxXJNYfgNxfJhLrtWzABnQ/g1q99NtENSxiYOS3yyeYdiTD3OrZlwTqBGKqkVN
         18a043yCiVO+R4Im3rFyzs7ySRWTd3nnNCgekMNZ15gkNrHe0gLS5nYeIZL2xrSCIHjn
         Bt2fmq19rWLlggq2mlB3HBmy7sWAdftsXI5WJ+LUz2GaqJtmLcRqphbSaVMm+YenwdKi
         KWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138299; x=1764743099;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubF0VsOjKKycR+5IX6gLuSzxxyFbVbRSMCLFqycryt0=;
        b=ow/e0+34qhWFvz5VPQyMmgf1O7YEIFJ82XmwnlSx2p5sLMNz6WdX1LW+MJJCSvLwrv
         QoLUBohAb+ZAPwJ1SRgVh37SotczRICW+KHbHooRmZS302Vuf5LBZ4axpJYz/TK3W5yU
         5mG8QIhEXCW3IUVI5qBYkep1zA80mUmcOn08dWvBNUuvkyLcSFYXtaGtFgN1qbnMXHZE
         5nOS94ka9305kJYB6OlVIcHuxgpmz57MfU4RN9vz4SOdGztfn+J/UNF4hMm2lfF55NRL
         nL2rB/8W+RXQbWfDxbHbneSoz8SDuZGA1HG0ZZB9EMbtaA1WxnBgqMKvYUHmV8TCcDQK
         K7gg==
X-Gm-Message-State: AOJu0YxyONu88H3C9Xr7l4CGH54/wK+PG79DO79zOy4TZ9MNl5jhKi4q
	AO6BiCgru2LSt+944VNCZ5llsjojyYSJQo9ELsQy46W223OX+Dg7cnlKTb9H0Q==
X-Gm-Gg: ASbGncsHrbibV6qEICLEsspeX5y4MA4gkR0zZNEIdfC0QLWD2oh5RIKHTEmAsh1FVkb
	xeXonnQcX6p3Ca6EJ/ab94RaJyD07oFZl7BAc30gyNlsM1e0seqCEK5dyxbN1mzgmde2TAGqgBu
	Ie95ajBwXybp34CPImpPJVaVFC2bs42goQ96jNJRqFIus+HDK2lIqAPJgVBHplozFvDRsgFSH1a
	bYYZTDDOPv6PDwMkNGryGV/+37JDjJpKb46DjiMCl4fzlViBya5yDbq4Gw0HuuXdED3FKMbVsJt
	TGbU4baxGIecFZj+/PvOl7rAMdvBnsLVs7wDnRrmk7yjcFyXcl1toPML3eWg89tV/kuSYQDZ/la
	6mV76HmDxkn01/IeMUFSPipinpXK85Is1ky+EC4yXrDG/DWb0ocHiwxmls3xICmTUO1cts3rdi2
	Y4xzZnR6zwly9sAa0d7A==
X-Google-Smtp-Source: AGHT+IGbye+5bfMYwao4qQ3UbwrZQdrlzAaLCVK0uK9pByDYJv5Y+bVDqkvzSO7hCnIiGcMnoZIcbA==
X-Received: by 2002:a05:620a:178c:b0:8b2:767c:31d3 with SMTP id af79cd13be357-8b33d1b13c7mr2300797785a.6.1764138298843;
        Tue, 25 Nov 2025 22:24:58 -0800 (PST)
Received: from [172.17.0.2] ([172.178.118.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932a919sm1345289585a.8.2025.11.25.22.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:24:58 -0800 (PST)
Message-ID: <69269d3a.e90a0220.6cd58.32ee@mx.google.com>
Date: Tue, 25 Nov 2025 22:24:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8037253766515611976=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: Add implementation of bearer connect/disconnect
In-Reply-To: <20251126-bearer-impl-v6-1-e93fd41f10b6@amlogic.com>
References: <20251126-bearer-impl-v6-1-e93fd41f10b6@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8037253766515611976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1027639

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.76 seconds
BluezMake                     PASS      696.10 seconds
MakeCheck                     PASS      22.46 seconds
MakeDistcheck                 PASS      253.51 seconds
CheckValgrind                 PASS      309.82 seconds
CheckSmatch                   PASS      351.91 seconds
bluezmakeextell               PASS      185.91 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      1038.47 seconds

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


--===============8037253766515611976==--
