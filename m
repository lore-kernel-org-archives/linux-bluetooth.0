Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C73A6EE9
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178755; cv=none; b=VMwcA70dWx3YkLqHBBpQ1/yOWyOIlSO+9TNpBOD15Quh1T+ge8J9+PZJrb/NzQP42h2Vl6T0rx3l/73xZZO8vH/Yv0zPw9S8HnE49zBSVhP1DQG8fEXHDfvwjXiHiO60o0rkqb3UuUswmE6V/nkNVOTmljli4GyCYJz8MvXJyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178755; c=relaxed/simple;
	bh=vZ2AG1iyIFS6L9Fs/N5tOEcsypvg9E2/ZExaK2OVpfI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q/oVaxD0Cv5u2giTsTKp78yMI/FOepEgwFNxMQRzz+EhCsKJDZJHn40Ruh/YBEgHxlc2EOVyHBiK5GQK4mg+kIQbD+mCbwHcNvoKq93CssXNLoCywzl8tP1NG8DeRP4jmvsuHfk6nFq7fJbBnGpmlJCEa4hd6Ek+xSblBepv0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+gziMAt; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+gziMAt"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e62211987so1231853eec.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790178752; x=1790783552; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p6FH2c1DqBe/5vl+PVT4/JWmYSNgG3MPqvURGsC/F00=;
        b=H+gziMAtCE9nj0osIu6t53blpjmJYBIjDEW5eqZagxjzxdfZR9w8xLEM9BRX9Ip3Ed
         FjGngMHOoHuvVPkilUxNF45i6lj99hdnhGjVfZSH2jx6VQjiCR51tt/1HbsNkjeX1dlA
         8CPEElJAEVPv/cLiI7WSJfktvOWmimNKruaab/1dYOX4TuQhyQwnWhxJ6rH8YSc4VY5D
         jWTL2sdMUb2i23gMjnYmCefX7wP4/MxmZMe/7onfT1PZ2CHE/FpmxPu9ZvdBVqMVugKD
         NgDVZ09JPnyXHrLJ65JEjngOZJazUqyn30qUP8rB6MgrLO/5PNUY1pBxQ6KcQwmXeYds
         prvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178752; x=1790783552;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p6FH2c1DqBe/5vl+PVT4/JWmYSNgG3MPqvURGsC/F00=;
        b=Zu7eWdsrj5g/yq8AY/c+PLvoigxY/uS8rNiJh19iZO6KGt/xCr2d1FjjmXDR5Y/KJo
         9TdX8u/hc3+PqOUqa6XDvnyyR8rt4pWlU/WS4UO8PnDAa9uGT7z2QN6Nz8qbe3jJxaKa
         HJLqB28pm1HSfMyOW1+BpFjPesOkWJzocUPABBmRpr8lJCGsHETmcdZ1KX64+QS75Uie
         wEL6mTY4ptGQi0cNW0QpTLFp7Jrs+MdcyAKn0szXNmcFNNrv4zcczKxDDwyEJfc4+CVk
         ++lwHFofrt5m+udOeuZHs5Ib252oHi2Mh6s0ZQXV4UPEqpGJDVbC8zaxIGbBgfHjzso+
         dYrA==
X-Gm-Message-State: AFuF++n9TRq7/TzabuIIvx3mw5Ylh88DlIvnw/wDGe/5JKO4a2ogeUXA
	65p/UYlIK1m2RQS7frJX3Ic9yNRdkKbhN5RdseL4Nb++jIF8R9taAw8UMCDIrg==
X-Gm-Gg: AYBFou0cwv/a18EsOdG6IpUNggvKdSKfyRW0XJDj9js/da2ACnyXsie5HQluHSoVnGp
	hILmDKzRvZYOMdU3gXFIASnOpOfEYbS0/RhOVgG8Gq8VBPUa6YMabm5V6T3Aemqz/jK1NdPyW0L
	pgSvwoPOO1EAWXdQ0UZHyv3/+bNnw2RQ65vcK4DI/R5LU9F1EqGxfk0SUNdIfZ5un6OLWhhR27w
	yMQ+MsoXQcNZI73fHdWSt07xcRCxa9aLX0BkCxXAKmhdHlmU0ZhJOwL/UhVRijQzAhJeT7nxBqJ
	jXHImd71Pg3ANuk4MoR+tYGtMkPVgmkWlYTQ/6cwZhKk7EcGgqBCSf8zfIruJmAUcWb94PhosCU
	9Pkx/JzUO42j355z7R2IdCLcCepNneFq9Lr7E/1PUdPFXjiplIXdQuFwJuo6LzhSyAqEQ3aROb4
	CL3g81oJnDiTI+44GBw5Y20FjdNvl2gkc+qfCkwk7cEEJkssEvXXCP6/Q3fmjPWXCWXRl1JYzto
	lGV54uOf5pJXyWO
