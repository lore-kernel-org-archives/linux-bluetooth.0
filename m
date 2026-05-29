Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4A23C4F3
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780031728; cv=none; b=NQuJPD6aHQ6qh4amfAIlUayGahE7ek0w6X9nVytvlmwzJzea0KgFo4SXZv7UPcu2DJoM844Zw4Focn5fwnS8YDVnIxdKO9TClhlL3veZH023NQvoTlHNbvniwLN41QzWK4a+4GoXduaMbtMZ6jEyCdKsm6PdAZty02p4DT4rzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780031728; c=relaxed/simple;
	bh=39pT/If6WTyFWP8dmmGkbV4dHib4SUtxTcDXStO/em4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cOb5p+e4RYb70QqJAWf152avv85Vw9eI+ebkMCejIjQFoUzWXxAqPuMWEc/CckYehF5oO60fDuzsKaT2C3R5yNFB0eI/sQt+bObj0Mf3p8YiccyvrZ6BozlIOKgCrolzUE14jw5yNaa1RHCccblM5yvAVcUEWHeKNBwt10+lQZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF0zsxT5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF0zsxT5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-914bfa75911so774142085a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 22:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780031726; x=1780636526; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/tEcrGF7XmPYe4GBtdD5JBaGj7TuZdsfEBEObYXZsdA=;
        b=JF0zsxT5+30NsASrxB4emzcIHS52gu239QXNNI+zNMvzB5DDNkGUzqs/VAmYUac1wr
         YDY9VwpVWjZzl6M23PP4qZWQL18z6nfA8zCU44ZbNhOe3rbErxj+mQW7bT0Gs1BOh8l2
         +aZus4PwcqJU0fD6rkHEUpnHwnkI6PakKtiKUT2lCj0SGCXvdV+CH3USY0wrJbAQkR7E
         zQVCiM3EPAG/k6RkU5x+5o/C9rjA58CsI6byxnWrxKppDze4BsOV1vvLyXpknhxXkl6K
         fm8v3HMTFd1S7CCu7DT61+VrrZ0h306QavV+XoN8BOPYWFuop4MhS6LlGjL9AXh0cfHK
         stJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780031726; x=1780636526;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tEcrGF7XmPYe4GBtdD5JBaGj7TuZdsfEBEObYXZsdA=;
        b=VPsE6vwTRECDbJpx4y2PVQAwzndL1jY6N/eTQcor6AHC1mw8Tlur/CVlHZk6cZpIqB
         /UpKOIUFlvN2/NkvT3EtFgA8eS4nwfK4XZYH2VitvxcweX7XFnaj/b6n5eG+mIHdOyxN
         +Bzr0NhNOXHdpVqTv6g6r7riOsBmfxOIkZ3KoL3iCM2qBYWooBJUDe5V13Ozj2CCDeYH
         9Bj8CvStZHkxC3fuSPXNfZ01aErKFmwTz2neR7xQqytVjnnO9p8O8eyXgxOJNMIJwxNj
         AvFWli2ypndKAfExs0SW5eHdCvTAsdGpXohuZpyJhUSapBxFnONiL6vGQZIBQfyWCUa7
         RF1g==
X-Gm-Message-State: AOJu0YzE1XSIdhI1d8ZSKthN+og7UI4faPPF/OtaLFB3Gj7Napx4jlp4
	2Zg75ST0drQgfRFq9u5lbRYkkwkn/afjDO1qwnWUx+U2C5pFA865AIk+BnTPZA==
X-Gm-Gg: Acq92OFx0pvFK/JylnzGWltqjVTqV0Mx3EV3Iahw9s3R5E82CQ6LDXIYsh3Er79Iv0V
	z5La6N0AGtwcWaAlYM94exf+eeUIDECmq4mkRujzZgZaogYcRnc2XknPmbopus8LkZFAIT400sH
	3oYiljm56V4WA1f7UemxDt22ia3o9MX7tqExVywvyXAH8O1YrZsHatF7q6OdIaIShiGdOf5/4Bo
	jaBwb77HC6oFnGp030MuUrmysr/rJjA1XNjz03npGoj+aBsedlpQip5JRmHYCqzVqPcYKNCi1HA
	2/TFEKnSyk/Yt9NI0ps9jXQLvG/BhdoeZvV3xjsj5IhA8ha7MeXAJRT74kwBcAMmwBaREMgdMt4
	f5BknvyR3TjeSEu3RhuqeM+z8y8dS0HYemCRN8b4Mc5YzgnosSZudTpd+x8oFQcU15rzNn/6Pjw
	ldZxfulx2g8EyMx50yTbVjMMC/dq2cDx9E2RGMPSoR5g==
X-Received: by 2002:a05:620a:628e:b0:911:fba0:6d02 with SMTP id af79cd13be357-9152fdc720emr145941885a.22.1780031726099;
        Thu, 28 May 2026 22:15:26 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.108.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532294a7asm73699385a.0.2026.05.28.22.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 22:15:25 -0700 (PDT)
Message-ID: <6a1920ed.2224c765.1fcedf.ef25@mx.google.com>
Date: Thu, 28 May 2026 22:15:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3661287865157811136=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: [v5] Bluetooth: bnep: reject short frames before parsing
In-Reply-To: <20260529032209.2269753-1-rollkingzzc@gmail.com>
References: <20260529032209.2269753-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3661287865157811136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1102596

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.21 seconds
CheckAllWarning               PASS      27.81 seconds
CheckSparse                   PASS      26.46 seconds
BuildKernel32                 PASS      24.59 seconds
TestRunnerSetup               PASS      530.02 seconds
TestRunner_bnep-tester        PASS      19.02 seconds
IncrementalBuild              PASS      24.35 seconds



https://github.com/bluez/bluetooth-next/pull/253

---
Regards,
Linux Bluetooth


--===============3661287865157811136==--
