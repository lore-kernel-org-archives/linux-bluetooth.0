Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5D563296
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572918; cv=none; b=sPlrdPa1r4j7EvZwgq3HxCPvMDzOiDQIAq5ezMVYHEr6V280kPTPu2acsSIyYB2p9ubVfR9+aDj3xVqoQpZLqMQB0dMUTk31X/F/S9J3Jq33JwDd2izVf1+BlgvYHI+VJQ6vu9XWZEa5EOjXFQX4JRQz3PIZUngQ2Wfd4PgTMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572918; c=relaxed/simple;
	bh=Iq6ZVWGap6hjqN/RSFtCvjMDUFVxZZopeIdUBkHpbUE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fEZ9xN9bk0MB9PNFScaxh0kxmO1roNsza3ceQFbTvFBMWq31/MQt6XVYUBVn+DIOnyyTEWtvodyI2GrnybYpwQleDN7bvI+iQCV3F8+7e/TYX2al6+/OdJaX1YVgubSQ2uVYIE1+oXmlYK/N5pKQbLF3+AKx9xFtgrBW5yBJwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqt/6Vo9; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqt/6Vo9"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae736c64so888276eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789572909; x=1790177709; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HjTJfiK7ZeZVKwz4rMY6ntKpezaCTKroZJD9VJF5lzg=;
        b=jqt/6Vo9wwFSSLAAlvX2XL1+6yBP4Hn5fuTsiHh9Sa7xkQLxTkF43fVSymprt813JG
         TPM9Ute8AKVdrAyxJAloN1xpIF7VZhjOMsq6BeMevavaaobS3/egSS1KqeJdwvbkeXs0
         Z4tS84csh4MUJuMSGaFnUN/kHnbwFXto593oD4wBoJJ1XEax6aLhPyOATmaLpdEKMj6j
         XMHxWS0VdWv6J3TZG4rhdDoP+z2vSMSDixWngwtPfNq/rTjhANH/RbGgCA3WvV6YS/gl
         aWJGr4jaloADhDaZPxDqaWVcRWcLV4V4elxZLhb3FuKqN5YIGX6Q21nCXyYel47S9Rkm
         /w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572909; x=1790177709;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HjTJfiK7ZeZVKwz4rMY6ntKpezaCTKroZJD9VJF5lzg=;
        b=HGiGwDvzsACR23qnZyAk0AIMEtPMAqE7QXZ2ay5uMRnQEvgUfAGEqYCA96NdaaxcKE
         BnPadYGRoage3LmUJkllzXau7bWW5rNg8YV5coMpf3YPlLKDYf0WJC4+HJJh56kbB0GH
         8TqinbXPvivPeblD6Jy5rcly08uTqVGcTbjEmPvA5K4/qwlfuNmKMYwttMDWAPm5OewQ
         KlVN2L1Tj2lW0PDqHEKRDB2cn5kb6wXa6kloHoDB8auyXy1vpSJOX+Eo5xUEBCwvyVgT
         Y6GJNZ3Cu+t/x+VMTHDG5y6hIiTpJKvG+N/iV1Q74oWNAUtBZmHKTk6UaN6jkjxfjH/L
         NfWA==
X-Gm-Message-State: AFuF++muIvKWCiTIB3nGp0TnNlXN/6O/Php1ELJarY6C7eUszWPNDQT9
	M3Z/1QKcJz8CcVrr2MtdHQRHUZe59HvTPeH38TKo6zYtlZxDO7jlWZFMQc7oLw==
X-Gm-Gg: AYBFou3m3zrcFU2u8nQ2QlUW9EYU7FxTvJBWBuCjSZYOWrghZ5Xiq0UgHLaBBBe7Zeg
	f35dCvse++b4q7SqxuuZj4m5s2ES4sxkUp7nfN+B76dyeMTR7KzZ8di05dDDoYk5PSgkwf2FDkj
	bLD63ZqJKjhprgop3zPpF6//5F/SjHgQnfOQkORu1g+rAYhBR1HV3oJsR31U5dMMx7rhkHegmc6
	HDIfDvAirnnn+MdQwGUMjlmHmUJNI41C7yGpLaTd0WKoHtBCEFQfy1B0Xv6lTbgXQeeOC9AS5Gc
	1O7Uj+xEv2RSjstcnfVmT6yU/7wVFNX+OWgcUWJ/LQcoJjXfyC9MMGZRNamw2iy+0WfbA9qiu+u
	FzsurRbRoxiyaPZ3AF6q4wWxU6V3rdniQ1rDh0ZY85rYhCZvkkbu+NLSkwYRpVlElh7pZNJwoQH
	kJSLD58aoVoyoTRjznjeEYeEpnjjMmX3g60KAwWUQLHK+wxuYTXAafdg7QzGvJkPv2OC4OgbGYP
	ULU+xQ/voKvz5E22YM=
X-Received: by 2002:a05:6820:184a:b0:6c3:4af1:661e with SMTP id 006d021491bc7-6c7d2df70abmr3021836eaf.46.1789572908937;
        Wed, 16 Sep 2026 08:35:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.155.180])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f6d70cc1sm68829eaf.10.2026.09.16.08.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:35:08 -0700 (PDT)
Message-ID: <6aaab72c.b72a8dbe.2c91fb.f80c@mx.google.com>
Date: Wed, 16 Sep 2026 08:35:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8802992645804465488=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, christiano.amora@gmail.com
Subject: RE: Bluetooth: SMP: reject Security Request over BR/EDR
In-Reply-To: <20260916134622.519192-1-christiano.amora@gmail.com>
References: <20260916134622.519192-1-christiano.amora@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8802992645804465488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1166514/

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      22.18 seconds
CheckAllWarning               PASS      25.11 seconds
CheckSparse                   PASS      27.16 seconds
BuildKernel32                 PASS      21.93 seconds
CheckKernelLLVM               PASS      24.58 seconds
TestRunnerSetup               PASS      578.85 seconds
TestRunner_smp-tester         PASS      6.92 seconds
IncrementalBuild              PASS      30.31 seconds



https://github.com/bluez/bluetooth-next/pull/782

---
Regards,
Linux Bluetooth


--===============8802992645804465488==--
