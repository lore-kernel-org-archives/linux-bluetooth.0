Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0337882E
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041903; cv=none; b=mzeo6iuu1vxkTXvj23jxucYiK6M3BbGOcXYYUKm9ltZVcUDxzXEoVfAb9FLcStImGz3hNxERN1CREcwzy2Qr0wRqCLL9QMOyVcyY9kPWlOOXL185VI2KrUkW/IHfzfan80Fwzc5+GZOtz5P4luji/0izwgqViPhvK4y3NAVxuUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041903; c=relaxed/simple;
	bh=pqAnJoDCki8kvNdo5W8nR29G0vZ8nrn2TQnPwD1fP7c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jGX4X5P8s29nmVi6F44KqoCvJUl4CdyzCIohZkwfIATcPmI5n3DqR4EpbozzJeMuqGrx+uDeIYEQTanHI1SfrLc6l1xKW6zVXZlRvY1cuwn8pM7IpEh3G4vK5UPWooZxaEK3LYgl6WdpT5DQgyCzhAildPuVsotCI9IAemd7X+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6+9PTjj; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6+9PTjj"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93695893ac1so313901085a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787041897; x=1787646697; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Th5kOqDCTPLkkIuOv4wX5h8oBvjTZP6UySnJimwYoDU=;
        b=k6+9PTjjWjKg3hevlJtncdt0ZM8GlDdVZBmrBHwEPwG/FloeJADCTJsFG8eKY9ZgHt
         MFel8TM5WH4AU4Z6g2s/I9kwD0jQxqlkvCVeJVurDEiXHyPiIZxLb/vnyDVfzdYHK05v
         8pijjyT9c/7Tv8KtbRCT69EWslHCbiVtJJrUmB7p7v9PZXU2nq2jI5KjgQy2Ykxyx/0O
         CkDRAN6Kn/WsbAZmuMEaTUhAOXezJK0timIdsZ46sN/IEnW/qwI3N8YDN4K4PNSj1kKE
         9Vpj7Rd0HEH1Va8x6OJpF+6XYXjHh2R26rA04Xy8qejhnNsadGoxWqVhXecdzBMV+8f5
         vErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041897; x=1787646697;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Th5kOqDCTPLkkIuOv4wX5h8oBvjTZP6UySnJimwYoDU=;
        b=paRydaLcxcrgqIFt1HJa6TOyQ6hGXFZoQkOX/hTXtu6ipq6iC9+J3Ql5RDd/6QQ0ot
         ox+e5AeAgDq5FnDXdAaarCnVkKFKsJlJA25hcgX25Drk2syD1yxdYAIq5DkMxHszlfT0
         ttRVM/aefTIOoTEdLMap0lAyzIjrwrWDHCNzvqfrPDdEqdN5IdUPGiPtS8uR0ghml81F
         x9ObT79dryfJvMA2PzDdwKBgRxs4nXmudHam1dxncitZjO5Nf+LLl8T96DksNuLM16B8
         Jx5XPUmsMtLNLGmV96s3+pFxCJk0r62J8OdIeOyl//qtTUXoirpWp70nNfeko0DZsrWM
         iZMw==
X-Gm-Message-State: AOJu0Ywlvssoq7FnBYi2S3wAE3eF4C1Xr3bP2qORLhIVYOTqO9QscwKw
	0R/8bDKPvPA8YvbJVdLjHzKOgSLTN5DE3ro7ZuPM2Ek0ibW0IzmHVth6KsbQWg==
X-Gm-Gg: AR+sD13yLJnmC11y/7uL4n6f8AWsk7asQPDV21rYDuXVHowb/PGfCMaTndpMAikuf9r
	EB+ZYHa81n3muiSFvqx0f/6eql8j8UaVtOJO3SyTSU6zMg9yR4s+on20mbfZeBR5m94XAYdySqo
	uJtLWJNy+GTn+F5DCrFgdMssekvxfAPO4NXIgq+tSOirUwG3Cy/pxcoWJVIBHC/Sxot/peq2G7a
	bKYDXJh8ToBufREVMZfc+U79yriXHN4Ky8bnC3F1LV4qlatEwO4EnAPw/XC4W1pp2SjQV/EUbr4
	9L2adI0JWjU8L5iPx6UlgC/hLe9ZkyPvTyYRKi4AqUd66DLk72Nl99pcWwXqwGo++8txoB2XakA
	IgK26DMYV8rCqBm5EKYkCpE5vC1gPXIRcx8wxlYzcYHbN/tJj7luU+SweyZRH0Ckgu9FkFpZ+Ev
	7skcD48AtusAdMFRyt8ri8OA8CSvWdUcLrFlDZMF79UCAXSvTuPSeFmsxiZjyOUeQ9RQ==
X-Received: by 2002:a05:620a:7108:b0:92e:54b3:3f86 with SMTP id af79cd13be357-93704b7c79amr598770885a.29.1787041897108;
        Tue, 18 Aug 2026 01:31:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.44.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45933667sm27033026d6.30.2026.08.18.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:31:36 -0700 (PDT)
Message-ID: <6a841868.a374d419.36b42b.5070@mx.google.com>
Date: Tue, 18 Aug 2026 01:31:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3156628796119141088=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
In-Reply-To: <20260818080104.563675-1-ali@iusegentoo.com>
References: <20260818080104.563675-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3156628796119141088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147625

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.59 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.64 seconds
CheckAllWarning               PASS      31.09 seconds
CheckSparse                   PASS      29.56 seconds
BuildKernel32                 PASS      27.05 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      511.83 seconds
IncrementalBuild              PASS      25.96 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/606

---
Regards,
Linux Bluetooth


--===============3156628796119141088==--
