Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B42D6E73
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764300920; cv=none; b=I6e7pUiaxJ3Cxmxe6iP/HAgn/V4yDQtvyZKgRVdTi5gJ57eqp3bw+XsEDFdH0FVKtuX0Mqpfv1hnPUI3ZRWEDeqR5leMHIrENUwCFTrVEKvRfHZcg59/bYi/15XGK/SpAKGHO8BRWvt2avuE2JXW/OMrnd7Pvao8lF63Hrgbk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764300920; c=relaxed/simple;
	bh=4dZrUG4oybAqUCA8yQoWLxpmvcPxcpEH2Tu9CAvQkSs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KGaJDklMoDhTeqc7T6DEp4eUzDaLO8HVdMpb4BBZPEzFAeYa+XIMOpZi/kXX39A3SopX34ATkEeR8JpwcFbdbU3/q7CgAgQL/U9/r5PdA2gVO/rd6dy1Y48rCRLQivzmAbwJJbYwcQev02ihmvhfq8LaMty1d8gltoTflQciBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr7leO8t; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr7leO8t"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ba92341f83so2233862b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 19:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764300918; x=1764905718; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccl16r6D3dqq+Jrd0ngcp5sM0tsp3Db50CPabeUAPtU=;
        b=Cr7leO8tFKBieQdZzUakN/L0RAwsBi/zvV8RCTKWf2a2kDZgOvmUpFsYRNYbfGGdwx
         tc/4if+r6eKvV4u19xNNCEoM2VlGKjarz8rOCQBVFV6UKna6kJcXwjqBoik56ur3rTmT
         LaShipbUgTtJUB+EDbEu3axRPJNhR3F0eFUN9mzIagjnH8EAmolhebaoIsI/E0gZA1Cs
         1FlBUScoyt3dM7AFyI+/Mf6rUDk431M2CQ3lwCQPxHDqZOfrqBo3CD1wGK0EcIupdv8K
         S/hDmw3Y6ts0f7p4d6C3PPShg/2ZPFs6stQBFu4Y/epOBBh7gBuj+X61uXR1+nhO68jh
         vPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764300918; x=1764905718;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccl16r6D3dqq+Jrd0ngcp5sM0tsp3Db50CPabeUAPtU=;
        b=oe3DoiN5MyLNtDUbMAJQwPWUs7AcPSJsErE08XaE2o4gZS3O8uO29xDfcXn2m1c1Fx
         7fXaUEzs1ZWMs5nhsUWiHVnQVy96jJQzvRHwM5HU80xM7lBvSRQUU2YQ9LZ1BvpVUBaW
         NRd5uXrbUJz+g+mFSzQ6X2hkFMd5ZRM3I0KYZ5/ttGjJaZrnD4luvIhh6QuAdfzf8f+7
         aX88PgaF6NHNWHTEHidz9davNDalREUtV5azlvTo2ttJOpM+iIBaFWDJtmsYJw3UwAs4
         /KDnhQGbjYR1nbzBZK62OLXECzecrMQ55EioFcjHXm4XH9aLzkxoXjydR6uAysYLPEe3
         g57w==
X-Gm-Message-State: AOJu0YzKNkedO8hxCc+gYNX6peiP+0C5YN+Rramhk16dUlU7yB4K0TCt
	zq+ClXPRnZ+BTJeoC74u6dNrQsW2CTtXkIfcvGPzPWqhckzrqzbNHnRSAM9j4Q==
X-Gm-Gg: ASbGncur/kWVKoWS+gGYsqleJPGeBVKXUeCbNEZcaaQf0QiDEkq0LIWaA8N9RCOhOTO
	STrYoEpYVFiSmdk1D+QaovYuY947swHmCvONRJNZOkiKKri5Dtrt2dnYh2HKuEAnlJTHFbZycHr
	1KgHi6IA2uZGNZ2mBWpZ3xw/Jg2EgAscqvy0vDSZBRE+TMwdvookIj20pOJ9Ds87HzSnXt7hMuz
	d5mQJn5prTLebW4YH37rLuCaRLQFrfwWW908UoUzyQdjXWJb2EEfKyDQBzFOF+z4L1nfuTE4w0j
	wgSoXRQNvkj5aHTDRFOxDKmjQndw+M7fW9wlNBBn9N6l7qc/Bx15nS9hplV2IQmpNpLcleJ8Lir
	eTQX8cQu3n+bG+Dnf/+AoAQwF82SLDU/sZEgTPFZ/82JrCA/KJhAP7APaeFwEVpIsnJCpqGBExm
	lUEvMfgOwUhk4pOzIBtsM=
X-Google-Smtp-Source: AGHT+IFuda2mdf2aPPbDWMyjGm+cSD98KXGnICVU9v6PnSi6j3B5/uarZKpUhhIOUxIYMhqePIB9eg==
X-Received: by 2002:a05:7022:2522:b0:11c:b3ad:1fe1 with SMTP id a92af1059eb24-11cb3ed2767mr10701735c88.11.1764300917491;
        Thu, 27 Nov 2025 19:35:17 -0800 (PST)
Received: from [172.17.0.2] ([172.182.195.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm17833408c88.1.2025.11.27.19.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 19:35:17 -0800 (PST)
Message-ID: <69291875.050a0220.19063a.35ac@mx.google.com>
Date: Thu, 27 Nov 2025 19:35:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8724003531050965232=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Hermes.Zhang@axis.com
Subject: RE: main: Fix wrong option name in LE options array
In-Reply-To: <20251128015818.1838246-1-Hermes.Zhang@axis.com>
References: <20251128015818.1838246-1-Hermes.Zhang@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8724003531050965232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1028487

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      19.96 seconds
BluezMake                     PASS      632.46 seconds
MakeCheck                     PASS      21.49 seconds
MakeDistcheck                 PASS      237.64 seconds
CheckValgrind                 PASS      294.93 seconds
CheckSmatch                   PASS      342.92 seconds
bluezmakeextell               PASS      178.57 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      963.33 seconds

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


--===============8724003531050965232==--
