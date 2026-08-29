Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAA1FF5E3
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788018463; cv=none; b=HOZUOMVSsK2FuOee9Enl6xj1PkAS9TvOe0odFMKF9f1NSBiSaaRnq+ZWEmgSjcaycCM44+p/f67qDemIl6eUxiTN19J6Sf2MvDzhS53YHeDoH2vzYYGY5y4yHqVZndBK3P5MZCiKYftwJSmVju8dzaLPgCFu3o5cw3OMzH4CNe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788018463; c=relaxed/simple;
	bh=qx6sbMX1BfPQaOG7jhvg/wqU0BFUuXTIdyPDJsvBVgo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p6GFzoJ2ssM8PQXm+Fb5EKO2NsQMzzpYqhW/+AULJgr8hcWb78Y1SNV5f+3a7nAkeb7Lp6XiZfDhX1/Z7dkfI7zK8Yn+XT+aELJ29Jfzc9asRFhe1VhWWkVy0Z4I6jmCljIbcgg85fF+ztzxuk9VlYpqs0T71XZungFSH197BVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoeGhxTl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoeGhxTl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so3124377a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788018461; x=1788623261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hco4/OvhFdic9Px4lfkCchrSB3MybcYuttYs1pq5264=;
        b=SoeGhxTlD0HMNZiI9zslGHW03PUEblf2a/tG6kYwQx5MHyOens7A+YL0XV4JylTgcx
         rAFWQW9RfoGN1YPUNJaV+tw06+tW6gN2HRuKD/4KCZinHWcVUOXky6zvqRl2EB2UlIEJ
         xUccGeVPjrly5PpKPG2ZPbC0UBtOSZmI2GHXh32Hyb6wvJjhtrcOCY6a0mjj0z9HJR5X
         l9an9ZVz3MXl+4ZZ5/Y38/oygd4yGi7cfj2+Asj0t4Lf9qOPl+4UF/BJ2BHxTtWJ4Fw7
         DkOrAy11WxnQZa9ilb2qM7VhW8AF1dt4NlW34mjj5CTdmRwsdH61z4n4FFV6Y12XbCtF
         lpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788018461; x=1788623261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hco4/OvhFdic9Px4lfkCchrSB3MybcYuttYs1pq5264=;
        b=Zm8s4ZPD9bUeX9J0YF3UyYUE+SJGO1LA+XtvUL7/3Z6yTcRbwGvZMho3doewNTcckQ
         yZ53heohJ3qwTzGmBgV3QpXaVIxVd8tc3HnoKq6d6fGYzjy7zvB7bLePag9vUPKCR7cb
         hb6cR4aMBScGn8bjjp0f77TOZb4N12IfJ77cZNkFD3WHjcATLtQ+J5pjNXkxpiUdQop0
         G6OrkKi7BBAL9M79DSV5gTI/2hkKTEtcQVDPWpsxGJzEnvD3B4H0f3sCcacNGznwxSgW
         m24g6pIJt1T/FoN9p6gf6B7fd8N9C3ZtbpPr+vRT2Q39SzkHbi4j4wRBbXOc+I3e+EoU
         mIPQ==
X-Gm-Message-State: AFuF++nddAsCjrM5T2ZpYtBLgcHhvKAXAs2RnGoN9N/0X6LL2lWYYHih
	wJpwIA1rWoZo7rjZbMXF7vGw03+wCbzhKNUIlVNKx7WOJSE2+8HxQPFrojBC7w==
X-Gm-Gg: AYBFou3haOfnwbC176S+BvQ9uAEnq1DqccUOuwzSgtwBoa6Q8MzfGKp4rnG4Z8lvLrw
	gidW+pgZr0zZjUpcWQbq4iJLvGxsT6l2WrAvb3PWhF5quqrK1n3bT7S+JW/n9eINrcuxlFUqaMa
	n/OJGhXuLiNzdf7IosxF4k+5KWfLD9lN12JxBKKFk8MPRffnjRceWxHSF8+9XjEcAx+K/if3iKb
	LBY3qkUK8ExcgrVDrIW7+/WpbDczHhJhaaoCgi3mOuhjwf/d1lkZP/mulobHz6chlBv8yr69FJJ
	ZKg4zwZRGy8ETXEGETTwxzTb9XXVIKo6k1AfdN9aQNPY+CTso4wB23Rmu4wYKJ1XqQP4XZ6xpgB
	hHjZZJV4Ps/aac6tNOgfTTrpQnMfE8OuZOhhaTKrK1dXCeUVo3VUd7PSK26VFuu/Vfi3VUBUoxO
	SQvwCBKHLhQrelA5djjuEdgnTXgIuUsF1RlxIV3bgljGY4sGvEk33/pFturuYnx6WoCTulSgkVU
	Kw=
X-Received: by 2002:a17:90b:2ccf:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-396d0f3f449mr27094373a91.16.1788018461400;
        Sat, 29 Aug 2026 08:47:41 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.61.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm24856994c88.0.2026.08.29.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 08:47:40 -0700 (PDT)
Message-ID: <6a92ff1c.492e23e4.3211ab.f313@mx.google.com>
Date: Sat, 29 Aug 2026 08:47:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5854924285088752840=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: fix wrong identifier in __set_ack_timer()
In-Reply-To: <efd26a64addcb562db0745aa4e0a8d2252be1d65.1788016177.git.pav@iki.fi>
References: <efd26a64addcb562db0745aa4e0a8d2252be1d65.1788016177.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5854924285088752840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153633

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.40 seconds
GitLint                       PASS      0.75 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.49 seconds
CheckAllWarning               PASS      30.20 seconds
CheckSparse                   PASS      28.75 seconds
BuildKernel32                 PASS      26.44 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      505.24 seconds
TestRunner_l2cap-tester       PASS      66.39 seconds
IncrementalBuild              PASS      26.24 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/665

---
Regards,
Linux Bluetooth


--===============5854924285088752840==--
