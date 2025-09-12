Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3604306481
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678595; cv=none; b=RfYUJtIqLt5CgVLrWQ2/0PmyTdf9R4Xx69dFNDlWAG9Z6ENSJykLSUneLsHGjMGwFjcre2NTpcY35GLVHWnromGZ6nriinJBYvSGjNG5qkODx4LwVHwQt9TIPCJkwd49M+74309rKSBz0cZdhSXuZv2kCa0XvXXEC2uuitmOe9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678595; c=relaxed/simple;
	bh=xhqHRyWKuacSPhxge4OR0eOQQ1ZZuvs0yvV1JKMnqDI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KkfCymto7Q29xdHDdj6u3yWxWKyw0tOvHskeYoXCUMLqoFJXF2GboXPMKbQGg50ZPhT6HuR++BBrRilpGRWzHGkXM2qqjlmllkduU5Es95Ezi56XCMFuHNXYW9y9oJWjUOCzyZRMTzP0L50XlSdnteZ5qi1AQ2/Y6tZqMDwm++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaeRhfga; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaeRhfga"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32df1321879so264534a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678593; x=1758283393; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SAFwQ7wDZxFoXBD2/qbVT5t5rzPkSUpgwaknuLF3pL8=;
        b=iaeRhfga66o2I8byOPEQFhHIk9aPS7sxVatO5xU5wKzxfcNgiH9Z53lG4g98n8L+Go
         k0InN871+IGe0EVAPh1cnOwwIoNgfwb8SCc0TI7cUvkBE5kY4RG6NL8nmGfzIG4HGqGg
         t39oa3C5Ycgc5/mXSbPG/eReKL6YWvwGx8QtJj4tmLuatN6cijP6kxRAmS7p8cXb2kFZ
         ztMmW7ETYoPGOXgCT734dEMkuLdtRMDYWS3FLrRjNQaAjNkQRmjgrAk6J1tBkIbkHP26
         XF4pAgXHk8swxWQjHIkGApxzeJ9MwifpVPc3qK0ra6gS4UJijupTP1Gk3phOc3tmDOeB
         v8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678593; x=1758283393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAFwQ7wDZxFoXBD2/qbVT5t5rzPkSUpgwaknuLF3pL8=;
        b=d91h1LjSVQsL178mKI/Vrbf1N91FvRIwox+YfvSe9BMEVWhdDgsLHUFFEhBRlpH9y/
         DUd2B7IZzBs51NrZNmpwBTkqQfsJC0uQPJgVqA5IELIE9nfeO2dK+VB8QWuF7mHWhtjt
         Pb2xR0yTng07WEyEqi8kjK1dW9IS6qIAxdutbzmk+c13EbQ+H01ikvC3tgupO7OyCM5l
         AGRV/eKyjYAA1XfHEUgmcpX5gGnO1V7hFqNbJgstXZfY1xljPjOQ88iZyOjRFsc1NKtS
         K2xoL5UcvEfWT6HLDF7NUeDBr1s+yCGfJPuyv3RpZ56szdBFtuyOo22mRN5DS4TirqjU
         4CtQ==
X-Gm-Message-State: AOJu0Yyql2O6ddnztNNqCQTS30v3DReeWMabEd9QQgy4Xpc/5q6lu+TN
	ghd+w7YQ+dvrB0IEdaGbT4dNfMv3S/fxV/fNV2oMW/JrjVBviQwpBwCtnTIPSA==
X-Gm-Gg: ASbGncsGO8WC2ooVA7gzmF7iDGVV2uuWJc14dfFIxe8iH813vtOcpxJR4wOYcVkVvq2
	GTyz/ZMDQeoD8ozlnzJN8uVbri2FhFqus2V3ymYc1E3bK9LLEmcsHS20amXP8ILJYk8syjr7Ikc
	0hHjrlVFT65h9vaeN0gzA0F0954oVm6aEKK60Pf46VFAm4db66v1WRiRIBHoVPGrRn5c7wgXnL8
	ks+xA2VYVPEl+uxh+TgiMIr2Wg17kvF9wKayXr7vk6RXsWNzE6A8hQTipArE3Ak9OEg+JjqbeXQ
	TZlEHho6/R1DqhQrnW+lXevouOVqnJu+hmgP1odNBN6WecvSk8jeIasJzSgoi+N61/o47VyVJMi
	ES9+zPygF1U6REGroPfHk6NAYjjviub+9K8XhUXE=
X-Google-Smtp-Source: AGHT+IHW6fFOWhZYC/fuzEhYrQTuNTOVmVXJGSi3hbFUuRJLzfludYzrxV6T7ZsJlqu3g8yWeBpqGA==
X-Received: by 2002:a17:90b:1810:b0:32b:d8af:b636 with SMTP id 98e67ed59e1d1-32de4f87766mr3323873a91.19.1757678592368;
        Fri, 12 Sep 2025 05:03:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd6318debsm6021245a91.20.2025.09.12.05.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:03:11 -0700 (PDT)
Message-ID: <68c40bff.170a0220.103813.3cdb@mx.google.com>
Date: Fri, 12 Sep 2025 05:03:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1498921093383107596=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andreas.glinserer@canonical.com
Subject: RE: [BlueZ] src/adapter: add timeout for missing discovery
In-Reply-To: <20250912103550.49240-1-andreas.glinserer@canonical.com>
References: <20250912103550.49240-1-andreas.glinserer@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1498921093383107596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1001717

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.36 seconds
BluezMake                     PASS      2873.61 seconds
MakeCheck                     PASS      20.05 seconds
MakeDistcheck                 PASS      189.60 seconds
CheckValgrind                 PASS      241.75 seconds
CheckSmatch                   PASS      313.32 seconds
bluezmakeextell               PASS      131.99 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      946.39 seconds

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


--===============1498921093383107596==--
