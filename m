Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02141C2E5
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835262; cv=none; b=Cnj/V5ehtjDBeWMijck8DAYYKN80kqML/MlKCYVbAdNTIqdTUk8jQs6QmUB255x9aNmF0EUa5Zv405v0CQLnjr7yNvzRc82kczGjUf5CAQttHPipGz8IWgXblKbocC9SRfTh2A27h3Kn/60M562K4swRDUL7ugckVH1f002N5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835262; c=relaxed/simple;
	bh=6aOv7H3RbHUmb4pLZOwAbDfQ09fltE/o8F+e4NAnPlM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I3uGFwPR3POoWvSNNH3RFGZMWJFUUONdK9XfCf16mo/Kz4VpBS1Qgnnge1+fW1g94lROIq67YhiVFjvvGGhzxGx8VPRLHSdLPHvvwpNTL6yHovqC3DEVn/9a0WSNjHzGF6XxTNKQgZ9DDwOqEyToxawOuH6lGvd6tO2pRWfBFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iew6imMd; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iew6imMd"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e5c5033f6so61990111cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835260; x=1779440060; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AGcLlsRW3Hm5AM04go6tu+z4nDU/qkloRQV6EcYqikM=;
        b=iew6imMd3ayxMrKOBnSgPPtPh/BF0S7v6KmE594r0RiV51dbiClRftC5hmz2y6CCme
         w0C+gATouvHSaSL2GSZ2P3W+BdRnnOwmU+HctzxvozTADb2Dn+HIewhKUC/CjHfse/KF
         C49b7isw6v8E8G03thYsmrxC0walPZl3LZv2GIIFvDtI28NS4we3R/W7GSQnDZlyUZlg
         f+qLxWwTRl+9R0+i9KIF7okbE6lLxY/JMTDDv92XISIe2Oo61GlxlP1P5oO3+Qn54wo5
         +qLrc7RZFS+L4EfslKY07azAavzdWXn0lV9c5hblDGn9cZ2VE28FBLVKKRuUoFa07HQ7
         Deug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835260; x=1779440060;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGcLlsRW3Hm5AM04go6tu+z4nDU/qkloRQV6EcYqikM=;
        b=H919KeSiwh2Bgn3U4CWgPo/JtyN4syvLfsDbO7N/mbweVmujQOaW1WTybkWQtJv6q+
         QHZ72vYhFvhaFf/9QSDhrKh32x9g4HI6NEpPDUiSPnio41qegRZYFncQ0DKT8JXktj5M
         TFV+G/nqU+TLCMVha2iKChNCA5my6Fy0JpZ8tyPEtsQxHPItpISOUbdCqERLXcCIQRvL
         F33RYYe7HQW6ghMOPS0YmB4pVyD7B/X5TqP6/5sVCcJIL1c2JQWZ4JRAznNF1M02FDcL
         ZLRsdbTE0HV1eCM7Omjv91Iet09/9yW0DiVytzESdOqMlyJFz8Rn0+DUlYnfiCgb2RF6
         wOPA==
X-Gm-Message-State: AOJu0YzhWvwTOzl+ftAwQNNwv3YMcl2Iv5wM2gVU6VmZ5md+14BqGNDz
	89+IsBtRboqF4OsmacqhmuejbuEe4i5oPbynfsUtZV381vt4OtuOyT31GOJkFQ==
X-Gm-Gg: Acq92OEGtEjFu9gvMd24p3LyrHKk57nSagyOOe+eL2XTpKU9KutanEcp5dT8YBqoD6f
	E+vd21vemIHYJ8iSksEae6DDgN3xz5yae2Tnr7urQPoZucqDafWj/9rDNSEdENpSznjJi/+zinn
	lqDvL3mJq9sKu0m3812QCxtote1P1tXqsH6lxwelXImWHC3ECtpC7PwElttw0Cwg5FjVwI3Gxo9
	MWRA4q7gCwSGDkX+JJHG1adNHKjbJhF1fo2F6VSUmraG2/gbCBELsNQjQJ8gMvqLPCa9YhS61FJ
	PzyL6OOpATOn0O6WQJWbSbbJ/8PBsIbyCwLnwYs9etypYceA1ZiPf7kglPDIkwv9F0+Q3mMdLlT
	FP1lr7Wu0ahnHBn96gqc3N3jFcGj1HIIAIp7HYuQFD/t+9/cPoRahU6+JEoVynOKLg61Rk8Yx6g
	LAb9jdIUqPOsa+e3PJRZbC/JHSfso/MQ==
X-Received: by 2002:ac8:624c:0:b0:509:3c8c:23f7 with SMTP id d75a77b69052e-5165a1e6671mr30817541cf.30.1778835259957;
        Fri, 15 May 2026 01:54:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.191.51])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645856d4esm38918371cf.27.2026.05.15.01.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:54:19 -0700 (PDT)
Message-ID: <6a06df3b.31fd851d.1c72fe.481e@mx.google.com>
Date: Fri, 15 May 2026 01:54:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7890785009080075545=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnexen@gmail.com
Subject: RE: [net] Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
In-Reply-To: <20260515062525.57603-1-devnexen@gmail.com>
References: <20260515062525.57603-1-devnexen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7890785009080075545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095152

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.92 seconds
CheckAllWarning               PASS      29.66 seconds
CheckSparse                   PASS      28.48 seconds
BuildKernel32                 PASS      26.26 seconds
TestRunnerSetup               PASS      577.08 seconds
TestRunner_iso-tester         PASS      597.41 seconds
IncrementalBuild              PASS      26.05 seconds



https://github.com/bluez/bluetooth-next/pull/194

---
Regards,
Linux Bluetooth


--===============7890785009080075545==--
