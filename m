Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781967;
	b=TbIRl1Sh8IQc5Q+Y1iBEU5fhMTFdcIox68f/DtUK3aQwbIOYHE4yfNz0gfKT0Gzlioyr
	 SJb/bgIZRpLjxKEgJyg3YSSSFSo7bP1ZnHfKUMteomNIXwwHHHxgiR1DpCKnYmgBe4nM1
	 KXpKzkgusMCNexn5r26jOTL595AQXcUVEzrE3ttpw969nMBhQ0dab4yCfE+MmyABz9NIq
	 jAF8T8k8nUQxJ1FjwdbVX/fEGEfL184Q+dfhCFgK3Fwb5xDaH7wj1F+4ipWQG6I5VUR5Q
	 27UKr+CUCLxph1I4bpCBxNIJYSNgDpZwgNBf3cgfEfMKqy+IF6shY9SeP+MkEyt40aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YfH5mYdi/ryXoRuSQdW7W7RoILssnwfpDzglMPSGdwc=;
	b=aFSul0Nm/Ag75OGSEoNumZrXZ5FKbZz/aZU72lVAaNhFkPG2M5eI8S7zaTOqez1QF5iK
	 cLFXlDozZ0phDJ0OXgMzeHvDsQQpDeP3uqOrgjspJGhKnbFdReEXLYFKgSYKBsfFEOFJY
	 YaZ2+0Wqt9Ywp4zeox1t+Dozs3Mv/601xadEiMr3bggSWZVYiAwUGa2yGQ+XgAHWmjWE7
	 LKUjUcOk5qW80xcjtqOBpFASeialKJUii/M3ghTfcpOYwovZYMjeA1nnUuMgxKl31iu7A
	 Zg00vfzqwmf6KL+6lZz5FXj3JqGwXRawBr76p2pRdCymzN1nGvvusbUgkhu1HA+3MKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jUTKYANV;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD22606A32E
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD22606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jUTKYANV
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-539a57a0b1fso159462b6e.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 00:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793781966; x=1794386766; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YfH5mYdi/ryXoRuSQdW7W7RoILssnwfpDzglMPSGdwc=;
        b=jUTKYANV2l+rtIn8IcjPE64UiilJG3a+oN04ZtKnTXIlr0NlQVX8OftWDF1OQ8jPhY
         mqD/+17zYLoeuHsd5mzIb40ED9rhXLejbnP1+jmwpfCIY9LTdXAAEYFehbEb9aAxzNXs
         hLkjq4UAsVj9l3bC0jz/8XqhleHFF6GnwHbPxAEiOUrsadqebBfzFBOQlmjMwcOLCZqx
         2r1u8fI3U4OfzuO9i/1OgJ/yNhqB+GtJJoxGaOFcp19+q+tyWIcLe0R33rq4S5L4Bar8
         BASwpH9/R89kganxpvz0GpSJjvYCNtWkV1WLqCiMCJOixCDoWodnQkUGQY+Ocs2EX1QB
         RRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781966; x=1794386766;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YfH5mYdi/ryXoRuSQdW7W7RoILssnwfpDzglMPSGdwc=;
        b=CXnXvRIGTcpqv/ajfgqdvIE/n1FhAlu4RjF+ZpA8gfJAUF20nZa74MJv0i0zbi+zfI
         YxEVODTkjDGAxCpxr8xl+qZkuQIqKLEFbyKYCPzG1oC1Iylhz2Kxv1RDBmas4oMMqP0U
         AV4c1xb/vgcavPnlGwA6/igTeL2wzKlVEh2Uemv0loeIavkIfYTDdgdJJ3N3de6b7FTa
         Z1rjodTtDpaG/SNsSqZoVQxh8ooJ752xUiFMIsCY0j0Dknyzum5l9Za5glriop5s27xh
         MxxuBUvjfdlyZiM0WNdXWSxNjGzSdSLPkp6/K/mW9kG5FnZwv3dRIdwfkPcA2DdC6g2y
         Rq2g==
X-Gm-Message-State: APuU4Z/wVhZxnvL1Le4mMYIx0/gR2KebD51BvjVLrMnOC3zvn+pry839
	QcFN2dvD+khYod5OE+Bbk22QmG7POAAX43SwxScc4P0ofbVOWTM+mbpdxTyM0w==
