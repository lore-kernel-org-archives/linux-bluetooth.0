Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F943B27D8
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182372; cv=none; b=dSjXtLPEYa6Rd1YQfibnHQW92TJK/JFjR1833KfJoNX89o4MQc5gJ8laHNP0qvtd5LX9+9PChfKcbxhPZwft7aLv6PEB3clQhECg6mCz6Z2fXCsrbNjdAC/s0G6X1JqoeYr98egShQw2Au0VPctKfVgeJBOZUr0QoP4XtgWjgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182372; c=relaxed/simple;
	bh=JaHwn+oywM+pn4tKAaEIuSXk7UXR4/hYX5fXrmY9iTY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GlhSfRltGbT/SDBRKsYuXf5AK/XqQ4dLuC7viOxr3TNcMjcDnOUQzFnOQOLZRWAT32dJvE00xhNyomZ1o3AFC+4bKq2F0XmpxO2+nBLHRwjHYcqUMbwmMfvs6wE4+YDvA1YSgCyOEaYYv41O50WXIBMERGjkkZOK5zG7NozLZAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKaAwcrx; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKaAwcrx"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-408778a8ec4so4838248fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773182370; x=1773787170; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VGdI71OuKs2qA3NV+/wH3+1/yPqVakCOMpfx29fOE1Y=;
        b=mKaAwcrxDDygSvNNPPfLTeJAhlArNTkyWYfjRE2p7r704g4w3+879tlWZB5e7YacG7
         0wbiEwE/R5wg4zAgASMr3XwwfFWJBiY8yj8BYYzHAKLyMmumJL9eKTwZ79Px/UQMA+pE
         q8Zpqs8raUbv8LcQwTcS14ql+p9/EsDjg+TdnrNoUgn74dRcapOuy6FU3Rl18jJYOeYh
         50/vpu4OV4rICNx/1XvJcW7hXOSWF1mAkFn20qerCjYxbYaGZW7n2VdwOCohGMeroEdc
         wsUvs3mgtnG1+nhhvlArcyNFxWELD/mxzv1uCnY6zbfXbenRXzdjQTIy7L6KUI/opR6E
         BvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182370; x=1773787170;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGdI71OuKs2qA3NV+/wH3+1/yPqVakCOMpfx29fOE1Y=;
        b=I67cvkdaNny88y2Pr6oCRvrDbha3VzzpGjiykNPmjbCJ8ECIhBydS1K9vxGd5E3qNL
         xosXVATnler3ennoA2rfeAs/zVOCyyPCrKGq+zQSC2GVEI5UVZG6wwGP8TJ++Zv3+uRw
         Qr93n5KLANH6eme5JSx/FI52jWjHUf9nJX1QLemYD6iVZ9AFbfQm2M2stPmYZ7L0Hz4W
         +ssjkPZGb0ycekR0yfeVwZfwrHxy34tmsHGnmMOqNjHUJfLvVvq8A0jXNiBU4A0THu3w
         VSdcFrslRhcSu01iMAfYWAVGNYcS/RzLwYuMP2iGBHKGmRnNkDRWuBQbWez05it2lyg2
         TRZA==
X-Gm-Message-State: AOJu0YylrF+SpTrxKGF6/sq78z79DbNq348EQ0h5OHt8BbN1AukKH7cp
	EpihTybRjumbVfP0JSQoZfJdGIeH1m88y9r15RbAyofuG6GWd1zegVYvguXasQ==
X-Gm-Gg: ATEYQzwYovmYQLEj7ahTe1tcbFbyQj6NAoFrC1ZVJEm2zf+T60tjtTbHvvSdFRmpdtj
	KwKI9fW/q/1UT+n0cTDfn4stVOOsav/ccWSwCjeqgPD0ZvAVYTbCkzai27eh4fMOiLV7WTtw867
	q5CwCucxR1qQiPK7ijJM68dazHowcXbscbKIKUDKEoVLgRU18GRb6UrMquEicj8nKYbBkwdAa1h
	bpyzbLKKhGly37G9POdrdK563Z01gGdz4x5gyVj+veXugrey8y8JS1JDTcnOfG3BhUx3L1dOkR2
	yV8RBCUoG0opqS6C0CMbcyQGDD+w4ngRbFf2ByLzbG/7rX0gPGpT0A2tWrBDy4QYzrvyEv5EqKP
	wAj++fQYvDkbZUXn9TkxF9tjMs2vznLVxjLccnrwAKt0pKRrlzbMdsEkNRFWKIM6pI6GHF6pQte
	H6l4V36DdrdvClYbuWJmev4r5W+nXZwiqbCU8noqyV
X-Received: by 2002:a05:6870:a10c:b0:417:565d:e3e with SMTP id 586e51a60fabf-4177c7fbec4mr349718fac.1.1773182369839;
        Tue, 10 Mar 2026 15:39:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.202.100.48])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e268f37sm274423fac.6.2026.03.10.15.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:39:29 -0700 (PDT)
Message-ID: <69b09da1.050a0220.2e13ad.e6b3@mx.google.com>
Date: Tue, 10 Mar 2026 15:39:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2907362888529415897=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/7] doc/btmon: Add GATT database reconstruction guide
In-Reply-To: <20260310213314.729718-1-luiz.dentz@gmail.com>
References: <20260310213314.729718-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2907362888529415897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1064659

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.95 seconds
BluezMake                     PASS      644.70 seconds
MakeCheck                     PASS      18.57 seconds
MakeDistcheck                 PASS      248.86 seconds
CheckValgrind                 PASS      298.77 seconds
CheckSmatch                   PASS      364.95 seconds
bluezmakeextell               PASS      184.14 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      1044.85 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1954/checks

---
Regards,
Linux Bluetooth


--===============2907362888529415897==--
