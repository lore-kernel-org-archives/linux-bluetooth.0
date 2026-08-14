Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED183EC835
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696642; cv=none; b=Gq/yjCFVt2b88Ba1txnSUqLPTqj9JcbLORw9dZTeWuipk8qDubHyRAft5Q76RuFU3qVkC4ymk2qI0+Jvw2wsAaNQKtTdlsBDshcq/UO/rqphVZ6X4eILzv1oT51xNnHxlwehnX2QROIGS2lEh8o6fVnZi8d0OxGYcPvgZYbDqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696642; c=relaxed/simple;
	bh=Gm7BZweBTzVzPzrmsvzXN09CqZ1PLIN8gIzO7MNVciY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dpvt+W3cGfVJiepFTmr6FfKVfCNb6AdXq2ZDHQ6D32GidI288Y/hznyHfU2VL4P81v3D+oXMOj1f0vy3EotlJr3XfpG6muh616WlyjA7+Xcs9/l5iKBY4ub2ncbbpEeCzzHH5Gte1OniUKAZHP8XEGqFoCdZv5zyPAkj8Va5FCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEOdYjq8; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEOdYjq8"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-936cda0e3fbso63845585a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786696632; x=1787301432; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hD57EtrVoeRFCqYfolwFy1DGq6G5+4Pj70zj8CVkyRw=;
        b=AEOdYjq8l153O/Tvq2dWlyPUhhdilSHpAO116fY2aU9b48w8KyV1e41Y9hyoG4dXv6
         hq+Cn7TN/FrIokEqrcJhYPjTTldpdpCH8uFWHFI7hOfz4TjwaWPxfBLHfhr9sr/W7kip
         ZhnSIomgImwZXATAL2AVUF0MudlnMwLlYP7ShBinz2YN2JNgHIo7gmO3ZcvtXkffT2s+
         iE+D8q7bf+GrRE5itS43L706q1G+sBoc+Ol8bRXCwHmE9TunnTNwpIEuTBmyiLHKeKPC
         34vjmBiUiApTOZoCZ47ri5mNRCN8ZcOydWGJb/xj+c4psBOqD58+Cr1ZyrLjHRrc13LK
         oX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786696632; x=1787301432;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hD57EtrVoeRFCqYfolwFy1DGq6G5+4Pj70zj8CVkyRw=;
        b=sLEK9b4afyvjAPzS0xZhnqtimi8mnTW07gOq2W8QKOCrEiE2G00MsiPSH/mLi/jPiN
         k094YBaUsQbY5UcD1cPUAtu3K80leO49a2R4v8MdPFy6N8ecr9vmUk5iloKxLHklFs7Z
         yKXrkEJ1kn2pmCnscZA+0daMFtI82OsEfHDP0bbxqYUcLH3/UFMd5r2APAtUaUGAxCU/
         4S5SSriHrrFA5DAfYeAkSiO5nCQz2ny4nlQ8N2KJDT0WgnVmXaXzliozgHToBS6lm/yX
         k7POUGs6fFeayS20Ivm90Ukp8ln7grYyKC88jXoSCp48q+/uR9e7Pw+Sigu22jHFm007
         1jgg==
X-Gm-Message-State: AOJu0YxLXu8cYOHa9WMbIgJFGIanjwy8vNTdgraf1/uZnB6HmmgpyeWk
	jdkLZxZGd95cZcODPdPQskD74rU7aRQH/xFq7k+EatZ1Z40/T90o0Gde34vUrw==
X-Gm-Gg: AR+sD11DEs1ElQW1GZaFXEx/eq3KnynZ8gRtuHdROWFLMJXAAtashReCKmya2SDDgtk
	riikgdSC1tGkxTsC5VwjyWMPjHYn0IJ8BnPMI3W8QYv5/yJ7UmVyrwL4yYJrN9nCfpOHynpeMRg
	2PQsstEKxT5UzML+/B5jz68D115lwM7ee0D7tZKEMCGG95SNLjtNooY+q8QQ/lxV9DPsjjKlBzJ
	oIRC9EA+Gnvh/fsWtxbmrVsuBlXwDmBucoD5R42o+c7wcEqdEJIGcLz1OPS99gsLHbk1sZREXul
	bv8PlUk64pDz6U1xuzoOSfb4T0LCA7k9SGoTxg2YgrUprqjMPKHapYi53cvAw6pNrlzw4IiNdUN
	dJTRj39Z+e+iF9pxeb+iT0eDaCmk5zq9D8j9r+FcLYZq4QAHik7KUebdfhXF1IrXy1W/W0IXP6R
	bzh3kOCTAVXb890NcaAyuPkDhVBnjWhT0fzbnVZnMBsSKJ25RTe/uRQX3xm0GzOkulSEACdFeN
