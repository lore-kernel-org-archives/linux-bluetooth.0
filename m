Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CC1E7C02
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247720; cv=none; b=J1ai6D+gjS078o/7025wen0wCssyanq/OTd4YPxEKI6k/JxGeXIkTMnHdRLwBxyRGOz2kvdMNPJ0JlrsP/BZ7WTjv2By/6S/XNc1QubUSJHmFscLcUAl1TdFnBV0tkrPpCOhlNMDTWcVXWHfIdJjWpFtRAtIExxsNyPdx5oTFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247720; c=relaxed/simple;
	bh=+kk39j/tIDa5gfGM+Qn12jVXGO60tlQjYtgctnsBi84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N02pxdAGpVJMsgRjIr0IrkKb0w9cdLUBUbvdGJ7LL1pShY3wtjUVvO6TicvWmVdiWa8u+H+4iusdx8B/iz3lR6W7Oh0t1PDjjkQTKO2Pi/OMBeVESk4wXmsLI+xiQfAjqh9dCKUYG1SGNIER10cwsrp1vB8LYdRwHsJYK0/ryfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyzDCsXa; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyzDCsXa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c0c45c580so42283491cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788247718; x=1788852518; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=plKJXlmbI1nuqwiKfaz63GjYXWro7CnJvSbuaf751ug=;
        b=DyzDCsXaJJ5uQyImHykCgsI56/VE2c7rSmgE4xUqH2MT4Oq58vf5wGKJbCi/pHkZik
         PtLFlnR8h/G9ZkHnFShlHIIRA3+doYS64g1uYNbmaLxKx+CkYQ8XS65EtsO9xMYdTRNa
         OxrVdXgIDYFLEhsYX97J6JRxfHFiHirjqfHrH9lO1Sht82jrFPxH7BD9FlNSoD9XA9Vd
         xwqIhJwakos/GjHRBe7zgLGBAzaNeL1NYnB7ks4rdwU8iHtbZH184i6RMPcAc5XvaMnm
         05H5ytG+uZeBX7wc9GpYIAxTnK4od4jAYFMwa87YY6XX2BiVDEDCp2rX8G8gSA+Qoxdv
         AJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788247718; x=1788852518;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=plKJXlmbI1nuqwiKfaz63GjYXWro7CnJvSbuaf751ug=;
        b=R4hhO9HA2WCjk1/CUzI+KV0nh8lbG0PG23XS3bFQRHIJq0wzulmC1XFTZxpB8nETjp
         qMPLSHC7oCjYqA2HkcVIS+FjX0/sOpJEK+TYZvshPyczEnhgB6qA0c49vq39BYTC1gQa
         40GyRhhQQBPjNSU2OMliXfDfAVoQsGGApK1kX9vOkLgqkySxXAsFsTN6gVEorDmbE7Bh
         /1DC6XagfGaaKpaWYyxSzYAK2P7HQeK8MA9QbefeBvWxIGOZcwzn/iiOaCPUEwlVD+u0
         N7HUNernmuoGmu8RTGpPmRMwgWD+I+cbtQH96JvTt0/cNpRbvNZIHaOWkpx/gaWibZVU
         1r9w==
X-Gm-Message-State: AFuF++kOpIePTj4CJXoAJMK0a7ogLaMcb92V14XCFONqLdv1gdVwnbvD
	pQIm0KK2kzxKgYNpVfDhkJN9+PepE/6G9HGoP/wpaFNq1uSE6DlWUbiKo2pskg/p
X-Gm-Gg: AR+sD12KEkJGwnhkXaeRTyo3qT2sY013yL9UY4SiZbPEQgjDZ7mYo9KuSwIzSfIA5YW
	MWQfLVNfe/YgjSZT/HH9FDp1KM+kpGkSy6zv1pAKiG01DQVyoVSEl6icc2wNm8WBNy60TBnBvPQ
	tdaQMiies3X8I2XWn8I6jyJ1CN25uMtzPC8PB2hwbWkTOo6137ZLIVn3azOWK/rc9HNHEa9tVF0
	y0FCVbLcJ/wHvSdpACo9G+bWaHAzul3OajcAXbUxx6bZs9lWfKXGVtZI25EVHMydZuXU81k4ZBV
	NF79dunqUQ73ztCFbDmpjw+T/6oKk3zOFyN7FLe0Ikat3hXPxeo5jNeBl9pNKKyj+KvszOy4vOE
	2rdHyPrj1w2Uhi02jjmONqmVFFdLzkTSVtuoPF6bwc1f8DiaMtZVipkgt9owqA7GUVlPQs55x8t
	iZ6Xp9EzP+7ttBukTMsSP5gZVjlplXqWO7eZbo6RUc5M7VRo2j0MllEw0g8nKfn8lQ8/eV
X-Received: by 2002:a05:622a:259a:b0:52d:6afd:7db5 with SMTP id d75a77b69052e-53021c76193mr93140331cf.25.1788247717825;
        Tue, 01 Sep 2026 00:28:37 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.100.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce44f5157sm102621536d6.24.2026.09.01.00.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:28:37 -0700 (PDT)
Message-ID: <6a967ea5.00c352d0.3888d2.2afe@mx.google.com>
Date: Tue, 01 Sep 2026 00:28:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7645617607070652099=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andy.chang@synaptics.corp-partner.google.com
Subject: RE: [v2,1/2] Bluetooth: dt-bindings: net: bluetooth: add BCM4384
In-Reply-To: <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
References: <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7645617607070652099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154971

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.67 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      26.21 seconds
CheckAllWarning               PASS      29.58 seconds
CheckSparse                   PASS      27.99 seconds
BuildKernel32                 PASS      25.60 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      470.54 seconds
TestRunner_l2cap-tester       PASS      65.11 seconds
TestRunner_iso-tester         PASS      112.54 seconds
TestRunner_bnep-tester        PASS      19.24 seconds
TestRunner_mgmt-tester        FAIL      222.91 seconds
TestRunner_rfcomm-tester      PASS      25.76 seconds
TestRunner_sco-tester         PASS      31.63 seconds
TestRunner_ioctl-tester       PASS      26.47 seconds
TestRunner_mesh-tester        FAIL      26.22 seconds
TestRunner_smp-tester         PASS      23.46 seconds
TestRunner_userchan-tester    PASS      20.08 seconds
TestRunner_6lowpan-tester     PASS      23.31 seconds
IncrementalBuild              PASS      26.17 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: dt-bindings: net: bluetooth: add BCM4384

19: B2 Line has trailing whitespace: " "
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
Read Exp Feature - Success                           Failed       0.244 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.612 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/678

---
Regards,
Linux Bluetooth


--===============7645617607070652099==--
