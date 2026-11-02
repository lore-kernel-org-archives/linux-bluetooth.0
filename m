Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647920;
	b=htOGOz30i2zpcM16yKlEwi28+xsavT2cwh5Z8nKVNR9mocvmmIoXcuyuSBM/D7uxdsmM
	 DBWADbpx5DKrBylXjTOc/AMho5NBfI9D3zWA7GDMIpVF8Sg1qvK/mOF/qa4TVx08Slliz
	 QgV3lPMBqhEnfgpMKgKYBla2oAOKlD4A+7BvuV41fSNLTnNx+fS0/8cDjOUs5SWn8Z/QD
	 OEmIdwIRWWifY4AkImy1BzYeTsvWPpI8ntGFoRs9FVtDkWws+EKt9Xly2stiqisCFtHt/
	 6gj5aN0gjVunsipT4m3xYSO+IofheHfA1Hyqh8Gw6RKcsq7p6blg2M06r/1xir3u34Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=AEUQzDuKA9cruWL10Y3xYt3biaP7eX6lPUTvlzpo3MI=;
	b=gv/y+wWGfwxiPqI1KJXUgaHHDC/iI/DxS2oJbTOrtjNbPv4YUoG9+hTfa4KY2AVQfwb/
	 BagUbfrKpqCjGHi4kV7BRbDz9iwZ5g/UBLILi4WKER3vneEh/tf2uH5Rt0LRA09glkR83
	 rNFfqFWuw/J40Z5iDqMS5Otfv5mtPgavjPzdcOybGvCAiAMQXoiNkloLiwtoTY1Ckf2Tp
	 aoY9IMYnjfG61kSJ70QE0MK60vfDS93HDKzNqfHNvhxv3J6jdm8PXA8GFZlkLhOaSP6pu
	 695ier6OMAFyqlWiKpk+8opn6wMgYi/vjoAYdQpkyyEHJyrCQ8VG2odV+k70WLXO+7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ED6ind7U;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29602606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29602606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ED6ind7U
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53669f7b518so43255371cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647919; x=1794252719; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AEUQzDuKA9cruWL10Y3xYt3biaP7eX6lPUTvlzpo3MI=;
        b=ED6ind7UV1KHFcgKcypHWJJXfCLOXKUc2LGn/7gEZn8Waf7SM8lDSHdRZcYCzoP3wc
         7hORyCqIJHVD1eE3MZF7wUPC+ZeJfwf072hClmR1eq1rphCRHV3oIb5+Nge6xotrMTQz
         oBNbIMq4vgc2j9UBs9gchdHw6L4Hvjhgse7MhYVd4SFooCrXQ1SvAlRVayFT1N8EWLrK
         Nf4Oz7lStV/yoLMBGS1LwWsZkl8locZnmeP/gf7QwjF230HKPaCHxtwGMUFc6jkFh208
         T1b5M1hJhfOeIGKPdatYy5KRj5WgbkPz7pQ+lQ9k6mSYiLxKUS7QikCCoADIoCl/A9lp
         +eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647919; x=1794252719;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AEUQzDuKA9cruWL10Y3xYt3biaP7eX6lPUTvlzpo3MI=;
        b=clPzkPEyd2kRENmtv2ManyZMU26UF6UVOABzc3BhCnZWme50xNpcCbBnwQH/wi9s8D
         Bs+cWD0qnvElz1ZjzqzZQ1JFGpt8NQb6w+hKXAKipc14gxqGqdRFdu5FDn3mPwhbZNKa
         Oa+P0M9jNx9OdeVcRf8zzzIvLcQ7xhi3QBA6zKmOdWrdqnV5tolwVAJwFVkzYYABkkGU
         bBNoRO/aYMzVGiLv/hFyypAHTJlkQWvgySeKrpoFCDloBLwQaDQXAbqf4ad2ZY3V2tmx
         taiAyXdDU7Exta8JF3J/qPtMe/drpOC05uTnYUr8YjDil7O0ndR6iduqWQAw9kWLKAdz
         cpxg==
X-Gm-Message-State: APuU4Z9UlPsrqqtTbM/519nvtD/QH1bjXaJGS1VAgd5lzxn71UWiDynO
	jRGgRnMdd4zGBK3lMKfQ3ntyaOviEGXyYHEF3b08kNE/4I8aNTwAnkElZHW5TQ==
