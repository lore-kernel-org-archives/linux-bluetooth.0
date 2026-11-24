Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546189;
	b=JRkpxsJbN8kpViUqKQZp27ALhOsllgIhEaJ6ZdS6GkWWJzcjoUPsx/fX1nSf1jvYY9nY
	 y55LE/7ZikSrRdQYXymBCsCpIZ3IGeGgdehf3/8Hatw9u4wZglzu5RXQcgMs1ckOUGYtr
	 15FXnN+/cFtHhAstlllQ3TfGsHRlyP01wvHzlDWnOvONERSRmry2qJgE5LO/UIyZ+KjxT
	 npGa6t12vatXu5eySpdnJXkcZJFJS23XmQkDM9WxliPGhs2GtatxrXF5CncuZ2iBOYKNK
	 om6efjCHUpYaxowHKsH466X+SbIUe+jBTJ0inLQplBEhXkrBNEgFxynAm7fs6jIs1Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=MN0Tg6bUb2APjnk0PCyUUZmN1CeniS/0TPQSf8s1ep0=;
	b=wTB4S6RbrwPvfPjWnf0XM3FmRsPXVMtgZF21r34jVFvu7S5b1FBeDblNQ0aNMJqINFs1
	 PNKUhXmatmOGk1hqUTH0/FpcqikOqcXCkH3WtWi/M3/61KfG4OX8uv7W3bvpO3vY4ECqK
	 irygvr3glbv1gVhk8zslb9dOLbZM8E1DuMonAZWHBj4AZlKasjpZZccuS90FHinTx3meu
	 k0OW2UPJmY++IQh6IZQuoTio0F+5med2s6EIe8QcKiGDqYnJB+ythEQdzf3hYiEVGvx35
	 3+SnTen2x/exLlWwmZKUk3FiSHk0wXVIyXb/F2uChTlqY9ourafgt0Wo2xHulH/lXkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lahfy4ZZ;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D672606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D672606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lahfy4ZZ
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f05bc71e01so20305115ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795546189; x=1796150989; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MN0Tg6bUb2APjnk0PCyUUZmN1CeniS/0TPQSf8s1ep0=;
        b=Lahfy4ZZd0oTFHeeZAB38v0gl4hLu9HE7JbUL+QxpEPfSuyRWNm+FiR+zmPX5hMatj
         IXC+ct9CsRrN4uv2KoXzvOWdxKphUjjZ8KoAEAes4ZjDdngSZpZXY7xa0t09kI/DCVlT
         m7rYyiS2qWe8ePbuFtK3o8cg9Q7QI9JIBX+xaOvrRkk8Z+kVm+FbR4KPVwZ36BbVClDQ
         g7cvM+2p4peHGAx1VU4thc436mhZeVcrDVo6aMhaFEmKl8TXsuo3dmvJUBgaNFOsRx3I
         /AbD2tiQ8sGa7Om0GEjEtSdPOyEvJA/AE54v9ia8UHaEhsL8i/VY7IAZaYsLUDZB9oWR
         kYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546189; x=1796150989;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MN0Tg6bUb2APjnk0PCyUUZmN1CeniS/0TPQSf8s1ep0=;
        b=bHzmMgo6NN1gqmHFrbvhaPdDwpZdkgHhAVuIRJ1AWw8/hj2+SBg/Sj6V7nC20SFbQU
         YEk6+Y1HyiJpW5FiwVBz2mnNPopqyFgh59A5XAOnFcz76h2zrPxBOYPQ4KZ0IK2GHd30
         FVf5Yq+JXmf2hpjvLxn9nMulF9JozRiXP1W7MxyhFkE7YnEnpDCL/+LcvnppW8YncEPe
         YEAwC171NXlwoldsL8O4WzOtj4VWRefHwfSZlfev+zZJiSUn41O3nUhggCftt0FdVYw+
         w9Ao3eNQZhPpGI4zP4QxLDTKpb3SOiERN14KLtdqoA/P3lfjFa0+b05FZq7e7MfuwQNc
         8KWg==
