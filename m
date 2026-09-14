Received: from mail-pz2-f35.google.com (mail-pz2-f35.google.com [74.125.228.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936332D42B
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366177; cv=none; b=LGuX4+1vYRiy4zBV8UGCLMzedDDqsq4J3ArpyAnCk+EoYa774DDrnXiUIt4ozyPp7u7MS9CL4bNkcYIxBgUPgYrKCR1wlWEEStP0rh+xuJ1ckBIN5rn2wDIIcfWkA228eWB+mNA+BDclzEll8ujdcP/dn23V1Ti/bXNr/gRkHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366177; c=relaxed/simple;
	bh=ixQdbiKac+bs97jD9vrXwM2vm0jodapNAoSZNUZ1zqQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t847++MO+XMI+QlBJ5XknXc5jXkfwstPZV349agWgE29V4Ux67x9MNVuRnvBwSG5mHLiAkD+I0OD9vCTFGb/aAS16Wem8eYR4e/FiUeOMigliTZcvFD097KiMfDPDA3kkLWkXUCeb+ePwd389ZSkRyjMY2qEU0V0+yjr2j1rqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edn0UAL1; arc=none smtp.client-ip=74.125.228.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edn0UAL1"
Received: by mail-pz2-f35.google.com with SMTP id 41be03b00d2f7-cc4bdf8abdfso1133717a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 23:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789366175; x=1789970975; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MrNQGGQQuVuj8Gk1F3xxwinhPnhdHLtCwht1Xw1lZEA=;
        b=edn0UAL1U6EwU/xj07jae++RqeXXw/mQHqbxj2/ttk3iT1kTS+ZABVhkKGVDyxALTT
         6wfhILJGUi5C87nvPQFSejjivNs/OWiEoVxnUigOsX1IVWUr/NA1uLqGKbBT3EYjhZQx
         /07T3xoLqxnU1y4uBzhmuzUmtutW8dcW+aVumUY7hZyXZ09hhCpkXx4gMvlS5hj7p+Eo
         CEA8beRlBz6NBysvH63YvhvqP6cQTHEqC3Aq6XQ9zP4vUF9As6DbQppdQO8L4p8KN4nN
         0VP4b3CjrtQlU5bh9DyS2A3Gtr9oh/TkzRws7KVXYAdkijjyX3CuHKjmDhZqodXT29SU
         vjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789366175; x=1789970975;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MrNQGGQQuVuj8Gk1F3xxwinhPnhdHLtCwht1Xw1lZEA=;
        b=pMRtAVWuUhMkPvCOMVzDsMh0dErTBfUHlNiHwFcexmpwib+g2Xe1RFR/bW9/PBhMgY
         q7opG1yJyK8Lf6ObsMEJGlpI/4hN0dJ9A+RN5krW9uljQTYh2nln9H13PdBxFgY2xPi/
         ENlDpSP9aIBb2u8cuOVqzt1w7PvY1yzTXAtOX2BwObSNRCHMfZWJZw1uUeI+96KU7YhU
         eNons1AnkSDdy7m5emJNRtw284Vv0J07Kh5ugSwswfPokqI7icm2Lc86tUjzqKV/Jakq
         Ls9eHT2HcGjsdKEpGyZp43qZH7GdcLfq4d9m01KcvgWHKYRjsPt4nAAvj9SV6npvkRYG
         3n1g==
X-Gm-Message-State: AFuF++lKHh5aXDk91g97YpXtm+/dyyopnkGZwXi1oTGVz7ob5m//2n7c
	qgZvrwmDbzY37H/+ucZ+GW6azQqY055nGxL7tmk/ODC3r0IfFgu46tePuG6zBQ==
X-Gm-Gg: AYBFou14STsYX8PDxTss7HZVB3ZL2ZirfXkLU8aICdXGrQ3l0kRfrbiQcLgra8h6o6r
	L+iINbOfdS5JhDtFVJcBDxCKaBXk0u6cMJ5gluHawpxOG1QoWCwaXnRG1rhI7VQWvfNplfaoJ6+
	4OhiHO84J2jt90U7YnKDnDpUDP8TM+6IEL5M2UywT5lt/m9ea4EpFsG5eU4Nx5ZGI7sdiEZntCC
	0RcxX53MKuvo4euFaLs6OYbltzJsCP4SIjQ7qPCxAVi6ct6hiKVYfjAxFpEjgYMxGJAjrF5MinX
	BtIkDggcXUqqGM7RJnyNRcmzPa6Boa+TQSpwElZorEw9XIsCcT3nAa5P1PgsWdnewlSsOVeWzLD
	I16qS4Z2k4+BA6G6+y8x5ZOlOLA330r+EAaautHB074EY9wq/qC/UaQLw37DEW0eYQhnEe0V6s5
	SvydYLCDVX+LPanweSiPBudu6BsLJyvqj/noXiThOWPavqs07oUBMMHfR/HUmpGnVO9QdvVNk1F
	ma8i0A=
X-Received: by 2002:a05:6a21:3384:b0:3d8:1f68:59ac with SMTP id adf61e73a8af0-3db406d01fcmr2585854637.23.1789366175475;
        Sun, 13 Sep 2026 23:09:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.239.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4ed295esm27292705eec.15.2026.09.13.23.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 23:09:35 -0700 (PDT)
Message-ID: <6aa78f9f.f85c57d6.91be1.811e@mx.google.com>
Date: Sun, 13 Sep 2026 23:09:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0192867342433848900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: Fix 2 devcoredump bugs and improve event length checks
In-Reply-To: <20260913-misc_fix-v1-1-558c1e4028b9@oss.qualcomm.com>
References: <20260913-misc_fix-v1-1-558c1e4028b9@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0192867342433848900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164165/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.37 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      7.79 seconds
GitLint                       FAIL      1.00 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      30.04 seconds
CheckAllWarning               PASS      34.56 seconds
CheckSparse                   WARNING   37.80 seconds
BuildKernel32                 PASS      29.91 seconds
CheckKernelLLVM               PASS      42.93 seconds
TestRunnerSetup               PASS      799.32 seconds
TestRunner_l2cap-tester       PASS      43.32 seconds
TestRunner_iso-tester         PASS      95.81 seconds
TestRunner_bnep-tester        PASS      13.60 seconds
TestRunner_mgmt-tester        FAIL      143.96 seconds
TestRunner_rfcomm-tester      PASS      16.92 seconds
TestRunner_sco-tester         PASS      22.48 seconds
TestRunner_ioctl-tester       PASS      18.47 seconds
TestRunner_mesh-tester        FAIL      19.15 seconds
TestRunner_smp-tester         PASS      15.66 seconds
TestRunner_userchan-tester    PASS      17.16 seconds
TestRunner_6lowpan-tester     PASS      16.51 seconds
IncrementalBuild              PASS      35.05 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[2/4] Bluetooth: coredump: Fix btmon heap-buffer-overflow
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#191: 
ERROR: AddressSanitizer: heap-buffer-overflow on address 0x51b00000065c at pc 0x7f50b987a029 bp 0x7ffde88dc8d0 sp 0x7ffde88dc088

total: 0 errors, 1 warnings, 0 checks, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14812259.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/4] Bluetooth: coredump: Fix skb leak in hci_devcd_append() stub

12: B3 Line contains hard tab characters (\t): "	..."
13: B3 Line contains hard tab characters (\t): "	// the skb_clone() is leaked."
14: B3 Line contains hard tab characters (\t): "	err = hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC));"
15: B3 Line contains hard tab characters (\t): "	if (err < 0)"
16: B3 Line contains hard tab characters (\t): "		goto free_skb;"
17: B3 Line contains hard tab characters (\t): "	..."
19: B3 Line contains hard tab characters (\t): "	kfree_skb(skb);		/* frees the original, not the clone */"
20: B3 Line contains hard tab characters (\t): "	return 0;"
[2/4] Bluetooth: coredump: Fix btmon heap-buffer-overflow

16: B3 Line contains hard tab characters (\t): "	__le16  opcode;"
17: B3 Line contains hard tab characters (\t): "	__le16  index;"
18: B3 Line contains hard tab characters (\t): "	__le16  len;"
25: B3 Line contains hard tab characters (\t): "	uint16_t channel;"
26: B3 Line contains hard tab characters (\t): "	int fd;"
27: B3 Line contains hard tab characters (\t): "	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];"
28: B3 Line contains hard tab characters (\t): "	uint16_t offset;"
32: B1 Line exceeds max length (128>80): "ERROR: AddressSanitizer: heap-buffer-overflow on address 0x51b00000065c at pc 0x7f50b987a029 bp 0x7ffde88dc8d0 sp 0x7ffde88dc088"
34: B1 Line exceeds max length (115>80): "    #0 0x7f50b987a028 in write ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1096"
38: B1 Line exceeds max length (85>80): "    #4 0x5b4f34451da6 in mainloop_run_with_signal ../src/shared/mainloop-notify.c:196"
40: B1 Line exceeds max length (89>80): "    #6 0x7f50b8c2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58"
42: B1 Line exceeds max length (109>80): "    #8 0x5b4f34295ed4 in _start (/usr/bin/btmon+0x29fed4) (BuildId: b41caafb24db693946c283eaea48112186863d2d)"
[3/4] Bluetooth: hci_event: Use 254 as max LE Meta subevent payload length in hci_le_ev_table[]

1: T1 Title exceeds max length (95>80): "[3/4] Bluetooth: hci_event: Use 254 as max LE Meta subevent payload length in hci_le_ev_table[]"
[4/4] Bluetooth: hci_event: Use 252 as max CC event payload length in hci_cc_table[]

1: T1 Title exceeds max length (84>80): "[4/4] Bluetooth: hci_event: Use 252 as max CC event payload length in hci_cc_table[]"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.140 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.568 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds


https://github.com/bluez/bluetooth-next/pull/762

---
Regards,
Linux Bluetooth


--===============0192867342433848900==--
