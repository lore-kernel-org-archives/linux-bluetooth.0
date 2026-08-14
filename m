Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E7394EA7
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735401; cv=none; b=ISzGxXyRRscUiz0x6z6u/Jc21ez5qJttKe/04ZmcjJu+bS2xFT5R5EmWlJD5RAI5UAMctZ9RjCnaADWa1cjVQhUzanuwjHVsTOijylhGXyEXpcDDc7TKNe7B1H44FiKx3mGGQEKeYZBztZJ/4aJy6O2z7JKd0RD0pIp3e4tc96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735401; c=relaxed/simple;
	bh=xCPDHUUIQeCzEMh8/fJRMdA73OPr4kT+jg8pZKhyF6k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t1XZ7g44I0KH6SU5uZDtHa7S5MQCM2sr1bxrnI9pkBTyE3DU2vicRvrdWiJRcASz8mRkct+li/Gd62xS4shGKR/ltGoGRFJYulRm/hKKmG9NVP0ZMXT2uliFH3KPN7VWOv5w3BOTaFEtIfGq0xcnQ92HLDyVHbPQoyn8qEgaLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbR9ueak; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbR9ueak"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84874b52eabso1708635b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786735400; x=1787340200; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uWUL0dxtXwtS9q5Si2L78DeQwXCDnGyTMGiZpQZB1SM=;
        b=PbR9ueakaUs3B3L6Po1Y3vE6zWT/7/2LCTKNfsbbIc0alIq/14GQE3iwlW/Ke+gTkV
         4FugwPM0b1yHaV+ZJ5b/xnyZADLI30l8s3hAuadFBujOMQqKlizWniqJsH/V33NaDWxf
         HK0o7v4VDG0SrZHFU+xoYw8UxkDEQGxHamlV19EC92OKHAVrvU8xiFk9yRs5LEtaXOFk
         kR6fdHi4vPTDpolGosKgILTVYu6XI7ovMKXILCJl/lHtB4VTvQXA97Ubm4cf5JL1k0n2
         NXY02spOkEI0P7Dq1S/ZQM3MwgNWJmBBzjavUQrlKm9FYCTJx4P61V4zptQqMar+kI8x
         hJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786735400; x=1787340200;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uWUL0dxtXwtS9q5Si2L78DeQwXCDnGyTMGiZpQZB1SM=;
        b=ZPMbbvPNiQOnH5WJpCdR8lVG1opRTCgOAtmjvt+2/GGCDrgEZMk+xb6gl6c3FhqIQ+
         04KzJP9m6Z5bHklK/OhU8gNUHlj5vPz14/EjNhfFrp7wQyq98s+W3JHxBOtyI5/JKBl8
         akU1gvweSQSmpsq8UOtxvVModLO53iggyXleZjSkTe12ECiY8SHMcDMHjtmPD3yku8Mi
         cPn+WIOqgxgAkt/dnp3OyE2OFrwuakbfyIQWlMOBVzUEVHrgVShmQyS/kt4nnH43dnQT
         0+vVH7o1T5J730Zf6Qsl8nYbAZk/6rjecgJmhTy9xnIGVOaW9jtG0615qErSuTatTsjf
         ps5w==
X-Gm-Message-State: AOJu0YxK9WAWpXtws4/c5m7m6K0aGjChLyN/JUdClchiwnFjZhxVmFYv
	vALyAhIAxbPVNM/cpW3kjaBY+JxA+oDhlf4q8LBoozIAEqNjLRw3BlD3Pn/+Iw==
X-Gm-Gg: AR+sD132zC3LAxVVWgvbB8EGHQRlMeLGw6rnrQuFaIYxsJQOSowiWud7NMUgzYCT3kI
	+M1eLGffS+qdcrr3W3kXc+lLg+FR0nDVO8gjMjCIlo81Xjt3r6Z4ybXh8vKY+lkLtkKFrJGXZqi
	jf5nNURF4jFN8AiWPmnlUi7EBfa55jDFnaRRxfPpx9+XZXqHmvvIRFGnb80I5Pd8guXiGvw0uxw
	wl6X6V0xanhS1L9n9T80+eKx78RaD0AtU8Bkp9EKdPOhwJVmhjpDt0uWnDKVVfOiaM25viT33LV
	EmVC0MVpY32Udz20aOu/QKWkR/iyqFAGduJqYNSqLv1ENcvkLJeck+307fBxS6ghJNGJyrtxeNo
	9F5U7LYOz6NNqg/FHNnu3as+tLAMTyXtvfSphDqQmCwmQnJoDzaq4ASnDXyYYPBiWtoXWQqLIyZ
	KQRbxqMpuuVRFlH548EG210q0WGKCG5r2PJX6C9wgk6LStkOj2vkf4CycBn+vdwXzyiTk46cCag
	yPgpQ==
X-Received: by 2002:a05:6a21:998c:b0:3c3:75ff:95b6 with SMTP id adf61e73a8af0-3cc71d3b98dmr9216333637.31.1786735399648;
        Fri, 14 Aug 2026 12:23:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea7fe465sm7144841eec.25.2026.08.14.12.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:23:19 -0700 (PDT)
Message-ID: <6a7f6b27.e7e80b80.289fa.5248@mx.google.com>
Date: Fri, 14 Aug 2026 12:23:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7233413633897071557=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: [v3] Bluetooth: btnxpuart: Validate the FW dump header length
In-Reply-To: <20260814182849.940976-1-ali@iusegentoo.com>
References: <20260814182849.940976-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7233413633897071557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1146237

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
VerifyFixes                   PASS      0.48 seconds
VerifySignedoff               PASS      0.15 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.46 seconds
CheckAllWarning               PASS      31.10 seconds
CheckSparse                   PASS      29.33 seconds
BuildKernel32                 PASS      27.20 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.52 seconds
IncrementalBuild              PASS      25.72 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/584

---
Regards,
Linux Bluetooth


--===============7233413633897071557==--
