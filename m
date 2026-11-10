Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309462;
	b=Gez+AkH0UWynuEKQW0IpGTvIUAkttekVvremGldK+TDg3qR1uviM8rm7pS5yUpOdIMQL
	 JQUR+2JdAjW2nFA6RUDBdnIlrJxOkxCWZg8otaJNNTn2ZmoLZqHbFlryC3uKWOxFeX2RZ
	 NViHydQ017C0HrdtPboVYzynB5qrpG207x6U9L/GmAboiVQ43I8T5NBJhJffbfDDoug4R
	 IVlv+T+DtQFuEP+cTzsiKD3CYCjjBfqal14Gs6LD/5NZqH0eyZ1w87DBQH34AB2BMMl2+
	 JZyoMIcIaYpw1jhku4IRsMj5VTFoXo2eWHWW0xXY50QDUG/i6tgJCcHRF0xX2yx3Crw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=yxxfMKWUFIlJbk/MJ8Xd4i2wW4h+IN8vVVg5Msw3Ifk=;
	b=p0dLZxfIPhrdeOpr/0UJggSMFVb1V1WhvXmZ6SuF8bSytMchbl6nKgHnGl9egpA5R3Qb
	 owLS9rq0e3CYOVn350nwkhu/v7n48jeehtaNiI5Ezw+mnzZyXbW35QnIvOSO3Xv6rsW/0
	 OM9jXNZkrqismScTIOY9V2Yr7EptlJrqSh8cAaVy3pnW+c0smN9KMkUgDoc6cViQrCdgx
	 JKk0Ya7db63/7xOpS8kygMvGjnt2P8dx1AxAjE6jNtSIFy3dxgCrPU+9i22I+IMDMqNwY
	 9jUBQUEiBAd/Sy2v0E5FOw8F176l3to/ol0nyOxThAEyPaNNOpXIVIDH5wspftVrOjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=joYTsuFC;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AFD606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 11:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39AFD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=joYTsuFC
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-7143451981fso1227679eaf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309461; x=1794914261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yxxfMKWUFIlJbk/MJ8Xd4i2wW4h+IN8vVVg5Msw3Ifk=;
        b=joYTsuFCuLrc/zofbFkMXMZPFL1EBin9Z+uNCBdcgL6ZZZ0MNB+7EkIc+s2qvfv8C0
         C4etxaE37BZy+AsvlbTw7e26STMmS99841LP2s1HWY7OT76JAEzVRy2WgPfT/n4hqMYi
         R+2sWG782gAke4TzupeGl9VGXqwMsDFLuvfrItTf7ASgvwEri1Sv6lITatKxGj32pS2l
         idUwSWQM//V6leItiGrkyvsdl+iR2YL6zW6RNSM1y81xDwtInGLsKfjrIZw+P39CV2u3
         tbdlyvETtJq5MUNhjzurVO53BIMhvGBHkqdtpD8TyK2VfN7l7Q7F8L9VNDRmNVbReAYJ
         SVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309461; x=1794914261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yxxfMKWUFIlJbk/MJ8Xd4i2wW4h+IN8vVVg5Msw3Ifk=;
        b=zWKdS9SeSq2UidscU4GKjKqwGIY+Zq5iF2UaSNJaKM7MJ1un5Nrdtplbt8k0E7BEW4
         UyvtsXIj/G/O95oSqlyReaXuV50k/oWqzD4Nyhv/wirnJPIcMukcyIrMc6IovM2QYe1i
         wyNOlUqVM5l1z9FpnMdtAiAy4zb78sQzgaO23QVd9rscLycoPfdXhlS4s17mpGPo2kOf
         bmf9m7voQlYzaNDowDfPp8ZT1WbWsxL8Tlx9rdKFrE7ZEp5rTmCh4/+MoH9DtnacEGdG
         wRbADboH8/bQbvjjyuMsyi/gYhO+QgKrH9hfjszcTa83Wut3Zwt/JpfCsPbSfEFvn4tz
         1mXg==
X-Gm-Message-State: APuU4Z/zhZlWYLTXtkKNAyYEvaJVw9wujrpdBSsUWuCS+04rK+jmgFSd
	zpdJ9eWX4Q8douRB5zHBzviQVvKzIcBG1RE2FXzq7kOZRWnq9SxpgNWQZXEe/w==
X-Gm-Gg: AYBFou3xSTo3e+QFFbeLqd0C+d2Dysgels+tbGmaFMmUGe6PNlosBExXQRsHBju4M/m
	j5esxRxQbllKtL1kee3mKcGrbkSf88NzuiXMNGoK9LsKria3Io0HJNy8dRI0FXYJgb8+QkYm2pc
	UExdW06PJcBn3Z1K6Ip0NkSwhdoGZWDLaDVf/1JadMSlMPfBcFMmATCYmxr7LImEgNY4/7r/DES
	WfQR+IjgXbAYsyLchYipG1FwrLd76WY0A/yKjyN4Tw9l++xyN4qNNzllN2n/dmtUJz903zsIGlk
	uyQgY6RqeBUXpKS57kablsMGDCr3Qn6JhiyvY/7Zd2iF563o62iV4bYeezjXq3oi43W4YLRof3o
	cbethbctFPgWnO039o8T+jNa+MnbAdG1U9JR1uyuQZWsRNbyvzT9c8U+zJjPA1OyFUi78gVp+2o
	f5B3UX6+YCQMYBrul+TXxPVXrMGh6512KV4GpgxA7TKGgvb1Tl73z6VZ78YvJFRh825UACzm9Fi
	IjzT31sdLOCNuUeybCT2Kuwj1ylKh4IPqwMO4QW7H5nbfUpPPrgjkctEMoAEZFaTF8sao/tq8Es
	nWXGrB2r
