Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47F371890
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719472; cv=none; b=ZIbTYUefZYzY7M5/x80R1qdB5XwJe4Ropej4LaRU1MxRSAFx5nE7UCshRUJOwAAGLA5w28rzONcFAqxHl9eo5+KT0mTLg9C++svjRC0aIt3eiilkjwB+671mU0dPUqLD/j4Gf6+aBS9rDpuePWeCie1KkPyiNjnufj8dQ44zAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719472; c=relaxed/simple;
	bh=iqEZORSyjeue8HjfI8SdJn9X+kBMFrjQptcZbNYGtOI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ogrqOhQQMAsDOdnu6LBirfARj4MOINoQ81p3SUZM0D7OXFkmRhpk278ePh1Qp6aMZ1eY63QwjNs26cMYeEDzQ59naYSMKbc68RweS8j7saiyxEYwMKnAHpZKMvKjTl7HmAwChnLs47ZK1uDWMosqUyrbdn+zPCZxlv7gQQQNUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbol2Md4; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbol2Md4"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-662bb8b1f93so51281d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781719470; x=1782324270; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2GjxFWpK540wHvCl0bgNlQqxuT/6pKMUHliOn8vj8=;
        b=Nbol2Md4NZBOWbcQgpNLcz5uy4g/Gr/iqOBfuUo93wY1gjdW+WnqhlEbE06utLAt3o
         TqBhZXtN228tS/24AYNLxM2cp3jrEEIUdEoFx8RzhODtkrRj7UIALnFDqtl/JJZbiosT
         nINYhKymZ2AmrbhHPH+pjKRCg8JZ6PnG/kmXCtc22WmRLwGQD1hqYYYg5+llgJnXUVF/
         qkP7Ukh9TnA5jHfWcnH/Jt2BGRL/iQMdpoTuJk25RXou46PoohLMAth277sFPe1n832P
         qhWQxzzxTt5QAJrcqHGT++c85TR0qwFaEE/9ouT1YfzSyk7ha/GqgqYKQjaHpe3K0lqg
         LkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781719470; x=1782324270;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX2GjxFWpK540wHvCl0bgNlQqxuT/6pKMUHliOn8vj8=;
        b=B74oYO83B9bH1k61jCtPnOdLNfhBzml7CqYGNBID7HTJxjdLIiH51Z9aRv0sHU7dRA
         ze6Fqr9EqA1nShHJ9Ksu15FMtx5zIO4QWRVnlXv6FvCtjuGz1LLo4jjyN1leFTeD23s+
         ixkVc0WoUFAVq3T90J7kyXTJUchNDJJb4QaPXTdDW02iOPO28bzVTdIT3DTSna2c/A3v
         a5/aiOtoFj9ntKr31pOZq0PIJ+9st/1yCD2r/ztEBm7akAKe8THKyUONIbqwCfPMY0UZ
         qV6vayVBAsnHEKabfxglEcNZl36sBcsSk/93efokFHXD/StgToaX3PPQGadv6PqlT8H/
         CM9g==
X-Gm-Message-State: AOJu0YzutsFL3S1KykoY5QuCADfFDsfWK+lwQvehV9vY8HAKCzkuzo5c
	BjgfwQxYDJsiA9wlv3JGOJwXZE3z5L1/uw5R7RQ9AJVx8WpLR3Vy3pGKM+SYAw==
X-Gm-Gg: AfdE7clHxnqvaNPzpkHYRknlA+cE05HHY7y/1rq/26RWe0obYM1rIkofUzKDOoTY3d6
	peubdWZYL6qxrHx6vA0PDRqTmCaJNALJP+Xr4skFpMhCg+R15O2GId2VyEY6JPWVlF17CJegL+R
	vR5o+5TahepBwWFLu+bTriQjEAMeJoDcXjtfvGHyhfwqcIpGD2oIuM6JeqdHr25Qed2fx1P4h5C
	yfN7EFzqMRMGA4bmVLGpf92O7D6dGuix+lRNp1qq7tRHfOC/AWRgDnWKD5rYj/kCdRgb5F5tPgx
	dzFvYfMQvyKtgbgSMqdhKGTliLb0V97C5T91GodUrdTyFUE7eEv5315SAhc0kxyVilR0y1wykKc
	slYutfJrMiUwkl2mbeu/PQcZVpLObUBk5nxVejGjwspD6XRq5nVuAnJSVWzBUXSXZsCEoB/f8w2
	XcqENb3SyalHY7mGT3HA==
X-Received: by 2002:a05:690e:138d:b0:655:5fb4:d275 with SMTP id 956f58d0204a3-662cd4b050fmr4250643d50.1.1781719469850;
        Wed, 17 Jun 2026 11:04:29 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.135.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8dba79d0e40sm27516936d6.15.2026.06.17.11.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:04:29 -0700 (PDT)
Message-ID: <6a32e1ad.a3ff9ca7.2f37ba.e7f9@mx.google.com>
Date: Wed, 17 Jun 2026 11:04:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4310140593625845054=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, runyu.xiao@seu.edu.cn
Subject: RE: Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock
In-Reply-To: <20260617153613.1139031-1-runyu.xiao@seu.edu.cn>
References: <20260617153613.1139031-1-runyu.xiao@seu.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4310140593625845054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113030

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
VerifyFixes                   PASS      0.46 seconds
VerifySignedoff               PASS      0.16 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.65 seconds
CheckAllWarning               PASS      29.50 seconds
CheckSparse                   PASS      27.53 seconds
BuildKernel32                 PASS      25.54 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      588.69 seconds
TestRunner_l2cap-tester       PENDING   57.76 seconds
IncrementalBuild              PASS      24.84 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_l2cap-tester - PENDING
Desc: Run l2cap-tester with test-runner
Output:



https://github.com/bluez/bluetooth-next/pull/327

---
Regards,
Linux Bluetooth


--===============4310140593625845054==--
