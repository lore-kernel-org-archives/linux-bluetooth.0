Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9740BCA4
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 04:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695685; cv=none; b=T1dm+gl/y2TDxYCKmDjR7VVJ8BMavvyIU9SNeAKtS2uHIS+ur3s4OMNTKU+xTme6RRryI/OItddreivNxuHWcJNUjX+Ud37b+RzaO185MguCnyh4r0UVsqsfUu2HYMa7RXsM5CEPj5RiWLhWV1ow3+NPorDQMzllHqPyds3lnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695685; c=relaxed/simple;
	bh=OZ1NeZHBSWtYDRNQetJjju8KwxkIRuoxdt7RqBIRV+A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dsDwBb2PTPi1iD56T9nJO9xTGYGH0dnD8S3j/5ARP08fBiJq5isPNHORH4cSTsK4/5UAqe9FhcfnJVsy8pgMiaauMkhno+2uT6nej8lyk9pL9tGTsmBaidS+eoGgKWfbynv1VvpAtItinIlB6/Pz/wAh5hLOxv9H0oR4D+UsIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No/2d6hm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No/2d6hm"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca7c1176317so8887294a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 21:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784695684; x=1785300484; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wPhi7JqxoKMEBfIny/zYQ8S+D7DtMpLpoCgmx1HJZ8Y=;
        b=No/2d6hmx0j2Xwgc8UPBdkP+9aKNsFs7YZTLpAD+akgqludnVubP9ElT8JmgtFOzj7
         rXxnLgvqm5X697GHjLJO5b9E5bk7+VWDnWh0jNcH5d1P/Jt6+/1b/HCxeFPswbgqc7Wq
         chz+9YmIibmh8hYioIuUcDtpyxCy0/BxjiReR8u76Enguq2aH0M41LKekKR8ePmuhUJs
         c3CNbD3++Oywtk3h1PWT1VCJl/3MWl76GZ0/5GvOWKSf3JtNakhusRmIQvDb2gMBR9jC
         jW7RlhFqQpxY0rKvCY2lejDSMrOw8Re/8oCwtLZwaLSr913e1gZHOJiG0Eh4b8ComSe9
         dH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784695684; x=1785300484;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wPhi7JqxoKMEBfIny/zYQ8S+D7DtMpLpoCgmx1HJZ8Y=;
        b=S+bzIvtQGAdyJFCC00H7WH5ahv5zKjiXOFGMh+q6Et3T+hPCkWG81ZTyNXkvgFxwIG
         kkTzd9gb+BTBItZQ/r6Gz0zgL/JZTMkepFTnoNJhI4dnSAV5HlMnXbAS9IRmRhendZao
         3mBgPoWR1nYLeH7/Q8JEGEd6SAZHr+PnzT5K+BmAOpqckv33GBhfzp2cDSw+Xb3tS8mV
         Qgf32r50mJG4wHZF3JXK6R5FPVsiHDMQTmB+UGStT/zMi+xDK8ka4ZFZevNeh9dbQ+U2
         dT8Ii8v+r/u1gPyarTAvugFe7ToMuiK+5lBTe9PvSs2eprJYnYWG7628oP39LtREj9ZV
         wEEg==
X-Gm-Message-State: AOJu0YyeWuC2fKEjjulMzi5fJ2NY1WGu+ssOloFFaawQrWMrcL72ALCs
	F0rIX3PhOHA4EH+7QbcbOqDPTu96qOucP8S+0/tqBnqnfLpg9IeiPKG46/08dJou
X-Gm-Gg: AR+sD130EBVXeD5s+CakuEspPHoa5KpoC0yIck6Fa/d/+cx9KlW1u7V8heOEH3O+HJ8
	40278l6ndm+BSZsxmJsxd9flGYFDtJoQ6PFPo/bkT5Gk6QCf2M1gLoXCODuny1RWZmiDX8LD3Px
	pxUErKgMq6wzuf3J5EK4R+gFFzlLciWXtNXCShA+qavYuczHETmx017d2cQUIo7jF/J3X9W4p6/
	s6GriPPtz8ioBLga38IIQJT3wVHp6UHnaqaQC/GVQg/5DpPlgforhSwSAMoJTTrV1EYki2TWVR2
	TSXI6UQt6aZRXXxs/l8zHjcfSRWCLTBaMPIigBncYHFAvgzx6ihx30GpmiW1INvL1+pbyUe+tLD
	ONgol5L53sbipBInv5VgiTRHDIT2RJ0Z4nnlX5MyTTB0/2yALCC3QST6qBObxq7D2Uduat+YfnZ
	2M/k1OEQa4
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:fb94 with SMTP id adf61e73a8af0-3c3ada37416mr22762575637.54.1784695683844;
        Tue, 21 Jul 2026 21:48:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.93.180])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e081978sm4068406eec.24.2026.07.21.21.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 21:48:03 -0700 (PDT)
Message-ID: <6a604b83.f06f4994.50b1b.e50f@mx.google.com>
Date: Tue, 21 Jul 2026 21:48:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0151553288932802957=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, amirabudubai@gmail.com
Subject: RE: Bluetooth: btusb: Gate ACL delivery on HCI handle presence
In-Reply-To: <20260722012311.35434-1-amirabudubai@gmail.com>
References: <20260722012311.35434-1-amirabudubai@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0151553288932802957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1132023

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      21.37 seconds
CheckAllWarning               PASS      23.88 seconds
CheckSparse                   PASS      22.91 seconds
BuildKernel32                 PASS      21.80 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      401.47 seconds
IncrementalBuild              PASS      21.52 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/472

---
Regards,
Linux Bluetooth


--===============0151553288932802957==--