X-Gm-Gg: AYBFou1SIFvDrq5pdpLuhEB/kbG4fXNHnUnahsq0t+40nsS9FXnmKAqjUoAy+maFFrE
	TOO8Iy5G+eGtP6Mfwi+aREtyJldCb1jcaRL1xEeCRE6YWJKBXdJXsEnxISbOGt745DLq1XJu9xb
	RWlZdx3DjF71V970ZV7jpFSI+tZU2LfmvaAYpFgBIExm0q24s/3d7Dppq9CMJaqRvIOoDSDT7Ft
	7z7t7JfNsDxtzm9TmpJAJqZPha1blP005mVq84QYO4pAK+XW4CDdYQrZDGTQk9q7beBF9ofeS8S
	AqWhdPLzsr/zaZqTWHH6TPOV42l/9uA3TBRkeSwXGDqxrRc2OEyBV3eVEvIw7OQblNRJaLAXmpb
	TQwtPc+rGw5sReHTUs82t/dKbdbyEWBIGWK9A0A/0V7EodBtKyEUWqF+7nadBEiu6yuwjM+utZ3
	xhc98cOjqqNiI0NnlGFfl/uLfPv+JaMsabvsD3r/zPtxsoE+9RdbQuTiz6g+57htMxnrSASZJce
	oytHPzym2iXGR1f5HBz1q86Gz2R2Aha/yMeU46jhpfwIEpIObxj2kqcjonmmeE=
X-Received: by 2002:a05:622a:c17:b0:533:8c7e:c6ec with SMTP id d75a77b69052e-542b79163e2mr191176291cf.36.1793647919007;
        Mon, 02 Nov 2026 11:31:59 -0800 (PST)
Received: from [172.17.0.2] ([20.62.254.135])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498cc59c80sm5611371cf.27.2026.11.02.11.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:31:58 -0800 (PST)
Message-ID: <6ae8e52e.f8c2439b.a78f9.58ae@mx.google.com>
Date: Mon, 02 Nov 2026 11:31:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9210586755197215895=="
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
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [v2] Bluetooth: MGMT: Send Connection Subrate on LE connection and update
In-Reply-To: <20261102170008.62788-1-kevin@simpleble.org>
References: <20261102170008.62788-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9210586755197215895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199296/

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.39 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.48 seconds
CheckAllWarning               PASS      28.60 seconds
CheckSparse                   WARNING   30.96 seconds
BuildKernel32                 PASS      28.29 seconds
CheckKernelLLVM               PASS      26.04 seconds
TestRunnerSetup               PASS      563.62 seconds
TestRunner_l2cap-tester       FAIL      12.19 seconds
TestRunner_iso-tester         PASS      10.88 seconds
TestRunner_bnep-tester        PASS      2.89 seconds
TestRunner_mgmt-tester        PASS      84.46 seconds
TestRunner_rfcomm-tester      PASS      4.12 seconds
TestRunner_sco-tester         PASS      5.20 seconds
TestRunner_ioctl-tester       PASS      4.31 seconds
TestRunner_mesh-tester        PASS      5.24 seconds
TestRunner_smp-tester         PASS      4.09 seconds
TestRunner_userchan-tester    PASS      3.10 seconds
TestRunner_6lowpan-tester     PASS      4.45 seconds
IncrementalBuild              PASS      24.66 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7bcb0ebe33d0 at pc 0x55a2b2510e8e bp 0x7ffc6b145df0 sp 0x7ffc6b145de0
READ of size 4 at 0x7bcb0ebe33d0 thread T0
    #0 0x55a2b2510e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55a2b2511b75 in timeout_callback src/shared/mainloop.c:270
    #2 0x55a2b2512aa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x55a2b25153fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55a2b251a64b in tester_run src/shared/tester.c:1223
    #5 0x55a2b244417d in main tools/l2cap-tester.c:3918
    #6 0x7f8b0fad6600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f8b0fad6717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x55a2b244ac84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7bcb0ebe33d0 is located 0 bytes inside of 40-byte region [0x7bcb0ebe33d0,0x7bcb0ebe33f8)
freed by thread T0 here:
    #0 0x7f8b104143ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55a2b251136a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f8b1041560f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55a2b24fb2d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1047

---
Regards,
Linux Bluetooth


--===============9210586755197215895==--
