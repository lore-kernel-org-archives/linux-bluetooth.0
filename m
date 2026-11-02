Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647875;
	b=wfaTlaWTuzZwYSFLWE+iwrE3efXpBZBqfwlNOQJ2jtsgqXXutvKgF1wzADThmy1paz83
	 e3vGp6n5S1EnZQEu9mzgiau6E2YlowF6F1qi2LJ+biJ4YJalq+7LnCsNRh5IHHB3brqvw
	 hdVrHKCsbpK38Sj+1VCSoYwNei/FigLVXO3EsnDWQeg1/UDb/xAM9kwd1+Gy28jrN/WDt
	 GjSrFJaNaCzhIX+4p7Yis7a4/R/WRmD6npx1QE1bSlcV9eTnMollPzG2cuPtQjWRWzJpM
	 k/rZIiDus6cv+BQAM0exNq7qJb+w1u28JSaARW9vZCrnFAUwau53f+P++H3f2OBo+Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ZfFL3/UUbd0olH4tFxdbFZCqBKqx255F9sH56di979I=;
	b=HLzkcYuh8qdBsb9lG32EPgCFZaFEHqNKmvaarw/Z+O9xCYrnflavlZvzaR1zGhj0X+TK
	 ZxPhOhh1o9w8tnRr52JqSzcXX6cI8nD7+2yNFob1qo5HcxiY1WEsKgmkc54OVtdGa2y0R
	 FiNHT6rZyJy0v3+k4c6xM0bAdy7TJAtjQM1PemeEARs7uK5Lxgjku4mPRfeOADyuMLBck
	 7fRAONiCp610pfCXcURUvwSKsiQ3xuOgxuIVuO6O4S3Wpea9cudibXomnwAP6HYrfzkkY
	 y9yykKpQlM34934k+eMIcOHqq+dN5DUKjkugZKqPmGFQkg5w7Wa4k16L/YBgYmtwfCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dLmjE8qV;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B5606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D6B5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dLmjE8qV
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a17a332ecso5310240eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647874; x=1794252674; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZfFL3/UUbd0olH4tFxdbFZCqBKqx255F9sH56di979I=;
        b=dLmjE8qVcpO6kWRlIJuyCTG+j9IezmQpZH7aL5r42cCNQ7aEEifsLpF/zIQkw0gdcC
         Iwq/ocdY+p40sn/GqJCTN55FOGOVTnmJg1JXAXO9pdxu7muLarS7D862YLXv5GerTwf8
         IM/30td6GEvKs2ZKLV+AH0HXyHHadjL8UA8Ftn1fS7+aYaeKHVgoffRVfAqeVERmvt+C
         QU0d0BiWA7ERQCJxGwIp0iz7/jZo2I/rUeLmdsCWPG/QbcKux8EUk8u8Wydx1r94VHsR
         nmz42N9MBEou6St5EiqJ/Cf+OLYR3cQ4M9Lw7ybcHDD9Ljn/yNPZsxBG4UblmMJs1+B0
         ijZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647874; x=1794252674;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZfFL3/UUbd0olH4tFxdbFZCqBKqx255F9sH56di979I=;
        b=guwpAeD+GFBsUYAeJh5t+KlP+72OpvOei7YnOPozeTpTe1HW6oWjf4n6VLNTwVqiDg
         HvdVVYfe6Qdx0Pee+DcEhYdJffw60OWa/BfYkkn/C5VhE4y3dzYPwKcjy53llgbxbdhN
         2pUnDqzZzsyEyzl2qkl8qX4onhYiezjxqKV0CEmroT/DpuTrN5+QgrvZpf5Sr+zyn+l2
         LEoDdEJKVf0q1xi6gnvChBF/kreumpl1nzS/QZ9WOr742xUPT/cyjawiHmEpdlNv1LRT
         SN27Hvl+5rdKDS6QNkXPdlTDWQ/X06z5O1Q7HkFqv7XOkvoRRTsgC2pcLA8rBK78GG9T
         2OkA==
X-Gm-Message-State: APuU4Z9QEbt6baibk++ge5VtVXRLeUCp7Z3kByRyrG/HtdUS7/QHcldB
	51K0nM1GMKApv6Ahk3YYYRzjkNkY9/oelAk3mNPlIzZPP/A2Y3LQbb/Zxhq2Yw==