X-Received: by 2002:a05:7300:5989:b0:33c:268f:1e92 with SMTP id 5a478bee46e88-33e88b32065mr2697611eec.0.1790178752151;
        Wed, 23 Sep 2026 08:52:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.111.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7cfd9sm7405140eec.5.2026.09.23.08.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:52:31 -0700 (PDT)
Message-ID: <6ab3f5bf.80a95698.1b311a.89cd@mx.google.com>
Date: Wed, 23 Sep 2026 08:52:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8301726257733302667=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v8] Bluetooth: btrtl: Add firmware format v3 support
In-Reply-To: <20260923104521.1706251-1-hildawu@realtek.com>
References: <20260923104521.1706251-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8301726257733302667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1172140/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.25 seconds
VerifyFixes                   PASS      0.36 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      28.75 seconds
CheckAllWarning               PASS      31.97 seconds
CheckSparse                   PASS      34.99 seconds
BuildKernel32                 PASS      28.20 seconds
CheckKernelLLVM               PASS      29.79 seconds
TestRunnerSetup               PASS      702.36 seconds
IncrementalBuild              PASS      27.22 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v8] Bluetooth: btrtl: Add firmware format v3 support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#801: 
new file mode 100644

total: 0 errors, 1 warnings, 1386 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14841085.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v8] Bluetooth: btrtl: Add firmware format v3 support

21: B1 Line exceeds max length (85>80): "[    1.838104] Bluetooth: btrtl_read_chip_id() hci0: RTL: chip_id status=0x00 id=0x3e"
22: B1 Line exceeds max length (116>80): "[    1.838331] Bluetooth: btrtl_initialize() hci0: RTL: examining hci_ver=0e hci_rev=000d lmp_ver=0e lmp_subver=8922"
23: B1 Line exceeds max length (90>80): "[    1.838571] Bluetooth: rtl_read_rom_version() hci0: RTL: rom_version status=0 version=0"
24: B1 Line exceeds max length (82>80): "[    1.838821] Bluetooth: btrtl_initialize() hci0: RTL: btrtl_initialize: key id 0"
25: B1 Line exceeds max length (84>80): "[    1.838825] Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_fw.bin"
26: B1 Line exceeds max length (88>80): "[    1.843021] Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_config.bin"
28: B1 Line exceeds max length (118>80): "[    1.843325] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection (f000:00), chip id 62, cut 0x01, len 0000c704"
29: B1 Line exceeds max length (90>80): "[    1.843342] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection version: c5900782"
30: B1 Line exceeds max length (103>80): "[    1.843347] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_config_f000.bin"
31: B1 Line exceeds max length (126>80): "[    1.843363] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_config_f000.bin not found, use default"
32: B1 Line exceeds max length (118>80): "[    1.843366] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection (f002:00), chip id 62, cut 0x01, len 00034378"
33: B1 Line exceeds max length (90>80): "[    1.843417] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection version: 2b84a8b2"
34: B1 Line exceeds max length (103>80): "[    1.843421] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_config_f002.bin"
35: B1 Line exceeds max length (109>80): "[    1.843647] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_config_f002.bin found"
36: B1 Line exceeds max length (118>80): "[    1.843654] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection (f000:00), chip id 62, cut 0x01, len 0000c704"
37: B1 Line exceeds max length (90>80): "[    1.843658] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip, key_id mismatch (1, 0)"
38: B1 Line exceeds max length (118>80): "[    1.843661] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection (f002:00), chip id 62, cut 0x01, len 00034378"
39: B1 Line exceeds max length (90>80): "[    1.843664] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip, key_id mismatch (1, 0)"
40: B1 Line exceeds max length (118>80): "[    1.843672] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection (f000:00), chip id 62, cut 0x01, len 0000c704"
41: B1 Line exceeds max length (90>80): "[    1.843674] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip, key_id mismatch (2, 0)"
42: B1 Line exceeds max length (118>80): "[    1.843676] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: subsection (f002:00), chip id 62, cut 0x01, len 00034378"
43: B1 Line exceeds max length (90>80): "[    1.843678] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip, key_id mismatch (2, 0)"
44: B1 Line exceeds max length (109>80): "[    1.843680] Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: firmware section payload total len: 0x00040a7c"
45: B1 Line exceeds max length (85>80): "[    2.293192] Bluetooth: rtl_finalize_download() hci0: RTL: Watchdog reset status 00"
46: B1 Line exceeds max length (82>80): "[    2.293957] Bluetooth: rtl_finalize_download() hci0: RTL: fw version 0x2b84a8b2"


https://github.com/bluez/bluetooth-next/pull/814

---
Regards,
Linux Bluetooth


--===============8301726257733302667==--
