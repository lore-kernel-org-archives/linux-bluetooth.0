Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696019;
	b=gUeo7aut2G1EHaLS/vI54p95AywsEpkwyobUawqG12tiuk/3HebcUc3s/9NTV/EIczTM
	 ysQq/Q5252d2vHRbM0fmAPARldOwdiV5BNm6+b98hSmHfA/ZIxUkd2IVC4YPJi5ULBFuw
	 EAXGuFzDU1oT7b8nzHYpNCwD3j8tgBE60O3EljD+tWMyt2ZTbXY5xOHfghk5E1eJ3aVTF
	 Ls9wFJVLqbQs/e1o7b6j+ngLZ3cpNTW08LYVTwyXIlbfYbrk+xG73U5ZBp7w2b20v5QNu
	 byuknjpauLs9DNKcMxMJ1WCRiJH2cU1WtbHNsmn+j/EX1kEUVIMo5jqUiy8jb/ymkRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=83oK+1AY+eL/bAtbxqlmoCpuyjZBx0vvve8U3gD1QHc=;
	b=h1WMZ3GjEtzT62/TwMgZK1+HpzD/IPO8mhi+XLc3pSrwQXI6J8cPqjKjfEYa8Mttm6Xl
	 0O7l/ugOQ2+56iQFdwWL4hpaEGqqcBQh+YiH++gLzNw/5r2QnR89W1DKWzlh8/YoQcs1B
	 kwlk4Wx/CeSBeCl2nqfjUnuKL6dFWIesHwiNmXDz6uzvBB0XgZsCYgWagJWX8ZclPCn7B
	 tc5kUTNrGXsgvdWNwEUbiPWBvjGepAz6QROquZcEV4Y0l5ib8mFbeOFDuAzyXToe78vXv
	 jOszjO1wQIkidZY2qlNA9Gb/x8RWCEGNvW54eglGpgTqbMWTWuMGdVis0aU4Tt6pJZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4nnka4S;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB8606A327
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 08:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CDB8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4nnka4S
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a06454116eso1625127b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 00:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793696018; x=1794300818; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=83oK+1AY+eL/bAtbxqlmoCpuyjZBx0vvve8U3gD1QHc=;
        b=x4nnka4S/EB73Y/EcAptmNDXZaxBjgtIGYstIyDswT2s/KvxYeHkSg8xdLNZrl9VWs
         MfQddQmpUD7NowRiovO7eibKKc4CRvUoW6J58Oxxljmum2+4TBf43OdkaOa8zFhqpQaC
         /ryJNKjQV6vIbduzzPSN1xio6VjblrTBDAUW0YoDWcF170wqndUUHLPpEhpsP/zRALyk
         yZJrx0mFBngzdzBSQYxxSgTxUG9WP6lRKcCoFSyaX3LQqglklQgARF5RDRnaAJtR4L6i
         ZDCVcHWMoTbr/U1s24hY1gEdRnsVDwWR6UbitJ1guFRXtjVLM+EPdobsBNq4e6596ud0
         Nfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696018; x=1794300818;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83oK+1AY+eL/bAtbxqlmoCpuyjZBx0vvve8U3gD1QHc=;
        b=LL1oDEOt3t4FtL+t404DnZ5T72HfjfmsKEh3PgVY42JK+muyiz84cJ5Bvj1Q9JlpKu
         qqQbCOtjCnvQFQgF4jcd8567ojArs8hEdMGHybOV6cG28fZ68mhYavNBo7fXljECj9Fy
         D8lcHXthmWCPEhDZP5UUMtO3IiVPFwBfl57W/SXwiLsuT5Z4j3Qqtf/qB4z/WOqfUEyy
         IUYObo4j0KV+UsVK4hEe3Va1Yw3BRp01ZyHmxsOHAm7ZqADBCvzfFyo+Q4/SKnOntzKE
         4zvfID1jbxXWdcS1iDq59i5g5zb65UNk8/jOi+N8zP/T7rqeV6TVaDfa4OEy9RJPsw46
         jQKg==
X-Gm-Message-State: APuU4Z99Ru1vxTbnTnnwq1Wt3Xpp2jiiCufnYQiTNZBiOhPqE8WKdagn
	XEx7TSsmhwNEWOCibp1yfzCjrJ8ZAAcxzHisSdbDv66g1lfN+Jt8cxx5c3a5RCr0
