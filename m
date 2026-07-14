Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C21C2C11FE
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001495; cv=none; b=b8Hjh4rGLDK/DPR2+jvvqDzAa8EHOIDjVpB2c+x0lAMZpnXbvuOKBzoof3D2u9ETKY70V0ZGFgBfiWYZpa/ZWFr2gt1Ay0Odm2WR5hioXWbe466y/W6YJdG81ecyAD/KMBrehK7Lb9Ou9R+IpzJYh63tilw7mjAuWJFj3z3ekDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001495; c=relaxed/simple;
	bh=Ps/M1bUEwdx0z3xbbDqZPjR0perF8yHHJZGOCvjJbp4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mrnG2PVUAE7oxn1n3MC6s1JAaTlouYJc9puYghkORqVicpp4XT0lrFGkG6PRrkIojaRdAxuzF+3O8LdtMdY+SrZKDSEhdqVnqxnBs2X9LrNApnkGXGCYi8yKrNAzD54LqfFod+hoxdvvWynFO7ejaWWh2GoIVa9ktcO0rToz0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekcdbKDb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekcdbKDb"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca88130e09aso2567036a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784001494; x=1784606294; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0GPxBphFUsFDv8cWzi2nE+fA0NQYjhTDLs1WrwWBCIg=;
        b=ekcdbKDbXkaVPiIM+Mx2Kh/9uY1v11P160vIhijCL0ATpCZFFCrOPXn8T+C4KfJMIA
         J8xHBC99txrYfZT99WmZHZtAFTWER+a3p8gDLWt0WEbsiYIsPL5ym/XIpGC/8OZamwJu
         ywzw7yjeoG3kQi5xcODitZLW95ejVi4gRngKWeDyELrjU8Hn0nBspvVKPv+c9TwjqXo4
         Ay5bt4FjOK5zmYNWr2NXbstTJVd/KxqNprFYZBpfPM9kAjOWXGQeDvoPSStjVVN9RyNI
         WJ+5d5HieuTrEuvh3PETn5tulIwhPv/KVF+3vPtIQsYjLO98eAbcQusdSUtGvGR8AdEl
         QpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784001494; x=1784606294;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0GPxBphFUsFDv8cWzi2nE+fA0NQYjhTDLs1WrwWBCIg=;
        b=fQb5umN4htLYc9oBf1JQ8RPL9PxTAc+LubLiLpwvfSjJt2SVAlYv8f1Z+kxmbe6D0W
         2K9Ji7qrcErzITDUxQa1+8GkqoDmO0BPY52ZAX7rki2PAYrGrRF05ziN3RMUHsApG27f
         brcMIIdzltDvpbLmqFCYH8nKyh2YqmAhWYeF/XabWOEXbe0mJl0gFlcHebprA19/nBYB
         b80QUIkZe0fdC00M9UzNhdy3FnNSZXFDYlh4H6uj26e426m2dQGX3qE/Pvuxs6fENl7P
         uPXb7QOjxTBtjTFHLA64RWHiQVrcZsWrOsokOHhG7oCZUtKHpyJk5KHKO/Xvlrc+cwD3
         2Gxg==
X-Gm-Message-State: AOJu0Yw5Ie7klcTJ6G7YwhML/gOo+Fg//ivQqpXaYFiBXisjlAjlMqJl
	0ebdZLUTieyPJzyroUDAkHBnolLsmbmnU/Nr8aviDsO2YalmXjcVMvLLqmTPLA==
X-Gm-Gg: AfdE7ckKb9nq1FLaY6LH4lNZTu0raMENU1j5yAue1eb87woHMXcbNLVn3atXsS7ij3a
	Ko+wZf2AGna6N2N85SSpQITcsDfED21THIrc597PiXYsqdMAJJ+D1xqZEDfcu2CXJYGFPeBWqVA
	CxYsSVCdy2+R5Qp7KjpvxAP6fRVLkXA3X6688TlHRwXV19Mx1042WXqQrnc/MdA2rl4yDduDgCt
	y0Ah2+5AfhcFfGYs993GZjgzidjN6If9DpzV5vQux3jVmyrPmVFiNPcarYk4laJ8jxK88LR+MkG
	3EI1bvc2NDsDSUWy9HzKUgxxPHEy9gBk/SeRlI/GSzTqVhKb3xTtJZilJjvyIBVwKlK6yhK/bOJ
	elhTikK7fvgDO1LYmr3RAkDiPavlVunz4Gf7UfrroOl/K0tVLN9opycc5tllP+pR92deZ1OqLzT
	FkvEzv3Jc9z4i5RCD9Nm2SWQ==
X-Received: by 2002:a05:6300:2284:b0:3bf:aa1a:d2f4 with SMTP id adf61e73a8af0-3c3571d9132mr775385637.49.1784001493489;
        Mon, 13 Jul 2026 20:58:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.226.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm56237412eec.17.2026.07.13.20.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:58:13 -0700 (PDT)
Message-ID: <6a55b3d5.1905e68e.18ad68.bf04@mx.google.com>
Date: Mon, 13 Jul 2026 20:58:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1010820532905312829=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: Bluetooth: virtio_bt: fix virtbt_probe error handling
In-Reply-To: <tencent_968BDEBA1F64E4B914B4E3DC25149BDDF40A@qq.com>
References: <tencent_968BDEBA1F64E4B914B4E3DC25149BDDF40A@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1010820532905312829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1127014

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.91 seconds
CheckAllWarning               PASS      29.40 seconds
CheckSparse                   PASS      27.84 seconds
BuildKernel32                 PASS      26.04 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.07 seconds
IncrementalBuild              PASS      25.70 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/433

---
Regards,
Linux Bluetooth


--===============1010820532905312829==--
