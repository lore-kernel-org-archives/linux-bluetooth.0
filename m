Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE561B142D
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387323; cv=none; b=ErXFJFv6aFT51dj+c5Ji4rba4dQyZSf9fQfWo6rirASu+6vQFR8Aodb7Pr2b2HDZEvPP1HNsd6VGSlenN9VVb8whi/AIfVfrDM354iHTJXgRMEUrA2Wf+MEbR+6cptqW0vskLVfU/wYUvAJ4qSeB1+58UK45yGB/VMgI30bGG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387323; c=relaxed/simple;
	bh=XAZyvP0+DR7klmkuxpSpHUt0DR4Znb2cSIUZRWxaazA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dJ6MPmcY6qD9ayTw0iPYTYjBt1yqZGZELD7P1XdG22jSlMf8/PSGtJIKZfb7wEw9jAHeKX8vlMOTtXugFzBjbVaSSQrweL86Wvx6C6d8A/0/ATdBPtz6+UDNb70dgJoIRc9Mg/LI/PJubN1fsG8iGH5pNMo5eE+7GYUEU8LlTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2D/LB1L; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2D/LB1L"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e7c6ec9dbso432583785a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784387321; x=1784992121; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H6DGu+pKL3MVyhR8tgFgUi98k7IcKar8pL/YChi2fTg=;
        b=j2D/LB1LuD0JDnRvzfYjRiMqYZoiq1dHyyH/ev4Bkj6vnr08Ih2i4L9AZdGQbj2HQM
         MMb/iwUZhbyDipnlHtehlEdRu2duJOGzcXcuFdKotPcUPYFa9TJHV2qQ6lmJ7Tkeyd6p
         WJnz4OvtiP2Biy1UeB0gAlm6BW1qOgLdoem2lwsxfoWoxttO5FPVBopBeb4QSFAdS6hO
         tN3sorFw1jUsdNJg+b59IcPdSusKQ13gyRiEbjebpSzVzdE5qzA4hTv7cN2SGztgso7J
         AbLDOA/RnTlk6YKJDrfHH3KpjVWoGEGNMS/7OMrNMzr8HGfvxiBxfgQvYx3znsZFhbQ9
         Bepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784387321; x=1784992121;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H6DGu+pKL3MVyhR8tgFgUi98k7IcKar8pL/YChi2fTg=;
        b=q3LWSAvuv06mEJrmUilo0VlvauWza0lfo70oA6WyDv1DM9Tqa/c/B4A75B64Xi6yjU
         aqWjh7ahtCnTHNVIKqszqrlZ5H4eRhebL/I+612bg6g4wLduceuCHJzJZ1cMRQGW1RoP
         vja9fX1Tyh2P5A1tj7tc5yN4NhA+8c2EKY5lQFZuvzT1MLhlqC8JHhE7g2Y8sWm15vmK
         0BTrCmeTUGpAyDMLfzZvcBOCAecyPtIid/JL7CYBjlZNcbuRYdvzxcr65AIC8roCVvDf
         YnARIMCUb4lu/LEj8KhSLJX17jvO2zwThaRMbdJRuCIMR6HGWGDS0Hy2a5XlTrMrrJId
         Z1zQ==
X-Gm-Message-State: AOJu0YwwAr0sMpXaGLraE1f7lg311TeIaA2ZRnlyu1ChSx6XyGk0RyDV
	O8/CNGJDl6I5eucH5OMPYXRYoD9uFMWNZzCY3UY+TPQqR4y5c+Bi+8nZMiwM6w==
X-Gm-Gg: AfdE7cmc2KBgPABOcifVCzPaqIlZHV3QhCPqYO0BxELclXcLPlD0bMDgaj67aA/qWJX
	l2vob2NHg3lC4IbXW23jFDOmPnbPgwZGBrGiscSvWoTFbeFU4Fw5k5pEWWp7CBA1VxvFTw9pPs7
	om9h8Sa29sMhaBCfyd9l+61ofP2aKSEwvtqLV5DiQI9kPmwkXd69+BFAzr83Bt95A8u5+UkEOar
	IDaxABMiRaCLnuaPPafIfrwsid+7OwN+rex2+ccbZ2GTh4fXNfDBD0zBvYgjgIIL3hxz4GhCIRX
	9SMcEyLZN8EcaEIh7WJf2urXgtJcVl2t7rot/Sx/q80e5PGkq4FY2I2OOpAZkakKUZLf0Dbt8S0
	JpNiQpoIuKR5DApjOkMsguTgR+qu33b8bbD6+SRdYz+Frv8HXdtackDYCrzhrcoI5OphHICQ+OH
	JYC+CLuH9h
X-Received: by 2002:a05:620a:7005:b0:92e:7c3e:26fe with SMTP id af79cd13be357-930b41f4f05mr768307885a.64.1784387320698;
        Sat, 18 Jul 2026 08:08:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.181.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542bdafsm425210185a.25.2026.07.18.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 08:08:40 -0700 (PDT)
Message-ID: <6a5b96f8.04986471.21bfa9.51d6@mx.google.com>
Date: Sat, 18 Jul 2026 08:08:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6498206823338863874=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, u.kleine-koenig@baylibre.com
Subject: RE: Bluetooth: hci_bcm4377: Use named initializers for pci_device_id array
In-Reply-To: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
References: <20260504160940.2168650-2-u.kleine-koenig@baylibre.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6498206823338863874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089397

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      26.95 seconds
CheckAllWarning               PASS      29.53 seconds
CheckSparse                   PASS      28.28 seconds
BuildKernel32                 PASS      26.89 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      510.75 seconds
IncrementalBuild              PASS      25.94 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/453

---
Regards,
Linux Bluetooth


--===============6498206823338863874==--
