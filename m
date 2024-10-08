Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5021E1D9A43
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389670; cv=none; b=TzH/5YoIYPFNRzNMnOiyAfwpIjeNXdwN9Svvy9BNFBCiemN7RV5Wh0Mpj23982BzLVxXNEuyTYb/RFKIQ6sIPcMXiIzC4o7nJwNCWh4nfAQDHOAUG23pZElEG6uhAurno7D4/vpQJrDl116uVvbXm10Gfh88880Oi8SX47EaQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389670; c=relaxed/simple;
	bh=Q0V1RJpmbhR5bIK9/x6NcNaEb+1EcQmv4c24puKhBv4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=G4TgpDX25ZuortV5/YLXMf2I7w4wfsq3mFmQ3U47kEDVXtVLjovJgwzb0B49c4oyb4/fvPQEy0Kg9IzXeZ5KQQwzYuWN7C63+fmg53Z1MAcOZETWbZ5Rl1mkL9xObPFJUa0c/bUclALxa8jSfIgmY4NcKobRXBVF8OEjBenQBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFqwIcZW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFqwIcZW"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7ae3e3db294so317956585a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2024 05:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728389668; x=1728994468; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll8atL/SL5bdT+/nGwFDSzejsclSjLlSCg/levZ7Fe8=;
        b=fFqwIcZWGiI5a9afBw7c7xnZVrWKcMVgMGaAgV0v3ixwybVctx+NBM6hMc/k1/QCQq
         c1JteQTZJPbqQMHEZUwjiVwCebEG9xFungwwYjvfvsTuC71Rjm9I0033htmK6LMUNL5c
         sTDM06/6+OvrkVppGbfJa3dv9XAB7qe623e6buDXvdAnk+VuWvV/Of6ien+cd9IvfZfg
         urPA2jSa3TmFcxtXxRRoLG5gLHCFkstPqkWHoy5CbA+m3yxkzLftHxtthAhCdd855/q0
         h4j4A2DIc2o357irZgzF1ppujr5MywYJoK3ZW3Pd9p5vRivGUbcDLZ0eA3+YZ8lQXraE
         cw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389668; x=1728994468;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ll8atL/SL5bdT+/nGwFDSzejsclSjLlSCg/levZ7Fe8=;
        b=k0Un6IVlmx2U0f7M+vqhY1rbCi4m8gtdCOhWHoGkV3dkeSKkeTGA7P8Rvj7BnTDCR9
         TZ1oaA4pcvVIunwrGrRD1qXRYvrXvNGXMyfclAMks4NggxHMnpoR+aKzYRp0EyHZKXua
         G4IKhp6k4WbT7vtQTU6Fox8z/X4v/aU8SUwsiTBvpMBIfiayb4c676DMGVE8cgZDGEmr
         J8EJUzZsU9Cqb+1ix/wtkGHJHgkHL9XOeBcGr0bQcd/9CsEhZ2gGzet2KI+q0SxeGkh1
         KcCzl9w7SdM4+QEXJsK6+sYWQT14wMbJGV3f/Ji7QxwDOBCk3OPcPry8y5B2kt+OwXeU
         Fucw==
X-Gm-Message-State: AOJu0YwGulQvL4wQCVcKKzvSM0ZYHygy4SB9NpSaELVixXvqhB9wjCLm
	dRKDUOOlrQ9V1s3UIF5xVlSCw0Pk2DrcGsN1ssQK7vZxRR1Mll6tr8M1wQ==
X-Google-Smtp-Source: AGHT+IGOKNqhS6KLUlBwQHLSi9bGEqbsDpBeqqebnxUfiHC1GMY4J2W4NdoVNGg6vkk6lLvp8etWpw==
X-Received: by 2002:a05:620a:1925:b0:7a9:aba6:d037 with SMTP id af79cd13be357-7ae6f421a17mr2171649885a.13.1728389667710;
        Tue, 08 Oct 2024 05:14:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7561e688sm347332685a.10.2024.10.08.05.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:14:27 -0700 (PDT)
Message-ID: <67052223.050a0220.13f1a8.990f@mx.google.com>
Date: Tue, 08 Oct 2024 05:14:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4879113193225246684=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add Scan Delegator support for Set Broadcast Code op
In-Reply-To: <20241008080126.48703-2-iulia.tanasescu@nxp.com>
References: <20241008080126.48703-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4879113193225246684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=896570

---Test result---

Test Summary:
CheckPatch                    PASS      2.88 seconds
GitLint                       PASS      1.85 seconds
BuildEll                      PASS      24.33 seconds
BluezMake                     PASS      1581.36 seconds
MakeCheck                     PASS      13.28 seconds
MakeDistcheck                 PASS      176.72 seconds
CheckValgrind                 PASS      249.58 seconds
CheckSmatch                   PASS      350.78 seconds
bluezmakeextell               PASS      118.16 seconds
IncrementalBuild              PASS      10361.16 seconds
ScanBuild                     PASS      1063.81 seconds



---
Regards,
Linux Bluetooth


--===============4879113193225246684==--
