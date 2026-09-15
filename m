Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C6380FD5
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457124; cv=none; b=JVP4VRuSvw6RlRkb0VHM2BPaiVbFsWZ/Je3jqZEIZF5Dm9W0OROdxT1MSc5ov8FPXDGGEdjWWdXbN5Akv6DOkr9rqo21UpqE5qPJ5R5/l0FEOJqF3BU7ISFFTN2jQQQ0WBKekpCwrKndSklF8prjUXFvM3j+pNvo76368wbJrk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457124; c=relaxed/simple;
	bh=xs63qerQlNg/tgMt68q3VogAdUPTXTBHQQ4urc3Qz6Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qjXEVAnWdaTQyu3SSlmBn0q3T6HPR0RTDFy2GBvHYRcxhNAxe6pdCOiG+Dpd6vpCKpil1FMRMCvB2u0IsBSehYhX8gKIGaxsHL+PTzT07pH9v9sThLTwMMjjnZQu9GB0kv2sUjPZimPkbXxTy8JnF4OywrvulVRCYpN/qJCOrq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=py4FZU5u; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="py4FZU5u"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a8568e9so2205303b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789457123; x=1790061923; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wa/YVBFS5fK4Sq9TdvFT2GovNZZPY+13hHrD0CYwKYA=;
        b=py4FZU5uaGpyCYFkHHfd2/vshGgz3jDKIwclN68ziottvC8a/3emp6Bgi82CL6wX4D
         HkYs4oCo1sh0E9FHrdwxU1uOP99BX9I+EORqxZHsFZN4r7YlgZIIgH/ADT3T5pY5u+tr
         8ZSheNyOynXdnH/doH/rf7Rz5ytznITvHcA+iIacPPhbTTNtcq6oz6EtG1H9PyUJ9Ej+
         HUdEWHm/MgVDrlu6Vyrt8CGSC0KaLgtcaY0gEmy6yav9/Ack+sozm8beqFsm4HEHY6gg
         FJZllAwmmkgGHptCtO1xrYPEfHhnQtTKQYUfVujdXaXAKNIkJSkBtzWjJ5NuwBJLpjG3
         YgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789457123; x=1790061923;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Wa/YVBFS5fK4Sq9TdvFT2GovNZZPY+13hHrD0CYwKYA=;
        b=svg1bNMu1YikQcvgKOsGaD8hG/P5IRz11fS2ljctkdGWTjArT2Eg1tjbK7tQmvVzYq
         egRVtzYVsaxJs2u3BfVUc0t+giNUXX5EczZM2bhrCF/ZMd3U+Wx6zKVPQcVBBMDbDnp1
         UH9aTOzPsW8l+3AofogQJjZgkAA+wE74bvTGM3Nwtx3jcFiike8VLRNa8QerwqxwnraA
         63b1ADRujaXYjYMTJGQ8k/UZ9EFNRyYHUDNKMKJA4IIiAsilE6qcnZrZ8TA+w9eoM43p
         sIyfLrI4poHgpmaiPyp8EQ+IrwWfy04IEqFaoNqk+0CLRB8mHUxqyjttxs82P+l/P6yP
         wbkQ==
X-Gm-Message-State: AFuF++ml92LdS8wMuS9reVf5DAedLCPlPlvRrecL7QUwpZI13AtRCypl
	eGypmVxdeprfkC+laa65d9jy24FnvKmbiAvIrIjjeW8uvNqCOMsZgOw1lFaVoA==
X-Gm-Gg: AYBFou1YHmShRiNi4+OeLEs2pz52HEaTyFDrSdyictMIQMBcr6yP0STvX8got1ukn4J
	WHvpEAxYnyyu2nQXLUjizXp7S43XKCmjJ/VUUtuogl3CLt/d1s2kxN96GyyW3rXJK/NIB6uKInv
	u6vHXqQVKTRhfUEftSOnbyG6udtsPt2jbiweSmbgKcllTl4lwr3VOlLlWEPArn+zhG6ezjFQIA2
	zWSbzRV8AVus+R6hVxMbc1lJCznOIVy1SeXPmglexIK/Q6zxd1T8caB4Sh/5yv1W3/UvFY5exxK
	sOtI5eWUXMqzJFjwFMqKYlRVPfdLMTS92Cj2Thv2TTrdos8BsU/A6tJwDEVUk/ClG+7hwoeUWMf
	0EvqF1mt68hhEoKCUPX1pN/7/S2oHaW80QQT12G9wPEEILD0Od4/lPnpvv7nDUPftBNJhy78U7/
	HQqGgCbwmwxVsj2b3DNO/AGnOXLAZNLJjx7vaxYJe8/e1rKeHo7ZoKd/GcB+ZAtfpc/RMtjx5K9
	mof
X-Received: by 2002:a05:6a20:2450:b0:3d1:2f88:913f with SMTP id adf61e73a8af0-3db40529a0dmr13211744637.14.1789457122632;
        Tue, 15 Sep 2026 00:25:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.66.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf72dbsm34079949eec.3.2026.09.15.00.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:25:22 -0700 (PDT)
Message-ID: <6aa8f2e2.749efa0d.1234b.2e88@mx.google.com>
Date: Tue, 15 Sep 2026 00:25:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6611795026887457154=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btnxpuart: Simplify ACL handling and fix skb leak
In-Reply-To: <20260914-misc_fix-v2-1-6178d838c946@oss.qualcomm.com>
References: <20260914-misc_fix-v2-1-6178d838c946@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6611795026887457154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165096/

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.58 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      22.43 seconds
CheckAllWarning               PASS      25.40 seconds
CheckSparse                   PASS      28.19 seconds
BuildKernel32                 PASS      22.29 seconds
CheckKernelLLVM               PASS      23.99 seconds
TestRunnerSetup               PASS      568.19 seconds
IncrementalBuild              PASS      24.19 seconds



https://github.com/bluez/bluetooth-next/pull/770

---
Regards,
Linux Bluetooth


--===============6611795026887457154==--
