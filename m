Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB272369D7A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065814; cv=none; b=Dcu2TnF8e8KDvpHPWPIRHqpYzLWdITgg4LBOVLlmmu1IIU+Qi4D0C7laThyVDMJgROUcujozxhzTwoCECI1fQ6SAONquVjJXbD8DdL6s5/cIMGjyPNQgJzlIAvjUTJwtd3kiIg3IkRx7hfenCpO6Yc6nSWJCVrxADeqmIQDKRsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065814; c=relaxed/simple;
	bh=/ea/q5mkEWtz1Ke2gErlacYJHz2fzt2XDrswHknWRuE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a+Pb1G+8nsn9xFZCVosamfy9C4UzNOprt+XeDY4uAknCY2Pc7hxOJ3Ldqq5PP1HTMNna6eVtKxv2vEAPa0KO8GMFtDFeJ7Snj/HMGbIeLjwsdCktxutv076XKc2KrjYuki3eyd3eduSmQU6VHQXJ64bLJETJrWOV9Vhl1aHHwCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt3L1V+H; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt3L1V+H"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9106f4c3a4dso196656d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065811; x=1789670611; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ax6Z48Jdam8Cr84wrp5S0SFfR7N8mF46AXXlfyeN2JQ=;
        b=kt3L1V+HIq/sQQor9h7NSri4RJE1moS1vE7E8F3DsvEfdm9gYlR0TsCpaQ0rag/bs2
         feMUDbCmYWErafUUnqxibfeekUcyju8m39PJJ9Cde5BLLR3PLLjE9Xh+rorp9LERXQOE
         3/OENw0T4d7Pi+iOQSO9FTWkVE3lHhGv8uE+eTaDsLSZF6LLptGxh02kD4j6N/GJuByB
         O1gzLLZou4REgwxgs5lwYzGkH0RPGIaK1NWnjjHIa8lg4TjzqRswns5oSlqHUAS//avk
         xOQ76/18hxZTzjGbgjzp6jJZtg262hu1c+y1UVMFRQcuApHazZ/pUS0M+Ln+aa2JQZ04
         iFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065811; x=1789670611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ax6Z48Jdam8Cr84wrp5S0SFfR7N8mF46AXXlfyeN2JQ=;
        b=SIv5ioz10kIxUf4ec3tDC+k1iNlYRpmLf2b2YjvwaFS2XQDbdZN2ZVd0t3be9rPNKh
         M/Hhx8OqiwewFG9p0hhwJTocG55zD8gtqfJAL7GiIY0mxLhRNnqEto6jSuJAj8Gphewz
         5BVJbqooFMAYdKeJY6OFt1Z/cj3hxWp2uGk/RQ3pzTgmK396jc+IPy1FbDhLnYanrxpF
         dfz63KZppXt1IDWCXW0qX61dMAQShEVhfFZb+qQHGe3XkXnSCCHsjaleFWwHWQehLudl
         GB30RvcUdewuZsRccpOzHxaMAgqvEC8XJ5mVZcW5AdsNaspM36b8Ts3brmGNFPHY7rgH
         kQhA==
X-Gm-Message-State: AFuF++nTFDCUBJQs9xcDY1Oj70AT66vn+XTZHy6O5YW4wLXVOZKCZO+0
	humlo74KFmDPUZRp67H+G0J+c0i1/D9ZJzusw3+kssU5eHwwC4fiNATXNntVDA==
X-Gm-Gg: AYBFou08TBlwXH3Xe+CoF63fAEO0kYTJEHkYcz62eUUqRIReS1m48rqT2LglUH/FD8L
	RVE/sGOx3Lu680RzFjCpRMjS1LFnWFhEcOwJmvaZVvWwWF8XYKDcESxhJNqDnXokHD/XjMSRl8Q
	tkQabhUyt3xfdpHzrybG5Qx/Tra5DLJnhkZt7JKY/28WOOcWsWqSCqxAAafsYXGawDqArMzhbxP
	UglOEKZY1WDbAgFy7UvZ/sVKyQ7Op0b/f9NW6l0Bnvtb5cD/nCTneBntZLEVihL1yDpwgRbhj6S
	ANAcJXwQG7iVImiN3AiJxQgq37wVYZtxggTiVeyH66f1zvdLgYp6QEpnnZ/Fwl1fP0Kjser/7ee
	mS+TEubuhHpn6U6q83n4MjLwbDIAapmoIje3Jyqf0wIfmDCNKAgtF5gZ66ymZ2jiQrEmB67uZ2t
	9ay/RMwxWIUCsj8sGIk4a7GcSDcpFxcqz905Ks7AXNfXoZ6IGDPHQxCIR0bwvbHL8fzqBRKBtc8
	58=
X-Received: by 2002:ad4:5e8e:0:b0:910:345c:b7e6 with SMTP id 6a1803df08f44-9121211dae5mr201746d6.37.1789065811514;
        Thu, 10 Sep 2026 11:43:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.34.38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f5e880csm2237936d6.49.2026.09.10.11.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:43:30 -0700 (PDT)
Message-ID: <6aa2fa52.8bd82347.209d6f.0935@mx.google.com>
Date: Thu, 10 Sep 2026 11:43:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7281893046293598647=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lijun01@kylinos.cn
Subject: RE: [v2] bluetooth: pm: use SIMPLE_DEV_OPS for pm struct
In-Reply-To: <20260819062334.2410737-1-lijun01@kylinos.cn>
References: <20260819062334.2410737-1-lijun01@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7281893046293598647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1148228/

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 FAIL      11.63 seconds
BuildKernel                   PASS      29.60 seconds
CheckAllWarning               PASS      32.97 seconds
CheckSparse                   WARNING   35.30 seconds
BuildKernel32                 PASS      28.86 seconds
CheckKernelLLVM               PASS      42.05 seconds
TestRunnerSetup               PASS      791.50 seconds
IncrementalBuild              PASS      27.07 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btmrvl_sdio.c:1729:1: warning: symbol 'btmrvl_sdio_pm_ops' was not declared. Should it be static?


https://github.com/bluez/bluetooth-next/pull/733

---
Regards,
Linux Bluetooth


--===============7281893046293598647==--
