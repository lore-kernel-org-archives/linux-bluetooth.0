Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41038237B
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003180; cv=none; b=dQQG4u4qGDzS+yNGP8aWh0B8eHGRyhVtUTkzE2fgaxrDKYx2r31NsVl2VBO+aIxv9nQzeeGMUK6/yEM+VPtcqeyofetc9oj9vx4xXh3BdbQz4SN18nXOuIsuZY2OdkXkgnfnTU0Tfh5/hT2Ryx+ktMRaic/koB18kzsGU90rieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003180; c=relaxed/simple;
	bh=9RKvzHYnh6RJZq08k7SmaABF+seAXFhDtxwwfawj4OI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bq9ab+V3w3ZYC4gAEcAo2BU3CZgl8CwH+wIcj1gCMdLHdBEUEs3Tli/XGz2NeylpMVYakRZqRuBCox1uX9wgZytr72Mhb2EHPbKTkQgJaVCeA81HHsu5jXhaKGrZg0RusxHJvf4kNAG54MTNFLB7YQ1xjJnqQiBpo8t8AdJqF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg3ZNdYY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg3ZNdYY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-526f963372aso25209761cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787003178; x=1787607978; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZFciyqnM2dEkvmI1Vq8n6is9kV0uh3HFz7EdvMbVDv0=;
        b=Kg3ZNdYYeI8INsK7rJEiO4dGHufgyyqO9K6+KbJlRBTgvd0RSETdWMoD1yQMQ37mmN
         6NiemuoKQTiKPIk7PJyazm4JUcNN7JP7AC+dN1AyiRo0YprpH6L34wKhKmJM6sr9p2ZG
         zjYtrcD7vSYjBW0MEexLCEstukGj5RoC3VtjGiqsyta3hD9mqqG3KHn7fo3NnOZG3VO7
         W+xPuIpx9KxMizYjdxH8NmWxuHuorhlaO22zV4ARzWU7x0UdXJ21gPfFfhH9eqmP1WYe
         LfDGIdPbKuYa5jYRe2jkyvD/ZKYFXK31lQG6oHJmT333mdt82zpCWIF6C+lWjxKOW0oD
         tahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003178; x=1787607978;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZFciyqnM2dEkvmI1Vq8n6is9kV0uh3HFz7EdvMbVDv0=;
        b=mZoQBH0eY8/G9jg+IM5utU0XDqgORa369rSaLGYzYjSYgl+GQ4kUG21DvEC9vAJsNP
         YVLXuUn9eNnAgH86+Z92KFJ3QzdjiUTaWvcjAbGaobLiar99pQckTEgUgQQiEuMYF0Xt
         2eQ/ZPe6+oYolVi70c3vAwq7RnSFmHztFtVf8eQmUBBqP6OzyQGKQ4y7xbBuds207tgK
         As1L8qEizygpQ+lPBoT/7FMO7Z3z995ySIylIfHTl7xhIAVYZXSsQ6kKs8Kr3JwKwpIP
         1hJ2/+N836QMQEkBnv8NfLl5UF9mvdipL3qEK0PYFG04e0WFwHJMlsA8NsuBUcVWHBk1
         Wxpw==
X-Gm-Message-State: AOJu0YwT2njYRsejddfxLm1kJoBXSae5r1GgSuvz1ty1pDefHmsYC3yu
	WtyYJaZdSkzOWXvhuqCFc4qPRlT9h/ucKmMoomsc4IPxwgTSZAkTCrBWSk32tw==
X-Gm-Gg: AR+sD12aO3D3lU8AaDAkja3W+qSFNkm1vaeVai83hDwW2ee9B7fCN7I47LF4iT5JyJh
	Av8SGEsFzQAF8wNojuRQCOpMtTIS6ykphxJHhZH9MDoUJCtKWy7xcDKPUId1PG6TOO7w01zc16w
	z6CajugRJcLrO82I0OSOjZQGprRc8F/Qv9ichFGpw1nOc4y1UPHqTVwW9G2fIdLankjO7px/5xG
	IvIh/DbwsQRIlP/55SNrfInP5UkUIWNth3ADToWx9D2mBA11LCVtdFgLi2Vn9yq4Ovxk+msq3Yv
	oy8NHKISAbTJzczG9TOgYT/8RBL7RI3iK3hIGZbVeGTymZOmSzhfoZ0w5M+1aDkfBKFPaPbONOm
	B9rx5yo6uGaX/9amXglCWlAwhcpWdcKLDNXCzN1c377YMZFLjn2FCEb/vWPusPaS//nPKobIGpk
	RnU+N2S9wOKydCpKvsGdmveLUS6L4UeBrC/3VKjFRC3VO5NaBtBMBTlzAP6+uIXfw3MSy6T9UdD
	jP6
X-Received: by 2002:a05:622a:1e0a:b0:51c:1bb9:137f with SMTP id d75a77b69052e-52d8543a326mr329766491cf.24.1787003178456;
        Mon, 17 Aug 2026 14:46:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.239.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db60e9e49sm23989861cf.6.2026.08.17.14.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:46:17 -0700 (PDT)
Message-ID: <6a838129.8d510ab8.7f8e5.c96e@mx.google.com>
Date: Mon, 17 Aug 2026 14:46:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6792108982900844518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johannes.goede@oss.qualcomm.com
Subject: RE: [1/2] Bluetooth: hci_core: Return -ENOMEM when the sent_cmd clone fails
In-Reply-To: <20260817205017.56524-1-johannes.goede@oss.qualcomm.com>
References: <20260817205017.56524-1-johannes.goede@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6792108982900844518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147409

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
VerifyFixes                   PASS      0.59 seconds
VerifySignedoff               PASS      1.01 seconds
GitLint                       PASS      0.70 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      26.35 seconds
CheckAllWarning               PASS      28.52 seconds
CheckSparse                   PASS      27.81 seconds
BuildKernel32                 PASS      25.42 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      458.20 seconds
TestRunner_l2cap-tester       PASS      63.59 seconds
TestRunner_iso-tester         PASS      84.05 seconds
TestRunner_bnep-tester        PASS      19.50 seconds
TestRunner_mgmt-tester        FAIL      222.35 seconds
TestRunner_rfcomm-tester      PASS      25.44 seconds
TestRunner_sco-tester         PASS      31.39 seconds
TestRunner_ioctl-tester       PASS      26.27 seconds
TestRunner_mesh-tester        FAIL      26.01 seconds
TestRunner_smp-tester         PASS      23.90 seconds
TestRunner_userchan-tester    PASS      19.82 seconds
TestRunner_6lowpan-tester     PASS      23.52 seconds
IncrementalBuild              PASS      26.42 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.252 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.431 seconds
Mesh - Send cancel - 2                               Timed out    1.986 seconds


https://github.com/bluez/bluetooth-next/pull/602

---
Regards,
Linux Bluetooth


--===============6792108982900844518==--
