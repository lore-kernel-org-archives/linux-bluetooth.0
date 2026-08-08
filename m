Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F245039
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786169277; cv=none; b=k0QAmayalksviFcQ168LYkW2LJ9iMlSQ+xj5EkoJ6/u7lMh+Jh3d0Dn/vZ+Swy+C+iJ1MQfXb6ZF8byq9TvvBWMkrgGbNyL46fNjb5PnMeSOo3fRyVhUUydqobr9VbtftUll0UplXJFHMdMXs/dCShK08HQaoQSpFyvj9Z5W+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786169277; c=relaxed/simple;
	bh=SmiiAg5ypq36We+7RHnaFUe45p8uHcKEWNLpCRzUBOQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T38K3cRG4zQMTvOTWHv30ub/5sQ+a0myqdx653TlbBQvYh65CiwbPi02TiAYZtAxw+0eB5HaARFWR0ZPJnlzLXjDnRfxo92HZcUtbCG5xDKp86gEFjqET3ZyIVci4VlxjPVgAHzJUfIehv7ZvqyF8lgDbHhuj2LL8U1niLu0J/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG+5EH1v; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG+5EH1v"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccf2360620so2333685ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786169275; x=1786774075; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v84fjdbXKK3bJzv3bR2vROecqyw679rQsRjINcu7AZY=;
        b=SG+5EH1vxoz3vdznENEKFlrVJUiGTjIj5V2CqLe+/7Jo2hs+mo0Rs0O8/BitLyH4VI
         5njf3EUpvCn0rJ/DttttVGZKIHH43ygaNjog3VfjWdkfEXCeuaJCGdVV2cmMQj84IkYh
         1ruigqDXlyItftXygW1ZNDDcEcdzzwQW68ctxl4x2f6xCpGXu2n/brzkxGn3zWaarkiW
         sK5K/kJDOychfnAmVEzEwPALFdGMr1b+H9QePNVi4YF3YmFKsHivorRqg421Cb0/8Xzg
         dFvTsj5LoUevZX5jykrPgcKUFhLtpwQEldIgZqXJl2OnCKKxt4c66bXpYYJTAvaQDrLI
         nGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786169275; x=1786774075;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v84fjdbXKK3bJzv3bR2vROecqyw679rQsRjINcu7AZY=;
        b=ruJ2X3hiDw4oUCh805+WTxpwaec7u3ok/E9Zx1Vo1RWe4CDfQ+tLT8QvUKTWp3Kf9l
         VjQDAlG8Qv7AQHQEvo9sblBoo6bELYx7R1tDjvqGXRtGlQj89ETZmaCDILHEeo02En9n
         CuosWvbz3tgj9V29HQ8DMMTUH8x6UpTzTFm2RalH/T7fmsPrVhe0dxtNrQpHlwcQ1aH4
         FqVR7OvDT4Udk83wj+ze78II9T/j+LDFPl+7vycpZ2Us3dYBdya18YdP6H2Xk9yqJCNT
         4owNyyO/jSs4RiCb7QdrQxAeKIGRR+7wCsf9zgpNnu+GSqlVyxEBtIR+0EgRiulRUUrH
         RZ/g==
X-Gm-Message-State: AOJu0Yxuwj2xepRFfl1Yr0HkBK7LpeA4wfNZ2BdTANOVrt2Jmhg8ejB0
	dO3tzuKFmMITobEm/bRCKkGRBnzXzocUl+p2wxGoe0o7K+c0mPM5FvVoZitkeQ==
X-Gm-Gg: AR+sD13UcB8eeoqrphHe+U4xMSVWASiey8IHbs5hOdkAsmnXpw/lYi9cCIDl/UUHRRa
	h1SkCGRv1rybmwC2I+bYu7cR3y9/20JlZzqZNsfeJPh6ZQvqPjC6JBvdQs3umrFoifz0uVFJoqT
	7kM6vDPcv2c2ZerFua7HopIYtJD7jaxRuZe0W4VfB1Mro7n4eyuufr7FSyV2JnP4oQ3+Gb1rsPi
	VkwqEEDO6vzDQZ8xyx6joi7FQ/Sn993jcVzWFEVALAxgFlSRkLpDMvT7GhNHdwywStCadlXyhxY
	z3CMUxpn/bPRJM3V3eV/AogTkdyAKajcSoUKfakFMo7rXwbxqa9Kz03ceq4ndyyvxllc01+4j9E
	4SXSp4LOXgSivVa4wcJm7t+WWRJDzfDZmKWh0yUX1DxWtgHzbWSOBArGqFQwpusOt+kLX8lR22X
	o9vVzBGk5yVpiY+HPdLey0gvBhYwiFGH/kmoqZhB35IK2ZqS4dS63LFw2JPdkFyD9j0Iqa
X-Received: by 2002:a05:6a21:3117:b0:3b5:489c:7bb5 with SMTP id adf61e73a8af0-3cbadc97c22mr19874907637.28.1786169274931;
        Fri, 07 Aug 2026 23:07:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.110.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde353sm16469897eec.23.2026.08.07.23.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:07:54 -0700 (PDT)
Message-ID: <6a76c7ba.d681cab9.2fcd52.4296@mx.google.com>
Date: Fri, 07 Aug 2026 23:07:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7106284790444552747=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lgs201920130244@gmail.com
Subject: RE: Bluetooth: hci_h5: fix usage_count leak when autosuspend_delay is negative
In-Reply-To: <20260808052655.2562268-1-lgs201920130244@gmail.com>
References: <20260808052655.2562268-1-lgs201920130244@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7106284790444552747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142535

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.81 seconds
CheckAllWarning               PASS      28.21 seconds
CheckSparse                   PASS      27.18 seconds
BuildKernel32                 PASS      25.26 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      462.68 seconds
IncrementalBuild              PASS      23.80 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/556

---
Regards,
Linux Bluetooth


--===============7106284790444552747==--
