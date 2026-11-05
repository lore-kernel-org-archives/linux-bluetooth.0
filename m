Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846661;
	b=VGAOecf8mARdkqYveAN7Tq/6g2TPGetSwQoPpsz5o1r2+stCSwlxdN54gvlAZk8P83Bq
	 WWR2LX1ZxoJF57ZaGfPHbfMMSVTyc7Qqh3zTbUivMZh0rEx2YPlNHaqF5G+20TKuo+eA0
	 GXBrHbYkmH6FbL60bfUN7VdMWQqgNJS4o5z7Lg4tA6SCiZwW5DtH4iILzjkn0syu4+loF
	 jJ5IctKlPnnXX8tQojb1bzf+Z75wJOAfKHmr2N3C8mN6Sp9UCNM1dhjt34whle45g+VQG
	 x0F6y/xROvQjLYZMXzMNsjN+FuTpTg6j7Ey9Hg5hY91GJWXSV05Ti12DEwchtXnwVBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=PfzedAsSHDyV1M0FmrhzYD3OSOz2bNs3YbRNn92N14E=;
	b=znJErVju3BcHFCMOLZCKkAtsHeS+U7bu4+HoCKijjzp2GJgdNOwLDXWX34M+SdFI1uH/
	 h3jQf29ri7K3KXdKAa3H/DTHJZwV43NX2AqN3DgeTYAvql5lzQTQ2f+TVqHyIJ5SFFtRh
	 673bcUSlptZoFu0+5jX3wg0fMVCqEYqa8g9nNcEkkZ84+/kV9aXwwSJ78DgB798mbWsfa
	 U699+wbwrCBQuQRXUolK8+kfaduoIxFZhTCFVk4zG7tAG5ywnnP2K5HLBeSFGm/ELPJ71
	 98SdjkUkBAcbMu0Rm5RNc2kQ7gf/+lWwpiviLKwmsjMjpL5kjfLEVvU9qaAhRow9dvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NiP3MqO+;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86026606A326
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 02:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86026606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NiP3MqO+
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a2761c69fbso366327c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 18:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793846660; x=1794451460; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PfzedAsSHDyV1M0FmrhzYD3OSOz2bNs3YbRNn92N14E=;
        b=NiP3MqO+5WLzNScPj33nDiDN03IBH4Aw7HKNL6AwGZA5ofTw5ccmUt7zLW2SO6UAes
         NjVRPJZKgzHb6Ip0oOsHi+vIU88bav8wYS61l/9TRqp+7eKqc0daSNHXQg6cDDr6ZL6x
         fTx4ZQpUjluN3lBkRe1hvq4Dl6KFsiqMXuRIy4JiT3rM8d9JrJlc+glpvIaIL9FvDri1
         1enOP2RSMEeZvq3TqL6I3OOzLcEznCnc43JbC9Wj7BMcYLEVi2hwABtyaQIH5tRhnN6l
         Wd2zVFaHaMlHpULQWKAIubVqbqhN7drzr3WxFYkI9YLyE2TAJfX1XON5jk81AWVmi5Nu
         umxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793846660; x=1794451460;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PfzedAsSHDyV1M0FmrhzYD3OSOz2bNs3YbRNn92N14E=;
        b=NZX0AfBXZqEeyTX911kdJ1c5I4SlTXbyjE6fnWztt35/Ong5LEZaWzA+m8VCxDsIuc
         D64d4pnV2X722a+0eW1saBRCBfeXcVasjBqtpl7FUWn+mge0KNUBBZItXJWFeM7C79GZ
         zwZdgiNOY9y0qignwWP4lRnhzjUgonh2/0zOhTQrPlEgx9kQH9kv5jaw7Gw1ubDBZRVB
         AHBwbVzdEL8fK4p/yRzh6tfeDfrihA3xyGDwpTtBYboGOH7ILOoIzmUtbnhgKDSTLJtV
         ysUbSLDgEuWiwjb/J/Qlwx6qZI2FTn6VvRV+G524wOp4HvNOA9BF6hxnmmyahRCP6dWX
         KWow==
X-Gm-Message-State: APuU4Z9eYvBwYWQrdnGXFSmt6amH4096QWWvkBqk/oLe+LOLLGRN4WnX
	mTW+EOu0feCY/zVRiW52zTwaYmP70dYPa26rhhXHt/DlAlh2hEAl6q/LwwCDIA==