X-Gm-Gg: AYBFou0WeymJukBg0LbwRgCL0jOctjpHJijx8KHIiURYDFdWxcyygrDHB2XxL5celF+
	uMBwDf1PHT6lyoq9cCjovIsVlkUtX+JigY4yn3UTuFXn9UVZzaHoEwk+4BTE0TkzvMnAXo/ooYi
	UmE1d97qhWKblXPkule2svraEGSBuplG2EhcN1KZya0Y2ITKFAFrTiyVEgpNaM/uCegVF+WvX/z
	6e8qAU82qilFJgNo9e4Ui0lurgNL1NCnIRDiTIYkDlP9s/JaKhnlL3y/4ZIRVMdYcg70uyr4H+j
	61vuwffIgoRmWBckpiIWyDRPDgprvplqjYjHYNfaQOZ6W+aPpronQrVs3mUZ3aIUEiGP0JTUPdk
	rZTURT2XNSa4T+Jc4Zn4dblyrJVhs5DZWcIzBA8nHXTBI9jz20TYz5PoEuTbNL5xGGYNHKBTIVX
	NZI+5/DxLLcaZ/F7EWEOtmSBaR18fnYoJz6wk3FJmV/+dlnPbTvrKxitAKz/xj79tD+fwI1clZo
	em8tUQ9oeyJazbJwrjFQNUAx/4KzchF57zrIB7jWzsHtBsbHP/mV9FIv8wD9UFs9w==
X-Received: by 2002:a05:6808:c122:b0:55e:fa63:7001 with SMTP id 5614622812f47-5640ddca9edmr11628495b6e.36.1793781965769;
        Wed, 04 Nov 2026 00:46:05 -0800 (PST)
Received: from [172.17.0.2] ([135.232.177.114])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm1191557b6e.11.2026.11.04.00.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 00:46:05 -0800 (PST)
Message-ID: <6aeaf0cd.6510e82a.12e6b9.fc61@mx.google.com>
Date: Wed, 04 Nov 2026 00:46:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8505045037069759522=="
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
To: linux-bluetooth@vger.kernel.org, vulab@iscas.ac.cn
Subject: RE: Bluetooth: delete the new SCO link if linking it fails
In-Reply-To: <20261104022807.1484114-1-vulab@iscas.ac.cn>
References: <20261104022807.1484114-1-vulab@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8505045037069759522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201153/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.75 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.42 seconds
CheckAllWarning               PASS      35.06 seconds
CheckSparse                   PASS      38.07 seconds
BuildKernel32                 PASS      30.88 seconds
CheckKernelLLVM               PASS      35.24 seconds
TestRunnerSetup               PASS      745.30 seconds
TestRunner_l2cap-tester       FAIL      10.73 seconds
TestRunner_iso-tester         PASS      10.87 seconds
TestRunner_bnep-tester        PASS      3.21 seconds
TestRunner_mgmt-tester        PASS      91.90 seconds
TestRunner_rfcomm-tester      PASS      4.63 seconds
TestRunner_sco-tester         PASS      5.66 seconds
TestRunner_ioctl-tester       PASS      4.75 seconds
TestRunner_mesh-tester        PASS      10.87 seconds
TestRunner_smp-tester         PASS      4.49 seconds
TestRunner_userchan-tester    PASS      3.27 seconds
TestRunner_6lowpan-tester     PASS      5.38 seconds
IncrementalBuild              PASS      28.91 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: delete the new SCO link if linking it fails
WARNING: Non-standard signature: Assisted-by:
#96: 
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex

ERROR: Unrecognized email address: 'DeepSeek-V4.1-Flash and OpenAI Codex'
#96: 
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex

total: 1 errors, 1 warnings, 0 checks, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14942649.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==38==ERROR: AddressSanitizer: heap-use-after-free on address 0x7befcd8e33d0 at pc 0x55560205ae8e bp 0x7ffefc4748b0 sp 0x7ffefc4748a0
READ of size 4 at 0x7befcd8e33d0 thread T0
    #0 0x55560205ae8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x55560205bb75 in timeout_callback src/shared/mainloop.c:270
    #2 0x55560205caa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x55560205f3fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x55560206464b in tester_run src/shared/tester.c:1223
    #5 0x555601f8e17d in main tools/l2cap-tester.c:3918
    #6 0x7fafce844600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7fafce844717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x555601f94c84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7befcd8e33d0 is located 0 bytes inside of 40-byte region [0x7befcd8e33d0,0x7befcd8e33f8)
freed by thread T0 here:
    #0 0x7fafcf1823ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55560205b36a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7fafcf18360f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x5556020452d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1057

---
Regards,
Linux Bluetooth


--===============8505045037069759522==--
