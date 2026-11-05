Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847992;
	b=wV8t8/n2gNlIcBhCCSVR0nAlz2FOzCyKOlqs+j36dHJJDcTsxR/E5h8joItSQ24ikzQa
	 oZlHvAw1QSPtO2ScJIFt1g7vI9ZLZyALJRyMsVES0oi2VYw76MrxzW0TlGY/sqy9qySyY
	 ItROw4UmR6lFWNcvLgAyTI3E5gIBs8f3yYyIy3wQqqgTB7vLxs528+8LmnU438AythdGl
	 PdQcK0geDMAi0eUlNu8s7tL2rnWFEzBTu2Xq1oXImF9PlyYtDJdsSEZgT2CICmPtRsXBY
	 KYhed6z7TPxhwdnGB9t6Z2AegWntG83hlRxBAQ5EhJITDuYd4zE0Gz88gTbfvhSfuOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=8KV71TIVfqv7FGsCF/SMomGx4eolSKW1uov+T9JGzKM=;
	b=RTF8Nogmf+ne8re0/ObDTiZ98sSIjIQ2+jJHvm746D0AbhA6f9r+2R5ZZ21Vb+LgKbiO
	 P/yNehNkp2C+2b4lm+bTmPkEpI8t4k9Wq9TcyY+c89sMVarrACFT7mazp4It0idxwBgmZ
	 whrpiVQjbK9KLeMBKvkXHG8zcOqfbptl7cmFdY2HP46u5xW7tsmQQFXX0CifteIADEGfL
	 ghUiSmheFVT0jbMEkrtvVr57P6PY7muvZNmY3lbra8cyZMTetYxWUZc3+PHVlko2s3vtA
	 P/bk9rpktgDQ1G/CX1xbp+a/U7QXhFVrVsDkm+gBA3fG9G4C7EoX7ppN7wpdYhAfcYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nwrqyrce;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56F606A326
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 03:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB56F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nwrqyrce
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14394530ec6so1997838c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 19:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793847991; x=1794452791; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8KV71TIVfqv7FGsCF/SMomGx4eolSKW1uov+T9JGzKM=;
        b=nwrqyrceR/Z9Rdt6UaydqEOGMy9VQ1tGjjFQB5tsMDAzI/Y0yqg4a+igAEuy+zGLW5
         VMX1h1WaO5zcpQiQTKyWqi2CZiVlmgejejI5Fnq6OEeBADNdLH3p22sH1SnImERoNVhN
         1gMZJfEiQPff5EDs92QaIOnvMRMEgNtL7SzcYp2qalSBeE6PXFDV8/9cnZgFGzc7jJ8R
         2e9fqX/LupS8+eNPBK5Ng92e51MivhFwGSkFPAM/ybEeaS//kSI0OGi3rm5evQ+7IGUB
         NUEpFBG93oT7ztKsmEWPKAAOSaO4jZ2D72c7cmwORg/tYiyRNzjpzsaMq0Q2qXqLVDN/
         75gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793847991; x=1794452791;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8KV71TIVfqv7FGsCF/SMomGx4eolSKW1uov+T9JGzKM=;
        b=G7VRsoqnXqEdNFspAIsewwOIfIviDStihO9oz5p1YeSz1DStgdr07WgFJmMyprPJ6j
         XsSSTnD6WVyyZNzzjlGdQEyfc0rDvEX90+JPnm26+cvXgfCGIDuM3LwEkv9U8aQGi/eQ
         gEPU15Aes6w5ffvdj/h79zZxHFDd6274s8aEKovr8l+qVudyGgCF4vPBNr2rAQf0fMbe
         fcf1JYcYf/4eYwfo7IjUqAsCXqar7GkB5T3oCba0YG2JPHRlfMf9y3U5fAexUpIj90Bv
         OpNl+D/okSTE3AHcBqzRT2aW1OofK9JLOlqzU+0eVAKAJf+RIi3ZKXaiok7fvG2BC4tC
         hNgg==
X-Gm-Message-State: APuU4Z8hwDO3slA7ecXvziBW6yry+s+9qblhk01+/BKcsxpJbJHTjNEc
	R9fArktUO/4pcSzCSMWFeOMy6Culh8DThdhrvHATe5wylNbjuCB90OfuRmEwCA==
