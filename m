Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E826B764
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171456; cv=none; b=c9/2azuP6yN2sdBHBnpOoxZuhtK83akORP+X1N+QRmrvI50hdSRWoSwAnUJFfLnZT1dABCpDVh1UDoXiWBLC/Grq3Hte+8gO9WawjN79EyETIyy0D/AZZvrzG2YfqyYwKOpehHCP9Ce5MZR84W2RTbbekSDUveLJKMIg55SpbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171456; c=relaxed/simple;
	bh=V+NraunXoX6+3UAYIqrYjycNpsS1Oqc4WXwobGzmARY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iVURYq9gFMonsrNwvMiL8cQj32i8iLIInp9yHZoSMW84Lwf6UB3uD6dTZHY2motSFQIfFPXNnJAOsNIf446EUVnmMM0MIU4heJCHJ66H9SuebY7wvRUfLJYplKQlJj8siyeTXvv4iXkB6Zpz9URJSnE35uAWwysAEyt5szQHOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMZA8WmB; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMZA8WmB"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca957432c7fso2129919a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171455; x=1785776255; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EeAgzO3tUulLSwyH0WDZiVpS0PGW09Eqc1WrOH0zdpI=;
        b=lMZA8WmBp2AjnBCvxSsN52uVbFgoM21de8jePCvdYC7WjvfMU6E9e6CqwDRhKwB5ju
         L4z0SXTUZGeuWpvKG6Wn7euAbacmpwjDGTRROKDYv7chOJrZIPhRKR6pwoE/eeBTfBZA
         tI1e0eLZMZ+yePXN+eWUFDGnT96/sto2dUmWBFfa8cgMVKTOmROTNdMrbvYUtQkZPbXu
         zBhhiWQnoxM5BPPPoDI08iOzXYxOLDc5Aie0XYSigaMOoi7rm4Tjx3q/OG1Xyx/Aafxn
         m2NpTZA1F/b1MptN0HaUOhXSPaD8ObznJa+vdr7As7S7WcfFwfCediRUMrfewB3YylIa
         0vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171455; x=1785776255;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EeAgzO3tUulLSwyH0WDZiVpS0PGW09Eqc1WrOH0zdpI=;
        b=NKvAZaNHFvY1ut64uCBEux/Zy6xRwblXBWmjnR/O8QEWCKKMSKchQa3WFsv4CbvFO0
         8gFVZCO6Z3rItF3VmgXvHpHpkD7lN43ffRLEM/Qpe8mRYfGFcqem+alWFQ+VjOoFuNic
         GhfXFwoR8/NoOLLGi05L6fYttYRK9udQOReixGVD4T4NRH2nPN5zFPbVrcQKeQrGsjmB
         Q1zBNTTu1BLgHWJ8kp24yYzvjm++N3rbnUEBe6M2TauTQ06kAGDkb6Ud/kzQA0mHjWj6
         KkDRj99Lei9rEivyjQC9N//CtKrmE9Kf+ozy7n7S2YEJdBh0wKoBGFHUrrM8QD9juw9Z
         WDiw==
X-Gm-Message-State: AOJu0YwEpE103OSienoB5ZCiqt4gjVZQ04A4yquUATf5CPX/ri3PuOy9
	cDSoCKf+ykLWZyyBuGulM1sZQcODp3Fvg4OO0V0Io6jSHzkS5f3Y/EAUCbCFyA==
X-Gm-Gg: AR+sD12Jr8NquTnFJw+ZRTTWjA2hQJrLIMco3n7PrDkEDwKiLGW/2cVsrJ35Z2RvVHQ
	XaOBbuebVrjsYZGH+6IkelTcRZPX0f9mtmzEkYYFtk6DxNXh/PUpG+Up2Yb/ygEuDDlHACeeyIb
	zuR7Ap914v6PG4Mitkp4f30kCuzrfQMdPxxRjJRfHxAiZFKNFc9VT/ppwdugOZGaXEXR64lCSy5
	cMuqnNstsMJnv8LH/E1vh1FEH7KOg5ANtHRNqS+1Szack9tBD2/NeLZylM1jShSJz6ImqEigcZx
	mTf2jG9Cghi58999BS3NjaIr7iDdo8umLLSNSs5DEtxlJiIWBFwt3v0upNXqXaEkX7MKm8sCO9I
	D4mwPV2HCasFaS54iPiieUINkspOatQps8Chm7vw2tKXCeTbR6YTfGtDvm3WforwZn77zUAz4pq
	xU9JHiYA82TQ==
X-Received: by 2002:a05:6a20:9392:b0:3c0:9c19:658d with SMTP id adf61e73a8af0-3c6c7ff5301mr420971637.71.1785171455011;
        Mon, 27 Jul 2026 09:57:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.212.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc579127sm29711332eec.21.2026.07.27.09.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:57:34 -0700 (PDT)
Message-ID: <6a678dfe.b4a331f0.1c45b5.f23b@mx.google.com>
Date: Mon, 27 Jul 2026 09:57:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4701841268475810554=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pzalewski@thegoodpenguin.co.uk
Subject: RE: Bluetooth: use named initializers for acpi_device_id
In-Reply-To: <20260727-acpi-bluetooth-v1-1-b5558d53e6e7@thegoodpenguin.co.uk>
References: <20260727-acpi-bluetooth-v1-1-b5558d53e6e7@thegoodpenguin.co.uk>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4701841268475810554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1135260

---Test result---

Test Summary:
CheckPatch                    PASS      4.18 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      27.35 seconds
CheckAllWarning               PASS      29.77 seconds
CheckSparse                   PASS      28.30 seconds
BuildKernel32                 PASS      26.12 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.13 seconds
IncrementalBuild              PASS      27.87 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/2] Bluetooth: hci_intel: drop unused assignment of acpi_device_id::driver_data

1: T1 Title exceeds max length (81>80): "[2/2] Bluetooth: hci_intel: drop unused assignment of acpi_device_id::driver_data"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/500

---
Regards,
Linux Bluetooth


--===============4701841268475810554==--
