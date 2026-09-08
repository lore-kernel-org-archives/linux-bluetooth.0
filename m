Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2EE572660
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882897; cv=none; b=c1ErdpJboe5Pss20BBcoqL26kK9U7cMdMwTYFrwDfY/fn9lh4wxXz9CsdA4mD+v0EJ5F175KATENNX0V5S+GsAQPuhLv8vdVm4qtWYfQFFTqfjis/zG5Oa0X06W06dQWdtFw7ifc47rC+B915W7Wuc9nBXN9YHDgkl2gTcuqLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882897; c=relaxed/simple;
	bh=4asvUjcEltihO7+PwOB4XWhSFUff8FoGtQVtgcC7TNU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dt3mJK+TRcge+CO0FNd2BZBim9sMUwt6SfyhjsSBAmsoW8xwvrQ3xapV2M5rFIyXbl3qUlJKnHhGtOdmcAh19lbEfNoR5Fiueh3eJJmK75o4aGTQ04zfbRRq8ia7ytN7JXvazN9dX3Cnzd/yLCtRlpM8IVxzLU/1fcFqV/F7KCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avs+ej9w; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avs+ej9w"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52fa6005224so41777451cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882895; x=1789487695; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4YdW+dd+TsEd0W0ahwcgjmSfTMOcuzj3yvLStbZcxAA=;
        b=avs+ej9w/g2WAZJiGkLHZeeBAyf1VHYPxcZYcXrC3XK0dnJcAhC30i2I89QS6wWRcE
         yGRkcV3r1cwwlHCGuQjMOOVskU+USfLTLFHKU+qgSc/OtCfC9tgfdfjGx6XJ6AKb4HUE
         n2TkRyqwzN10CSUyoBtHIx+9UTgI+iDotxBJm6taAVkAyXJQY1NODL6bJ6twteCjzEEO
         ttIKUlMfSBU+p28cvQokGcTz3V6gZsTOuzdcA+0heOei11lnHLl38r2kuHHZfMEhgFN/
         7XOZxGjWOidW4N260UabWlhubn4ypI4WWKCk9YwyPrgjHriO/eWQa+aKoOOr77mFZ12G
         vfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882895; x=1789487695;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4YdW+dd+TsEd0W0ahwcgjmSfTMOcuzj3yvLStbZcxAA=;
        b=n+JyMxxS/58L6mxv/pQ80Q0UfE1MCrl+sBL1WHh5O/4j2rPgILXUfSype+mSNzM7rR
         T9zcXrJxD2jrV0t3At0h/RwWknuOsBD1hW08aa59QUyRV+wCJ/Mu4DNLPiGBwG9uVSvR
         DHJyF4py8WWh5pP6VIRFb/i5Bbb9sV8uxGQDN3zcVnAnDBW+rIgOiVFf2xYNBFYs86Q6
         LHAcza1L/+B6UweW2P3s+mN/YoUOMrEwFv9ZPk6FgQg9mbiTgfgNb8VM6OZhQSNHG4ow
         NM6LKOGh5cXCq/PvBhY3KGczgx2hFVjHjhxniQSju3EHzsRUaWY319O4yZf26KgNUxqT
         xjxA==
X-Gm-Message-State: AFuF++kNBfIc+7sSY+ARM1UTSVquMViABOgbOuATbY1iBHF9zRI+wch4
	Qv6AYMMFB4v6JxRdDjBQZSCtDaqs2xJA24IqtPrpp47slSGCkb9/B+PUy7kp6A==
X-Gm-Gg: AYBFou0y5GooxaZCW4WpG58MEnAExfjvd0prLLFbbQmlpVP+qv1N2Z+8CrtCUTusyCk
	7NLqAa+svpBRjXUigFleARcRB4S3I4h2uxa3Z+vdiNlwmN30czDIwecgbWJ+VoEWgEPEqJ5L+x/
	dsvZqe1enjUoOHVQKIG9QFApcZz8Y6AIuICN4gM05yYPidY9nFrzbQM+k7VJ5ASA6Rg2EsRgq86
	rOW1j9pDfi1S7MP0HMj0zkT9HBtik3uUGeS5wOtN+XNXSONzc2WkiDt8VHb+Cez9BubmR/+5cqQ
	ot/NRc3w1DR9/p6UDjCECTZIdTRry0iwlPbGvTDzLjn32BO7vdPWO38xsGxtRYnE+0rjUnik3SH
	YzNDCeFQb7mlSc4SLydzINfxukqUzzlg13iJ17WPSULcELML2NU2V4ew2tAaQYQ5m9zhV88XmXQ
	a3taM/zhr1X7FsPzy8vxQuqdafNCngW09fYpfTvTwcCbL+eIR2yW0Lt9eC3H+EAuHjXiw=
X-Received: by 2002:a05:622a:5a1b:b0:51b:f40b:2fb3 with SMTP id d75a77b69052e-530546cf804mr366247501cf.9.1788882890047;
        Tue, 08 Sep 2026 08:54:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.30.251])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53054116466sm116000761cf.6.2026.09.08.08.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:54:47 -0700 (PDT)
Message-ID: <6aa02fc7.8d510ab8.195d0.d724@mx.google.com>
Date: Tue, 08 Sep 2026 08:54:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2038867678436378534=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [RESEND,v7] Bluetooth: btrtl: Add firmware format v3 support
In-Reply-To: <20260908075517.661675-1-hildawu@realtek.com>
References: <20260908075517.661675-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2038867678436378534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160249/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.44 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.64 seconds
CheckAllWarning               PASS      29.72 seconds
CheckSparse                   PASS      27.79 seconds
BuildKernel32                 PASS      25.69 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      474.85 seconds
IncrementalBuild              PASS      26.04 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RESEND,v7] Bluetooth: btrtl: Add firmware format v3 support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#839: 
new file mode 100644

total: 0 errors, 1 warnings, 1425 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14798218.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RESEND,v7] Bluetooth: btrtl: Add firmware format v3 support

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
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/720

---
Regards,
Linux Bluetooth


--===============2038867678436378534==--
