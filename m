Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9A47DD59
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494214; cv=none; b=TDO8hVkmoda8nlnurj5W+XaqN5wUuwipdY2z2iAbAvMWbPLql9QDIeBWJ6WjQIfmbxGl2Tk+bAavzsNMCe/9NdClIE78FYDZTgLmZRRwH8QktkH7YqZMC+SY1Xb0HBePmoCV+YV7fD8nt7JoeBRBOyVUhydRTpML3HxJ5RUyGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494214; c=relaxed/simple;
	bh=qmUT8AsVx/E1J6C7j+zw+Yjc9JadyXaCzPg79kgFf9M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U38zBXVK7MDHeACIMcUZyRUx18Lx1bmrt9+RF7/texgOKYC07lasbXdt1WfTGQWwqypPErblqRieYa6MSBfBkUReGY4U3Km3rxp4wise8ISttEh9JuZtcteFwCLaYbyYjtJZCc5g/3GbraiYv1a6mZK/UMRfK/6RxKO4VefRDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGkM4PQJ; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGkM4PQJ"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5309ce58730so58323121cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789494207; x=1790099007; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OdBDi3xLKyHr3ulXpeUvUZ6L48KbVjfWuWvQYY3yvS0=;
        b=HGkM4PQJ3vb8y+4cMNy/OXk6evebjxq9qdFlByRnmsu9JspFfs2wuapVxly1H+AO4O
         QJVoQau0UVRbUh8A+EDPRRD6H9s7g6kEw4ZhVnybiDKD7xWbn6+zjFdWnZssBgIzo9MF
         ZeJIIMymoImwxOq4zvoxpxLsh9wiR9zG/CaKjXlGtqccGArXZkcjdsafr6nu1sDsIzxv
         SRDtKTUpDZNTqEPNASZanILdpEmFgBKBvXJFjESWZyATmHUexIG7VM+M8Jmt6tvG5q6q
         VVbHazk7Z/6te0Sh99iB9BemXb3Z4RpFV9ZywYDz6zOPLBxr1vcAbiafYlh/8/e7Sung
         W/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494207; x=1790099007;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OdBDi3xLKyHr3ulXpeUvUZ6L48KbVjfWuWvQYY3yvS0=;
        b=Jo0N8Y2O/TPqoGQsVe2Yhn9q15KQGfz9U9su12oVu5BEhCdlxoOdIybGfTifKhvFha
         CiNUlS5JDolDrCMFgXWph8EZwsTh9ZZIyPzboOUuXDV1eRedqaUwrFB5EgRSvBwpLLce
         IxAlDS6D7u1jySx1Y4BWmyZwdIyykc2N1oCP9NB6XZH2pRQ6MVVVBFVAnBeH70xWpkyb
         bLIJ8dIh/ydLSOmGSsx5BIr0NeVMJSCf5afPiC7TJGSmi7tLRhDtmnC02ik4avGOLkwl
         3J5RSRKU5BhSijvrzbxqh5zcadqEoQ1RK5X1QHIBD1Wejrr2IMLDeLL6SyolZQiMRvKF
         a4dg==
X-Gm-Message-State: AFuF++kVQXyDacvf0X8bQiQE3hBh1uXlziETQx0qhJaGbI/wR4B3yYfO
	e3rwbZ3EKfWgpnoGPomUKMux5FdKfbI1xBYeiCtJ65MYwNcPspnNnTtRxSG10A==
X-Gm-Gg: AYBFou2jTiB1dtgHKZ97Tkjm3KWEvE3BMAZtoY46OjU1jFE96quNlH5QmNgPuGAbnZm
	8JMKrmMBBHUdirXJTSLmJuUa0vMRO5SMW409GBM1c4osmr4Bgon20nllSps/vMNmdNnrPQEH8m/
	v62ZNBQjDDUpsUXTIXYxyBNC/+7IFQJSNEIcRf033KxqchZFyJ2ag4UaxE1s/tPeb5mgGai/uoR
	+3r0kd0cFt/dV7zctd/Xf2gUI71IcmVHnrn4HhItoiK7X4s2OPvUITlW9LqqRFJCsBEG/dP4Hky
	mJ2KCQQAmtFAyuuCrN1xUB0Plz2CWik5KRqyopZMF10TCHjCxHfuCcpbP3HXgS8kQqmepWWb6Ik
	cpm1GOp1PUdY+ylSV6BpD7NxXO04VvOwvQxWNIQedoGonqw0X10N4qh43H/trDkUM3uRE1IN+Gk
	pRNUcqJqf9z54qawWhGthwfT/p+75hjD+VipZoFRLdamkNIRMpcO2LrO/MttWswL1e5jNsNnwyP
	aH6z+I4
X-Received: by 2002:a05:622a:1b17:b0:517:9f43:4732 with SMTP id d75a77b69052e-5310cf168cfmr134969461cf.11.1789494207502;
        Tue, 15 Sep 2026 10:43:27 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca4e66adsm131566261cf.22.2026.09.15.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:43:27 -0700 (PDT)
Message-ID: <6aa983bf.ed379546.1ef29f.1980@mx.google.com>
Date: Tue, 15 Sep 2026 10:43:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7067895122888045713=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: Bluetooth: ISO: balance the parent hold in hci_bind_bis()
In-Reply-To: <20260915160332.3107274-1-qwe.aldo@gmail.com>
References: <20260915160332.3107274-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7067895122888045713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1165736/

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      28.25 seconds
CheckAllWarning               PASS      36.13 seconds
CheckSparse                   PASS      34.95 seconds
BuildKernel32                 PASS      28.10 seconds
CheckKernelLLVM               PASS      31.01 seconds
TestRunnerSetup               PASS      722.97 seconds
TestRunner_l2cap-tester       FAIL      9.01 seconds
TestRunner_iso-tester         FAIL      7.52 seconds
TestRunner_bnep-tester        FAIL      7.67 seconds
TestRunner_mgmt-tester        FAIL      7.59 seconds
TestRunner_rfcomm-tester      FAIL      7.55 seconds
TestRunner_sco-tester         FAIL      7.65 seconds
TestRunner_ioctl-tester       FAIL      7.68 seconds
TestRunner_mesh-tester        FAIL      7.66 seconds
TestRunner_smp-tester         FAIL      7.66 seconds
TestRunner_userchan-tester    FAIL      7.55 seconds
TestRunner_6lowpan-tester     FAIL      7.62 seconds
IncrementalBuild              PASS      26.77 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_rfcomm-tester - FAIL
Desc: Run rfcomm-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_smp-tester - FAIL
Desc: Run smp-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/776

---
Regards,
Linux Bluetooth


--===============7067895122888045713==--
