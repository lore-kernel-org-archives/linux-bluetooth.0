Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8626CE39
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357567; cv=none; b=FZJudEbfbjmR4pKdUQePYiKzujktF0W3rcfZnEttk1vDucfwTBxrxyhFp2xsWIxjMS63jleyLGqZqLPEJfoC3UsrxC5SaMRqdtk1fr5Uh6fhx5C5IV8d9ddS8khcS7V0zjaXPHPW/aT2dqAJmSeoGhJX8YkK5wb+NP1+GX30Ohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357567; c=relaxed/simple;
	bh=mgibVN6xgk8Ulvf00/6CeZYDajkYvHq1q6tD5SUvSvg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BkoFEWN/BJnbsPMpmO2e8SCHyM4udIGIPunsmp7Hsdk9iakzSMadJyIyxghfnt2pgavsCnuAAoSsaVmWi1rW91wV7IngMxdTzp5fWtOoWOj7b9BWdjQ+qyeXG+hQjSQHPNkj+mLuItfL4mbvVni+qCaLakD5GKAOwkRj9FOb/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/ycblUv; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/ycblUv"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304e6c6464dso8508368eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 16:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780357565; x=1780962365; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ/65v9tzBqWxMQ8r8d8AFh8TsesgOfXq5Iort2SexQ=;
        b=o/ycblUvCxN+ZyRazj9/0kcgUHKykjCoVLEYLuyHs7HbORlDj2gHPM4hCxZGup7HH+
         TY55UvHSZQCIkQyc+hB05OuRDx6HE2wmOX1juvttypNkrovGjUOTfezSSlwa+RRMiO9W
         nJcdf++j21SGfu8Vb89vQaJZ7n1jMWfIhN1pRet4mEKzM3SLF27mHbSpys794JLfgS02
         sZ50EdO3yV+L/RJusgLQT2Ihl2l3iw3vSfSMdCSS5DgP6ui9lAKEYvjAnqwzVx27nEra
         czjYmK5yDmH+94cF5IGSTgnrtZqYmBjcMIsGqX7iNgS7VZE9lFUsAC3OskukHhidTqmk
         mCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780357565; x=1780962365;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZ/65v9tzBqWxMQ8r8d8AFh8TsesgOfXq5Iort2SexQ=;
        b=HnxFDrP6JZK7OjZoz/vx5cCO404OBYhQgF687YXD/0qp6Mc0sx9Z7wbp+wQM/UqjvB
         OS/1B4xOqCe8wzokCUW8VHQNYxpyBbLkrGETLoLzN1FetemMlewQMjAzgDnhG1PRIDw7
         PDZZWBiHiiPc8Ymp8KGr1gck3CDr/VSqLHIOSGPRtv+fV3uTsaMUrm7N9WoJCqa+0has
         SHpt6vowRFTKbBWuRcgfRyqKnwA5QAr/B0MCfJRgMlhaxubV5jwhzw5Iea0JGelNf1yc
         3/wDW6aigD9V2qSuCo46dQgUGxSyIOEBeqpxp7M0SDLblB0gtDXzvyN00SPRKk8IfV6g
         CKAg==
X-Gm-Message-State: AOJu0YxZNpEMFEB/n6xploxsIxJiZJMxJu+6RuvaGnAjakKUMzrZ6Ioc
	IkQeGd3mUTAWtfwFpSBQG1fgsJcXCbOs8gW66gYcVYXho5uaSSivtdyUa5GgCFgB
X-Gm-Gg: Acq92OE2Rm3hiGtbRlIhWRj0+TPOvBnyNbR6j8Fd40mCxh1aB05U1lZhJTvUTe7RxNv
	jFSnMbSzRAKAfvlgBsIZTviBYwvx4a7hqaCuwXZDOjaktt0o+w1DD9MUV7RXoQ6c5qiV/S2cjKw
	xfkN6ztpSDzNKSWD9PAtRd+J0+XFXkc1Rn+nf2YKyfXUeUQRnwBDvOoWIghzufQbFZi8i3A05zr
	HVvROooDFz3938CYglFvXlme2dJQKKC+TRLbeQurqKPEC7wMkYW9wPteHzZFFnt7C2Y6iVPs7io
	rtJpJMe22fQjkSUc8IW5tBQ9CDVyypB4mobLLT0txhGtj4C7dP4kd+Ia/Tkwfj/nlzlZ+oMfooN
	AwklsJqQT49ywooLClH5b5F/UwiEEXvt6Xdxx0hICST2hjBQkgXOWeuUMBXz1Pez47vCziR4x7E
	8+66b70WAYyut9D62O9kta4MgyaWIOdfLSAFCvkw==
X-Received: by 2002:a05:7022:f302:b0:137:e391:1acf with SMTP id a92af1059eb24-137e3911c8emr1340082c88.36.1780357565285;
        Mon, 01 Jun 2026 16:46:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.61.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36aef95sm7848892c88.4.2026.06.01.16.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:46:04 -0700 (PDT)
Message-ID: <6a1e19bc.e1ebb1b2.2ae2e1.fa82@mx.google.com>
Date: Mon, 01 Jun 2026 16:46:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8344359003597214708=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, s.shtylyov@auroraos.dev
Subject: RE: Bluetooth: hci_h5: reset hci_uart::priv in the close() method
In-Reply-To: <4f997f21-786e-4745-80c1-0d6da94c0d48@auroraos.dev>
References: <4f997f21-786e-4745-80c1-0d6da94c0d48@auroraos.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8344359003597214708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104221

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.29 seconds
CheckAllWarning               PASS      27.74 seconds
CheckSparse                   PASS      26.86 seconds
BuildKernel32                 PASS      24.91 seconds
TestRunnerSetup               PASS      540.54 seconds
IncrementalBuild              PASS      24.70 seconds



https://github.com/bluez/bluetooth-next/pull/270

---
Regards,
Linux Bluetooth


--===============8344359003597214708==--
