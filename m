Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB744963A5
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018008; cv=none; b=TM0n8AzcGA9/rvwCjzWBbt4X05LSzfDWUzsiYJCESvgMugiwKZmQegOLkYnsoa6z2s5slabaM4cO7L+njp40oA7XQD8QYxcuxGjyC1T54ZkoA6lRoJMNJe9tsTygWa7e79hNALNXY0KLX7onE9p/80ein9C08x9ASgYMwOBWnGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018008; c=relaxed/simple;
	bh=zD8k7/Mr6ezrk1kN7OxCoZH5+b8hELXPCguHj8HkB/Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e6fk53JPRAxk84n8z7JPKfHWSz1sigLo3ctx9PrGtHxULtESx8N+3AbB/imWNjdA13I97dPc7SAMq3Q84qeXjgmgFrZnbEz24IlWmC9hDd1GY+TI0ljWBqgsjKjkDh1c6ijO4undS/kXX9zZLcyb1jvwV/22CsARt8rSwHabPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj7/X0Xn; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj7/X0Xn"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8f0579401c4so743642485a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778018006; x=1778622806; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b1lJtAdkZxtZt+c4DRFxxodKELly3V5oG0VjWoKnDqU=;
        b=Bj7/X0XnVz41l44mdb9PkEuA0F1x1Hu1ooULLrUOJL0xsy7Be3yxj1xZKjAiI1Cgki
         nM6KaLLYagXbKc6ZFVTQWbArTK/zXHgNiHdv31ok1qJ7U7WSDQ+pXpP/yr4gIcZmom8C
         i9CQcvuVpZIeu4inDMWXbYJKLiG029idasUtlRAjoAIAMQXOPYFMIeuo1yKVnGlHwVOI
         2OPvMha7nc60iwRe7RPtjwgNTC8+p5l0PKQH/fYSqdgavO8E++nf4rPieU03bbY2DUds
         kh4EGtoZ/lKtvfSmJvjb0f0GEuRE0ppE9WYu3oEN9v3E1m9tGFVJEtA2d27xtJYiSIwP
         2LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018006; x=1778622806;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1lJtAdkZxtZt+c4DRFxxodKELly3V5oG0VjWoKnDqU=;
        b=KfwkMy73pO56KCkBNONMYPRQc8JArFfHc9w7hpKZeGCIJ775N7x0Rjm7AZuvEpJd2q
         JUBqGbx4UvIJFJa0224Gc3xDvfMAl8z6V3MfpkbzPwbfsRhHL54aj0BERHdediMNug+G
         l3r4Qm1itigH1qFWOaOdKizfpqbVk/M/Gnqk8yu4kPJYNGbAZUcpXPTS6n4wHpO3gZgY
         8TZaasLF+eH4bV2EVIf0iFzA77cojZqyPYz2Fh913ftlWYo/vRFwh5eb4LdZ618HU9TU
         +bd2bi/VnOW+zWVSKfSNOjGxjpiE+uLKQjeJNUvMyUiJ56ydRPKzrz9AaHA1x3WAMY21
         +OMw==
X-Gm-Message-State: AOJu0YzqJtNo2RnyE5yoQPcqHg7DU6NETMsZDyk+7IYLabO3dyktdpKp
	ROqLGhFIgPcdiSjWG7gP4i/2lWkEExX69ISrKDaRkWfxxy+GVPzaKw6trGwdgw==
X-Gm-Gg: AeBDieukButNmG7vLJ7QIuY/ulKM8mA0F6laZ0hqW1meYURh6QxjPert4Qh+aHzj2ri
	KaywhBIre4/pLmVy5FilUvF+8tPelcA8r8WF/F9PZELxLULSK47eOX7o4gjK+lNiGfagIE19QSu
	Qz2usT+vljF4FwJsB++rWtZ0z5ftAJoUhZlWjnew3Sj4PLAcndwZC6Q6vg3MBoi4+piHE4sAGmr
	Cn0irb1Xosi3/EMh2zUl79h73hzomp7kHaVQ8Riueqh7Fkfd6CdAtZujNa8QzWYCv9wY0IwXvI3
	DQCj5DqylK+cN7JLTox/FtXjnSQN4ZXsvW8Vw5yZZzhtjOOCANuPWicj2NHvcuEOueht/py8gsZ
	1vUGI9w52K6p0EEo1B51nDqr9n0TCKxvLOEUqICq+LcT7bHW8pTNzK2x/RdqqK7za/i2jZeAVoh
	27M24wEyXvEynn9TiX2uyToKgJP9neswWh2151llQ=
X-Received: by 2002:a05:620a:25cf:b0:8ea:c7a8:5072 with SMTP id af79cd13be357-904d3fa3fbcmr141778385a.8.1778018005931;
        Tue, 05 May 2026 14:53:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.69.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91dd48sm1453708685a.38.2026.05.05.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:53:25 -0700 (PDT)
Message-ID: <69fa66d5.050a0220.de9b2.9626@mx.google.com>
Date: Tue, 05 May 2026 14:53:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8368207404462468698=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] emulator/vhci: Add debug messages to error paths
In-Reply-To: <20260505204719.1348473-1-luiz.dentz@gmail.com>
References: <20260505204719.1348473-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8368207404462468698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090123

---Test result---

Test Summary:
CheckPatch                    PASS      1.97 seconds
GitLint                       PASS      1.46 seconds
BuildEll                      PASS      19.86 seconds
BluezMake                     PASS      611.29 seconds
CheckSmatch                   PASS      322.85 seconds
bluezmakeextell               PASS      167.27 seconds
IncrementalBuild              PASS      612.35 seconds
ScanBuild                     PASS      896.75 seconds



https://github.com/bluez/bluez/pull/2100

---
Regards,
Linux Bluetooth


--===============8368207404462468698==--
