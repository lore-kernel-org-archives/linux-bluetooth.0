Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25776485CE8
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350026; cv=none; b=WA5yQY4cXlwVS52fTH71yq/8lwtJf15t0lsrmvj1zJZ5oSwrnCFi/QywQ5TzM+n4T8PIlQKWhJMq465pfSiXLvZgpzpxygvd50Z73tLoJnsBPOWH5Dzq0aPAJPb/Ol4vLPIdhkNUB2plIcohSCWIJrAB4Nb/Iyslez2D+FksjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350026; c=relaxed/simple;
	bh=jWyk1FQ8qarnjvKGG4feN31q+WlXnocpjbhxF+EFsyk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uhPOg35AmcIPvE1XmSxdswYUUKKt3HJKRDIWWY2lSU43dXuNULda5aIQNYiOs6dmxOBhPMnB8Px2e8y2Y26fIQb2p1mpyPZ3hPEa/0Uxoq6x+usJPsHRGaMGKf/eYnJ8KA8OqsWGz8yVwzbV826qtffhoK6gngawpT1Ji+RU1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBJk9TqK; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBJk9TqK"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-939309d02d6so91816385a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788350011; x=1788954811; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uts+c6MqjaIs9cxmyvdvP2DFauZyqN3XoIrtE5vCjVA=;
        b=FBJk9TqKKRWOWZmXsu2tpy8dSthB74UAReLR9Fbjxk+VyGHP2GiZFolNd0HY/96AbE
         /0jEdyfEbDTApOQV5KsaA5NbBWt/DC+tZ9NRt7cE+OqI4H1xXp+ymfY2NDcO7IBtBzF9
         +EymAqzydwo6sj+NdBWmjEeuELp72Dm9AYTm2CbKCeS+o4znkaUpY0ZTxwEl52Iy577P
         4UToYzT2GCcRuJpBCKOCn4qA4BAiY0kzL3g24fNeAH+Km1fsa9xp7ZNHO4yS0Prs0Mjc
         0cwX5nwafFEtmCyUAyHQ4OeSxn3DYSRMpShUZABdUggD7bDhE9C2zUrB/aR0BHMjI44T
         Ht2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788350011; x=1788954811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uts+c6MqjaIs9cxmyvdvP2DFauZyqN3XoIrtE5vCjVA=;
        b=sT6dpzt/zhscTvBtJTeshOaoRUITGC7p1VUpejZbEwBdqYxF/FJssY25wYwfHpo5/y
         /0gdP+91RrYpWBImHO7YjnDfndnJWp8EsN1Jgt79LoZyE/ufmzY4YI23BnhAfwZUQJkd
         M8voUBphhBuq1pXNNOJdxSDJLU8VdiMEIx9QVEHSViSxsEOXKcDr5hC74+RAa+v9NuWs
         iQ3HT2hDF/f5zjQPDPWjS3WttVbW6qvyTNhmo1jhLO739JkRwD4jNRlsanI7ltvRtG2h
         1YiXNwMxEQRekbtHGijALBGLHhxHV/BoeWQ9UO2l5ld4UCknkpIb7XyaJIKDdelF7lZR
         9Akw==
X-Gm-Message-State: AFuF++kIdzUk34EgKFCooMHPCUF35xqtEvThZZUjVtMMCGvi8gV2Qb7B
	UM/4yyfGItvmmQGto3e2IjcCpF5WXNwD7yarzS/7xXmeFs4gwMuk3Al4BuOCPw==
X-Gm-Gg: AR+sD12ItMIwVAXWnEbMkvmI2ftZzF6co9FI3YXNVgZKCyPJTVO8fZIWQBiEQ0CkRKD
	f7MnniRBUCElDt/BAkv8BrZaoF1SPeidVjuMBWzWpkScSVdPEZGv9DGQHFE0UBe37Dpmi9nhPqh
	gtaBWgI9dF2x7psnLMa3DPpe50WFPJ+mt7pwLBjg+76viQBWvWweQSDSSlvrjJs0ci7M3Jpo+eP
	ex28oYTHE7d4aSa7Q1fQMAaxgHCStbrWOK8wFaCpvXTlOeLuZ5m7UsxIjC9M2qoFUaAVzaLJ+/i
	wJ1mc/NqMzMpDLr2ONWfkwAVbjvTKA/Xlx0dAG8AKbSMPbXvaKXOVL2IoPwek7OtY/cvqERxQTe
	XVeSdpgrd3xtfDP3fujKwy47ewkZolK/RTgiKtkQhFS72zLF9T+53dPAAmhLVyPtAO1LRIZy6sM
	O6cHO1jezx1YDkGirXCkEjCkElSiQWI7RgX2C9xrNo/igqsFKxx+D0jmnj1BsowC6NyBxK
X-Received: by 2002:a05:620a:2b4b:b0:939:2c5c:7977 with SMTP id af79cd13be357-93960edc59bmr503133185a.20.1788350011438;
        Wed, 02 Sep 2026 04:53:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.167.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eee7f12sm16108986d6.39.2026.09.02.04.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:53:31 -0700 (PDT)
Message-ID: <6a980e3b.ce53cff3.1bb42a.b775@mx.google.com>
Date: Wed, 02 Sep 2026 04:53:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5793933334627308853=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catherine.l@intel.com
Subject: RE: [v1] Bluetooth: btusb: Add support for Intel Otter Peak2 (OrP2)
In-Reply-To: <20260902160407.257899-1-catherine.l@intel.com>
References: <20260902160407.257899-1-catherine.l@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5793933334627308853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156048

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.58 seconds
CheckAllWarning               PASS      30.71 seconds
CheckSparse                   PASS      29.16 seconds
BuildKernel32                 PASS      26.46 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.41 seconds
IncrementalBuild              PASS      26.24 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/686

---
Regards,
Linux Bluetooth


--===============5793933334627308853==--
