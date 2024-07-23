Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E675156C5F
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757562; cv=none; b=JU0/u0AtOPY6MtDAy7ITIVzSoR5Bk98ZI4dv3AXMuyTXfnCmtBIDYRb5jw3sr5wQjSUfZWcUq11YgZMiUcQ8OQ/Rsivpm2L11JGZrVNSPIn/t/w5QTN4duZuhDMbmhF5FoyV62SaLL+V43SR2j+pR2kl/cQoIMMUYEsoz6X04uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757562; c=relaxed/simple;
	bh=tmlG734WrCKEXQrFWfIMoYuLvamSOBzn8BHbIYpBhDQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VwXkIDV5M8Ktb9O3YcjsIpz+SJK4rsDYulA2hv8rBLmSt5vjSpSJkXki6OYctS3VS4i/GZzhnQKLrrtwAm16XIbBaYXplDQN5mmINBVXlxdYA7k6aHKkFJUv3NgrrQzX7W3tQ91WetU2BnWMJqdnnQy9mDSXAZcJcHXBYwx2zNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzjfluGl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzjfluGl"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d24ee79fbso1896301b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721757560; x=1722362360; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I96yy7E9CcHG8yDIIE5u28djxlmB2kTLaDxOnm1664Q=;
        b=OzjfluGl2yAH+BHwOVnpzB9gA4WiEqiHtJtqc7tOVHD+l0zhdioOeFJzKdpUwa1G8i
         bCl7bjz/hQBugAZomjnRYiros9rxjaVYkQ6bcS0cDEiBxv7SpZHmcgK7KkuE9W844EBv
         NUasBfFCQK7pEPKdjRwIdrbrY6C3dTI40TiilZ3+lysl+AVizOcpyy6BMqA3D3WZpHRh
         hJGRVTDa+WCu0Y44v4hft1bIeiDliCIbkkJ2XVrQwh8mwAa2k/ojuOynzN96O7+XLuQl
         lfT54jBbQeKidTlAWukyd0r5GVaQpUCieRYrzvXdedjsiHYi03jIxBT0RM9UvV0r8s4P
         siAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721757560; x=1722362360;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I96yy7E9CcHG8yDIIE5u28djxlmB2kTLaDxOnm1664Q=;
        b=t2JZT1YL+SAo+On+vo4Jvh4Yac22tBwG/vM+qjtDRjCPugENx8e6ndXTynaNJiye8/
         6WMGfrtCHXEn8Fy6oSjeO6SL75SnUdb4pKdjoerwLc2pBWkQvI2lKWnGI4Gbz1wMQfDy
         j6ThiHKt0yXwUM2/Fdk/MkT7OuhG8HPoM8G8zqksrNMqrPGY9lj56fJCslA2a2jcx48+
         UQoZVLfue7Z8Rve4HfmKf+YKiTzGTE72MknUdXTUDXXEjAGMPbk5ydfuOud3w5w1fnos
         pMMNaDP22ApB/51S1FLxSvmCyaWq9+sATl06ciY5bjyMCnT7X3f8+O7DMy+EmbFg65Mr
         GrGQ==
X-Gm-Message-State: AOJu0Yw+Yi0wz+Mzyimmm9pSY7pcqeUGGkuCZ8w7PoJgNLiGbCLw++c8
	JcGgO65s5jR4Zih2SgSK0YpaYt41Hh8NUZWqay926Qvep0HZWQT1WSVesQ==
X-Google-Smtp-Source: AGHT+IHFsTtEWaT0Xpira9yXiCX12fDaXEvpLMVylzwFmEnovwb+Da9yD68WhBONyPBrIw+NVTqkvw==
X-Received: by 2002:a05:6a20:1596:b0:1bf:df4:84db with SMTP id adf61e73a8af0-1c44f9361e1mr4289474637.42.1721757560261;
        Tue, 23 Jul 2024 10:59:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.243.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c72075sm9493358a91.28.2024.07.23.10.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 10:59:20 -0700 (PDT)
Message-ID: <669fef78.170a0220.4c88b.8caf@mx.google.com>
Date: Tue, 23 Jul 2024 10:59:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6702951826818478530=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yskelg@gmail.com
Subject: RE: Bluetooth: hci_core: fix suspicious RCU usage in hci_conn_drop()
In-Reply-To: <20240723171756.13755-2-yskelg@gmail.com>
References: <20240723171756.13755-2-yskelg@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6702951826818478530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873322

---Test result---

Test Summary:
CheckPatch                    FAIL      0.91 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      33.00 seconds
CheckAllWarning               PASS      35.66 seconds
CheckSparse                   PASS      40.98 seconds
CheckSmatch                   PASS      103.93 seconds
BuildKernel32                 PASS      29.85 seconds
TestRunnerSetup               PASS      540.47 seconds
TestRunner_l2cap-tester       PASS      22.85 seconds
TestRunner_iso-tester         PASS      32.82 seconds
TestRunner_bnep-tester        PASS      5.43 seconds
TestRunner_mgmt-tester        FAIL      116.18 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      15.21 seconds
TestRunner_ioctl-tester       PASS      7.88 seconds
TestRunner_mesh-tester        PASS      5.93 seconds
TestRunner_smp-tester         PASS      6.97 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PASS      27.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_core: fix suspicious RCU usage in hci_conn_drop()
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 1ae534019415 ("Merge 3586166ab17668992c0cb052b6658d4eba37e05b into e0fec3b758385c70fedc3b4b1b3e34f51a1855ac")'
#169: 
Fixes: deee93d13d38 ("Bluetooth: use hdev->workqueue when queuing hdev->

total: 0 errors, 1 warnings, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13740235.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 489 (99.4%), Failed: 1, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 6 (RL is full)               Failed       0.202 seconds


---
Regards,
Linux Bluetooth


--===============6702951826818478530==--
