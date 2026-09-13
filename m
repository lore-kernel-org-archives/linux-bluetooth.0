Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F730C606
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789302378; cv=none; b=PxGiV3SwZsriRrUgY2LBDtjNBMTYzAh8jUi+9aBpqVdyIQcleCZWiroQImNEtVJjT6IH8nYr5FSrIgkW63XcMhiI0mTA7JPbwsEk6mWQOkJFaeX2yYV+lcZmAy5st1ihdEgvxg9o236/jGvAgE9gbMW4Oz0p+eVHipKJA53MtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789302378; c=relaxed/simple;
	bh=31L4llpSX6C9AYYbZad2GaYJqPQlhyPN+pmUx9/KNN8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QrCiM/LOqdwFfo0LLp2wZTFR+ULgCkG6oOpyrUUiUWHTuRdV1VgVq6mc11qMu0u+TGOm+VzUZHrfWmKuIsd5ky1tWLAPUm0Vn0qpJ+lFTbjbg8oLGXYaJJ83cPNtvRJ9sNYTjEXJ/TbFQ6g9m20uookdYW4GPhjmqWdmZjb+kPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhB39d8B; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhB39d8B"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4d64bcea5so1127875a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789302376; x=1789907176; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=StftTLU/RtGSN7iJKH1rEn6mT1hHiPG8bOYHjEnElTc=;
        b=bhB39d8BK7hkNCku45hqwB9oN8vW/pznLn8u5CuGRlJaYF3gFp2d2Nah0lEiC2yayh
         xTAe8dxGcfZxJ3fWDAA4tNKwqtmgqbc1DxdKXFO/M4nN6+fjGFURTxV0zg3QOIHOt5dQ
         rGN2rImTe4Knj+aYClSttQbD6ET/FT5ddRmlvA/cv3GGAy2BMoexai/v5v6VxSJcZ2e4
         hauWpfxhvbE3QrBw/ZKDHSe65oHQLyO1jXtFU8U+gXQfMIZWLta9qwY7qK16+EwTFhe4
         BL19G1OHroFXhUCGb52jmRVdNAp0bnjbuMRmgBj0XcZjPJWF8nwDYcoTaOz/FJtO1oTM
         kSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789302376; x=1789907176;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=StftTLU/RtGSN7iJKH1rEn6mT1hHiPG8bOYHjEnElTc=;
        b=GZOiHJTkkbL5gdsFPKUzOqepnhc72Pwi80/r/kOUaHgT0hj49cQppx1CEeGJhqVhEt
         mmKsGEmEVimsgQsI6V/M3V46ZvTMVXUOAT4YpzIBnV13YApWSszl/30xOVWhLL7gBfCC
         7s9DRs6J2FZJAp2ZUZCdtg9CM5Pt70SEsVhVedwkuEr2Ffn2l0SQikOV+rfcrTI5Sgek
         K/A7q1pCFVPBi59Tj7Yq+tRxllIOHmU9m3hCkHQolk/JANpW2JRoFkdKU5tn92MqDRWi
         OMra+VQedBV1/asGr/CF/LGe2Jg+zEPooXbfhRKZ8KvsQMfKvliHI1lpiM6D3pKknl2K
         4YbA==
X-Gm-Message-State: AFuF++mxq9rcf5Cl6WDMzB7KU1CwF5xfmJ7dZDPdIyrfvbY+LuZU0CKw
	Z1ZpL0dojfnDCHKdaExEto7FmSoRrDGZD/qTqJW6BxMT6noAHYsRAe8s2v1pRQ==
X-Gm-Gg: AYBFou0+9NZASDSGbVRi3vprQjbkJZ+c+tYglo55R73KqUQC86jGwCsorHWhI9DP8ts
	tqe/q0/7mybMFi98P3L4f7fZrwWgKP6vm3nR4JqCG+UACcwbiF4KzXaZaKFMi/A3cmh+2nqqVta
	U97Ukiuz+tcJXBnATeNiFV8mBfIWLsUDl4Ivyytb7mbdVuGCQ5wv/8GxsUxglGtfBeN2Mxr71+r
	KsuX8Y+gb0sW87reRp7wU1RmWFGmZYdIVi4jawEGzVohDM+iQ/hAtJQ6mOkgCZDxt42GcIsHY96
	bHjfwy81O0BSw5pY7u+kmdFwRvH0PIhSjCque6ymeZmbF17RlXY413vPvVNdvlm0kWTDlp0Nsmq
	yDExmj58isyq2qXURW3/6W/URgLDJcxwSmqZwx9CMbW4+J9LL1eRv0+Pm6YMwcxsEWIzrANHBd9
	70CdpHInIUN2jcvyVKGoVGuktTVWinGeOFPVMpfMFy2jahzDIUxaemS3LUK+6jY1eznL4aQN6G9
	dsG
X-Received: by 2002:a05:6a21:32a6:b0:3d3:ae1f:d7f8 with SMTP id adf61e73a8af0-3daed62fa0dmr25088110637.24.1789302376194;
        Sun, 13 Sep 2026 05:26:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.94.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm20688894eec.31.2026.09.13.05.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:26:15 -0700 (PDT)
Message-ID: <6aa69667.c21e2895.1168de.cc16@mx.google.com>
Date: Sun, 13 Sep 2026 05:26:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8417094565657253480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mlukerbrown@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add USB ID 13d3:3626 for RTL8851BE
In-Reply-To: <178928149096.19047.17192117267904511764@gmail.com>
References: <178928149096.19047.17192117267904511764@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8417094565657253480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1163708/

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      21.51 seconds
CheckAllWarning               PASS      24.90 seconds
CheckSparse                   PASS      28.04 seconds
BuildKernel32                 PASS      21.64 seconds
CheckKernelLLVM               PASS      25.39 seconds
TestRunnerSetup               PASS      565.61 seconds
IncrementalBuild              PASS      20.79 seconds



https://github.com/bluez/bluetooth-next/pull/759

---
Regards,
Linux Bluetooth


--===============8417094565657253480==--
