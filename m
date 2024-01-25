Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871F763B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152526; cv=none; b=gKofwu53mAv/CP9HN99wk0LmKOY17R4lZ8u/JYC8ftJgT/Ok9okfI130KLJJ1UNMmJ2FJUfbJDCG4pP3h3LNlB8YGgXjg5IH+wORjHgqkCQc7cK1e7djki6lnnGIVbt2OKnlriUuHJgucPLigWngIFMnEka2mEGhN+tFkMxu62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152526; c=relaxed/simple;
	bh=bntNJVwybTkJESSHsKWuhjLHSGqj3IXjcbFiPmqKWVs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HyIUGHQWpBM98FdE2tylcgRhY6ezfYlJDpjMCtEWKnr/KSOw28pa0okq++7kTNkNNmIZJyao2m2oMqo9VC0fTa61EISrIAHOdGrLLV9Op+QV+zsVbxlW2CwCrh61u7Hmv6oeBdQSBtKrfx1d+x6jDydz2OZL1fjT4NiiIXYVCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL5m6akf; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL5m6akf"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ddef319fabso4100921a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 19:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706152514; x=1706757314; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aQaZkNBOnbXkPBBnv+EK4XaTCnYHzuNrpLBBlHyxBbg=;
        b=iL5m6akf8Kdlze758w8j1XFqzeGRdoaArpILVpkefKIESdwuHLzp7SMosM4vDKdjQs
         gH7AxIX5785QRBuhCUjnqlxDkm+Dcia2hei2vYPiLT19O82x8CueLj7CDDr6cznzXwxd
         Acq3t631kenaWF0nGarOO1yUl/naHBXONLNodYIGAXBcZpWq8A8oO4NXl9ZLRG8sxGAs
         Qnf3Q6DHdSJg6DDhA1vmuMh8t/hVd3Cy6p8DVOu4o2uiXHDSuGmsOx2FBR2kCVIxe5V9
         0F2hcbYz1v64dhSlAkddHKVPl8FOLeKnrKcA411TRlIbnyEGwT+bV4EEyEhDjP0Uh8pg
         RNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706152514; x=1706757314;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQaZkNBOnbXkPBBnv+EK4XaTCnYHzuNrpLBBlHyxBbg=;
        b=MIxLEaQqjPEgX9WWfB1UlcDQ+74ueCuVcojeiIllxin48JAezBU42iCsLIrDccJlIY
         n4vRAFCPLyMvcmj1WcFrrmS9IX6Nd28dluT5l1zyCDNdAZdvjclCt0V7kvnG+PPhp/g3
         AfnnzNT9IRXFEL64X5zWyRlFoDwRirBrnTRR5fMkxyXMGV2Y1X6DouRbzmdgbFetfjHN
         nokqSSgiCyei+q5e76MmPhCOJM+6uysSBwgeaK4TIMlZDAIR6cqAdEmjTlzYgqju1Q9h
         8NoC8YewqDxVnEtrU8CVz2btuXKX9I9mR05zW+oExDWGeEtw2B7hrjUFbZRfg9IeA2Ol
         wtnQ==
X-Gm-Message-State: AOJu0YwVX66ndLW5UFrn2yiQg4HCTvebJe1gzJUc1pX6+WtTDWmyy/5G
	24va/ZYCuyV9ORgTxFPNZxf8drEjNN+hvhrUb6Gzbh8t1LckzjDbFuaHEFkm
X-Google-Smtp-Source: AGHT+IGu+24RwFO2u7SnEYPcw59Wpsxa5igJJxqKtbpUil806oqVKB+mTxaZK4bVgrqPyVDIlnyuwg==
X-Received: by 2002:a9d:6b84:0:b0:6dd:f0a6:dfea with SMTP id b4-20020a9d6b84000000b006ddf0a6dfeamr234963otq.26.1706152514133;
        Wed, 24 Jan 2024 19:15:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVw9H3AejS977ugb5QTawoumMv/kvCvkWdAslAM3EO3hL0wmOgjPGza9zYIVKo6Ejj6wrDHTIEaFxuEMcp7hXZufyvJvrvL12uB4y4SVajEXMr3vEnx7nARHSLd
Received: from [172.17.0.2] ([20.171.122.190])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b006dbc4cb72ebsm10615401pff.201.2024.01.24.19.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 19:15:13 -0800 (PST)
Message-ID: <65b1d241.a70a0220.b4b7d.474a@mx.google.com>
Date: Wed, 24 Jan 2024 19:15:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6493280233050624457=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+emil.l.velikov.gmail.com@kernel.org
Subject: RE: Remove support for external plugins
In-Reply-To: <20240125-rm-ext-plugins-v3-1-d141f7870bb6@gmail.com>
References: <20240125-rm-ext-plugins-v3-1-d141f7870bb6@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6493280233050624457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819668

---Test result---

Test Summary:
CheckPatch                    FAIL      2.89 seconds
GitLint                       PASS      1.83 seconds
BuildEll                      PASS      23.99 seconds
BluezMake                     PASS      735.43 seconds
MakeCheck                     PASS      11.83 seconds
MakeDistcheck                 PASS      163.54 seconds
CheckValgrind                 PASS      226.28 seconds
CheckSmatch                   PASS      330.80 seconds
bluezmakeextell               PASS      107.89 seconds
IncrementalBuild              PASS      5466.84 seconds
ScanBuild                     PASS      954.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,2/8] obexd: factor out external plugin support
WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#134: FILE: obexd/src/plugin.c:47:
+static gboolean add_external_plugin(void *handle, const struct obex_plugin_desc *desc)

/github/workspace/src/src/13529768.patch total: 0 errors, 1 warnings, 176 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13529768.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,5/8] bluetoothd: factor out external plugin support
WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#243: FILE: src/plugin.c:190:
+	 * plugins are loaded. */

WARNING:TRAILING_SEMICOLON: macros should not use a trailing semicolon
#318: FILE: src/plugin.h:51:
+#define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
+		const struct bluetooth_plugin_desc \
+		__bluetooth_builtin_ ## name = { \
+			#name, priority, init, exit \
+		};

/github/workspace/src/src/13529772.patch total: 0 errors, 2 warnings, 211 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13529772.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,7/8] bluetoothd: change plugin loading alike obexd
WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#108: FILE: src/plugin.c:52:
+		if (err == -ENOSYS || err == -ENOTSUP)

/github/workspace/src/src/13529774.patch total: 0 errors, 1 warnings, 106 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13529774.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6493280233050624457==--