X-Gm-Gg: AYBFou3/2vGCG1MDcBPiDaFhZR68gGPxUY7m/KZgkUWePAyHQ1wXq5THKlJW4SToo/K
	efM0kHiZH5iBSuZlX0U+Av9Mt8Np6dCZiPNbz96wO+YMAUfzWoH88oRqQh6wZ0qeyjcIBxIY7NK
	FFaVXKDgf/BYqXRM2kAGp3o01cnZK4Zq61Q7pcHZA7BZ4rYkwEsv+q6tI+gcvyM5LcYV4/hsLOJ
	4nuLOe0q/KjBbCkNZ+JmryjtsRDWCz5fSjAWgl8jbOX6jVWrYVErXvrQdQMXdxRI0WJ8oD02pOJ
	3eehZBw2VkQW0W483uW+WpoZuxuKEKu5XjdvoOr4lexk+qcJhHhW96Unb2Zp/PsmMrIwYFdvich
	eMWZY6BxZSi/BF7/fIlsyEcGBkTK6Ff2eulGesjWcTdMh6bssFzFbmdHAK0QT7zaz4/b/skVl1k
	/9P+w3NVyGbwsZuSSNSoBsWitzO/oiI/a9k6wlbaTQP0HGEFK0LZPB06a1dmWZkyidvsqdBpsHp
	p5XI9D7cuCyC8sYiBBSsm/DVaBeuQMD79HuguHfgXgISqaYrxyrr+ZLeyW6QecY9yNMDEMjDuuI
	TA9hEHBK
X-Received: by 2002:a05:6a00:10d4:b0:89f:28c3:aab0 with SMTP id d2e1a72fcca58-8a9bf61f237mr9790530b3a.40.1793696014569;
        Tue, 03 Nov 2026 00:53:34 -0800 (PST)
Received: from [172.17.0.2] ([20.168.139.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fd8d5sm3183043b3a.8.2026.11.03.00.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:53:33 -0800 (PST)
Message-ID: <6ae9a10d.f0f4bd69.18d593.2495@mx.google.com>
Date: Tue, 03 Nov 2026 00:53:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8388169307248953703=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: Fix Transport_Unit_Size and remove redundant NVMEM dependency
In-Reply-To: <20261102-fix_kconf-v2-1-b4bd28de37b5@oss.qualcomm.com>
References: <20261102-fix_kconf-v2-1-b4bd28de37b5@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8388169307248953703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199849/

---Test result---

Test Summary:
CheckPatch                    PASS      1.13 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.36 seconds
CheckAllWarning               PASS      35.31 seconds
CheckSparse                   PASS      38.11 seconds
BuildKernel32                 PASS      30.63 seconds
CheckKernelLLVM               PASS      32.63 seconds
TestRunnerSetup               PASS      748.43 seconds
TestRunner_l2cap-tester       FAIL      12.36 seconds
TestRunner_iso-tester         PASS      11.09 seconds
TestRunner_bnep-tester        PASS      3.16 seconds
TestRunner_mgmt-tester        PASS      88.53 seconds
TestRunner_rfcomm-tester      PASS      4.50 seconds
TestRunner_sco-tester         PASS      5.67 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        PASS      5.51 seconds
TestRunner_smp-tester         PASS      4.36 seconds
TestRunner_userchan-tester    PASS      3.22 seconds
TestRunner_6lowpan-tester     PASS      5.04 seconds
IncrementalBuild              PASS      33.82 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7bd3bd5e33d0 at pc 0x55ee46e8de8e bp 0x7ffff8207fa0 sp 0x7ffff8207f90
READ of size 4 at 0x7bd3bd5e33d0 thread T0
    #0 0x55ee46e8de8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55ee46e8eb75 in timeout_callback src/shared/mainloop.c:270
    #2 0x55ee46e8faa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x55ee46e923fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55ee46e9764b in tester_run src/shared/tester.c:1223
    #5 0x55ee46dc117d in main tools/l2cap-tester.c:3918
    #6 0x7f93be567600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f93be567717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55ee46dc7c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7bd3bd5e33d0 is located 0 bytes inside of 40-byte region [0x7bd3bd5e33d0,0x7bd3bd5e33f8)
freed by thread T0 here:
    #0 0x7f93beea53ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55ee46e8e36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f93beea660f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55ee46e782d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1050

---
Regards,
Linux Bluetooth


--===============8388169307248953703==--
