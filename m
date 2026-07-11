Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB231ED83
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783784616; cv=none; b=WuhOUNDHSoKnFSpy51dh6ljuI+ZIcFuOtDPewT72c4UcZud8vq5cOx1s05I7stwIo/3Z2KWHeovLg9Dz2PYzSp/Bt/u2Bl6bs2CrofeqdjLd5eUv5rawcPPLGwnqK1IwEPq1Zux9uS8pWQE9s2p9LTrXe3NLL/YkOHmJtyBiKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783784616; c=relaxed/simple;
	bh=S18ctfs2G8uxMr8zTOAZTzBwfMlL8OK6/UF/mG5WCmE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DdpAPEZN5iuIFKR9DliKZDAvquTrjYvLTPfocrcGnKHi7fY/DeeoyXA+aQS35QEoWllVJ0AX3IgFDtydrV+hkOqeSswK2Z49t6YVBmclP07hWUMspZJL2kuuUB4DmkYdQg/7cSDjw0mrkLKy7raQbD7aivmKOZpcv5MNEdYRof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+i1Hvn2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+i1Hvn2"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso1133941a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783784614; x=1784389414; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ow2VtRuUn/e7qVuOQhqszZkllY4qKGUpCRxPnPoouBQ=;
        b=p+i1Hvn21YUE0eb1VJhAp1l7KdlFcUQmSrdMUh6JH3F/cdSxuocbHYWFOvLXwaYV9R
         pAFYkvmRx6hC56LZT/u+lanHP0DPXtFKrPFgAyzOjqoJ7bNNIZLgR+TngL+QdZFtv2D8
         sbLRINcP7n+mXbHOZp9AanrfPDf1fheroMx4US6AJfrnVqX4MWhS1mqLDK0qkGiyzoQ8
         JFSkVthpYNS0JWEqaG4g/KeBOOxN23wBHkPSRb1XifWguiD+YOSHxBSc3/z3nOjsRoWq
         Vy3PijWFPrJleg1EvZSTDS4/JahG63lxjI91ioTe+j7C8F7E4pNqMG4EmCb6LAxo6qwW
         dgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783784614; x=1784389414;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ow2VtRuUn/e7qVuOQhqszZkllY4qKGUpCRxPnPoouBQ=;
        b=sNL4bciUzmNp/gG0FW4ybb28wPG5ETUSNjFpQBRhLOmt2YkIdGov8kRUuMviLxqGUp
         +T4RPR8R4tsEgJrVCOlw+XbvQXCo7brnEKXggYqHS02AlnZ7k1GkjimmnbyDNnQNvVuQ
         do+C/hvt0I14l8VaijTGf+OHEAKRHa1QDl0n5jk6+mkEFtsFLPnGKx93psFWj4PZdA6/
         CR4kAI2YfD7UZ3+DENpNtDOnHKHRASKrWDDK5ooJW2olOn8+nua5KTeKiFfRaWmmsqDd
         ewLVHrd9XGJY2o5CBLZlOI+KeT99thgeLOJWU3ZcJ3Iu0yNI03ZmL/VSwH+hfP587JFG
         DY1Q==
X-Gm-Message-State: AOJu0Yw1W2NQA0j2a5Wy6vTKupgZiPeeDlUAlI6lUcruLvhwrZ0DRbTx
	2XV1qT2viQFberHle+8RHx398HBCEuhGQ45cDhy6xfwVR+Kcyt2Q8V8BJaLmbA==
X-Gm-Gg: AfdE7ckPd8yxBmqixDrrGGfGPoHzHoL18n/NMGzAIXPXwG3/7mj578/G1fGap8m6lKI
	SW81xNqh5kgW83woubgT66uTsS4t+af4WhR6PWZdXte1fg5GKMPG0AVtvx90vj5PITNLTEciGw7
	UdputZmBrjyVlxYXdF6evQIfJymC58MeGLCcqw8uYIxR6pB+Giu0MvxOI56mzAujB1Bk5mSNqz5
	/iN5iH63poGtOFPDqgfWbQ3yxARUvddrpJ7ia8rLNwGlAnTpGVj31oViubia//Z6qV0tP/nEjbU
	r7I3Mxd1S3i9AOrwY2mviJ5QoRLipHRoQ6+io0GFrtW3GdOcDJOWZZM0sQ9tvv+aPZ7u++ObSjN
	FkWgVsqdnOYmVEsnU9X3Pq5T6cRJq3QlOvQ+/c43BZsScB9cpFIVK2ot4WY9ch9Y/7ZxON/fcay
	I0Cq39r9Vk+90tUoJUb/px25DaI4wa
X-Received: by 2002:a05:6a20:1587:b0:3bf:b931:b3f4 with SMTP id adf61e73a8af0-3c110e2fe11mr3845682637.51.1783784614091;
        Sat, 11 Jul 2026 08:43:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.56.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm49609717eec.4.2026.07.11.08.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:43:33 -0700 (PDT)
Message-ID: <6a5264a5.481afadf.196d57.44b7@mx.google.com>
Date: Sat, 11 Jul 2026 08:43:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2758522677120758551=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_core: add lockdep check to hci_conn lookups
In-Reply-To: <df21b30ef45a6616b32f79c2133c7c2dc19edcc3.1783779953.git.pav@iki.fi>
References: <df21b30ef45a6616b32f79c2133c7c2dc19edcc3.1783779953.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2758522677120758551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125861

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      19.71 seconds
CheckAllWarning               PASS      21.72 seconds
CheckSparse                   PASS      20.86 seconds
BuildKernel32                 PASS      19.14 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      356.51 seconds
TestRunner_l2cap-tester       PASS      47.17 seconds
TestRunner_iso-tester         PASS      71.15 seconds
TestRunner_bnep-tester        PASS      14.28 seconds
TestRunner_mgmt-tester        FAIL      168.46 seconds
TestRunner_rfcomm-tester      PASS      19.39 seconds
TestRunner_sco-tester         PASS      25.51 seconds
TestRunner_ioctl-tester       PASS      21.28 seconds
TestRunner_mesh-tester        FAIL      20.49 seconds
TestRunner_smp-tester         PASS      17.79 seconds
TestRunner_userchan-tester    PASS      15.24 seconds
TestRunner_6lowpan-tester     PASS      17.40 seconds
IncrementalBuild              PASS      18.77 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_core: add lockdep check to hci_conn lookups

19: B2 Line has trailing whitespace: "    "
23: B2 Line has trailing whitespace: "    "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.179 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.047 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/425

---
Regards,
Linux Bluetooth


--===============2758522677120758551==--