X-Received: by 2002:a05:6820:5713:10b0:717:da:ba40 with SMTP id 006d021491bc7-718a5a58999mr740166eaf.26.1794309460882;
        Tue, 10 Nov 2026 03:17:40 -0800 (PST)
Received: from [172.17.0.2] ([48.214.151.86])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a9a468b1sm1402583eaf.10.2026.11.10.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:17:40 -0800 (PST)
Message-ID: <6af2fd54.51100f89.b9f51.7c42@mx.google.com>
Date: Tue, 10 Nov 2026 03:17:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5331792926583841117=="
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
To: linux-bluetooth@vger.kernel.org, piyus@iiitd.ac.in
Subject: RE: [BUG] Bluetooth: stack out-of-bounds write in eir_create_adv_data() and eir_create_scan_rsp() when a controller stops reporting LE Extended Advertising (seen on 7.3.1)
In-Reply-To: <CADq=QSx3zruNoQ41d7iza=WcTikx9uxkrXQ50cXWugrYeVMb2Q@mail.gmail.com>
References: <CADq=QSx3zruNoQ41d7iza=WcTikx9uxkrXQ50cXWugrYeVMb2Q@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5331792926583841117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1206772/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.10 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      23.29 seconds
CheckAllWarning               PASS      27.44 seconds
CheckSparse                   PASS      29.76 seconds
BuildKernel32                 PASS      24.16 seconds
CheckKernelLLVM               PASS      25.02 seconds
TestRunnerSetup               PASS      546.22 seconds
TestRunner_l2cap-tester       PASS      13.15 seconds
TestRunner_iso-tester         PASS      11.47 seconds
TestRunner_bnep-tester        PASS      2.92 seconds
TestRunner_mgmt-tester        PASS      83.84 seconds
TestRunner_rfcomm-tester      PASS      4.13 seconds
TestRunner_sco-tester         PASS      5.19 seconds
TestRunner_ioctl-tester       PASS      4.32 seconds
TestRunner_mesh-tester        PASS      5.18 seconds
TestRunner_smp-tester         PASS      4.04 seconds
TestRunner_userchan-tester    PASS      2.96 seconds
TestRunner_6lowpan-tester     PASS      4.10 seconds
IncrementalBuild              PASS      22.42 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BUG] Bluetooth: stack out-of-bounds write in eir_create_adv_data() and eir_create_scan_rsp() when a controller stops reporting LE Extended Advertising (seen on 7.3.1)
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#144: 
In both cases a 220-byte memcpy() writes to a 31-byte buffer that is part of

ERROR: Avoid using diff content in the commit message - patch(1) might not work
#459: 
@@ -1609,7 +1610,7 @@ static int __hci_set_scan_rsp_data_sync(struct

WARNING: The commit message has 'Call Trace:', perhaps it also needs a 'Fixes:' tag?

ERROR: Missing Signed-off-by: line(s)

total: 2 errors, 2 warnings, 0 checks, 59 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14967012.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BUG] Bluetooth: stack out-of-bounds write in eir_create_adv_data() and eir_create_scan_rsp() when a controller stops reporting LE Extended Advertising (seen on 7.3.1)

1: CC1 Body does not contain a 'Signed-off-by' line
1: T1 Title exceeds max length (167>80): "[BUG] Bluetooth: stack out-of-bounds write in eir_create_adv_data() and eir_create_scan_rsp() when a controller stops reporting LE Extended Advertising (seen on 7.3.1)"
380: B1 Line exceeds max length (90>80): "BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440 net/bluetooth/eir.c:303"
383: B1 Line exceeds max length (99>80): "CPU: 1 UID: 0 PID: 14158 Comm: syz-executor Not tainted 7.3.1-g41f174fd422b-dirty #8 PREEMPT(full) "
383: B2 Line has trailing whitespace: "CPU: 1 UID: 0 PID: 14158 Comm: syz-executor Not tainted 7.3.1-g41f174fd422b-dirty #8 PREEMPT(full) "
384: B1 Line exceeds max length (93>80): "Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
415: B1 Line exceeds max length (199>80): "Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00"
440: B1 Line exceeds max length (183>80): "page last allocated via order 0, migratetype Unmovable, gfp_mask 0x29c2(GFP_NOWAIT|__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_ZERO), pid 14157, tgid 14157 (syz-executor), ts 13167688309676"
496: B1 Line exceeds max length (90>80): "BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0 net/bluetooth/eir.c:360"
499: B1 Line exceeds max length (98>80): "CPU: 3 UID: 0 PID: 9585 Comm: syz-executor Not tainted 7.3.1-g41f174fd422b-dirty #8 PREEMPT(full) "
499: B2 Line has trailing whitespace: "CPU: 3 UID: 0 PID: 9585 Comm: syz-executor Not tainted 7.3.1-g41f174fd422b-dirty #8 PREEMPT(full) "
500: B1 Line exceeds max length (93>80): "Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014"
531: B1 Line exceeds max length (199>80): "Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00"
549: B1 Line exceeds max length (82>80): "page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x7f93bfa2d pfn:0x5b5cf"
556: B1 Line exceeds max length (179>80): "page last allocated via order 0, migratetype Unmovable, gfp_mask 0x29c2(GFP_NOWAIT|__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_ZERO), pid 9584, tgid 9584 (syz-executor), ts 209124958665"
596: B1 Line exceeds max length (81>80): " drm_fbdev_shmem_helper_fb_dirty+0xcc/0x1c0 drivers/gpu/drm/drm_fbdev_shmem.c:117"


https://github.com/bluez/bluetooth-next/pull/1101

---
Regards,
Linux Bluetooth


--===============5331792926583841117==--