X-Gm-Gg: AYBFou0V7zYYOYlQMvjHJIL2FDhn5dMBNje2VwEBYL1a7wqiDT5pWy2TO3125jQlzk+
	yMTRI0h9gF+O+hqsVivVgQCrl70vGy4EPIwDxhoDbShiFa9Vc22cmUoC9nDkKkP/GgATBpgWebk
	im6Oh19TZXea56HMDVNbarytBZlgxn+x++1f1Lx5mgJPGbL4cbIo5Lo26Y9U9e5UQJ/D9fnTidI
	4zLyDfK1E/CzB+BbHRJK5wrB0Yu57JIO6eZ0grmnqjD3pgyHTqPhNqYc2DORp3Sdq+NWUFAq1rC
	/Thb0VWfeGLudAixZcQoxGkwm2ZBYG3x4EwhTw4PT+3bdBjPN27eCAiho5RfUNr4dc2fVEErUc0
	pqQcAdlDJsEB5zae4lnFE2F574QL74FH56ltRx2MG5heOIGnGf/6VYmMJDHjLDF+ErsTIfkKIGQ
	++0cdLMauSNYOoJcVZuhI6d4/yFx4YAEKsaaf48clmo1ZFeQ9mQhGiWOp+d7/J9tmQCGDFGlrrl
	dHuc9aDz8JHheF0hf3fTAjHFEf40vIAL44Rrg0kBZc7C80v8Tib+SzalQuu/VU=
X-Received: by 2002:a05:7301:4b10:b0:35c:85fa:5a61 with SMTP id 5a478bee46e88-36a424940d9mr16908808eec.38.1793647874271;
        Mon, 02 Nov 2026 11:31:14 -0800 (PST)
Received: from [172.17.0.2] ([20.57.198.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a96172sm36136806eec.27.2026.11.02.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:31:13 -0800 (PST)
Message-ID: <6ae8e501.b52ed58b.308aad.b090@mx.google.com>
Date: Mon, 02 Nov 2026 11:31:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1223294164938953405=="
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
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] power: sequencing: qcom-wcn: increase WCN7850 power-up delay
In-Reply-To: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
References: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1223294164938953405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1198647/

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
VerifyFixes                   PASS      7.51 seconds
VerifySignedoff               PASS      1.27 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 FAIL      0.07 seconds
BuildKernel                   PASS      25.63 seconds
CheckAllWarning               PASS      29.05 seconds
CheckSparse                   PASS      30.66 seconds
BuildKernel32                 PASS      25.01 seconds
CheckKernelLLVM               PASS      25.07 seconds
TestRunnerSetup               PASS      559.75 seconds
TestRunner_l2cap-tester       FAIL      12.10 seconds
TestRunner_iso-tester         PASS      11.62 seconds
TestRunner_bnep-tester        PASS      2.92 seconds
TestRunner_mgmt-tester        PASS      83.96 seconds
TestRunner_rfcomm-tester      PASS      4.30 seconds
TestRunner_sco-tester         PASS      5.10 seconds
TestRunner_ioctl-tester       PASS      4.27 seconds
TestRunner_mesh-tester        PASS      5.15 seconds
TestRunner_smp-tester         PASS      4.23 seconds
TestRunner_userchan-tester    PASS      2.88 seconds
TestRunner_6lowpan-tester     PASS      4.02 seconds
IncrementalBuild              PASS      23.89 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Sanitizer errors:
==35==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b6f351e33d0 at pc 0x561bb9d85e8e bp 0x7ffe98f52c10 sp 0x7ffe98f52c00
READ of size 4 at 0x7b6f351e33d0 thread T0
    #0 0x561bb9d85e8d in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x561bb9d86b75 in timeout_callback src/shared/mainloop.c:270
    #2 0x561bb9d87aa6 in mainloop_run src/shared/mainloop.c:124
    #3 0x561bb9d8a3fa in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x561bb9d8f64b in tester_run src/shared/tester.c:1223
    #5 0x561bb9cb917d in main tools/l2cap-tester.c:3918
    #6 0x7f2f361a5600 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:59
    #7 0x7f2f361a5717 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x561bb9cbfc84 in _start (/home/runner/work/bluetooth-next/bluetooth-next/src/bluez/tools/l2cap-tester+0x16cc84) (BuildId: 91c9d49e9766c394468e27ffa29b05e7d348169f)

0x7b6f351e33d0 is located 0 bytes inside of 40-byte region [0x7b6f351e33d0,0x7b6f351e33f8)
freed by thread T0 here:
    #0 0x7f2f36ae33ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x561bb9d8636a in timeout_destroy src/shared/mainloop.c:251

previously allocated by thread T0 here:
    #0 0x7f2f36ae460f in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x561bb9d702d5 in util_malloc src/shared/util.c:46

SUMMARY: AddressSanitizer: heap-use-after-free src/shared/timeout-mainloop.c:33 in timeout_callback
No test result found


https://github.com/bluez/bluetooth-next/pull/1039

---
Regards,
Linux Bluetooth


--===============1223294164938953405==--
