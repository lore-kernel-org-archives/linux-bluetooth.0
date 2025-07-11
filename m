Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8A3D6F
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262176; cv=none; b=RiVvxs6Xnu91XRtqAb/ixIOWeDVW0Bg6GnCnXKcaGmKG+s6oBRgm5IAeoXC1bBDTY0VxOnmcztzTiCu6bbI32wgnQkt2o9agAfiMK6Brp3pMpRxYKlFyJ1a67iQe60uziuc6uxj37c9GweLp1H9GrrPyjoDwalN2hH4HAqXxCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262176; c=relaxed/simple;
	bh=EABDuG2rTKwhkxgogI7Hche/2rPwsCg8nYKLBSN2aD8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VjDLR5yaPEvfvaGz/Lt7SOmzsNCkLlqDeFFo2DpYfu7nX6VkI7zkVXNgABN3vXolHcW/DELR1qzad1Tpo6E3lyn9VgY5N7/ZE1BDrZEYC5nv4xl8eMiyvDOmyfl7ihb/n7AxDeI9vJi7VqmRum/j/DvI/Sa25lcm0+iZJFxPG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrgA6RpM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrgA6RpM"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fac7147cb8so34699036d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752262173; x=1752866973; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LBSvrYA9Z3KiANZGWLeJTF+krkT9LLgNMrQtri6UYow=;
        b=HrgA6RpMUKCsJ/WoFiZIIZIKr6J0dvHD5Tqx4wprPVHScemTN3H0kzF/wW7yqXKtwP
         lTZhqSBFxjHhthu6AnynBwmZ33vJuKRQ2lV1e4Lr2JlE0AiP93TsOiQ+YYaGJ1M1AUeH
         mw+W2rfpSFKU3uFsjEmsmAG/KTqOfVAqx5ufOLMs4AY0yUmtJCZyPhXFAo5k7bUDHuNK
         HdG6QH+bCDi3qLLWtZIzKO7vWnhTJsJQf5FUgFN3j2pzqIo9CUthezzDWp6o2CO6D6g+
         WBqHWbVD7i/E7OxSv0koigUuaubAVENTNATVC6pe/3qAcUAgWXF+L0IyzQ+/e+CNkiUS
         dR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262173; x=1752866973;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBSvrYA9Z3KiANZGWLeJTF+krkT9LLgNMrQtri6UYow=;
        b=taYEya87QBW40UYTBtV12l64MOXYbMuw4j3XQ7viG1//ObLCESD4ceJwnq/FGaXZW+
         x7KeLXsTPGwTMwgrGte2mRz4Jr/ZQQL/sIad5qGiRAdK1/RpoTm9qA94YaTEz37bEZuD
         dAU3mUz8/ASLBpT0fLnsBIdwQJ9dziR87z601aopUUsrQRhjOvQShEygD/yfOThynjKT
         4cg3EZm5qoKsI9lFHAQ/MqXpj610tqcs1b516g9mTyd2a34VIzrbx90FbBTP7if9I2Er
         JTACTpMYDZKS7DPBvw2FSBdiy8tb6f/VHnijGwvFQwNYCwD6oVYZZ+cqD3Dj/Vc+CCuN
         9yvQ==
X-Gm-Message-State: AOJu0YxRd0TjFF357I7LzjsTZsVh1RZCSnVt414PPRAgWQIouxI7RdmV
	XicNd1+rKM8k+8PAePrhBEUp07Ky90KY2aoojmgY/FbkfqD+zYlVDqwEz2yiGQ==
X-Gm-Gg: ASbGncskmXtpgO4GaAVgoT2jQEDPVuEZVKUhmqAH3Z+ILxI+lED8r857nKdpt8PYm5/
	wXknsw/rOhMMOJ2gZLf2EDFcV0wxLP2ovM5RlAk/Bw8y22/a/ZMHT3LK7NaSTzuzFf6kIGQXvEq
	VK87eAl2ntuLfjiu2eRvVSVrlHSU2MwYF+Ggnu59lhnpv9SPH2EqYeKNxxdG6y96/ke4007R0I0
	OxQqonhzfgG4/ksn2MvkcXLB9MuhZnFPSKwKz19X9apgpYbx8wVlYmZ+XwyljwMCbMVIkShVrMA
	eQGJLGxlbW4cVJq8UsGuMMZWCzNW6Jt8RY2BT8aFBTK84cTvkaLNsR+YCaxndKgDAlMwH8R6Dhq
	roCBDDgUtbLWMJEqQ/yeA8sJDzA==
X-Google-Smtp-Source: AGHT+IH88SpmsAwgDAGe3X28Ub//2OnReV/fQPwnOnAFEhYmG7pyaqNPqABnB3vrIxhieZo/bGeSag==
X-Received: by 2002:a05:6214:2488:b0:702:d1aa:46e6 with SMTP id 6a1803df08f44-704a35903f3mr82988586d6.28.1752262172855;
        Fri, 11 Jul 2025 12:29:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.82.3.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde421c82sm250923485a.56.2025.07.11.12.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:29:32 -0700 (PDT)
Message-ID: <6871661c.050a0220.354755.b3b5@mx.google.com>
Date: Fri, 11 Jul 2025 12:29:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5861887845984227983=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] profiles/battery: handle reversed ordering of CCC and value
In-Reply-To: <f16f76956a16625d436ded521cccd47a0786d117.1752255326.git.pav@iki.fi>
References: <f16f76956a16625d436ded521cccd47a0786d117.1752255326.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5861887845984227983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=981617

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      21.61 seconds
BluezMake                     PASS      4149.15 seconds
MakeCheck                     PASS      21.64 seconds
MakeDistcheck                 PASS      203.00 seconds
CheckValgrind                 PASS      264.19 seconds
CheckSmatch                   PASS      334.45 seconds
bluezmakeextell               PASS      142.74 seconds
IncrementalBuild              PENDING   0.21 seconds
ScanBuild                     PASS      1038.21 seconds

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



---
Regards,
Linux Bluetooth


--===============5861887845984227983==--
