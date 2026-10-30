Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378724;
	b=Zws8UJrDYtN3L4PJP0GLx5gaNPoOeHlUafkGV0/RZar0YGhfRndLQ5Yxjh5RRNPXhOau
	 3g6sScyL1Nxz7Zp6POnTpL3+C3h9iZ6r+52+65O+3SqHGQ9XFr9cUxX9Rc9nG6NYGFZJt
	 P7v0ZGk/H3QU+wYqWgFEe1IkGZxYTDJy05qTYB3G9u3yEvVuKmqCG2u8CYqJ+Nung3eNP
	 dekjXFhQZVpr6tVzE0rszRQmWEy6sF37R5/j6idBbq0vE/4tE4u80Q2/r4XxDO5j8JqF9
	 v/GjyDcHd/65OD03VqVd1A0mu+G545c5dBvxjBKsQuiwDmcLeNvbv5oASVH47sbWfHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=V2WY3Gdhxa5N6vrHuFcbs2PVmrsLTM4byr6mJKT54rc=;
	b=OJR4HFxG44Y6kop+IVKY1jbMtwUTREPGB6xnVl9T4YnxrGwWq013y0z7nxa/nhn1/2tE
	 Wnu+UoiNEXt+KU+j9iHLAeWhJ7CJSKr6Nx+bpW7ytczEvcqfLneZPAuPVCz69ySVhcQzG
	 4JLv7AQhQ1yUdyn9ACYD1mX0nbW5Pto68cq8K5g+Cav6reWH5xW1XVhGiVXK+k5W9Drj0
	 xcwnFRjljzTqzZTn6OT+xY9rPkC2Wqew/ALDMWz2KLBFoAtT70GZPUU8zTrbwLRDaI8Lr
	 8noNKdfv7Fwjmk0tPqECDa+p2E3vITgpKu1IHAWp+uZgE2Xw4xSjx+x61qZwYULgzQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vj4XR2Mh;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B8606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 16:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E46B8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vj4XR2Mh
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5361e313e63so9431541cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793378723; x=1793983523; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V2WY3Gdhxa5N6vrHuFcbs2PVmrsLTM4byr6mJKT54rc=;
        b=vj4XR2Mhh78aaeocBmgOS5YMLlZa0DulEWLiv/xpxtkzKGqgpx1LFh6+4mImpaNBSh
         wJQy1inHnliXJxp1F4nezBsiygc8rmYNhgGqhmic/Pm7Rh/HY07B29E56wgvHDXtxNQx
         GBZcdWQNkk/WGOa8HzU3cN5bbYO8FAUt7mb/2Vh+NYJkAZnY+I2T0qSSsBzunSW9W5RK
         wPsIwj4GGVyJYdKjJLblNZOyqGzZJ//eY0hQ4+9unZY2FZ80761iYp0vfRT+ktBALh/D
         o+kUkVL7Ulfqub8MREHRvKoJPavflxFUHrMt/gde0xFngyEO8IBxe0c8zz9KGJOu7AHY
         ozGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793378723; x=1793983523;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V2WY3Gdhxa5N6vrHuFcbs2PVmrsLTM4byr6mJKT54rc=;
        b=T30aFvRy85PQ3B2SAjiiGnsW+5zVobjwmBH/hs2Lg0ODWVx3xjih9voS0a/w13fIyY
         MzyvnklDitBbBBh1nXSYg+rVZ/KpK+bcla4TCIFSo/kcn9y2dJOFZJBYbZJ6Agq68kGF
         gYmEtLts5EYt/PPmfsMk2F6+lmj8OlIuCufWfklUxC1vYJuVBh4XNXA26nOcQT9tUMvR
         LuK8RdOxF6n5vRxNIR2icuxgda8fZop3ns4H1mOcEBPcmiaBdVMo+D2ZfvN8nXj4edll
         lUlxNT+dv11xiTUjlhvndiQxp91Vov2pBLMDY8jnjdwtlZxwcYgwAdZ0BKwOJfyczZUN
         98/A==
X-Gm-Message-State: AFq9FYIa06NirxiRNkwfFXrP+eCf81LQjILQzOeED/mPh5z8LowKvEoM
	2gf3IIK0j2VrTJ0a587qYnPQLDHP9Dp2mWZljLmEasZTqIvFovw983OKVF+wKw==
