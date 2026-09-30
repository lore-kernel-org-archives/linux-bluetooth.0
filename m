Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2340627F
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809623; cv=none; b=KKdUleu0rXiyd/udxZEOUHn9RN0gAVlqddnO1+vJFPGpHlsCIuKDpauFJzXfsEBmUZsxdCIISqQ65lbVH6GnIxQvxYd4Hy5C7Zp65UaW7eAs1AWe67+oeunfTnPTFGsQnjw2OeW+s0ppBFRTLBGBTbANrXMMEEG8MEvCTCviewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809623; c=relaxed/simple;
	bh=5EOZnitLiFKcS/w6v0hx6XYnZKEFE4DUFvsrxmpH0/Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QPsMfmtotyzJoRl/rLeabaAjJpaw1RFovzps47qB5TEhuJkQo/oR1/jxDs5kXNsc+4+/BmLw5iu9Rz4f5pN0c8JL49AI1+Iemn8G+q5UVv+zwNgdb3yrGbKNsBZzgBR/APpgIEtXEu0JsU1xNb6aRSaVPjZiSt6QSPNExIKl+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq5bu7DE; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq5bu7DE"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso2367721a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790809617; x=1791414417; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SFkwJukBdntS2dLseCGIirdVDURZ3wXdN4L7sKjW3b0=;
        b=Sq5bu7DEmLlRhC+WKZFqRfZcotAwpjChfouRxoR5vBHgISbtpZvCTG2uvZxdbPPnc/
         LJFUrVvqkginuIiO71IzCs+4KzEuwco2mLkI5NGt6A1rNs/M9FcD4xW9zwI0qAFbnwvA
         7BfNZ1X4gfFyqJvN5mz1kw+FCR/s6tiDzOzeCoy34hEVdiX8qPc0hA1jfs9zzI8RYDrD
         DYtPaX/XbN7pMAeGQkAZrP2fZ8olgmvsfk/DFmpJvaSgmdygGQk2fmF4aY65VvbVWoK3
         AZNTajsCG+O+E+opXKunDxPN9jLuu23jSbEfYV3mSsEwGmuoOoHK7PlhuA1zU1EW+RcF
         SU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790809617; x=1791414417;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SFkwJukBdntS2dLseCGIirdVDURZ3wXdN4L7sKjW3b0=;
        b=gDYo65M3hsoRd0cpp4nzdYKwHkufgeGO+7klCm/0ODV6ozLcqPPhBXrVK6VhXFqkUY
         FyH6Pl/nwvwLpnLnUu3xAMA4ik828uwqNAKAO1LPnYRzWSRsm4kvittu4WoRqz9+2KIj
         ZZdjrvvyIGMudhy5F4uehc1oIF0ddtThPA7dvXsysdQyVAxQ+IMQd3SnCZx5JBIuCTBv
         vdMPfM4qWYwmlIjjzHNHRlH+PmqFdHha3H8D2xkkG+061C6EIRQyKOiyDY9JP62jMHcu
         gnbNBit1j4OR1VF22vat0JxyTriG5FIL9x5cuRFeiR0udjBuQbKJOIk3G7DWMhXoK+Y5
         Hs2A==
X-Gm-Message-State: AFq9FYLchhFPXDCRKSFutGY5qqPzlITDSIQ1lHhuxNQWL7N1/jHUeNC3
	VG0O0DtI1sx61c2zfjSSutrUR5jYkwIIcwvl99iA1i96/QGt73FoKJHCOdjBAw==
X-Gm-Gg: AYBFou0gfamGW1xSitUR5NPi0KL2kP3X9STzLKaOT2SZyBaUk6VMN5MlscN1JtZzeYj
	kBbC2Taxb86PWbEPvx09p6B+x7lJFbNFRKC2UKAZm2nwpVSlM1hBtN9043iFTeKa+Cddss8rAm3
	1wlqMI5B7LW58h3q/rUlRnq2UfH5FZH6nPUN2C7U+KiU7ips6FdHjPvYk75/Vd+e6U4+0WWbQcn
	MbSP+bcV/cQf/PNEmUzyhUyYz/f0VBEf8F79ATQpL+0fsgo4NTWkyvsCz8/bYSKs4FYFeJG4lfp
	x6Mesqs1b4D9vG7YW3+QVLrEmbyfgNND9j/qw3g5X6as8eM0COgZyIKEXGrPeR2K9ElJFrPxdU1
	mcc2bthIuRUJBqtGaXJH4AfegqmSzeZGF4K6J3hhJaG8pYX8pl6nUKA/OODJgku3+CEHpktLW2B
	tjmnjOna6B3ssYc8CJgDRz7wvZo8kFviahI5uTDLEfaySvzxVfwHpnYeHkfy/rx37YRU9ZSlwWM
	FTU
X-Received: by 2002:a17:90b:50c5:b0:3a0:c717:2db with SMTP id 98e67ed59e1d1-3a4d1534cb9mr1122291a91.27.1790809616775;
        Wed, 30 Sep 2026 16:06:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.155.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4371383sm1323838a91.2.2026.09.30.16.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 16:06:55 -0700 (PDT)
Message-ID: <6abd960f.197a801a.307fc9.d61d@mx.google.com>
Date: Wed, 30 Sep 2026 16:06:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3835811389315352515=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwertyuiopyyy@gmail.com
Subject: RE: [v2] Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks
In-Reply-To: <20260930192249.757-1-qwertyuiopyyy@gmail.com>
References: <20260930192249.757-1-qwertyuiopyyy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3835811389315352515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1177199/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.39 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.17 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      16.64 seconds
CheckAllWarning               PASS      19.65 seconds
CheckSparse                   PASS      30.25 seconds
BuildKernel32                 PASS      16.96 seconds
CheckKernelLLVM               PASS      18.18 seconds
TestRunnerSetup               PASS      411.75 seconds
IncrementalBuild              PASS      17.38 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#110: 
Similar issue but with different device id. After patching bluetooth is working fine,

ERROR: code indent should use tabs where possible
#131: FILE: drivers/bluetooth/btusb_main.c:275:
+        { USB_DEVICE(0x0b05, 0x1825), .driver_info = BTUSB_QCA_ROME |$

WARNING: please, no spaces at the start of a line
#131: FILE: drivers/bluetooth/btusb_main.c:275:
+        { USB_DEVICE(0x0b05, 0x1825), .driver_info = BTUSB_QCA_ROME |$

ERROR: code indent should use tabs where possible
#132: FILE: drivers/bluetooth/btusb_main.c:276:
+                                                     BTUSB_WIDEBAND_SPEECH },$

WARNING: please, no spaces at the start of a line
#132: FILE: drivers/bluetooth/btusb_main.c:276:
+                                                     BTUSB_WIDEBAND_SPEECH },$

total: 2 errors, 3 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14859393.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btusb: add ASUS 0b05:1825 to QCA Rome quirks

15: B1 Line exceeds max length (85>80): "Similar issue but with different device id. After patching bluetooth is working fine,"


https://github.com/bluez/bluetooth-next/pull/846

---
Regards,
Linux Bluetooth


--===============3835811389315352515==--
