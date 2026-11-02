Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647777;
	b=2vW9tFG7m4a8AoWnh7BkLwGlwb3pusiVMMrlD8UX+bPgjW1Ust6bCq8OwxniizjvaPA8
	 d0/0S1EssJu9Jom2flimvv5fTulp9troVBiGK0s4fwmsamNltWywAwbirCM9fyRSE/4uK
	 sucds1AuMNBd6XlkBC4HBQWKwWo5Mhk7bSbFH3qlLQCA6omXt379qOiLhPnIzmEWirrfx
	 CvdrroV/iycN/7RKOOHhrEnKEwpbOxey1Ud+HpN+ID3eHdsm0QgXCcOqS7IymdDUliRdb
	 fqVHQGmgAkN5tukybIJoOQ+6Lm/dJ8K3DagdGuqlDQf8Rz6jb1TVAF/OtKyZMUAeglA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=y7zuAChlgtC0NLckRkSIfIMUi0baTIWqA4oN7DmbRaU=;
	b=lrjwBx+y0i0pdiR7imKwDPP+z6Ifu6nmTVi4dHzEUGR4yZCbjz5yurmjJD/bmciTY7Ti
	 BSn0JCMdOXLX/7PdyWVarKEWNLTLvRqfuK95FWjhb97qzG3hY7kl7Mb9sUeoKA0e/2ESI
	 tlL5R7dzzKp3wKa2QsLOSgQ48CdYE52SpY3GoBhkNGxBd09tm6SM1SOBMafy46G4aKiPR
	 XLwCEioFGs6oC7kBadPuocKbS54XaLzhvuFPVPEsct2doHsEq725+R8IAD/II/0coY/rF
	 DagtVmwm/hY2WgOW7cG8yvCXOGoT/nimPfyZYFpEJtyygSvnUIGnuOoDxpnrhWYt9pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V4NV8xmG;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA8606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3AA8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V4NV8xmG
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-844a8bf7e25so2385778a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647776; x=1794252576; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y7zuAChlgtC0NLckRkSIfIMUi0baTIWqA4oN7DmbRaU=;
        b=V4NV8xmGCB/bZXbJoUsGh1evMi+JDoNlK2VMKoHqWrYES0tAkAbwEA/wVSb8Hpy7hb
         moAU23/pBC6vmxjd4M5zbCFPhwwg7wF7uUkgKV71VvBx1QOjs7yvwzanwTQUG8PL1BDL
         V9ocpSBwLbVFW2m9/y/LzCortAjenaB+ZWdz8n4+gorHQ8WBnasb1egyIJvfrGQYDkMg
         GeAbWJ44HNF2+b+0V3YzwfHjMmN+NyFOyGqujztsdps9B80kruArp4ZBOzV6LdWZMXHs
         py/Dr99IP4vMKyvbxSnVMcDK4T28curK2IfijHqU/RWgUotGIRyGVRH0956LlBidm8xh
         hXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647776; x=1794252576;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y7zuAChlgtC0NLckRkSIfIMUi0baTIWqA4oN7DmbRaU=;
        b=sdiYbf3eVYOFLxTKhfVjZO24kInQUcic/D1zWeBxY7OnTKlldHg/OPcPAVBxRVGyge
         LhDfVpuJ8/gLQoNj7itN6uvm/FPBn77VxjKhfBe2Q+y32zoTPB7Kc+H/H7IxBUaBEBJs
         soWC729a8l1yEePGo7P2VvC1yeIVVC79I32K1vtbBZk9HxPNLHCNO1ePlMzuMKa4Gs7/
         FiwgM8h+8zBXbW2bX/pwNmPm4vgegtNGIodP3JDp7IBwz0BBR8Sa7ct4X044BiM2fKv7
         kP2YChmVZmWnEGgIxfJZ5gOfYPoctaxalpDX7RSGokGakltQcv9Fha1aD75LUwZd5L+Q
         TCdw==
X-Gm-Message-State: AFq9FYL9Qm2MHA1AO4SSG5rz43XRAxqMXQZE73aCiqucO7fRcwOgzpcj
	5wWs/3waTH43ZSIQt4DDxwXvpcCfsQiN2ibwXDFh1X6l40Mj8dzFrNzbcDrtCw==
