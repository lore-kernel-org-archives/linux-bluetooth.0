Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895338D6A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955338; cv=none; b=qOoz3QjDDKvnEFgL8S36wMuAkG7N4xZRg20ZZ1iEiPGJvFcfaR+yoKn16GAFc+kmEd13oJrzmJ3COPMJ4FPfVLFghR80nzYow4vFdKPzpWXWJLb2ts2N9Em7TpSgPja8L9WsEawCoAYgghz3gOw0FsygtwAqFqVNZxr8bJy8U2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955338; c=relaxed/simple;
	bh=4zgd4C1e3zzclNAS6pzXXiKQyQ+O2Ux0i3qAz4HZ8AE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CHBYGXtX0+zE0y8K6ri7VxcIJH5HZyvXfDCksY7HoE1wPj+fTKCqevoNhIGC0gWznxzANmlkZ4tiSdioQ05zM/QIk3gP+QEN5+P36fabdL6J/iF4l8we6Z5B0y4XpQZVarxAaLi3Kq0MzXYkRfaqc32sXOBXgjXyBdoQZ9oUKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl0oXCBp; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl0oXCBp"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso1146354a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 15:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787955337; x=1788560137; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xXKAwuwUvBMQ+sM08TOAQB/bOCdU3FMFQumXH/x7aUE=;
        b=Pl0oXCBpaOEV9eDj7sTMPItL6PZ/6a/iDLJ3xv9eNOmQgS8kS3jCqrvXu2/WLJuIpF
         /WQuWKSfvqMlUXg96KfljzQXOoxpL4rDcAWuwraKpT/x5qzVoEpPvYnbj76wNI/OovtS
         qhf2uJedMwqg4p9GTJd7w69Ywx1NcxVpLXO1E83eXLa4qob046gXC+pUEBDBgPq1TMqf
         Fl72ZLJAF6UCl+zH6mVIApUmtMe7euNLn+Z0ZdUEDemvMOkNw40JM03Ilu2PZ3+Wh3C8
         ObnoakrmXW/2wzTwLeVpU/uwdK3mu+RyIW2cbxGPCs7Hj3LpumY4gPDmTOxbGq+YcdVc
         rX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787955337; x=1788560137;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xXKAwuwUvBMQ+sM08TOAQB/bOCdU3FMFQumXH/x7aUE=;
        b=PKLndX9mqlZQ3+7l7tXVzL42yRHFt18NHnHSXKHwiEvcbAuSWcsVWKZGScgZ3H4+G1
         Q7Kr6WI9WnMTeAFOdNMTo3Ca1VkU9l/0Yx90xNyV8dBZ5qFh3qvWgt5HZzRuZNxLMRrd
         enagXWguOJXApcV6tHHWcSAF3/DK9hkwzfXLpVmj8HBwREZn4Jvud47ls+DZRUZJb39o
         5a8KS/t45tmpXKGLHW4rWe6J9tBxIZq5uKcAGAwABS6mw4GaexGiIN1/Kprs4dDwACOE
         mywr1Iky/RFAyWoXt2A/RWDvibxn4MB1/praVwaItjqxHqZEHT45nLv+VxW8jQ1Hs2ds
         dJzg==
X-Gm-Message-State: AFuF++kM2HcJwrtXehlxxRqDDzNE82fdTU33ZSG6Wht28tcujvsfPeEY
	U3nTVJuNRAn25X/C4hd9tkN22giDaphtnulsDQvMrtDinFV7Qn2D+Yw9bahqdQ==
X-Gm-Gg: AR+sD12TLQ4lcFvOk3D7StbWRfMmnUCQTYhPaAZUwCyosiq6JbY6zwLu06wIoSJPp5J
	aadQKqzCrWeL2I8Yuq/FGnp+QZUyxgcF6UNTTSZ+BiUg5+FYAAG1GHalsg7SnwDu1bc5GFsNN79
	K+mcu++UdAsV146szn2zpIydkiURr0hJlVhmGSBhoyqZMxndv+cA+HkHVJJoLH4dhorCL8bpqki
	mVPD/rphvav1rbpt/F5dOxcb2vagMxq0xBb2JTbLxhgFHngQDA0EOdqYiKc+0PMnDKGjE5kx1tw
	83xy25K4jHUYtR4mb3N9xTCrwPIee9dY1vc2EKZb8YGMfXIjAse/Jjbs01/t4kTsNG3GN454W00
	VaFraftaAo8OIGgtolVqSZbG35ErM1+1jIywV8vdZ2YeAIQq228FOFv2uHztAnK75KEQKxEKREd
	yDLQE54lBkNZAhXCGaHXh0j+xDGTgz/Uq5+7dQPzLhtp5CG94+oZWkT4tEaNpDZUBi9co=
X-Received: by 2002:a05:6a20:4392:b0:3d3:b02a:61a5 with SMTP id adf61e73a8af0-3d3b02a6bcdmr4291650637.28.1787955336724;
        Fri, 28 Aug 2026 15:15:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.31.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286fa20e2fsm8845987eec.28.2026.08.28.15.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:15:36 -0700 (PDT)
Message-ID: <6a920888.160324b0.35d592.9a6a@mx.google.com>
Date: Fri, 28 Aug 2026 15:15:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2834945999183884305=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1,1/4] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition
In-Reply-To: <20260828142725.241243-1-chandrashekar.devegowda@intel.com>
References: <20260828142725.241243-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2834945999183884305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153294

---Test result---

Test Summary:
CheckPatch                    PASS      3.53 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.86 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      27.83 seconds
CheckAllWarning               PASS      30.31 seconds
CheckSparse                   PASS      29.13 seconds
BuildKernel32                 PASS      26.64 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.06 seconds
IncrementalBuild              PASS      32.39 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/4] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition

1: T1 Title exceeds max length (84>80): "[v1,1/4] Bluetooth: btintel_pcie: remove duplicate BTINTEL_PCIE_MAGIC_NUM definition"
[v1,3/4] Bluetooth: btintel_pcie: log mailbox handler latency in msix_gp1_handler

1: T1 Title exceeds max length (81>80): "[v1,3/4] Bluetooth: btintel_pcie: log mailbox handler latency in msix_gp1_handler"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/661

---
Regards,
Linux Bluetooth


--===============2834945999183884305==--
