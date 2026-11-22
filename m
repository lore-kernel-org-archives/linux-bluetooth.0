Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368241;
	b=UewifR7EK2AVYm+jajGZT3L8oT9zWPLq5DydUqHt1QgYB40aG7dJpKucIHF/C5x63bj3
	 Z/0YyNgEYDGBujyXoShrnV+nsxK+2zZrMZDzOTPcugDkAHn9NmVxKFe1Sfup4nW/iSCOc
	 rt8I8YZGJ10IPgZLtfN1/kLPGjQqVsj//IhjOhvx6M7zI1XgujreDgSHGsgX5RahUu0x/
	 38DLMwYTaBhH3aIs84svQ05o+TauF8aFqHAauPKCIIFzRLth4SSx8qT0XRIgBpKKoAf9G
	 SsQQJb6PXzLqFJW/WwPsPhMsegQOdQfFDvdjRQbkIE/DL5fQ1XFBLZ0/7W4HTtoSj4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=aQoF8oVlg8QLJfPvPVhay0ZSz7LTlJi+N6pyAKoJ7AA=;
	b=cn6GP5wrN9BsTzaHDtpZ9QKclfxC7UOMEnzhzjsoKuAU0MoLyrINhr+tdKiXz6Vx1UPS
	 ghxx4EZ9CGJfmnk302ug84EoZEq9KGFsO5Nbm96ToqzKewhangRRKhlK7oQx0Kp5ESaT9
	 HsgCxbBJNRfLdAeHC+fOYdASDkvZCSsYGyDpdbikMH/YEb/vm3yVn9H5gcF0/81ZnHeFB
	 mapRAx/ZNs8SdcpL1+Cg6huLG9+9KnNpsO89s2dAwcelfwFdW2v8nw/3OdnyJd9CD4kI3
	 q0N6PTl3/IWD/jrqsypKcWbODM1lRKzodELaJMpe2ZCp82OiNL5SVUCaIemHs/Q1gbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3+dRuSL;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D37606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82D37606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3+dRuSL
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-18818daa3e7so1500748c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368241; x=1795973041; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aQoF8oVlg8QLJfPvPVhay0ZSz7LTlJi+N6pyAKoJ7AA=;
        b=B3+dRuSLkJBayW86XrhI8viq9u07aqgkGzA45iwnixwZnPfbgFgV/fzH3iFZlV6Tia
         cQsWjG1+3lwphnNcVjqUdJNmcYPDBLwp0iPjxW7ghB6j2TeORG4vLNeYGmHiww8MXfeY
         aRALfxhm4WyKuHvoNonHsFYzHeejeRM9B0Ik1WkvHzVnjhGWd9zJpBWKDmDTdO8XOCqt
         wmQv7/SgbXX7VrSStxkhXcfYBL+BKkcGA8STvC9aC39ajWsvfoggdj810qqEAh7dGmI9
         VilEhNM+H8OY3UES7PZB0OE1IOZn9TZQ1Xg3OWmLKr//qtOhvrC1QvZfKFfEpeToIHd5
         dj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368241; x=1795973041;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aQoF8oVlg8QLJfPvPVhay0ZSz7LTlJi+N6pyAKoJ7AA=;
        b=WoPy6p2lmzxHWRByp5N5XhMykrHs7q/l0NP8C9l8lRjIeCd4B71iyS9aY8Tc4U6nfk
         B6PmgPdmMOBjKH6g7dwC584cGZgpjUFIaGnCbWjqJJPZajIiNO0Hw9HBdoijO9BIIIDP
         4TEuPWSD9UrjpVA2YNUCwCKi0McJNWRyoah2eZ6EMQtZgnTjxZXgk0d9yRjG4MqYNAEE
         6AGhksASJEDatkf9WbTpEqpApW/T0I+Zd4eY7NtpUm2bR4lSK8VGSmMtpfyAvAISQpFj
         buvcvgWNN2lO6az570LOux/l7o2Aj32TMiMZILizj9OfPcoijurczFoxOH44ZnnAbUrD
         27FQ==
X-Gm-Message-State: APuU4Z9UT5fcsfZk0cUC0AWpgrVCRaz8UuOoJUYLui1LIIKT7QsFPZmr
	NLicLHkMoXtTnW4V5d56SidFjklhyjmDX8feSCpqWsc8eIe6of1ilKPjQL0IWg==
X-Gm-Gg: AZFdTZcTcP+z0syAvX1tr6myo6iucBLuIZsH4LHrxw5A84PrCUnFwQDy61V2qo72DdB
	ncmLrmW0GkMt4Stb4qJhh88FS0IsKpGLQDHe/SAXrvFyckxiUi0t4f5mUxoWaz9GXQiCvZKPt00
	auXMOAexzAxA78DoNVzipeBKpIkq0aMzSIi67qNM5YBEBPDI5uz1VfHeqPCtnz+kFKpZZcjIZ5V
	L2fSR0u9G8JRzeJqHSafyakTOQ5T8W9pbn9DX804uWytSZp068oDeVkXkVxKo91yJuQYV5eh+In
	/9WDMY0eynFD/IPG8ARM52ihmwG4+6pku1u0YM943fVntr4nPQnej1MsiI/cy/4pknICjj4uBVG
	e1x0iDmkPp1G+qDTMs9eShQ/S6+jcaey6+kvHw3ILbH1m8hjbr8bvFgNV1xZNoXzL5LPjcwSycT
	gFmoFkgXfAYzFLaF+sbyZl8Cgsm2+PCPBr3kLiLLcRLcam3A7mF17GH/inmOaQxDxgmWuV4JfZK
	1CM2xt1YW9Eq6Ryijbaxvwf7apgl9jqaCEgpHKHZhRFqTy9Ly25XsRwj1Ez
X-Received: by 2002:a05:701b:2603:b0:1b2:42db:8a5d with SMTP id a92af1059eb24-1b5568aaca4mr8982367c88.3.1795368240599;
        Sun, 22 Nov 2026 09:24:00 -0800 (PST)
Received: from [172.17.0.2] ([4.242.196.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm23514102c88.6.2026.11.22.09.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:24:00 -0800 (PST)
Message-ID: <6b032530.48d69adf.6c722.d7af@mx.google.com>
Date: Sun, 22 Nov 2026 09:24:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9010882083789686176=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: btbcm: Add default address for BCM4345C0
In-Reply-To: <20261122155527.1553835-1-simon.mikuda@streamunlimited.com>
References: <20261122155527.1553835-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9010882083789686176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218724/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.00 seconds
CheckAllWarning               PASS      26.26 seconds
CheckSparse                   PASS      28.12 seconds
BuildKernel32                 PASS      22.99 seconds
CheckKernelLLVM               PASS      23.83 seconds
TestRunnerSetup               PASS      543.34 seconds
IncrementalBuild              PASS      22.08 seconds



https://github.com/bluez/bluetooth-next/pull/1187

---
Regards,
Linux Bluetooth


--===============9010882083789686176==--