X-Gm-Gg: AYBFou0at+x/mfYT3CA/N+0gCUi6w0c6w2/jTQnnQbD7tJvMDGd/ze2hTyYDMsKMDcB
	hvwGOWfuePpBrPnSpJlMBIk/NfttFdd0/3rb1sHUuh8Cbww7bjfsIAmdqb8jjEVLn/pwk6SdsA9
	ujPFOBFZJo9hE16fg8yHCryVUe00rHngSr6ZsgnjFhyxAuxlv8O4bcyieZOKfGGt/22jBtOUSns
	zhJwW5FdgUhiIbhWXSO2NpVPcA47TWPHX3+F7BiC+EDb6OhWTWRkux0XqwPAe5ajWHnfrcsPQ4L
	o3kjwYlEDY7wQoExYaguXf/WYUGC447jNyQx0czf9L45wFi2a2VCCDEpeUXzxuR4OAgFE6Ialeh
	sngertJwH3EHnYotDP6GEniRXgAhWOP5FEE5RoBo40JYA7cuGn2R0trLBPRVoaMuABEu+WkG017
	tpWvGMWH4cMnmq28Ei5r00LxCQOkFTQrcb75WRvfoIRghEO+xycPTQk+JTZBYYASI5Ima6mDgP0
	sg2SOuQFJ16Wf2ZCWGFmBMHc8hfukMszmzcFiwZwPeHXc9nK7+/GZLv/fMhkgs=
X-Received: by 2002:a05:7022:7e0c:b0:15c:1679:1cc7 with SMTP id a92af1059eb24-1ac5f181878mr25359398c88.37.1793847990537;
        Wed, 04 Nov 2026 19:06:30 -0800 (PST)
Received: from [172.17.0.2] ([13.71.233.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c283sm12771254c88.4.2026.11.04.19.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 19:06:30 -0800 (PST)
Message-ID: <6aebf2b6.0773843b.1c977c.dd28@mx.google.com>
Date: Wed, 04 Nov 2026 19:06:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4249184452858733823=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add support for HDT and EKS
In-Reply-To: <20261104222055.1207928-2-luiz.dentz@gmail.com>
References: <20261104222055.1207928-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4249184452858733823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1202520/

---Test result---

Test Summary:
CheckPatch                    FAIL      9.11 seconds
GitLint                       PASS      2.90 seconds
BuildEll                      PASS      20.41 seconds
BluezMake                     PASS      315.36 seconds
MakeCheck                     PASS      19.60 seconds
MakeDistcheck                 PASS      149.23 seconds
CheckValgrind                 PASS      351.95 seconds
CheckSmatch                   WARNING   338.11 seconds
bluezmakeextell               PASS      99.95 seconds
TestFunctional                PASS      1186.21 seconds
IncrementalBuild              PASS      575.08 seconds
ScanBuild                     PASS      1185.30 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,03/10] monitor: Add HCI decoding for HDT
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#161: FILE: monitor/bt.h:259:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#167: FILE: monitor/bt.h:265:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#177: FILE: monitor/bt.h:275:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#182: FILE: monitor/bt.h:280:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#190: FILE: monitor/bt.h:288:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#198: FILE: monitor/bt.h:296:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#205: FILE: monitor/bt.h:303:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#212: FILE: monitor/bt.h:310:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#217: FILE: monitor/bt.h:315:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#233: FILE: monitor/bt.h:3318:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#239: FILE: monitor/bt.h:3324:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#245: FILE: monitor/bt.h:3330:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#256: FILE: monitor/bt.h:3341:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#262: FILE: monitor/bt.h:3347:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#273: FILE: monitor/bt.h:3358:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#282: FILE: monitor/bt.h:3367:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#287: FILE: monitor/bt.h:3372:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#305: FILE: monitor/bt.h:3390:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#318: FILE: monitor/bt.h:3403:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#325: FILE: monitor/bt.h:3410:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#348: FILE: monitor/bt.h:3433:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#363: FILE: monitor/bt.h:3448:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#381: FILE: monitor/bt.h:3466:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#388: FILE: monitor/bt.h:3473:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#411: FILE: monitor/bt.h:3496:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#418: FILE: monitor/bt.h:3503:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#426: FILE: monitor/bt.h:3511:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#436: FILE: monitor/bt.h:3521:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#441: FILE: monitor/bt.h:3526:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#448: FILE: monitor/bt.h:3533:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#454: FILE: monitor/bt.h:3539:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#473: FILE: monitor/bt.h:4528:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#483: FILE: monitor/bt.h:4538:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#494: FILE: monitor/bt.h:4549:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#527: FILE: monitor/bt.h:4582:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#548: FILE: monitor/bt.h:4603:
+} __attribute__ ((packed));

