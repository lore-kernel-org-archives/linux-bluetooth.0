Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179543ABD96
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792434; cv=none; b=jqI2KyaOO1tkzl7IWjraPyYY2eCDlwT1SWZraKp9i3YZYv+kL0l8LFDhh9f+xgpWxLP+qiQmDWBsAo7yvOsBWokP47p88BmpHBoQImtVaYy1WUYDf01n2Oyz8esv+sV9PN4QHMvVyfcE4VNfE2+P7UzPDwlfYsKpd/5RfqH7uXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792434; c=relaxed/simple;
	bh=v20Q6gnK+rnmz5S4ATyX5gdg+leGrWW8Lxb7gDsrNZw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=E3QGhuEitAlgQB+S0EcJJ0d5ZpKdf7vDfU7xYCceFXOhuDlncOdKvneSFUxpFD5k6nci1MztutefQCABIPvThXkcmyM5lzUwk3GXsueg+wsPtgEPLl84MBPCqrZ1kw56qe85HtTrOzmO4MlbIyhf89sIGVIj4rwmGgGkT9VuFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA4okMPW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA4okMPW"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93e50170ba7so104403485a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 01:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792432; x=1792397232; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LaH1L9S3yNdimBR40BOA/0v6Lnhmow/aYg0KOtsFkDw=;
        b=VA4okMPWVaKC8g6FaF7seHeTFnndjx6gcyLRkQe95TV2XuTWJIpcCnaUow7EqWWRcc
         Do4Hjo0xcMLICM/XF/P/4anCdoNe+wsGiltBYkvjonowIvb1c3aBIUDxPQ1SsZHg+nd2
         bVYK7c0ePTiNtHBOAq8g2omcl/kINIBErlIfau8P/sKjUQ8tfjMbGTqxS5EZx0ZCTJwV
         O1B2A8Dx7ii2U6cM+6ocmXyq8wzg7iIssSgjqolzPiifm1y7xcedMRxI43TQi73O6zG0
         BZ04FZeF3dw2L+5RsQmShVaxlWlLNbNOxoUtBLtt8etl9Iw/MA+szHmRm0AUxHj/+zyo
         rJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792432; x=1792397232;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LaH1L9S3yNdimBR40BOA/0v6Lnhmow/aYg0KOtsFkDw=;
        b=G7hRhkPeKZYfSF/mnFltPdaXG5c5Ko1nmdqhXTH9AfOyp15uRmU5gxE2+Y0s2HzvPz
         HLB3TvGKNPbA1cHDRg6FgXoIUuENNH7PBKP0lbIgxL+m7FJP4K9frnNw2apYmGisNN0c
         kLEn1zbv+sYVL1PS61VCVzjo2eeWiRO06FA8uKZlSUEWCsYDTPVEpOXE616zw1KMMBWU
         tOX79IXRCQKxaiJT16IW2ojNp135qsxwWvj0Vsu9EcCEkET+TiWnCNOsz5G6mfWbvZnB
         DWCg1fc3XBwPkxZox9ayEpcWNb6VREy5BabPllyFMfKmJ8RUzqxR3D+txGwK/y5tvuzG
         mkbg==
X-Gm-Message-State: AFq9FYILmFw3zytd2D05BGr3YsrGvhr/dNe3XiDQyXB/v9tXJQakK2Rd
	Cvkn+TJJoGP9iTpt5Y/GZ5RWIvGKxTPSNc+6Qr6jA4pl3GGBsW1iXGPonCTdkw==
X-Gm-Gg: AYBFou0ZtshAa3VJ5EmsI9lDJ43RMF91xeuA7vVkPkW+B7AdVdsJU0R3p8xk0XYjNM2
	zQ9r8PVp6Aw5sNA24IObybATOw0GPg8xJIwObgWVq0QoGTHkMJNL8Xqz00pLq4yaXjgp3zNOFkF
	WwgX/z2QV8LZOdoq382ZlYXdVLeqDFoPo+ovripN6BSuRU84oIHnY2chiMIw1y7RBf+jXyI22KK
	YY9LvrS4+IFfqn1JbF/IhS8JeRhjjhtkcP7g51BbROd3BVGqbX2tZbv9916xThIoDCfujpxif0u
	M1lm7xR4aRNXoanGIR0q86/o8IOW6ENA9kWgC+7FuvdTxDwZ4FuAytrZjSBvULzibTg3Ezmnjp6
	V0ozuix/AI8rqOa9FSkWe2S2J7fkCM+0pO3Bgpg1obl79AVW9AYPP2Vho7ssviAAr0+dhg6kF+m
	XmkI1Sl29Z58T/NZnj63up0CXnyDVWD8qCMm8zOyPbZeci98KOywl7+20IzM1rj9Utncxh5BVnt
	0ITo5ph97M/bhjf
X-Received: by 2002:a05:620a:280d:b0:93e:e394:78df with SMTP id af79cd13be357-93ee3948ff4mr404572285a.58.1791792431974;
        Mon, 12 Oct 2026 01:07:11 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.140.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550ce8a5sm89280676d6.40.2026.10.12.01.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 01:07:11 -0700 (PDT)
Message-ID: <6acc952f.d6521e61.172db.7a50@mx.google.com>
Date: Mon, 12 Oct 2026 01:07:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4873555560764792196=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: Keep IRKs alive during updates
In-Reply-To: <pm-bluetooth-objects-candidate-0191-v7-12caee3a7046a1a8f311@gmail.com>
References: <pm-bluetooth-objects-candidate-0191-v7-12caee3a7046a1a8f311@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4873555560764792196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183564/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.69 seconds
CheckAllWarning               PASS      27.78 seconds
CheckSparse                   PASS      30.55 seconds
BuildKernel32                 PASS      24.90 seconds
CheckKernelLLVM               PASS      25.69 seconds
TestRunnerSetup               PASS      596.48 seconds
TestRunner_l2cap-tester       PASS      13.79 seconds
TestRunner_iso-tester         PASS      9.74 seconds
TestRunner_bnep-tester        PASS      2.94 seconds
TestRunner_mgmt-tester        PASS      57.16 seconds
TestRunner_rfcomm-tester      PASS      4.24 seconds
TestRunner_sco-tester         PASS      5.29 seconds
TestRunner_ioctl-tester       PASS      4.32 seconds
TestRunner_mesh-tester        PASS      5.20 seconds
TestRunner_smp-tester         PASS      4.06 seconds
TestRunner_userchan-tester    PASS      3.35 seconds
TestRunner_6lowpan-tester     PASS      4.09 seconds
IncrementalBuild              PASS      23.50 seconds



https://github.com/bluez/bluetooth-next/pull/903

---
Regards,
Linux Bluetooth


--===============4873555560764792196==--
