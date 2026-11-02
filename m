Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647954;
	b=PKzMwf8xquVVfGyEXtTMx7FOL5km41vRo07rX3uiDkjHMWPGCylHUJ2LPGjmieN6ktZ4
	 MN4nlvGcXK39kpgmeXoIU67yjE40WiDAZHDQN8+EC85dQfhxQ23/A5X9RhwhVBb8WmbWT
	 cRYWQm0hA7hChC/xuYIHB1C1w9BvtEzig3GV5XXCm3sfAwVRtFmxbJ+Up1VMqt5D8NZu+
	 YHSVpy9k+MO7vWaJ0cRfLbc8ARUfZpQWLKbtecZR866esFdEsiS/3pkVPYCjwm0disFHe
	 bv7ModcvSGGbJHzc+JOGsRdrLt61mo6yYcG1KKOR8dgFGTfYxsMePuUHJOnlk4UQYjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=vOWziQ+4OYKc42EtC5QL/57C2En1gari8HMGQD2BRZ4=;
	b=vr3YFVoBLULSpYFCeDPWxOUy7jywxPophWwtTiK3L3NDdWJPm9B7eExmm3oh21MQ4LfE
	 YLBgqATHQc3x3vjdMedZDzS93F0bEQ+nX0SAzzPxsd5J8pZ3YwdBHzkf2vjQxJqx74jAA
	 FCX8aVi34551XG/eqN4xHhKGQYsde8NR4wwRhO6pXDa3gKFGHdlEKDbodrt6/aZSKaRfo
	 G8qN0p3xUd4BUzSmWSg2HapQKAsFlUeHo93suY4sbatZLI3cgCuCdjAPM4+dc68o9+yNC
	 71XwysE8xptSk4vTdzYLfMbVuFQ0cftneR4oIeZhKfOmgSYwV348sCBTc0K2EqCnA0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yA3BReHM;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06E606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F06E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yA3BReHM
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535a54bed9so5098525eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647953; x=1794252753; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vOWziQ+4OYKc42EtC5QL/57C2En1gari8HMGQD2BRZ4=;
        b=yA3BReHM6Ed7yY/ZN2u/mcr4wjXvlIzr2nuwY1e/M0hJeljNtCj9lSHYlnp7XPvioy
         MKeHuO4wvugV3FuTbFwi2a4NvHe2y8+HD5/v7FWCRYcWyQY7xMFTAfzk4RDhMAdCnc/Y
         rAMhzDz4ZoQL45JyqeF7z/mZ6q+Tm0ahz/W+WJszFkKuAQnf5EQEaU54tbKCfbZtZW8i
         r/2SdhHZIvfaArHe6auqhdYKUwuESp4TJTUIY9dPlCc14+F3899rkJsmjGzTKZB3u5NG
         nZg3BjREEGH94C2rGM9PebkwJTyoHNWy8c19InwnaKtH6UvLohXBXOs7d+VrdMyX+YvP
         DcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647953; x=1794252753;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vOWziQ+4OYKc42EtC5QL/57C2En1gari8HMGQD2BRZ4=;
        b=cp8MOLvooRssWo49F/RWB2D3KctGqNXP4U/URL8qiWqg3pdlXA49b9GzMnBlr7NDAm
         OWnCg4I2JlhPIvPmc0PRC4C9vpn2FPoF17gT0zOCeucdmP3n7QFK9k3090SPxmECv16d
         XVIoOy6LMf/KHVkEg1Z91yNiWkfZ7q4sz703Zy+qhbIK1va7mHS02yE/ugWHYEZxILfn
         4uIw42X+M/i7kHyWclvH8b5tnl94MQzN/yvok7wg7lh6i0NFvTJQC5ZcKzK2eHjl+3AW
         whnUZUVaKacAeG+UgZtFXxR/usewDOFimUdcIODBgrsGMIZ0jdKe85U2yk9MIpf+yUk4
         ttDg==
X-Gm-Message-State: APuU4Z9FQVHqX8OzgIrQpFGHEB1zeacnnnAKyig7G+raL6nkbfqYM0+H
	eqj+03VH7hjd6LlsWjzH5qhr+Xtw0KwIMKOHWLjWon8KIqcEVdymC1MH5qArtg==
