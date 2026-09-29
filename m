Received: from mail-dy2-f37.google.com (mail-dy2-f37.google.com [74.125.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6552CCEA
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689230; cv=none; b=Nzr5KsaDwUI3YGh46PbT4gHOJzUi8r01IJIOPjn3IMQYhGGStHssowfTqATL4P9PXRapAyqtkEY0pVl/WBYkzNPyfJcFVQeHpu+wHTosxxUNBWdY/w9ATTRGymUktbw3rIx4onLGz2NHfs1oZ6vae8XC40NKYWfLOTyeZftKyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689230; c=relaxed/simple;
	bh=aKwvYGk06uWf8YLV01W8jzML7+Y902WqBECObmWXqfE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=u3nDv2B6yWM2h34N2y8rGbqugNJNcLrbpNlq8RIb8w2jrSm31IhUIzHmpay+N+Ro+81h53KKLSCBBu63U6cf9UZo7UjpOamC2Pc8X/+9mES7RZdpOR1hZpbtBAkQ8He5FB6lMV1+4Mq9L8/NYkVwPZOIBUOt0/rP07CvvzOFIJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omRO9Jz4; arc=none smtp.client-ip=74.125.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omRO9Jz4"
Received: by mail-dy2-f37.google.com with SMTP id 5a478bee46e88-346c612c7a8so1685572eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689228; x=1791294028; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HIK45t8q39+WPVtXFPgXk3ufeauXaQn163XsXRByY+M=;
        b=omRO9Jz4MSn7xQytTD/A2LMj3FhuLfpWHuT2CcnZUim6yLwNPi6ELqJt3iJmsJumRN
         Z1PaNlj3d7Je7g7uCJvD1awzD8K3cu81vN1P3SOygK6GAcOg8o1Oj6f0YugiQ0VK3AJD
         z6BfRMjS3fN0XK1Fg7a+agXbZxPJYAoM3Qn55V1Ya/wH3zq+TMOG4ROoB6/otNsLKSe1
         pp3CtusR1lNET/P0846VlLpIaNgnIW4aasgoUR6ufLDBOehTKObu0cyWpVJX1U13iEad
         eTjL7mYz/9Ypm51s7zciHwAtuAD7QlSCUqG9+BLbUfXR9bZetIylxb37yeAQxwwrUoTS
         rgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689228; x=1791294028;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HIK45t8q39+WPVtXFPgXk3ufeauXaQn163XsXRByY+M=;
        b=mGJ6i8CrjS7vVNNTiD9U8FyQrq5kmdo0/GchEDKA8tqeKSjDo9H7Iir2E9vt7dHWwx
         juYSrtp4cWm/Ms3piPfUAk4gNSNYvtL/D5r8gyddaroSYdaK78w82r5aCV84vMhO6Qoa
         RHFxF5oC1c/98MT6fH0pLjEOrvPqPUMboxknktLBlPVIj2eEvNuH+YpZsCPjSTEu0m1X
         xIZOm7Pg7ZBacWFmbT4wuvzvLeRDjtRJkvJpA6ZWu27+3mR0of6bufC5xhAMEzYKCrEi
         ebPNahbqWsrnKvu8NHBtpPLt0DJCqRMifbPLn3z1fh+6bKvbW+mxovMBMdmnJto7YLUB
         zQnQ==
X-Gm-Message-State: AFuF++mCoTuBV806Rkv369veadud3keH/Bq3H3ia+VL6fi2nJzu17VWl
	9xkhvdUr9CsjpuM6WjHqMSQW8bD7oU90A3WQ92r8ChjyxtsAi9GPf7QKTddhmQ==
X-Gm-Gg: AYBFou14E8jtxlzvCdNYbKayXD+Lv5P3+OJsBsBXSnAwM/jrW7C1C6nSTfQxHqiLyba
	uSW0adrH00jDWa/KTQpvMLCgTe1dx1LTGwWPJxDHSrXFewf2agl7xFr/Mxa9bVqQLHfF0I5HxL5
	InahPrIFITVuR1/cQCuZDnKqSddlfjtl4aYucpeBlZaHZbeVJtUAdWitUCqNhZNQ8Wsg/1Lu0Vg
	UBRrAwoZHRLWFf9pw8Kk5/ML2Z8t+zEp7jpVjFhZMI65q/X7Ha41+4oATRDRPf/EgZosFXmtOSR
	mmnbix1rQ26Pemm4yN3pLdBFSivfVeymlT3gt+Uwac7z4wKt+Dkx6eFHvkLCY4bKeLxPB8FOFGf
	B71ZI72w9B06FP8qAhNPmu8cpEo+LxkN/LzevLs4zoFUwxEFg9RU/Ew/pg0mONx4s+3+y6omnVI
	UeD8tzww85v7yNZgf/LLkaguop6RwZgHPG8KzJZpDWeEuqWIt2y1HnkNuRO4llOmTnOawQsfFGp
	mnsdg==
X-Received: by 2002:a05:693c:415a:10b0:34b:56c:2fdf with SMTP id 5a478bee46e88-34b056c3f77mr3010338eec.36.1790689227684;
        Tue, 29 Sep 2026 06:40:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.33.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341451457d0sm40059127eec.21.2026.09.29.06.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:40:26 -0700 (PDT)
Message-ID: <6abbbfca.996d28e9.3aaf8.0ae7@mx.google.com>
Date: Tue, 29 Sep 2026 06:40:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6583705387912992810=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ravindra@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: fix TX descriptor bounds check
In-Reply-To: <20260929065641.2936267-1-ravindra@intel.com>
References: <20260929065641.2936267-1-ravindra@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6583705387912992810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175817/

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      5.67 seconds
SubjectPrefix                 PASS      0.65 seconds
BuildKernel                   PASS      33.34 seconds
CheckAllWarning               PASS      35.91 seconds
CheckSparse                   PASS      47.68 seconds
BuildKernel32                 PASS      30.27 seconds
CheckKernelLLVM               PASS      36.10 seconds
TestRunnerSetup               PASS      819.43 seconds
IncrementalBuild              PASS      30.35 seconds



https://github.com/bluez/bluetooth-next/pull/839

---
Regards,
Linux Bluetooth


--===============6583705387912992810==--
