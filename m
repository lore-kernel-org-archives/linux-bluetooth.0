Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B52481664
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262745; cv=none; b=j+gS4fBxrMPbVvvxOac9W8w2QicEx5lbmmBf1z0ef04VTENpfgxRICYtAnd6BdJafROr2kt9Ayp30D+iIdMi+R3U7TRhXFiL0NLyKkidBIsXwOntnNjbTeKFcivWvwKvFYE/SJR+2GoG6KR6y4iHueY8xx22x0IEB2m4zV6/e74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262745; c=relaxed/simple;
	bh=clPbVbm+OECxqvpsnQZHQtgNL83+u26/vKRoPcyfO0Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EQT56AprGqw8tAdWIWOvqruluDJbBfCwubAlphEM9GsSwor8PZWMgZ70ZK4Hl9I/UcHbsQvucJiWCtWFjEGD5Fw0uyvvg+CLAEa1mIeUXIbZh61kMnbU64HkPBkD+10y/PhnNW9gaQXL5mCQUzrfN1E20uXzq2E6WJoEKiGpm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxB0TUtG; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxB0TUtG"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-5329fc7b325so14460611cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790262742; x=1790867542; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D9LKP/vcn+pAKi0EJisPo1+f1eUaPYaCLRVSCQkPGjw=;
        b=cxB0TUtGK3tpj7GpfHaTxpB036R8AzQNXA5K/8WcJtu/3HPfHyyzVggf3hr7TZcL6j
         Z+0vF1f7PCNiOpCTEJOoQIAXyi5rP07QheTj90Zca4E9uLHqPNDJ2ynywDOf2xjHeNTv
         EeXNwi5eSOC10La00erf0I7UZLSPvE8BBOcSrYTWlB5jHXe4WxDinySqTd5MA7vdfCzA
         9Wlr8zum5ETMIPztK3Vyo+kt5zFg+PovKG6+MyURA2brJduWPlUWQN3i+sne3ZEe+cbk
         wfjLlYLG2VCo/a80tjWowNMLaBOge0qqpvXJU1IKgLeo6vR0NHgCGtox7sMKt+HXK3ji
         a5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262742; x=1790867542;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D9LKP/vcn+pAKi0EJisPo1+f1eUaPYaCLRVSCQkPGjw=;
        b=n55nzZhIuGmKsSis8k53a1yX9Bdhtc638qiPFRrm/8izyYMTjODG1y1NZ4/P++NxGw
         Ew52mOfX/cxIF0QNlDvrM8Sy/SBtG7KXHQKtO15lrJDzHY2QoGSETPKkAGH618fVKzfq
         WVU+5mSsMPQtvjUyrOBRj7iz32zHj87kg0EzTJrEwjhQYq+MfTP0YFM8FQ8NCjogNFJa
         U4ZU1dCqV3bB16mfnORlggccow0YfAA7UFMfmu8+XeCF6YbYFjotk892IYeKcfJolS3d
         oDi70Bm9TUd2RS2x+GWPtT7K5MwkOamcOPD3K8ka7NHcjSuzWKtXZkwSjakuN4Vbni4a
         pEiA==
X-Gm-Message-State: AFuF++m1KoplHhiLF/GeoybnedBnM/X7BUyHuTQPyOE2hhXOVTWmoRRY
	3/Up72Id/U1zWv8HeH+Rw8dfk8nY3hJ9vfaLDdj3I3njV41gjCiG+NhPcFQrPQ==
X-Gm-Gg: AYBFou1reQuCd1iW3QYuVibyk0g8Yxlj0dyIJdFOM2rtjCP7b2yGYzUCu8dG/4znpHB
	l9h1rxHkZCr4G7lkWs88lGrKQdHfm5qwqyMMXO5MfWOuH4fqHR4qlLwRrwaDErICIUoUcX5/mEi
	CdZd48ihZIDszRyp1vnbhPrbHGQIVTA0nlBEcVsU6UKXJBxLxjm5DqIW8aApIRWbMaUAPNuYRuk
	F3DE+G3ub+e9w54cdfzyh+dXBRtM8YZ3hMsSKL7y8fQQP18IufQimUq1G9rxP94dbmzwIqzd/MT
	1pxnWs5pKuS+BFn6cQZLbYqt8h3OVkEIo0Kc7wFGlc5Y422S3qYxMm2prBTRuKTBkmZLCUD7uZ4
	UNuaT5VW4z/DBRIRTKruTIdrMlCf38BlUC+WJgMxS5bTutB2Z9NH7utRAkVzxsydtsFJM6nWEJH
	OdqjHn47d2qu7OzkEAnyPE9qfPp27vp1zI/+xIoLGWwcaOnMmGeYGoOO40OCA6s5PaW0EFNEcrU
	/PD