X-Gm-Gg: AYBFou2dzB766GAp+OnC9gZpF4bixtOOATYddxsB3g0kt3HKH8CxZyFQDWTrMPbjNwR
	lEfk8lIBzMbnJKSi225afOun4cV+4yN8yrkqOKMMzwEGv45YlTBLM+qk4iUdQKReaxc9v+/fy9y
	4fIzIiX7r7qlVvqyi9zf/x00WDFYdZfrZpes+PeHU8GSt67BJgQb54ksKWZNEkuHxCPE1Wvdd+G
	BsE06e05H8l7T/PX/FKqPzKl6lT/yHjHO0Q11i0gW3LTZhXvSKe23bAHg6hQRUe6zfaUBYJGvks
	XgDWcOWA1xr+XRDbdQNdvP296nkaskiaox18GDKGQ1VFRSE17i4IeJE/1wQGFhG55O7xn1cULUm
	iCQNfwZEA87ezw4m3DgLX7IjN4iS2MMeaw0j738ASZMycb09FTbUjWIw2pW2KB+B6fpyoHVL1d2
	uiA47Rs0eVcdw7b1PgnI1b8ed+1H7a5HRI23YNkm5cuKBqKViiVu/vIA2nHfsnQST7BHYsEhgZD
	NG9Pxz7dD+te6pdraCoyLYKhoPf/qNuH9QZk6OYzQiJz6MDgR5Ay7jyaLcTG3Ag
X-Received: by 2002:a05:7300:5b89:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36a424c7b7dmr25790134eec.31.1793647953117;
        Mon, 02 Nov 2026 11:32:33 -0800 (PST)
Received: from [172.17.0.2] ([172.182.242.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm41859101eec.7.2026.11.02.11.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:32:32 -0800 (PST)
Message-ID: <6ae8e550.0c4016f4.1bd57.8ca9@mx.google.com>
Date: Mon, 02 Nov 2026 11:32:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8785418944442010319=="
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
To: linux-bluetooth@vger.kernel.org, yfzhang23@stu.pku.edu.cn
Subject: RE: Bluetooth: validate retained LE ISO command lengths
In-Reply-To: <179362071770.29269.17982398081263832695@stu.pku.edu.cn>
References: <179362071770.29269.17982398081263832695@stu.pku.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8785418944442010319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198784/

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      24.95 seconds
CheckAllWarning               PASS      28.00 seconds
CheckSparse                   WARNING   29.42 seconds
BuildKernel32                 PASS      24.60 seconds
CheckKernelLLVM               PASS      25.20 seconds
TestRunnerSetup               PASS      572.25 seconds
TestRunner_l2cap-tester       FAIL      11.69 seconds
TestRunner_iso-tester         PASS      13.77 seconds
TestRunner_bnep-tester        PASS      2.77 seconds
TestRunner_mgmt-tester        PASS      84.55 seconds
TestRunner_rfcomm-tester      PASS      4.25 seconds
TestRunner_sco-tester         PASS      5.08 seconds
TestRunner_ioctl-tester       PASS      4.20 seconds
TestRunner_mesh-tester        PASS      5.10 seconds
TestRunner_smp-tester         PASS      3.98 seconds
TestRunner_userchan-tester    PASS      3.41 seconds
TestRunner_6lowpan-tester     PASS      4.04 seconds
IncrementalBuild              PASS      27.26 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7bbc644e33d0 at pc 0x55c39ff30e8e bp 0x7ffd38a4a0c0 sp 0x7ffd38a4a0b0
READ of size 4 at 0x7bbc644e33d0 thread T0
    #0 0x55c39ff30e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55c39ff31b75 in timeout_callback src/shared/mainloop.c:270
    #2 0x55c39ff32aa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x55c39ff353fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55c39ff3a64b in tester_run src/shared/tester.c:1223
    #5 0x55c39fe6417d in main tools/l2cap-tester.c:3918
    #6 0x7f7c65443600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f7c65443717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55c39fe6ac84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7bbc644e33d0 is located 0 bytes inside of 40-byte region [0x7bbc644e33d0,0x7bbc644e33f8)
freed by thread T0 here:
    #0 0x7f7c65d813ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55c39ff3136a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f7c65d8260f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55c39ff1b2d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1041

---
Regards,
Linux Bluetooth


--===============8785418944442010319==--
