Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795819360;
	b=B0jsadg8lFSQaRh47o9gmn3cLvesQLDEhLAlnmAVhRVKqsYTbu+6mFrDSSFuowjzJidt
	 efwk+L/tse+IMVndTiAPMyfiaq0X+SxemAUK1FlIZOnXHH16zHBn1O/LWalvBFqHMHnfl
	 f8uQQ4NfJvlLxvQS4WdQ9SVqIiG4j9AbV11/c0LhKpQGe6TxqxGGJBk2Xe18x1gmIf/Kt
	 +MUbbKRKZlDdN5txzuRb5UZByLvatN3zLrcVyJs+Ue4VLdbz+zd7YLBjJWRMOKwK/ECYW
	 kWUVEzfS4v2QK8vIW7tTCdHrwSZEGQXRMxZ/FuKxQoj15EMK6S8uDC+cM4CRGQftVqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=eX28GoT+TUNLuKb/EoC+WzvbdwYPfNI97qL9Kbmfp48=;
	b=HuBrRO3X8rTrv0TxMsKg4KPRvnMjmb822Wbqi0ZSh16G6cL7/qZAoArQf/Vuf4Td5wV9
	 uU/2rL+o53TsHX4Wd7US+RMQzjNMntHalYHg+fkbtWErlPnII64b8pNggzKj2Sy5ZVRZl
	 /nsB5TsliyD+5A4KbLl2GDpqketiI5zIFwTLTT48HOQycXdSaliYzYIjy3Y/OcuyQHlBQ
	 2navnlGt9QkY+7KatKNSgLpxi63wAP1+3joRpcw7Iik4uZSkoEkgwMatvnk1Huvcwgs0k
	 VS5cOVPha47qdfYdKJW44Bzpvtn2o89pbhCqdio9WeS4KS+6I+/Y3OZWKucuegQGK2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c92g4P62;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2912606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 22:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2912606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c92g4P62
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55d846e884eso53268491cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795819359; x=1796424159; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eX28GoT+TUNLuKb/EoC+WzvbdwYPfNI97qL9Kbmfp48=;
        b=c92g4P62H1sxXrPgrb+AE/xOvp2R/M6EzP9NmJxFUx1q/5E6OVssw/SkI/AxyZAWyO
         QYx6LrR0lBDJP5umq/9lMK/BQLGkx33BL3+mptl1U5lDfqMFg/M9enabVp+7EWOB/XSn
         vya2RLDYIusuddmA8U6FFcysTeiQCGYwZmjSMtCM3Kjt2DyIfPJwJq9IGm0GD4x4Kf1p
         ogds4IDAjtgJUOpsN5SNJvMbh9MjrDDib+dnoNk1gQ5rqFSc5DVncyVLif/7w+RdqkGB
         NVvNDNrWBZv6qYzxXOguEpc9JxJc6LUEFrNgZsK96h6s2VO8U9HdcmRRr/SCA9naNuQx
         ovUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795819359; x=1796424159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eX28GoT+TUNLuKb/EoC+WzvbdwYPfNI97qL9Kbmfp48=;
        b=Y1ZWjuV1hRVpC8oxX5O3iMWHX/C38caLyIuSHLbuLH79jwMGiFxEuCHJd6ZTHc5U6D
         IECQgcV6Baa9++lCRa+JKzQJ9IoUJxxmkAGc7wWvJUYjuZJ2LHjIgh3ReyfJG6FMvPpx
         cdNnaRJ+l1t/dPjEnj5lbVCLuA0c4HByYRP3k5SA/FGkRtahvZvPwtSR0N17UFQ+cV0a
         g1qryXkg9vJgoUbMFBF3fbuIqB4JPrgmxr0uHC4HWHsQ14f7CXbYoZat+/bUb++k63Ry
         5gFLeYBeTJQWOY6b99yXBcDNvTlhhEQlhx8LoovgV7/lT7/wyRtiG63L4pa/krn5LSVu
         aJiQ==
X-Gm-Message-State: APuU4Z9Z0SyDG8gHeLX9YOwiT5T/E4P2xjXvNcIvwYcAFWn/scR8JH97
	Eb97H84IWYyYqTp31FejzINM+ZVb/NWPqABXlnvN5KlNd9rLDyR8Z27itAOwvA==
X-Gm-Gg: AZFdTZciCsdhIfi342SJFlFob5mi2rJ2uBwfAU/wksar0oIiXB+iNqhzimP9gwEuQTL
	hbVQi6dB74WNAY5aSr4hfPYnOQIZOnIy6umxcVW6LVR8WS3BODSObD45LNaq6p/aHzC0G1bJePz
	71RUAitThX6Ars/hhn5cO+elH6wa0wcbQhpHbOzlFuyuqD6fKj6Gapoh6MlFpbOxrFIPd+j6HhR
	D4EeJh+aMCvv9H10pl1DPOBGDsVrLckGogfSLLV/S+wo2BlnKFvsJK5/Y1yAefAVVU9s6KrauCC
	8eEiukjNcCzj+6Rbq3P/4dXd8gUli5pAjAM8J078iageB0xgP0mHOJRNkgVHWKeqFbvX/fnhr3L
	PZZKv8D1zJHUoDS1s4RzdpA93qV0z4z3M0JrubAS5tuUbAQ+mQTX8sToU8Fd2gnolxJZ7aRdWTs
	8aVHkxg3vRE1sTIEZmXObEE8ftJed6InE6e+7SD8ZGP36mwRHga+4Snp3fa1We1ssR1kozvUvbw
	3alJB+BrGTwJN0lttsZRsPa9vZBkuGxf+5CrmUxGfe8AEUIhDfZ/Sr98voEnYM=
X-Received: by 2002:a05:620a:2948:b0:949:70ec:7e9d with SMTP id af79cd13be357-949ba9b4a6bmr4848502785a.14.1795819358749;
        Fri, 27 Nov 2026 14:42:38 -0800 (PST)
Received: from [172.17.0.2] ([40.76.238.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a058aasm225331776d6.33.2026.11.27.14.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 14:42:38 -0800 (PST)
Message-ID: <6b0a075e.f8e917fe.2417dc.94c4@mx.google.com>
Date: Fri, 27 Nov 2026 14:42:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0120950485897302021=="
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
To: linux-bluetooth@vger.kernel.org, dev@deq.rocks
Subject: RE: Bluetooth: hci_bcm4377: resume after ACPI S3 and ASPM
In-Reply-To: <20261127132501.262651-2-dev@deq.rocks>
References: <20261127132501.262651-2-dev@deq.rocks>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0120950485897302021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224492/

---Test result---

Test Summary:
CheckPatch                    PASS      2.25 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      31.99 seconds
CheckAllWarning               PASS      35.87 seconds
CheckSparse                   PASS      38.70 seconds
BuildKernel32                 PASS      32.11 seconds
CheckKernelLLVM               PASS      35.27 seconds
TestRunnerSetup               PASS      774.93 seconds
IncrementalBuild              PASS      33.21 seconds



https://github.com/bluez/bluetooth-next/pull/1245

---
Regards,
Linux Bluetooth


--===============0120950485897302021==--
