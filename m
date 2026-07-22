Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD8545DF7F
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714580; cv=none; b=i58hN531q3GcsDzkBfNgB9doZxvH1fOIQ0w9SSBejNIXRpUKkmH1GzN7DTcfpnhBb6OSUm5V/fBVihCAfpYpLc/bVgftm2DhIhDv8Rw8LxFRjCiO6mwOkPm1GCwLQhlopV3nQlEkH5lI7DBQd2kSP+BXDK5IRBLGDxSjRSetZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714580; c=relaxed/simple;
	bh=kGj1ZDfPRsGJsQ/vDRCxou4Gj5DvRmAMUteF2l85gJc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SsFIRfjAsSGnFp7JISO68b+2ZXzSRXOg257LPogEsvShoSLxzzY+XENgr+vWQXN1bAWfLhaoycPuS75JpbNi4mQ/ObjxSRaL3K0rIOKmL9Pv+R7jegUsKKmjoYCRuJkJKmxYwxSTwn5BtbMEByWk1hHovOb2HB97ikKItCJFxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmVi4fFD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmVi4fFD"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c149c5722so74099531cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784714577; x=1785319377; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Te+VWFABnrWa7VmoCY4DOqd2TBhTeQihkIyMDOeCXdA=;
        b=VmVi4fFDzxDV9jwxqfnt7+4tuRofqOyqQdzAgajC3MsIqe8bUvVlsKCWlpFtQTv08s
         Ivd86JBWyi1v4Lp/VhTssMGIviY45DcL/buV7IzvrRVoM+m5EkdZ0EEgh1McBthRvgjM
         pWK+Ttn26Z/CGWPGJk/yIJe3pBlP1lUHOu/++EvXPz7kRKJOJZWmuDMl7DNgJC+llt9g
         ab/7dIJi2QCkNGRSKBZTqUKXBq0CKW/am8u3tf8GhD9gURG6ypyvqgquSB1hF1M5rEd/
         f1O+6/Q8yIY7sgnOSLUEmBUMaJMtgfxQ9xL8KeYJAonnw++bqsUurVE8chwZ4edfQu37
         /oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784714577; x=1785319377;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Te+VWFABnrWa7VmoCY4DOqd2TBhTeQihkIyMDOeCXdA=;
        b=l3dlIsLEasdN/+rDt2b4wzW1bv3oLC64HdYafWKxj2rZ3cxDRXZpWwBUohrMBQHytt
         YGzXDZT2rvTnf/Zm7kQ4N3MH079gH5RiObiDMxZn/VgW+60WcRKN/SI2PLggYbEz1REN
         HtisuxDrMlPf0lUr8xMq0wNXi9W5Q1om+XeOum8RaDKTXKo401USGN0Yu+yQzrDhzno1
         BqsyRLgx3H1kgvsiEf2JVektDJHDsP5lER0K+1qqyGjwaarlEvyFllknKr5i+i/XU0xJ
         1Viu5XVoMYIah9x87q1FrViRdqo7xIIomomJm5LEm9gdjAUmkECtQULQlWweD4IYrPF3
         km7A==
X-Gm-Message-State: AOJu0YzfanFqiq7AfLzwGyHOSEazaNeLzut3ZsaTFMJjtcNljo4KpYdJ
	TjK2DNmrU8prAyyVn9Kup2E0j4GVIL++CUko29zv994c88IaobsBz94TPSqAYQ==
X-Gm-Gg: AR+sD12SsuhiGFqm8l3ZhkViGGRYUM94ycPrvxqbEe31BWMEo695LCTlfjlyj/R/5re
	pYILzzBLsyK1Eg8LIh097f2wDes4FbABdS4fxzDHinOUN8koKuBLLPKrK5JmnMQo0+fBK5Fjc6f
	vpK8B7Ll+o/YA7OD26SMGMyGVjmXIQVAuS6WDeFuQSxLUYin3egyfFvl7UI2W9kTN7wtGXxjU/O
	uXqHz68Iyh0iW44KmQoB/F8AtKcx0q1b+ZUu8AfMfjezLsMMuoTcj8wtjmgk/orXflNlrDZf6Tr
	1JCcE7ZzfAKlDYIxV72GLbXoWLzOwdxtLP95TgmGKCJNfAv7OFWq0+lob6H2zvDm3r2EVzWaqhI
	zyFvF6/55GpHVtG86YVD+E3HZIynM/Fj2sK0LOLOOxtAj1vIDL9ou2qibn3WdD4FL+IT15SPRT0
	UI1NFnSmHseaX5PxvDqw==
X-Received: by 2002:a05:622a:680b:10b0:528:2709:5fc with SMTP id d75a77b69052e-52827090b18mr8537151cf.35.1784714576375;
        Wed, 22 Jul 2026 03:02:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3557b28sm11973491cf.21.2026.07.22.03.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:02:55 -0700 (PDT)
Message-ID: <6a60954f.c927a5f4.2a0dce.7982@mx.google.com>
Date: Wed, 22 Jul 2026 03:02:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1159444076226596255=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chenchangcheng@kylinos.cn
Subject: RE: Bluetooth: btrsi: Move set_bt_context after successful HCI registration
In-Reply-To: <20260722083136.175650-1-chenchangcheng@kylinos.cn>
References: <20260722083136.175650-1-chenchangcheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1159444076226596255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132252

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.01 seconds
CheckAllWarning               PASS      30.86 seconds
CheckSparse                   PASS      29.46 seconds
BuildKernel32                 PASS      27.13 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      512.27 seconds
IncrementalBuild              PASS      26.81 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/474

---
Regards,
Linux Bluetooth


--===============1159444076226596255==--