X-Received: by 2002:ac8:5a07:0:b0:530:faf3:fdcc with SMTP id d75a77b69052e-532fea133c3mr29272441cf.19.1790262741667;
        Thu, 24 Sep 2026 08:12:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.175.24])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532f501100asm30270321cf.24.2026.09.24.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:12:21 -0700 (PDT)
Message-ID: <6ab53dd5.9f0a01f5.384a9f.70f6@mx.google.com>
Date: Thu, 24 Sep 2026 08:12:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7844961959520209031=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: [bluez] monitor: Fix stack-buffer-overflow in packet_hci_scodata()
In-Reply-To: <20260924-fix_sco-v1-1-ddca18333914@oss.qualcomm.com>
References: <20260924-fix_sco-v1-1-ddca18333914@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7844961959520209031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173024/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.53 seconds
GitLint                       FAIL      0.33 seconds
BuildEll                      PASS      15.45 seconds
BluezMake                     PASS      285.73 seconds
MakeCheck                     PASS      0.76 seconds
MakeDistcheck                 PASS      117.73 seconds
CheckValgrind                 PASS      110.23 seconds
CheckSmatch                   WARNING   216.94 seconds
bluezmakeextell               PASS      71.69 seconds
TestFunctional                PASS      891.85 seconds
IncrementalBuild              PASS      279.95 seconds
ScanBuild                     PASS      794.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[bluez] monitor: Fix stack-buffer-overflow in packet_hci_scodata()
WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#163: 
AddressSanitizer: stack-buffer-overflow on address 0x7bd1443dedba at pc 0x7bd1474ced69 bp 0x7ffdb0324880 sp 0x7ffdb0324010

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#266: FILE: monitor/packet.c:15055:
+		snprintf(handle_str, sizeof(handle_str), "Handle %d [%u/%u]", acl_handle(handle),

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#270: FILE: monitor/packet.c:15058:
+		snprintf(handle_str, sizeof(handle_str), "Handle %d", acl_handle(handle));

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#324: FILE: monitor/packet.c:15129:
+		snprintf(handle_str, sizeof(handle_str), "Handle %d [%u/%u]", acl_handle(handle),

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#328: FILE: monitor/packet.c:15132:
+		snprintf(handle_str, sizeof(handle_str), "Handle %d", acl_handle(handle));

WARNING:LONG_LINE: line length of 100 exceeds 80 columns
#354: FILE: monitor/packet.c:15242:
+		snprintf(handle_str, sizeof(handle_str), "Handle %u%s", acl_handle(handle), sn_str);

/home/runner/work/bluez/bluez/src/patch/14844485.patch total: 0 errors, 6 warnings, 164 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14844485.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[bluez] monitor: Fix stack-buffer-overflow in packet_hci_scodata()

8: B1 Line exceeds max length (122>80): "AddressSanitizer: stack-buffer-overflow on address 0x7bd1443dedba at pc 0x7bd1474ced69 bp 0x7ffdb0324880 sp 0x7ffdb0324010"
10: B1 Line exceeds max length (118>80): "    #0 0x7bd1474ced68 in vsprintf ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1671"
11: B1 Line exceeds max length (123>80): "    #1 0x7bd1474d0643 in __sprintf_chk ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1719"
18: B1 Line exceeds max length (86>80): "    #8 0x7bd1474e81d86 in mainloop_run_with_signal ../src/shared/mainloop-notify.c:196"
20: B1 Line exceeds max length (90>80): "    #10 0x7bd14662a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58"
21: B1 Line exceeds max length (81>80): "    #11 0x7bd14662a28a in __libc_start_main_impl ../sysdeps/nptl/libc-start.c:360"
22: B1 Line exceeds max length (110>80): "    #12 0x5f5c39cbc664 in _start (/usr/bin/btmon+0x2b2664) (BuildId: 370a6386c9fceae18f9a456c0c029ac378b0b070)"
34: B2 Line has trailing whitespace: "--  "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2576

---
Regards,
Linux Bluetooth


--===============7844961959520209031==--
