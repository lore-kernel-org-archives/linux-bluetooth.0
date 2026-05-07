Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD11C301717
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188016; cv=none; b=a8TVJ5baoAWnBdQis3mYxYLgYNMjfgIEI3bQVG872Iz6JoRwgigOehLs/ow99YSiOQGQppwoa2zEEpiktGoTJIrAT1Z1bZKg4cLr/Jtrrgxpzn9dUl+rJdbZqr4XNL94h7vAUNrn+5LWIMYfW5Ehi5PkgAQo/uSxlLSnWLdTs5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188016; c=relaxed/simple;
	bh=2MsPWgJ4OFnAhgd5kFkc7nH5yFlZOY5vZhXmGbQ1jWo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ig0fiCQc7i4DwNDVOYUJsCDJGpRUB6DzsidbpQe4vzGaX/MkqpcuDetDhl1hFlrGE7B3CrlW1Qiuv/qWg4oIk3orIsK+Dy85q/5VQkaJUsE5Bk4b2JQWxgEyw+xlx4JsC2xxANM4/4y8iIWhY4F5UCvDKR/kEVmoO4GcTzPJulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPzatr5X; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPzatr5X"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8eb5ad01402so133198785a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 14:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778188013; x=1778792813; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+HLSEYp6Y4PORHb86yJ5rMfbbABAV9Cy0qR0bGtwj0E=;
        b=bPzatr5XuXhPbcmlyYFAKC70MxHV1b3+HHZ8SEGvyPilptqjZF6U4Xld8l/LfCvOzo
         AdnSX5gR28C82LGw2JIJNpqkxO/2OxWXgmVTDnP2pQhmdS26Jin/vxjwsqBbLEKroaB2
         AmTToXzVHmXix1BrzwYsKCZ9jy0wwWdu4Fv/fT6/DJdssHtOJC/PYk/BWLPRy17Y2ZjJ
         LKf3iIwllSLU2fnvnS09I6iLljSWU1wf/LWYyentwS4oFAikniuyKIfGCL5dUABgvAr0
         T8okMsretmctFYi3/CmXRqPl/mznN507SFBNTx0b6OrIqEefI7CzFeNRnfNtNKvx8PxR
         sHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778188013; x=1778792813;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HLSEYp6Y4PORHb86yJ5rMfbbABAV9Cy0qR0bGtwj0E=;
        b=RScWj8UNPmfDfpecPU6W5EowfgjSdHDujTsvyGlWZHCIkN9ZokQ6dOHQnfMKqaLCqS
         J3Zg/oXjifDfk5lYo7QGd0NVIHmad5EwyTKX+tJC6lHPVDoTZKdsV3PZS5OZTd6c7Drb
         cNVFTtQioLy7I3kaHnXZ5odQsoq0Ts2CJcqdnbVJ9FhQ2b6FZYY0ar1GC0jQfUctrvZQ
         1ZGskpeODRvlodQR4MXUPhpsXHII3li57MTwdZZxl+gDLU/ch+PoJrquotf2odYB6cXy
         yhRSv+erxJ5iJ1Scdde+Ct6Q2SWZjAodzMm7RGhF+HCj2Sl7iuk9jFaTQDJfyYhjgY+w
         8aWg==
X-Gm-Message-State: AOJu0YxwpKeuC08PonFoUiCN12+6VieUtLD+I/prfES4rJ/cbUdeh/oZ
	WiK8rsPoPH/KTCxoEb9ChplYz5BACp/boImu/C1hWdfi9ZoMRDzNyOT1Tx+Neg==
X-Gm-Gg: AeBDiet6ltDXKI/izCJE4RvTHf2Y1VQy1k5Li/UbGYI4qDYYdulennzU8/pe2PwFYIN
	cN23Y7BthKrllfUDlRKDEcYKO60zkqeag9IuzxKkfa9VEQYteD0+FYY4o9SfZ4b77Cs7IWhAY80
	khlqSKnlqyKaHUFqDn5HY4c0OW00rI3DAxcSjhP7WgTnzp7SvOEFnhVMLAXBLnTprz0o27lNgJ+
	BoS5zfKZE+F01RJjV38VAB+NpXEDgBl/tf7QiytPQwO+GVPMoSgq97DeNeIW4lBhMgZvPBZr7aF
	OkLblqOWREn0U1saxKKwZUGZueXIpPiRGp6+SFdSLDqgcVsLv/5VPHi39oHVoULQ4w/GALr2KKF
	Er420oDYigSEIWKu077sO7gKvk622CKN/SIkWExss+4o1B5NKsLcPKCaar5koCRVbbLmCTBRCW9
	qxv45W82avuJkWWWMN+TXJ8k7t76kKzA==
X-Received: by 2002:a05:620a:2697:b0:8f5:9a78:2f4 with SMTP id af79cd13be357-904d40a2da2mr1433817785a.7.1778188013173;
        Thu, 07 May 2026 14:06:53 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.161.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-904f810e354sm596238685a.45.2026.05.07.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 14:06:52 -0700 (PDT)
Message-ID: <69fcfeec.050a0220.bf5e7.2a03@mx.google.com>
Date: Thu, 07 May 2026 14:06:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7048796290187371335=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vladimirkondratyev2@gmail.com
Subject: RE: Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
In-Reply-To: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7048796290187371335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091276

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.57 seconds
CheckAllWarning               PASS      30.23 seconds
CheckSparse                   PASS      28.95 seconds
BuildKernel32                 PASS      27.07 seconds
TestRunnerSetup               PASS      582.94 seconds
IncrementalBuild              PASS      25.20 seconds



https://github.com/bluez/bluetooth-next/pull/155

---
Regards,
Linux Bluetooth


--===============7048796290187371335==--