X-Gm-Gg: AYBFou2LG3sr3m7LUQ9jJTcg9B8zHVQ/zm8zdIy9tHoLsk1tFuohG15Wa4TT5Sa+LDc
	v/TCL6W+jB42oM6L6FShCQKF+AQA+hO6qMHhc6cLndjo1FlfEmKZPSUSa4RZWLe6gWf7pvW3jzv
	gkczvm9jZl6PVWjzBQsX6EeoDyIEsoElvO1/5t2NJUde/xeGEeBIpQ/Rg0PdclZE1FOEsnyclZY
	uji8lxpaVf/TqCDh2sV25NOwfRWAHRq3QpELY5q3TSnYCLFrhwBI0eOWqPDnS1S9RW5A4ibos+y
	VTz5LNpyc5IIShWA+IXOkocQszEDD+3Jo8ble8hh/Rno4hE1z1BRnGck7FltFzG5UQPOjw0Hq/5
	ybOahiIyRcInwcQbWWmLssVWNFGGFaeWL0S16MRaOMPcaBBLV6oNgqleV66y+SmLAdhsZfso7qI
	AUPI8IZgU97dzVEVZVeCBB9TAVdZRsEllyECkxjylN1a0TfRulIGLPon4icqdmhcnUlCYrs4mBW
	OjOjNZMDn3aT1zETtfUtU35Wfj4r/HHDKIin9EDMEwGLbcQKT+QckZ173IT2ZdUQjGMlXEsCCuS
	Ga1o8wc=
X-Received: by 2002:a05:6830:71a1:b0:845:8d86:9f88 with SMTP id 46e09a7af769-85d363e9c41mr7795102a34.15.1793647775836;
        Mon, 02 Nov 2026 11:29:35 -0800 (PST)
Received: from [172.17.0.2] ([20.80.86.192])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354f6601sm10201553a34.21.2026.11.02.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:29:35 -0800 (PST)
Message-ID: <6ae8e49f.8f9f3ad8.7b6f1.58ed@mx.google.com>
Date: Mon, 02 Nov 2026 11:29:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9050848666348174984=="
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
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20261102-block-as-nvmem-v12-1-f4a2a681087d@oss.qualcomm.com>
References: <20261102-block-as-nvmem-v12-1-f4a2a681087d@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9050848666348174984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199253/

---Test result---

Test Summary:
CheckPatch                    FAIL      6.22 seconds
VerifyFixes                   PASS      7.99 seconds
VerifySignedoff               PASS      1.42 seconds
GitLint                       PASS      0.62 seconds
SubjectPrefix                 FAIL      0.31 seconds
BuildKernel                   PASS      20.57 seconds
CheckAllWarning               PASS      24.52 seconds
CheckSparse                   PASS      25.22 seconds
BuildKernel32                 PASS      21.19 seconds
CheckKernelLLVM               PASS      20.60 seconds
TestRunnerSetup               PASS      472.16 seconds
TestRunner_l2cap-tester       FAIL      12.07 seconds
TestRunner_iso-tester         PASS      11.27 seconds
TestRunner_bnep-tester        PASS      2.80 seconds
TestRunner_mgmt-tester        PASS      83.15 seconds
TestRunner_rfcomm-tester      PASS      4.02 seconds
TestRunner_sco-tester         PASS      5.02 seconds
TestRunner_ioctl-tester       PASS      4.19 seconds
TestRunner_mesh-tester        PASS      5.04 seconds
TestRunner_smp-tester         PASS      3.98 seconds
TestRunner_userchan-tester    PASS      2.87 seconds
TestRunner_6lowpan-tester     PASS      12.85 seconds
IncrementalBuild              PASS      38.56 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v12,2/2] block: implement NVMEM provider
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#266: 
new file mode 100644

total: 0 errors, 1 warnings, 194 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14936682.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==38==ERROR: AddressSanitizer: heap-use-after-free on address 0x7c37651e33d0 at pc 0x55ad034d8e8e bp 0x7ffc16b95f60 sp 0x7ffc16b95f50
READ of size 4 at 0x7c37651e33d0 thread T0
    #0 0x55ad034d8e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55ad034d9b75 in timeout_callback src/shared/mainloop.c:270
    #2 0x55ad034daaa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x55ad034dd3fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55ad034e264b in tester_run src/shared/tester.c:1223
    #5 0x55ad0340c17d in main tools/l2cap-tester.c:3918
    #6 0x7ff766178600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7ff766178717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55ad03412c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7c37651e33d0 is located 0 bytes inside of 40-byte region [0x7c37651e33d0,0x7c37651e33f8)
freed by thread T0 here:
    #0 0x7ff766ab63ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55ad034d936a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7ff766ab760f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55ad034c32d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1045

---
Regards,
Linux Bluetooth


--===============9050848666348174984==--