X-Gm-Gg: AYBFou16fd0Ev69qkNg5QpWJiqyehsStjTFeguTQ4vozVWNTc0SlbADWp1ORz+CikLt
	VCU2KmiCg7IVHEfmwDgccYM1fZuL2wrLKl2qP5wRuTvyhTqGBj34ce6xrCMGTaRWlyv2jeuBJQK
	5LJj+1ghdIXyp6NDRBvz5KPalFkLYcU8ktMDwlb12At6qq7L93TWVJXq3THX4ih8PoKBxV09IX3
	aG23P60qtP2XLH6/v8OAWzotfwJBqK3oYQf5Ffyg8k4OhFWmYgFI2oMHEM0tE/97sOxzLncPrNj
	iSoLEHepkK5PvWz/v+5nvJi0rYi6TcxLVqw6NVylXIzol8CANKmGjFDv5GaRwqbecNewo/uj1Zt
	lr2+QoT+Mv/dqwgqniZuh9h0yqGjpEo1uZkRJKeNWijFSzGY8dhmAq2X4gWKgncLo6JT0vbvIwA
	nifiCrvPymcnU2o60fxCAzz9tqPCUhBXsOUlv+lRHJTNKyySB3POt5BWwDs54nmltJjIhHTriH+
	vvahCk1x/exBvvykYFWTXbstpA8EHNrXxjW3mTyuz301M6/uDfPYRvJOVBsHd0=
X-Received: by 2002:a05:7022:2582:b0:1ae:e0f5:2cdd with SMTP id a92af1059eb24-1aee0f52cf9mr27246762c88.28.1793846659940;
        Wed, 04 Nov 2026 18:44:19 -0800 (PST)
Received: from [172.17.0.2] ([52.157.33.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b86fbesm12470419c88.1.2026.11.04.18.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:44:19 -0800 (PST)
Message-ID: <6aebed83.54e42a5c.246e68.763c@mx.google.com>
Date: Wed, 04 Nov 2026 18:44:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7653425108654940551=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: Fix not updating of hdev->commands[] after reset
In-Reply-To: <20261104221956.1207025-1-luiz.dentz@gmail.com>
References: <20261104221956.1207025-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7653425108654940551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1202519/

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      31.38 seconds
CheckAllWarning               PASS      35.58 seconds
CheckSparse                   WARNING   38.36 seconds
BuildKernel32                 PASS      30.73 seconds
CheckKernelLLVM               PASS      33.06 seconds
TestRunnerSetup               PASS      742.14 seconds
TestRunner_l2cap-tester       FAIL      10.67 seconds
TestRunner_iso-tester         PASS      21.63 seconds
TestRunner_bnep-tester        PASS      9.66 seconds
TestRunner_mgmt-tester        PASS      88.22 seconds
TestRunner_rfcomm-tester      PASS      4.47 seconds
TestRunner_sco-tester         PASS      5.63 seconds
TestRunner_ioctl-tester       PASS      4.65 seconds
TestRunner_mesh-tester        PASS      5.53 seconds
TestRunner_smp-tester         PASS      4.36 seconds
TestRunner_userchan-tester    PASS      3.21 seconds
TestRunner_6lowpan-tester     PASS      4.42 seconds
IncrementalBuild              PASS      29.12 seconds

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
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b69e63e33d0 at pc 0x564e45f78eee bp 0x7ffd6db81ef0 sp 0x7ffd6db81ee0
READ of size 4 at 0x7b69e63e33d0 thread T0
    #0 0x564e45f78eed in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x564e45f79ed5 in timeout_callback src/shared/mainloop.c:271
    #2 0x564e45f7b006 in mainloop_run src/shared/mainloop.c:125
    #3 0x564e45f7d96a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x564e45f82c4b in tester_run src/shared/tester.c:1297
    #5 0x564e45eac1dd in main tools/l2cap-tester.c:3918
    #6 0x7f29e7387600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f29e7387717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x564e45eb2ce4 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16dce4) (BuildId: 4b6cbb2e2c80ac13520eedc70b7cea5c676c63f3)

0x7b69e63e33d0 is located 0 bytes inside of 40-byte region [0x7b69e63e33d0,0x7b69e63e33f8)
freed by thread T0 here:
    #0 0x7f29e7cc53ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x564e45f793ca in timeout_destroy src/shared/mainloop.c:252

previously allocated by thread T0 here:
    #0 0x7f29e7cc660f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x564e45f63335 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1068

---
Regards,
Linux Bluetooth


--===============7653425108654940551==--