X-Gm-Message-State: APuU4Z+V9bCfUTGJtvNX3QwaATcGeo6GTzNXc21zUlbdb4NBGWcWALXx
	F57UxRWWyC+lkIQfaTeSrMZlXLfaPfZdHpJ6s/jvJ1p5dxQcXwzjxDwuMtqmGA==
X-Gm-Gg: AZFdTZeM2/D1jxEjJVB+LM22TP6ObqBaOnCwPGpvqmg16SGllgFrrJoTTfH9pgiHPch
	Ibj2dXXJAWoZXWUUDbTva7lWBOwmfvqXMDt/HqGw46fD9G9cUMb5fqDdI10ieER2Q6ytz804XIL
	Tdj7YDgUV+JSKjdA3pfkil4bCDxDLBJTW1sSx07aiSgcVCQIGd3IAl2E5cBzDEVjzheBP9IHMJf
	/8o3szjLwPJTm0iC2xKGC5kDb6nUJTkWugNQVV/jg6nqqiPaRRDNFOSCNgGWFWOfDMmYwS20oXd
	jzUD6vDPt/LB7YV8dRSMAHcgk0tUe2f1JUjog4NP7w4ryMyZbrQF9Hs6mpLgzjL8agLXfd5yWFl
	7vQKH+bFkzpnWObZTDZgcaW8R6hYNRH1WCAZ/MwaFUca20luaxpUgud29m6zxHjWF+/cGuBR1GS
	RYN6bGN+G8akq4km5SgvGyXaE6Xskjh1R9keogRTNMtdWN3F6XlOLWkBZx7twgbeC3dKIqxicTu
	5CRY+VT5GI3m61kB5aSf+rKW9GDerbYcO09ZRz93dnA23FOsHxP59b3J0YOudaiLTzKHig7Sl+x
	3I8FayI8XUCPEXdJ80oXOzOkC3HONXf/qvtKHw==
X-Received: by 2002:a17:903:19e7:b0:2e9:5714:608b with SMTP id d9443c01a7336-2f03f1aff8emr149580685ad.34.1795546188562;
        Tue, 24 Nov 2026 10:49:48 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-30.us-west-2.compute.amazonaws.com. [3.42.157.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f142b8bsm71848415ad.70.2026.11.24.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:49:48 -0800 (PST)
Message-ID: <6b05dc4c.d0f6c027.19b01e.ce4e@mx.google.com>
Date: Tue, 24 Nov 2026 10:49:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6174098128184232455=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [v2] Bluetooth: hci_sync: Don't announce a broadcast from an NRPA
In-Reply-To: <20261124113937.1695751-1-simon.mikuda@streamunlimited.com>
References: <20261124113937.1695751-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6174098128184232455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220747/

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.04 seconds
VerifySignedoff               PASS      0.04 seconds
GitLint                       PASS      0.15 seconds
SubjectPrefix                 PASS      0.04 seconds
BuildKernel                   PASS      20.96 seconds
CheckAllWarning               PASS      24.09 seconds
CheckSparse                   PASS      25.76 seconds
BuildKernel32                 PASS      20.98 seconds
CheckKernelLLVM               PASS      22.64 seconds
TestRunnerSetup               PASS      482.93 seconds
TestRunner_l2cap-tester       PASS      14.16 seconds
TestRunner_iso-tester         PASS      11.74 seconds
TestRunner_bnep-tester        PASS      3.14 seconds
TestRunner_mgmt-tester        PASS      84.60 seconds
TestRunner_rfcomm-tester      PASS      4.38 seconds
TestRunner_sco-tester         PASS      5.41 seconds
TestRunner_ioctl-tester       PASS      4.49 seconds
TestRunner_mesh-tester        PASS      4.39 seconds
TestRunner_smp-tester         PASS      4.31 seconds
TestRunner_userchan-tester    PASS      3.16 seconds
TestRunner_6lowpan-tester     PASS      4.37 seconds
IncrementalBuild              PASS      19.80 seconds



https://github.com/bluez/bluetooth-next/pull/1214

---
Regards,
Linux Bluetooth


--===============6174098128184232455==--