X-Received: by 2002:a05:620a:3b15:b0:930:987c:c1da with SMTP id af79cd13be357-936d22c5b84mr289106985a.22.1786696632526;
        Fri, 14 Aug 2026 01:37:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.95.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce24564asm218821485a.40.2026.08.14.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:37:12 -0700 (PDT)
Message-ID: <6a7ed3b8.0ea1c686.132cd9.5131@mx.google.com>
Date: Fri, 14 Aug 2026 01:37:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6632028154175663154=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v6] Bluetooth: btrtl: Add firmware format v3 support
In-Reply-To: <20260814065920.413487-1-hildawu@realtek.com>
References: <20260814065920.413487-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6632028154175663154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1145861

---Test result---

Test Summary:
CheckPatch                    FAIL      2.47 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.44 seconds
CheckAllWarning               PASS      28.92 seconds
CheckSparse                   PASS      27.17 seconds
BuildKernel32                 PASS      25.47 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      468.27 seconds
IncrementalBuild              PASS      24.61 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6] Bluetooth: btrtl: Add firmware format v3 support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#803: 
new file mode 100644

total: 0 errors, 1 warnings, 1399 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14749594.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6] Bluetooth: btrtl: Add firmware format v3 support

21: B1 Line exceeds max length (85>80): "[    1.945295] Bluetooth: btrtl_read_chip_id() hci0: RTL: chip_id status=0x00 id=0x3e"
22: B1 Line exceeds max length (116>80): "[    1.945547] Bluetooth: btrtl_initialize() hci0: RTL: examining hci_ver=0e hci_rev=000d lmp_ver=0e lmp_subver=8922"
23: B1 Line exceeds max length (90>80): "[    1.945789] Bluetooth: rtl_read_rom_version() hci0: RTL: rom_version status=0 version=0"
24: B1 Line exceeds max length (82>80): "[    1.946034] Bluetooth: btrtl_initialize() hci0: RTL: btrtl_initialize: key id 0"
25: B1 Line exceeds max length (84>80): "[    1.946038] Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_fw.bin"
26: B1 Line exceeds max length (88>80): "[    1.950522] Bluetooth: rtl_load_file() hci0: RTL: loading rtl_bt/rtl8922du_config.bin"
28: B1 Line exceeds max length (113>80): "[    1.950844] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f000:00), chip id 62, cut 0x01, len 0000c704"
29: B1 Line exceeds max length (85>80): "[    1.950862] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image version: c5900782"
30: B1 Line exceeds max length (103>80): "[    1.950865] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_config_f000.bin"
31: B1 Line exceeds max length (113>80): "[    1.950882] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f002:00), chip id 62, cut 0x01, len 00034378"
32: B1 Line exceeds max length (85>80): "[    1.950922] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image version: 2b84a8b2"
33: B1 Line exceeds max length (103>80): "[    1.950925] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_config_f002.bin"
34: B1 Line exceeds max length (109>80): "[    1.951157] Bluetooth: rtlbt_parse_config() hci0: RTL: config file: rtl_bt/rtl8922du_config_f002.bin found"
35: B1 Line exceeds max length (113>80): "[    1.951164] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f000:00), chip id 62, cut 0x01, len 0000c704"
36: B1 Line exceeds max length (96>80): "[    1.951169] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip image, key_id mismatch (1, 0)"
37: B1 Line exceeds max length (113>80): "[    1.951177] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f002:00), chip id 62, cut 0x01, len 00034378"
38: B1 Line exceeds max length (96>80): "[    1.951179] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip image, key_id mismatch (1, 0)"
39: B1 Line exceeds max length (113>80): "[    1.951181] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f000:00), chip id 62, cut 0x01, len 0000c704"
40: B1 Line exceeds max length (96>80): "[    1.951184] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip image, key_id mismatch (2, 0)"
41: B1 Line exceeds max length (113>80): "[    1.951185] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: image (f002:00), chip id 62, cut 0x01, len 00034378"
42: B1 Line exceeds max length (96>80): "[    1.951187] Bluetooth: rtlbt_parse_section_v3() hci0: RTL: skip image, key_id mismatch (2, 0)"
43: B1 Line exceeds max length (98>80): "[    1.951189] Bluetooth: rtlbt_parse_firmware_v3() hci0: RTL: image payload total len: 0x00040a7c"
44: B1 Line exceeds max length (85>80): "[    2.429887] Bluetooth: rtl_finalize_download() hci0: RTL: Watchdog reset status 00"
45: B1 Line exceeds max length (82>80): "[    2.430162] Bluetooth: rtl_finalize_download() hci0: RTL: fw version 0x2b84a8b2"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/579

---
Regards,
Linux Bluetooth


--===============6632028154175663154==--