X-Gm-Gg: AYBFou2MvsbZIuOtJG5/b+zzplJL9d8TheRg45ND1HSVx8iDwSjKdMH4SMwbvjAsQyt
	8Ms3fvfXz//fC2qg09LXJB55JSW9UU7y3rknR/3Gp2NwrcMiUu9N8Hwu2vKNXLn0drBDT8yO5Ar
	0A/f8LtigsPIbeWFcTZaja9TPdTcAiSNJDrAUmQLOlc9qQgukh1Dx7psOGnLlm617jIwdwIW0Cr
	xpIOyO4O1jmyDwYGR+G8m0vx+7XzHtwU1BQvspw3ZxvKnUVFStkM1MTKEl5m3xhADhxnUpQrnYc
	+7pfikLNffGU4iuPfaijFOoHMGMLyVQzrrqth8kcZqdgTCdnGRxySs3fRPQ+CDuwnRzyb90dwdq
	9ww+oU/mhR12BFOXJDwrRCQ0itSKxp2zvR77OS4ie90mSUHRvYhj1YfCRs2MaCeYhyt/0NNBRsS
	WCzPh/rHHa+bltB9cYpXxlq9jioNljUo7vdZuDwsTy2zw6KIPzh8eteQzQVqa4dBePCwzKcZHvf
	slZXqkItqu4iZNH5/KwLBgD9+nxn/FOp1oeFUNOB6+Cmb0U/1h/FOeNM9PX1A==
X-Received: by 2002:a05:622a:3d2:b0:536:8f5a:64a with SMTP id d75a77b69052e-542b7d07d77mr43674821cf.63.1793378722637;
        Fri, 30 Oct 2026 09:45:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.47.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f401f5sm19469056d6.19.2026.10.30.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:45:22 -0700 (PDT)
Message-ID: <6ae4c9a2.5a092a7f.18d9eb.fd21@mx.google.com>
Date: Fri, 30 Oct 2026 09:45:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0606395642444491851=="
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
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: Fix advertising instance accesses without hdev->lock
In-Reply-To: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0606395642444491851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197214/

---Test result---

Test Summary:
CheckPatch                    PASS      2.33 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      1.20 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      32.04 seconds
CheckAllWarning               PASS      38.53 seconds
CheckSparse                   PASS      38.36 seconds
BuildKernel32                 PASS      31.19 seconds
CheckKernelLLVM               PASS      33.38 seconds
TestRunnerSetup               PASS      744.07 seconds
TestRunner_l2cap-tester       FAIL      12.26 seconds
TestRunner_iso-tester         PASS      10.88 seconds
TestRunner_bnep-tester        PASS      3.17 seconds
TestRunner_mgmt-tester        PASS      88.75 seconds
TestRunner_rfcomm-tester      PASS      4.54 seconds
TestRunner_sco-tester         PASS      5.70 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        PASS      5.59 seconds
TestRunner_smp-tester         PASS      4.42 seconds
TestRunner_userchan-tester    PASS      3.77 seconds
TestRunner_6lowpan-tester     PASS      4.47 seconds
IncrementalBuild              PASS      33.64 seconds

Details
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7c0212ee33d0 at pc 0x560ef2fa5e8e bp 0x7ffc4e083ff0 sp 0x7ffc4e083fe0
READ of size 4 at 0x7c0212ee33d0 thread T0
    #0 0x560ef2fa5e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x560ef2fa6b75 in timeout_callback src/shared/mainloop.c:270
    #2 0x560ef2fa7aa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x560ef2faa3fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x560ef2faf64b in tester_run src/shared/tester.c:1223
    #5 0x560ef2ed917d in main tools/l2cap-tester.c:3918
    #6 0x7fc213e7d600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7fc213e7d717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x560ef2edfc84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7c0212ee33d0 is located 0 bytes inside of 40-byte region [0x7c0212ee33d0,0x7c0212ee33f8)
freed by thread T0 here:
    #0 0x7fc2147bb3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x560ef2fa636a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7fc2147bc60f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x560ef2f902d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1031

---
Regards,
Linux Bluetooth


--===============0606395642444491851==--