WARNING:LINE_SPACING: Missing a blank line after declarations
#1143: FILE: monitor/packet.c:10542:
+		uint16_t mask = print_bitfield(2, rates, fields);
+		if (mask)

WARNING:SPACING: Unnecessary space before function pointer arguments
#1465: FILE: monitor/packet.c:10864:
+	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#1468: FILE: monitor/packet.c:10867:
+	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1589: FILE: monitor/packet.c:10988:
+				enhanced_accept_sync_conn_request_cmd, 63, true },

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1740: FILE: monitor/packet.c:12039:
+				sizeof(struct bt_hci_cmd_le_create_big_v2), true,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#1964: FILE: monitor/packet.c:15003:
+				i < (int) (size / sizeof(*evt->bis_handle)); i++)

/home/runner/work/bluez/bluez/src/patch/14951052.patch total: 0 errors, 42 warnings, 1855 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14951052.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,04/10] monitor: Add LL decoding for HDT
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#154: FILE: monitor/ll.c:570:
+				"64 bits" : "128 bits", (v2->flags >> 1) & 0x01);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#174: FILE: monitor/ll.c:605:
+				"64 bits" : "128 bits", (v2->flags >> 1) & 0x01);

WARNING:LINE_SPACING: Missing a blank line after declarations
#212: FILE: monitor/ll.c:704:
+		uint16_t mask = print_bitfield(2, rates, fields);
+		if (mask)

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#241: FILE: monitor/ll.c:777:
+				"64 bits" : "128 bits", (v2->flags >> 4) & 0x01);

/home/runner/work/bluez/bluez/src/patch/14951051.patch total: 0 errors, 4 warnings, 284 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14951051.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,05/10] emulator: Add HDT support to btdev
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#652: FILE: emulator/btdev.c:7262:
+static void le_cis_estabilished_fill(struct bt_hci_evt_le_cis_established_v3 *evt,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#766: FILE: emulator/btdev.c:7348:
+		le_cis_estabilished_fill(&evt, &conn->link->dev->le_cig[cig_idx],

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#900: FILE: emulator/btdev.c:8456:
+	} __attribute__ ((packed)) rsp;

/home/runner/work/bluez/bluez/src/patch/14951054.patch total: 0 errors, 3 warnings, 1249 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14951054.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,07/10] shared/gatt: Add MIC length permission checks
WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#572: FILE: unit/test-gatt.c:4735:
+	define_test_server("/robustness/mic-len/read-multiple-variable", test_server,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#593: FILE: unit/test-gatt.c:4756:
+	define_test_server("/robustness/mic-len/read-by-group-type", test_server,

/home/runner/work/bluez/bluez/src/patch/14951055.patch total: 0 errors, 2 warnings, 379 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14951055.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,08/10] main.conf: Add HDT configuration
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#213: FILE: src/main.c:193:
+static const char *hdt_options[] = {

/home/runner/work/bluez/bluez/src/patch/14951056.patch total: 0 errors, 1 warnings, 152 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14951056.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,09/10] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
WARNING:MACRO_ARG_UNUSED: Argument 'name' is not used in function-like macro
#414: FILE: tools/iso-tester.c:954:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'setup' is not used in function-like macro
#414: FILE: tools/iso-tester.c:954:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'func' is not used in function-like macro
#414: FILE: tools/iso-tester.c:954:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#1937: FILE: tools/iso-tester.c:5119:
+							&connect_hdt_type_mismatch,

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#3110: FILE: tools/l2cap-tester.c:3858:
+					BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2,

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#3474: FILE: tools/mgmt-tester.c:14370:
+	} __attribute__((packed)) *cmd = param;

/home/runner/work/bluez/bluez/src/patch/14951058.patch total: 0 errors, 6 warnings, 3329 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14951058.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,10/10] l2test: Add HDT options
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#204: FILE: tools/l2test.c:127:
+static int mic_len = 0;

/home/runner/work/bluez/bluez/src/patch/14951057.patch total: 1 errors, 0 warnings, 303 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14951057.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4216:52: warning: array of flexible structuresmonitor/bt.h:4204:40: warning: array of flexible structuresemulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2762

---
Regards,
Linux Bluetooth


--===============4249184452858733823==--
