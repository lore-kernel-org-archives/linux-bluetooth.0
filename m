Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833665;
	b=gYHdr0jnCqbJk+Z7MbStEHwXKXBwQAIx+uaq3tTqkIJYy313dYCPHRr7egogUZJ9AKBr
	 oKeDRG0weJQa1kAgeZn35XmsGUQDozySqQf02eB9HHMR/zHbw8kCIogNKauWSuZvvO4Ht
	 R51KTmrU3pAwxd7w7MoTyumAWJ4EnUok0cSzaIVzQXrKhsPjiKOh22xuhwdlR/uac46ei
	 8R7ynBig8Dm4/BKoUOsqDs+aVEXkNd5TKov4rLm7bVCBYuyJyOAZYVI5OXsklvC/43sdu
	 mFZXr7PCc157sVJbHpXSmyqcyPkES5vlivDCFE/29OMMgUrO+IUdcwG1C1IKzkV13Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=obbvWxLPV30cyUtgnxAhrMD1pOHgaaGcGUxNCHFOSe0=;
	b=RITpmjHbIk118tnYne2ifewSpW5xZ+U6FUOOKucaXXITnx2zab9KbCtNLJF9P7c3stQP
	 I+rEGjqV2tC34JdvkjxhzS49d/s82FVhWL8wDF1H552HRlmbkF5MAs6FNlx2mDlwUlPn/
	 Cjr2cXvV1SnCeIm/Ef4M0dr1DH4TpbFsb+OjbVIip1HGg2uu5AFU/8zyjBgiTnJUcRd7K
	 S+KJB3gjdY78UIrDlNEovqggw5bBlEd4O2Xx9ZQ0lbiAmbCeChUt8ZIPNLoej0jDMWhzD
	 XpREj2QzuvR3EGDqSno6gJxTggh9yOVoJoA3HO9m/c6u+Bh/wastozmg40+8VKs0xbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sSUCEmRt;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CDA606A326
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 23:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CDA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sSUCEmRt
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so1415361c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 15:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793833664; x=1794438464; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=obbvWxLPV30cyUtgnxAhrMD1pOHgaaGcGUxNCHFOSe0=;
        b=sSUCEmRtUzYTCFlHGbs1z+0ed+Z637Y8M6zVNlBb9Kqn25gN1s7GQxPTEqEGH6Os2t
         p+R+N9YVd3DLu9XpvmHe6uxKHjgTwGmJgdUk+hqUUQRwZ3+zJIEYVcCGBRjbY5sZjgve
         eFh5a9EU7WDXzNKk/xbi5jgKyrErnOgBvts2SouwgpeM9Tpfnj2yTvw7t0nccyV848Gg
         TI17B6Tkblz8+Kg+zWEcMilF8Vuv/5IFpEN+aQ2y7mWD9gQnhGp7xxQN0FbXQl5Y5dcI
         kU5bMkp9LB1LFwXX/NbbZw3E3Ef7H88rLsI199nidahUTw+Kr+/5k0YbtvgjYa1zyTgr
         fEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833664; x=1794438464;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=obbvWxLPV30cyUtgnxAhrMD1pOHgaaGcGUxNCHFOSe0=;
        b=MJjaDmYzW86JuI+YAcF9lDRgmDRqBJqW+FI56WWl3DYKQ9SIv2J4H1kgpMgdA5tyEC
         QtWOazfwM+Ib42LfLc5sMHpuj5vk1uX18StN0js7VjTBR0NO6OtnkIXRhwuNrTvVAOCK
         vjsjd4yergDrJwDCZYF2kjxceuCCAiqyyAnymMGDyE/KYJkIq8+4ywBj/GgtRv6KPUa3
         ++r+bstdxYJpFiJ/qq3HpYcem9LgMwKj6pvDBFhiSOLvp1vjdMI59Ts5fK9Rx2iAfHQ2
         N91wIzPNGsrj0uMx1ajmoWrlnXn4Ci4ahPUAEA4prpef5Kl5IOwClyVNTSY3YAS6Ov4C
         9UkA==
X-Gm-Message-State: APuU4Z+x8SkiuBjF0q6MyaTyoJMxGV5E1Oa4dQTi59lV+bfjQUNkf1Ls
	qWYbY29NS40M42w0Vqi6YjvrcyI8XNzFpvGjoL/CoxvU4mRCjwKewFuEwMUuUg==
X-Gm-Gg: AYBFou3fqKf6oWoWSIz+V3ezEHZBN10o/zdQLRcCCgJ/L8K7zvZYtxubqm+1a5Uglcl
	ab52R+eJ/pUK7lJMWkN6PNDadEb4DiJw7Gff+U0M+BDQcmkaKxUJ4j+bmTJvcTqLX4I5pOuN+Le
	EuWkvz/z+zE5WTd7nyNFlzrzfnCTqLFjZIRESI4Tobxa36m85XBS6DBWZVYtqcH1VAfba0o0DfI
	oIowX/KiNW+GwsKA/1T9VFsq12YZyYFFrBT+nGMZ/KNScwvB5z3MwD2uW0lOLHqnM1PHT0L6zvb
	HE7KT7oaWsG4B6UGHFscZ2mBpsg6IUdeDAk/XvLEJKjgtkO91S0MryXbu/qeiTXoLawNQeZMOms
	LNfeBg9ivXR/profFlOWIWLFzw3eKODM7eAU1xkBTI+VPag6S1NY7jU0epK8bZcnKgDwfCiwO02
	OlFfhwCe8R1NSGimEg8lCTeCVI06WudGd/jZCfSmAy3CAE0MGwNMThli3I0VlJ/3i2Kqn4ZRU81
	iI4o6TZHHutLlYN9u6DgSzBoit6qj/P/ZOyvjWdBABMay2M6Fp/+dCS23RISJyE
X-Received: by 2002:a05:7022:b05c:b0:1b0:430d:d81c with SMTP id a92af1059eb24-1b0430dd84dmr18433329c88.25.1793833662719;
        Wed, 04 Nov 2026 15:07:42 -0800 (PST)
Received: from [172.17.0.2] ([172.184.211.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3784f78sm12865380eec.2.2026.11.04.15.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:07:41 -0800 (PST)
Message-ID: <6aebbabd.99020481.122143.54ec@mx.google.com>
Date: Wed, 04 Nov 2026 15:07:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2056447727760078505=="
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
In-Reply-To: <20261104183647.839090-2-luiz.dentz@gmail.com>
References: <20261104183647.839090-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2056447727760078505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1202167/

---Test result---

Test Summary:
CheckPatch                    FAIL      7.02 seconds
GitLint                       PASS      2.04 seconds
BuildEll                      PASS      20.81 seconds
BluezMake                     PASS      319.48 seconds
MakeCheck                     PASS      14.74 seconds
MakeDistcheck                 PASS      151.08 seconds
CheckValgrind                 PASS      353.41 seconds
CheckSmatch                   WARNING   347.21 seconds
bluezmakeextell               PASS      103.04 seconds
TestFunctional                FAIL      1232.30 seconds
IncrementalBuild              PASS      575.94 seconds
ScanBuild                     PASS      1204.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/9] monitor: Add HCI decoding for HDT
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

/home/runner/work/bluez/bluez/src/patch/14946300.patch total: 0 errors, 42 warnings, 1855 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14946300.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,3/9] monitor: Add LL decoding for HDT
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

/home/runner/work/bluez/bluez/src/patch/14946299.patch total: 0 errors, 4 warnings, 284 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14946299.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,4/9] emulator: Add HDT support to btdev
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#610: FILE: emulator/btdev.c:7220:
+static void le_cis_estabilished_fill(struct bt_hci_evt_le_cis_established_v3 *evt,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#724: FILE: emulator/btdev.c:7306:
+		le_cis_estabilished_fill(&evt, &conn->link->dev->le_cig[cig_idx],

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#858: FILE: emulator/btdev.c:8414:
+	} __attribute__ ((packed)) rsp;

/home/runner/work/bluez/bluez/src/patch/14946302.patch total: 0 errors, 3 warnings, 1207 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14946302.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,6/9] shared/gatt: Add MIC length permission checks
WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#572: FILE: unit/test-gatt.c:4735:
+	define_test_server("/robustness/mic-len/read-multiple-variable", test_server,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#593: FILE: unit/test-gatt.c:4756:
+	define_test_server("/robustness/mic-len/read-by-group-type", test_server,

/home/runner/work/bluez/bluez/src/patch/14946316.patch total: 0 errors, 2 warnings, 379 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14946316.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,7/9] main.conf: Add HDT configuration
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#213: FILE: src/main.c:193:
+static const char *hdt_options[] = {

/home/runner/work/bluez/bluez/src/patch/14946317.patch total: 0 errors, 1 warnings, 152 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14946317.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,8/9] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
WARNING:MACRO_ARG_UNUSED: Argument 'name' is not used in function-like macro
#392: FILE: tools/iso-tester.c:932:
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
#392: FILE: tools/iso-tester.c:932:
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
#392: FILE: tools/iso-tester.c:932:
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
#2922: FILE: tools/l2cap-tester.c:3698:
+					BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2,

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#3279: FILE: tools/mgmt-tester.c:14370:
+	} __attribute__((packed)) *cmd = param;

/home/runner/work/bluez/bluez/src/patch/14946319.patch total: 0 errors, 5 warnings, 3136 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14946319.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,9/9] l2test: Add HDT options
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#204: FILE: tools/l2test.c:127:
+static int mic_len = 0;

/home/runner/work/bluez/bluez/src/patch/14946318.patch total: 1 errors, 0 warnings, 303 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14946318.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2292:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4216:52: warning: array of flexible structuresmonitor/bt.h:4204:40: warning: array of flexible structuresemulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bearer::test_bearer_le_conn_update[hosts14-vm2]: failed on teardown with "pytest_bluezenv.plugin.CoredumpWarning: Core dump: test-bluezenv-hosts14.1-bluetoothd-1793831616-189.core
        /usr/bin/gdb: warning: Couldn't determine a path for the index cache directory.
        [New LWP 189]
        [Thread debugging using libthread_db enabled]
        Using host libthread_db library "/usr/lib/x86_64-linux-gnu/libthread_db.so.1".
        Core was generated by `/home/runner/work/bluez/bluez/src/src/src/bluetoothd --nodetach -f /run/bluetoo'.
        Program terminated with signal SIGABRT, Aborted.
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44

        warning: 44	./nptl/pthread_kill.c: No such file or directory

        Thread 1 (Thread 0x7fcc95cd3900 (LWP 189)):
        #0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, no_tid=0) at ./nptl/pthread_kill.c:44
                tid = <optimized out>
                ret = 0
                pd = <optimized out>
                old_mask = {__val = {4412750543122677053}}
                ret = <optimized out>
        #1  __pthread_kill_internal (threadid=<optimized out>, signo=6) at ./nptl/pthread_kill.c:89
        No locals.
        #2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at ./nptl/pthread_kill.c:100
        No locals.
        #3  0x00007fcc9642eb7e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
                ret = <optimized out>
        #4  0x00007fcc964118ec in __GI_abort () at ./stdlib/abort.c:77
                act = {__sigaction_handler = {sa_handler = 0x0, sa_sigaction = 0x0}, sa_mask = {__val = {0, 136118580285088, 11575157580189038336, 140729153238016, 140729153238304, 140729153238160, 22, 140516667927504, 0, 140729153238096, 140516684772886, 140516659306496, 4096, 0, 11575157580189038336, 140516658184216}}, sa_flags = -1753899008, sa_restorer = 0x16}
        #5  0x00007fcc97039a0f in __sanitizer::Abort () at ../../../../src/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp:165
        No locals.
        #6  0x00007fcc9715fc2d in __sanitizer::Die () at ../../../../src/libsanitizer/sanitizer_common/sanitizer_termination.cpp:58
        No locals.
        #7  0x00007fcc9713493c in __asan::ScopedInErrorReport::~ScopedInErrorReport (this=0x7ffe0f3035c6) at ../../../../src/libsanitizer/asan/asan_report.cpp:221
                buffer_copy = {buffer_ = {<__sanitizer::InternalMmapVectorNoCtor<char, false>> = {data_ = 0x7bcc8ff9b000 '=' <repeats 65 times>, "\n==189==ERROR: AddressSanitizer: heap-use-after-free on address 0x7cdc951e1720 at pc 0x55d5fef5c4cd bp 0x7ffe0f304240 sp 0x7ffe0f304230"..., capacity_bytes_ = 8192, size_ = 4349}, <No data fields>}}
                buffer_copy = <optimized out>
                l = <optimized out>
        #8  0x00007fcc97133e02 in __asan::ReportGenericError (pc=94377593914573, bp=140729153241664, sp=sp@entry=140729153241648, addr=137286836426528, is_write=is_write@entry=false, access_size=8, fatal=true, exp=<optimized out>) at ../../../../src/libsanitizer/asan/asan_report.cpp:536
                in_report = {error_report_lock_ = {<No data fields>}, static current_error_ = {kind = __asan::kErrorKindGeneric, {Base = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, DeadlySignal = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, signal = {siginfo = 0x7fcc00000002, context = 0x7cdc951e1720, addr = 0, pc = 0, sp = 6103148528072, bp = 137286836426528, is_memory_access = 96, write_flag = __sanitizer::SignalContext::Unknown, is_true_faulting_addr = 192}}, DoubleFree = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, second_free_stack = 0x7fcc00000002, addr_description = {addr = 137286836426528, alloc_tid = 0, free_tid = 0, alloc_stack_id = 456, free_stack_id = 1421, chunk_access = {bad_addr = 137286836426528, offset = 96, chunk_begin = 137286836426432, chunk_size = 232, user_requested_alignment = 8, access_type = 2, alloc_type = 1}}}, NewDeleteTypeMismatch = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, free_stack = 0x7fcc00000002, addr_description = {addr = 137286836426528, alloc_tid = 0, free_tid = 0, alloc_stack_id = 456, free_stack_id = 1421, chunk_access = {bad_addr = 137286836426528, offset = 96, chunk_begin = 137286836426432, chunk_size = 232, user_requested_alignment = 8, access_type = 2, alloc_type = 1}}, delete_size = 0, delete_alignment = 140729153239696}, FreeNotMalloced = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, free_stack = 0x7fcc00000002, addr_description = {data = {kind = 2501777184, {shadow = {addr = 0, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 0, alloc_tid = 0, free_tid = 6103148528072, alloc_stack_id = 2501777184, free_stack_id = 31964, chunk_access = {bad_addr = 96, offset = 137286836426432, chunk_begin = 232, chunk_size = 140514150080520, user_requested_alignment = 0, access_type = 0, alloc_type = 0}}, stack = {addr = 0, tid = 0, offset = 6103148528072, frame_pc = 137286836426528, access_size = 96, frame_descr = 0x7cdc951e16c0 "\215\005"}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 0, size = 6103148528072, size_with_redzone = 137286836426528, name = 0x60 <error: Cannot access memory at address 0x60>, module_name = 0x7cdc951e16c0 "\215\005", has_dynamic_init = 232, gcc_location = 0x7fcc00006008, odr_indicator = 0}, {beg = 140729153239696, size = 140516684812594, size_with_redzone = 140729153239776, name = 0x2 <error: Cannot access memory at address 0x2>, module_name = 0x7fcc00000000 "", has_dynamic_init = 140516690451664, gcc_location = 0x7ffe0000058f, odr_indicator = 140516655126768}, {beg = 140729153239824, size = 2, size_with_redzone = 140516685340608, name = 0x7cac951e0b90 "\003\021", module_name = 0x7ffe0f303ae0 "0C0\017\376\177", has_dynamic_init = 140516683691832, gcc_location = 0xa0, odr_indicator = 137080677993360}, {beg = 140516659417296, size = 140729153239808, size_with_redzone = 137080677993376, name = 0x55d5fee70a40 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", module_name = 0x7ffe0f304410 "", has_dynamic_init = 136118585380640, gcc_location = 0x7ffe0f304330, odr_indicator = 140516684620737}}, reg_sites = {254819072, 32766, 2522642050, 30}, access_size = 140729153239824, size = 205 '\315'}, wild = {addr = 0, access_size = 0}}}}}, AllocTypeMismatch = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, dealloc_stack = 0x7fcc00000002, alloc_type = 2501777184, dealloc_type = 31964, addr_description = {data = {kind = __asan::kAddressKindWild, {shadow = {addr = 0, kind = (unknown: 0xc8), shadow_byte = 1 '\001'}, heap = {addr = 0, alloc_tid = 6103148528072, free_tid = 137286836426528, alloc_stack_id = 96, free_stack_id = 0, chunk_access = {bad_addr = 137286836426432, offset = 232, chunk_begin = 140514150080520, chunk_size = 0, user_requested_alignment = 2704, access_type = 3, alloc_type = 0}}, stack = {addr = 0, tid = 6103148528072, offset = 137286836426528, frame_pc = 96, access_size = 137286836426432, frame_descr = 0xe8 <error: Cannot access memory at address 0xe8>}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 6103148528072, size = 137286836426528, size_with_redzone = 96, name = 0x7cdc951e16c0 "\215\005", module_name = 0xe8 <error: Cannot access memory at address 0xe8>, has_dynamic_init = 140514150080520, gcc_location = 0x0, odr_indicator = 140729153239696}, {beg = 140516684812594, size = 140729153239776, size_with_redzone = 2, name = 0x7fcc00000000 "", module_name = 0x7fcc976b5cd0 <__sanitizer::theDepot+4178832> "\217\005", has_dynamic_init = 140728898422159, gcc_location = 0x7fcc955058f0, odr_indicator = 140729153239824}, {beg = 2, size = 140516685340608, size_with_redzone = 137080677993360, name = 0x7ffe0f303ae0 "0C0\017\376\177", module_name = 0x7fcc97043738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248> "H\203;", has_dynamic_init = 160, gcc_location = 0x7cac951e0b90, odr_indicator = 140516659417296}, {beg = 140729153239808, size = 137080677993376, size_with_redzone = 94377592949312, name = 0x7ffe0f304410 "", module_name = 0x7bcc93edcf20 "0W\036\225<|", has_dynamic_init = 140729153241904, gcc_location = 0x7fcc971263c1 <___interceptor_free(void*)+113>, odr_indicator = 140729153239808}}, reg_sites = {2522642050, 30, 254819088, 32766}, access_size = 94377593914573, size = 64 '@'}, wild = {addr = 0, access_size = 6103148528072}}}}}, MallocUsableSizeNotOwned = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, addr_description = {data = {kind = 2501777184, {shadow = {addr = 0, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 0, alloc_tid = 0, free_tid = 6103148528072, alloc_stack_id = 2501777184, free_stack_id = 31964, chunk_access = {bad_addr = 96, offset = 137286836426432, chunk_begin = 232, chunk_size = 140514150080520, user_requested_alignment = 0, access_type = 0, alloc_type = 0}}, stack = {addr = 0, tid = 0, offset = 6103148528072, frame_pc = 137286836426528, access_size = 96, frame_descr = 0x7cdc951e16c0 "\215\005"}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 0, size = 6103148528072, size_with_redzone = 137286836426528, name = 0x60 <error: Cannot access memory at address 0x60>, module_name = 0x7cdc951e16c0 "\215\005", has_dynamic_init = 232, gcc_location = 0x7fcc00006008, odr_indicator = 0}, {beg = 140729153239696, size = 140516684812594, size_with_redzone = 140729153239776, name = 0x2 <error: Cannot access memory at address 0x2>, module_name = 0x7fcc00000000 "", has_dynamic_init = 140516690451664, gcc_location = 0x7ffe0000058f, odr_indicator = 140516655126768}, {beg = 140729153239824, size = 2, size_with_redzone = 140516685340608, name = 0x7cac951e0b90 "\003\021", module_name = 0x7ffe0f303ae0 "0C0\017\376\177", has_dynamic_init = 140516683691832, gcc_location = 0xa0, odr_indicator = 137080677993360}, {beg = 140516659417296, size = 140729153239808, size_with_redzone = 137080677993376, name = 0x55d5fee70a40 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", module_name = 0x7ffe0f304410 "", has_dynamic_init = 136118585380640, gcc_location = 0x7ffe0f304330, odr_indicator = 140516684620737}}, reg_sites = {254819072, 32766, 2522642050, 30}, access_size = 140729153239824, size = 205 '\315'}, wild = {addr = 0, access_size = 0}}}}}, SanitizerGetAllocatedSizeNotOwned = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, addr_description = {data = {kind = 2501777184, {shadow = {addr = 0, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 0, alloc_tid = 0, free_tid = 6103148528072, alloc_stack_id = 2501777184, free_stack_id = 31964, chunk_access = {bad_addr = 96, offset = 137286836426432, chunk_begin = 232, chunk_size = 140514150080520, user_requested_alignment = 0, access_type = 0, alloc_type = 0}}, stack = {addr = 0, tid = 0, offset = 6103148528072, frame_pc = 137286836426528, access_size = 96, frame_descr = 0x7cdc951e16c0 "\215\005"}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 0, size = 6103148528072, size_with_redzone = 137286836426528, name = 0x60 <error: Cannot access memory at address 0x60>, module_name = 0x7cdc951e16c0 "\215\005", has_dynamic_init = 232, gcc_location = 0x7fcc00006008, odr_indicator = 0}, {beg = 140729153239696, size = 140516684812594, size_with_redzone = 140729153239776, name = 0x2 <error: Cannot access memory at address 0x2>, module_name = 0x7fcc00000000 "", has_dynamic_init = 140516690451664, gcc_location = 0x7ffe0000058f, odr_indicator = 140516655126768}, {beg = 140729153239824, size = 2, size_with_redzone = 140516685340608, name = 0x7cac951e0b90 "\003\021", module_name = 0x7ffe0f303ae0 "0C0\017\376\177", has_dynamic_init = 140516683691832, gcc_location = 0xa0, odr_indicator = 137080677993360}, {beg = 140516659417296, size = 140729153239808, size_with_redzone = 137080677993376, name = 0x55d5fee70a40 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", module_name = 0x7ffe0f304410 "", has_dynamic_init = 136118585380640, gcc_location = 0x7ffe0f304330, odr_indicator = 140516684620737}}, reg_sites = {254819072, 32766, 2522642050, 30}, access_size = 140729153239824, size = 205 '\315'}, wild = {addr = 0, access_size = 0}}}}}, CallocOverflow = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, count = 137286836426528, size = 0}, ReallocArrayOverflow = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, count = 137286836426528, size = 0}, PvallocOverflow = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, size = 137286836426528}, InvalidAllocationAlignment = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, alignment = 137286836426528}, InvalidAlignedAllocAlignment = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, size = 137286836426528, alignment = 0}, InvalidPosixMemalignAlignment = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, alignment = 137286836426528}, AllocationSizeTooBig = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, user_size = 137286836426528, total_size = 0, max_size = 0}, RssLimitExceeded = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002}, OutOfMemory = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, requested_size = 137286836426528}, StringFunctionMemoryRangesOverlap = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, length1 = 137286836426528, length2 = 0, addr1_description = {data = {kind = __asan::kAddressKindWild, {shadow = {addr = 6103148528072, kind = (unknown: 0x20), shadow_byte = 23 '\027'}, heap = {addr = 6103148528072, alloc_tid = 137286836426528, free_tid = 96, alloc_stack_id = 2501777088, free_stack_id = 31964, chunk_access = {bad_addr = 232, offset = 140514150080520, chunk_begin = 0, chunk_size = 140729153239696, user_requested_alignment = 306, access_type = 1, alloc_type = 1}}, stack = {addr = 6103148528072, tid = 137286836426528, offset = 96, frame_pc = 137286836426432, access_size = 232, frame_descr = 0x7fcc00006008 ""}, global = {addr = 6103148528072, static kMaxGlobals = 4, globals = {{beg = 137286836426528, size = 96, size_with_redzone = 137286836426432, name = 0xe8 <error: Cannot access memory at address 0xe8>, module_name = 0x7fcc00006008 "", has_dynamic_init = 0, gcc_location = 0x7ffe0f303a90, odr_indicator = 140516684812594}, {beg = 140729153239776, size = 2, size_with_redzone = 140514150055936, name = 0x7fcc976b5cd0 <__sanitizer::theDepot+4178832> "\217\005", module_name = 0x7ffe0000058f <error: Cannot access memory at address 0x7ffe0000058f>, has_dynamic_init = 140516655126768, gcc_location = 0x7ffe0f303b10, odr_indicator = 2}, {beg = 140516685340608, size = 137080677993360, size_with_redzone = 140729153239776, name = 0x7fcc97043738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248> "H\203;", module_name = 0xa0 <error: Cannot access memory at address 0xa0>, has_dynamic_init = 137080677993360, gcc_location = 0x7fcc9591d0d0, odr_indicator = 140729153239808}, {beg = 137080677993376, size = 94377592949312, size_with_redzone = 140729153242128, name = 0x7bcc93edcf20 "0W\036\225<|", module_name = 0x7ffe0f304330 "\200\t\036\225<}", has_dynamic_init = 140516684620737, gcc_location = 0x7ffe0f303b00, odr_indicator = 131371660930}}, reg_sites = {254819088, 32766, 4277519565, 21973}, access_size = 140729153241664, size = 48 '0'}, wild = {addr = 6103148528072, access_size = 137286836426528}}}}, addr2_description = {data = {kind = 8, {shadow = {addr = 140516685051799, kind = __asan::kShadowKindLow, shadow_byte = 253 '\375'}, heap = {addr = 140516685051799, alloc_tid = 140516672929024, free_tid = 136118586522784, alloc_stack_id = 4279184864, free_stack_id = 21973, chunk_access = {bad_addr = 30064771156, offset = 140516684881789, chunk_begin = 136118586522912, chunk_size = 140516684881789, user_requested_alignment = 264, access_type = 0, alloc_type = 1}}, stack = {addr = 140516685051799, tid = 140516672929024, offset = 136118586522784, frame_pc = 94377595579872, access_size = 30064771156, frame_descr = 0x7fcc97165f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125> "I\211\302H\205\300u\035\351\213"}, global = {addr = 140516685051799, static kMaxGlobals = 4, globals = {{beg = 140516672929024, size = 136118586522784, size_with_redzone = 94377595579872, name = 0x700000054 <error: Cannot access memory at address 0x700000054>, module_name = 0x7fcc97165f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125> "I\211\302H\205\300u\035\351\213", has_dynamic_init = 136118586522912, gcc_location = 0x7fcc97165f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125>, odr_indicator = 140729153241352}, {beg = 11575157580189038336, size = 140729153241368, size_with_redzone = 140516685315960, name = 0x0, module_name = 0x7bec951f6350 "\240|\036\225,|", has_dynamic_init = 140516663310520, gcc_location = 0x7bfc951ea510, odr_indicator = 140729153241408}, {beg = 136668361135648, size = 136118585380800, size_with_redzone = 136256044352240, name = 0x7bcc93edcfe0 "", module_name = 0xb <error: Cannot access memory at address 0xb>, has_dynamic_init = 136118585380800, gcc_location = 0x0, odr_indicator = 94377593838688}, {beg = 0, size = 136668361135648, size_with_redzone = 94377593880292, name = 0x7ccc951e1440 "", module_name = 0x7bcc93edd020 "", has_dynamic_init = 17014823172600, gcc_location = 0x7ffe0f3041b0, odr_indicator = 137218116949064}}, reg_sites = {2534825853, 32716, 2513254584, 32716}, access_size = 94377593309536, size = 224 '\340'}, wild = {addr = 140516685051799, access_size = 140516672929024}}}}, function = 0xa0a3387dca567700 <error: Cannot access memory at address 0xa0a3387dca567700>}, StringFunctionSizeOverflow = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, addr_description = {data = {kind = 2501777184, {shadow = {addr = 0, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 0, alloc_tid = 0, free_tid = 6103148528072, alloc_stack_id = 2501777184, free_stack_id = 31964, chunk_access = {bad_addr = 96, offset = 137286836426432, chunk_begin = 232, chunk_size = 140514150080520, user_requested_alignment = 0, access_type = 0, alloc_type = 0}}, stack = {addr = 0, tid = 0, offset = 6103148528072, frame_pc = 137286836426528, access_size = 96, frame_descr = 0x7cdc951e16c0 "\215\005"}, global = {addr = 0, static kMaxGlobals = 4, globals = {{beg = 0, size = 6103148528072, size_with_redzone = 137286836426528, name = 0x60 <error: Cannot access memory at address 0x60>, module_name = 0x7cdc951e16c0 "\215\005", has_dynamic_init = 232, gcc_location = 0x7fcc00006008, odr_indicator = 0}, {beg = 140729153239696, size = 140516684812594, size_with_redzone = 140729153239776, name = 0x2 <error: Cannot access memory at address 0x2>, module_name = 0x7fcc00000000 "", has_dynamic_init = 140516690451664, gcc_location = 0x7ffe0000058f, odr_indicator = 140516655126768}, {beg = 140729153239824, size = 2, size_with_redzone = 140516685340608, name = 0x7cac951e0b90 "\003\021", module_name = 0x7ffe0f303ae0 "0C0\017\376\177", has_dynamic_init = 140516683691832, gcc_location = 0xa0, odr_indicator = 137080677993360}, {beg = 140516659417296, size = 140729153239808, size_with_redzone = 137080677993376, name = 0x55d5fee70a40 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", module_name = 0x7ffe0f304410 "", has_dynamic_init = 136118585380640, gcc_location = 0x7ffe0f304330, odr_indicator = 140516684620737}}, reg_sites = {254819072, 32766, 2522642050, 30}, access_size = 140729153239824, size = 205 '\315'}, wild = {addr = 0, access_size = 0}}}}, size = 140729153241664}, BadParamsToAnnotateContiguousContainer = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, beg = 137286836426528, end = 0, old_mid = 0, new_mid = 6103148528072}, BadParamsToAnnotateDoubleEndedContiguousContainer = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, storage_beg = 137286836426528, storage_end = 0, old_container_beg = 0, old_container_end = 6103148528072, new_container_beg = 137286836426528, new_container_end = 96}, BadParamsToCopyContiguousContainerAnnotations = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, stack = 0x7fcc00000002, old_storage_beg = 137286836426528, old_storage_end = 0, new_storage_beg = 0, new_storage_end = 6103148528072}, ODRViolation = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, global1 = {beg = 140514150055938, size = 137286836426528, size_with_redzone = 0, name = 0x0, module_name = 0x58d000001c8 <error: Cannot access memory at address 0x58d000001c8>, has_dynamic_init = 137286836426528, gcc_location = 0x60, odr_indicator = 137286836426432}, global2 = {beg = 232, size = 140514150080520, size_with_redzone = 0, name = 0x7ffe0f303a90 "\340:0\017\376\177", module_name = 0x7fcc97155132 <__sanitizer::StackDepotBase<__sanitizer::StackDepotNode, 1, 20>::Put(__sanitizer::StackTrace, bool*)+690> "H\213E\330D\213E\300D\211@\bD\213U\320L\213]\310E\211\023M\205\366\017\204\256\376\377\377A\306\006\001H\213]\360L\213u\370\351\245\376\377\377\203\372\t~+L\211M\300\211U\310H\211M\320L\211]\330\350\3649\377\377L\213M\300\213U\310H\213M\320L\213]\330\203\302\001\351\217\376\377\377\270\n", has_dynamic_init = 140729153239776, gcc_location = 0x2, odr_indicator = 140514150055936}, stack_id1 = 2540395728, stack_id2 = 32716}, InvalidPointerPair = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, pc = 140514150055938, bp = 137286836426528, sp = 0, addr1_description = {data = {kind = __asan::kAddressKindWild, {shadow = {addr = 6103148528072, kind = (unknown: 0x20), shadow_byte = 23 '\027'}, heap = {addr = 6103148528072, alloc_tid = 137286836426528, free_tid = 96, alloc_stack_id = 2501777088, free_stack_id = 31964, chunk_access = {bad_addr = 232, offset = 140514150080520, chunk_begin = 0, chunk_size = 140729153239696, user_requested_alignment = 306, access_type = 1, alloc_type = 1}}, stack = {addr = 6103148528072, tid = 137286836426528, offset = 96, frame_pc = 137286836426432, access_size = 232, frame_descr = 0x7fcc00006008 ""}, global = {addr = 6103148528072, static kMaxGlobals = 4, globals = {{beg = 137286836426528, size = 96, size_with_redzone = 137286836426432, name = 0xe8 <error: Cannot access memory at address 0xe8>, module_name = 0x7fcc00006008 "", has_dynamic_init = 0, gcc_location = 0x7ffe0f303a90, odr_indicator = 140516684812594}, {beg = 140729153239776, size = 2, size_with_redzone = 140514150055936, name = 0x7fcc976b5cd0 <__sanitizer::theDepot+4178832> "\217\005", module_name = 0x7ffe0000058f <error: Cannot access memory at address 0x7ffe0000058f>, has_dynamic_init = 140516655126768, gcc_location = 0x7ffe0f303b10, odr_indicator = 2}, {beg = 140516685340608, size = 137080677993360, size_with_redzone = 140729153239776, name = 0x7fcc97043738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248> "H\203;", module_name = 0xa0 <error: Cannot access memory at address 0xa0>, has_dynamic_init = 137080677993360, gcc_location = 0x7fcc9591d0d0, odr_indicator = 140729153239808}, {beg = 137080677993376, size = 94377592949312, size_with_redzone = 140729153242128, name = 0x7bcc93edcf20 "0W\036\225<|", module_name = 0x7ffe0f304330 "\200\t\036\225<}", has_dynamic_init = 140516684620737, gcc_location = 0x7ffe0f303b00, odr_indicator = 131371660930}}, reg_sites = {254819088, 32766, 4277519565, 21973}, access_size = 140729153241664, size = 48 '0'}, wild = {addr = 6103148528072, access_size = 137286836426528}}}}, addr2_description = {data = {kind = 8, {shadow = {addr = 140516685051799, kind = __asan::kShadowKindLow, shadow_byte = 253 '\375'}, heap = {addr = 140516685051799, alloc_tid = 140516672929024, free_tid = 136118586522784, alloc_stack_id = 4279184864, free_stack_id = 21973, chunk_access = {bad_addr = 30064771156, offset = 140516684881789, chunk_begin = 136118586522912, chunk_size = 140516684881789, user_requested_alignment = 264, access_type = 0, alloc_type = 1}}, stack = {addr = 140516685051799, tid = 140516672929024, offset = 136118586522784, frame_pc = 94377595579872, access_size = 30064771156, frame_descr = 0x7fcc97165f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125> "I\211\302H\205\300u\035\351\213"}, global = {addr = 140516685051799, static kMaxGlobals = 4, globals = {{beg = 140516672929024, size = 136118586522784, size_with_redzone = 94377595579872, name = 0x700000054 <error: Cannot access memory at address 0x700000054>, module_name = 0x7fcc97165f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125> "I\211\302H\205\300u\035\351\213", has_dynamic_init = 136118586522912, gcc_location = 0x7fcc97165f7d <__sanitizer::DTLS_on_tls_get_addr(void*, void*, unsigned long, unsigned long)+125>, odr_indicator = 140729153241352}, {beg = 11575157580189038336, size = 140729153241368, size_with_redzone = 140516685315960, name = 0x0, module_name = 0x7bec951f6350 "\240|\036\225,|", has_dynamic_init = 140516663310520, gcc_location = 0x7bfc951ea510, odr_indicator = 140729153241408}, {beg = 136668361135648, size = 136118585380800, size_with_redzone = 136256044352240, name = 0x7bcc93edcfe0 "", module_name = 0xb <error: Cannot access memory at address 0xb>, has_dynamic_init = 136118585380800, gcc_location = 0x0, odr_indicator = 94377593838688}, {beg = 0, size = 136668361135648, size_with_redzone = 94377593880292, name = 0x7ccc951e1440 "", module_name = 0x7bcc93edd020 "", has_dynamic_init = 17014823172600, gcc_location = 0x7ffe0f3041b0, odr_indicator = 137218116949064}}, reg_sites = {2534825853, 32716, 2513254584, 32716}, access_size = 94377593309536, size = 224 '\340'}, wild = {addr = 140516685051799, access_size = 140516672929024}}}}}, Generic = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, addr_description = {data = {kind = __asan::kAddressKindHeap, {shadow = {addr = 137286836426528, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 137286836426528, alloc_tid = 0, free_tid = 0, alloc_stack_id = 456, free_stack_id = 1421, chunk_access = {bad_addr = 137286836426528, offset = 96, chunk_begin = 137286836426432, chunk_size = 232, user_requested_alignment = 8, access_type = 2, alloc_type = 1}}, stack = {addr = 137286836426528, tid = 0, offset = 0, frame_pc = 6103148528072, access_size = 137286836426528, frame_descr = 0x60 <error: Cannot access memory at address 0x60>}, global = {addr = 137286836426528, static kMaxGlobals = 4, globals = {{beg = 0, size = 0, size_with_redzone = 6103148528072, name = 0x7cdc951e1720 "\240\025\036\225L|", module_name = 0x60 <error: Cannot access memory at address 0x60>, has_dynamic_init = 137286836426432, gcc_location = 0xe8, odr_indicator = 140514150080520}, {beg = 0, size = 140729153239696, size_with_redzone = 140516684812594, name = 0x7ffe0f303ae0 "0C0\017\376\177", module_name = 0x2 <error: Cannot access memory at address 0x2>, has_dynamic_init = 140514150055936, gcc_location = 0x7fcc976b5cd0 <__sanitizer::theDepot+4178832>, odr_indicator = 140728898422159}, {beg = 140516655126768, size = 140729153239824, size_with_redzone = 2, name = 0x7fcc971d5fc0 <__asan::instance> "", module_name = 0x7cac951e0b90 "\003\021", has_dynamic_init = 140729153239776, gcc_location = 0x7fcc97043738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248>, odr_indicator = 160}, {beg = 137080677993360, size = 140516659417296, size_with_redzone = 140729153239808, name = 0x7cac951e0ba0 "\217\005", module_name = 0x55d5fee70a40 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", has_dynamic_init = 140729153242128, gcc_location = 0x7bcc93edcf20, odr_indicator = 140729153241904}}, reg_sites = {2534564801, 32716, 254819072, 32766}, access_size = 131371660930, size = 16 '\020'}, wild = {addr = 137286836426528, access_size = 0}}}}, pc = 94377593914573, bp = 140729153241664, sp = 140729153241648, access_size = 8, bug_descr = 0x7fcc9718f797 "heap-use-after-free", is_write = false, shadow_val = 253 '\375'}}}, halt_on_error_ = true}
                error = {<__asan::ErrorBase> = {scariness = {score = 51, descr = "8-byte-read-heap-use-after-free\000\314{\000\000\260>0\017\376\177\000\0000\000\000\000\000\000\000\000G\000\000\000\000\000\000\000\220>0\017\376\177\000\000\034\313\r\227\314\177", '\000' <repeats 26 times>, "\305\374\023\227\314\177\000\000\340~\036\225,|\000\000:\000\000\000\000\000\000\000\300~\036\225,|\000\000\320~\036\225,|\000\000\36060\017\376\177\000\000\005\\\b\227\314\177\000\000P\b!\224\314{\000\000\000\320\221\225\314\177\000\000\001\000\000\000\000\000\000\000\001\000\000\000\325\000\001\001\000\000\000\000\000\000\000\000\370\377\377\377"...}, tid = 0}, addr_description = {data = {kind = __asan::kAddressKindHeap, {shadow = {addr = 137286836426528, kind = __asan::kShadowKindLow, shadow_byte = 0 '\000'}, heap = {addr = 137286836426528, alloc_tid = 0, free_tid = 0, alloc_stack_id = 456, free_stack_id = 1421, chunk_access = {bad_addr = 137286836426528, offset = 96, chunk_begin = 137286836426432, chunk_size = 232, user_requested_alignment = 8, access_type = 2, alloc_type = 1}}, stack = {addr = 137286836426528, tid = 0, offset = 0, frame_pc = 6103148528072, access_size = 137286836426528, frame_descr = 0x60 <error: Cannot access memory at address 0x60>}, global = {addr = 137286836426528, static kMaxGlobals = 4, globals = {{beg = 0, size = 0, size_with_redzone = 6103148528072, name = 0x7cdc951e1720 "\240\025\036\225L|", module_name = 0x60 <error: Cannot access memory at address 0x60>, has_dynamic_init = 137286836426432, gcc_location = 0xe8, odr_indicator = 140514150080520}, {beg = 0, size = 140729153239696, size_with_redzone = 140516684812594, name = 0x7ffe0f303ae0 "0C0\017\376\177", module_name = 0x2 <error: Cannot access memory at address 0x2>, has_dynamic_init = 140514150055936, gcc_location = 0x7fcc976b5cd0 <__sanitizer::theDepot+4178832>, odr_indicator = 140728898422159}, {beg = 140516655126768, size = 140729153239824, size_with_redzone = 2, name = 0x7fcc971d5fc0 <__asan::instance> "", module_name = 0x7cac951e0b90 "\003\021", has_dynamic_init = 140729153239776, gcc_location = 0x7fcc97043738 <__sanitizer::Quarantine<__asan::QuarantineCallback, __asan::AsanChunk>::Put(__sanitizer::QuarantineCache<__asan::QuarantineCallback>*, __asan::QuarantineCallback, __asan::AsanChunk*, unsigned long)+248>, odr_indicator = 160}, {beg = 137080677993360, size = 140516659417296, size_with_redzone = 140729153239808, name = 0x7cac951e0ba0 "\217\005", module_name = 0x55d5fee70a40 <device_free> "\363\017\036\372USH\211\373H\203\354\030H\205\377\017\204-\n", has_dynamic_init = 140729153242128, gcc_location = 0x7bcc93edcf20, odr_indicator = 140729153241904}}, reg_sites = {2534564801, 32716, 254819072, 32766}, access_size = 131371660930, size = 16 '\020'}, wild = {addr = 137286836426528, access_size = 0}}}}, pc = 94377593914573, bp = 140729153241664, sp = 140729153241648, access_size = 8, bug_descr = 0x7fcc9718f797 "heap-use-after-free", is_write = false, shadow_val = 253 '\375'}
        #9  0x00007fcc97133f8d in __asan::ReportGenericError (pc=<optimized out>, bp=bp@entry=140729153241664, sp=sp@entry=140729153241648, addr=<optimized out>, is_write=is_write@entry=false, access_size=access_size@entry=8, exp=<optimized out>, fatal=true) at ../../../../src/libsanitizer/asan/asan_report.cpp:536
                in_report = <optimized out>
                error = <optimized out>
                enable_fp = <optimized out>
        #10 0x00007fcc971353f9 in __asan::__asan_report_load8 (addr=<optimized out>) at ../../../../src/libsanitizer/asan/asan_rtl.cpp:131
                bp = 140729153241664
                pc = <optimized out>
                local_stack = 136256044360528
                sp = 140729153241648
        #11 0x000055d5fef5c4cd in discovery_op_free (op=0x7c4c951e16a0) at src/shared/gatt-client.c:407
        No locals.
        #12 0x000055d5ff08986a in bt_gatt_request_unref (req=0x7c4c951e1fa0) at src/shared/gatt-helpers.c:577
        No locals.
        #13 bt_gatt_request_unref (req=0x7c4c951e1fa0) at src/shared/gatt-helpers.c:566
        No locals.
        #14 0x000055d5fef4a1d4 in destroy_att_send_op (data=0x7c2c951e7ca0) at src/shared/att.c:216
                op = 0x7c2c951e7ca0
        #15 0x000055d5fef07e52 in queue_remove_all (queue=0x7bfc951ea510, function=function@entry=0x0, user_data=user_data@entry=0x0, destroy=destroy@entry=0x55d5fef4a0f0 <destroy_att_send_op>) at src/shared/queue.c:341
                tmp = 0x7bec951f6350
                entry = 0x0
                count = <optimized out>
        #16 0x000055d5fef54556 in bt_att_cancel_all (att=0x7ccc951e1440) at src/shared/att.c:1940
                entry = <optimized out>
        #17 bt_att_cancel_all (att=0x7ccc951e1440) at src/shared/att.c:1933
                entry = <optimized out>
                chan = <optimized out>
        #18 0x000055d5fef55490 in bt_att_unref (att=0x7ccc951e1440) at src/shared/att.c:1351
        No locals.
        #19 bt_att_unref (att=0x7ccc951e1440) at src/shared/att.c:1342
        No locals.
        #20 0x000055d5fee706af in attio_cleanup (device=device@entry=0x7d3c951e0780) at src/device.c:873
        No locals.
        #21 0x000055d5fee70be7 in device_free (user_data=0x7d3c951e0780) at src/device.c:918
                device = 0x7d3c951e0780
                __func__ = "device_free"
        #22 0x000055d5feef19aa in remove_interface (data=0x7c3c951e5730, name=name@entry=0x55d5ff117500 "org.bluez.Device1") at gdbus/object.c:742
                iface = 0x7c2c951e6260
        #23 0x000055d5feef456c in g_dbus_unregister_interface (connection=<optimized out>, path=<optimized out>, name=<optimized out>) at gdbus/object.c:1499
                data = <optimized out>
        #24 0x000055d5fee2682b in remove_temporary_devices (adapter=adapter@entry=0x7cfc951e0200) at src/adapter.c:826
                dev = 0x7d3c951e0780
                l = <optimized out>
                next = 0x0
        #25 0x000055d5fee27b8a in adapter_shutdown () at src/adapter.c:11531
                adapter = 0x7cfc951e0200
                list = 0x7bfc951e3a00 = {0x7cfc951e0200}
                __func__ = "adapter_shutdown"
        #26 0x000055d5feec89dc in signal_callback (signum=<optimized out>, user_data=<optimized out>) at src/main.c:1550
                terminated = false
        #27 signal_callback (signum=<optimized out>, user_data=<optimized out>) at src/main.c:1537
                terminated = false
        #28 0x000055d5ff07ddfe in signal_read (io=<optimized out>, user_data=0x7bfc951e35b0) at src/shared/mainloop-notify.c:145
                data = <optimized out>
                si = <optimized out>
                result = <optimized out>
                fd = <optimized out>
        #29 0x000055d5ff07acf5 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:173
                watch = <optimized out>
                result = <optimized out>
                destroy = <optimized out>
        #30 0x00007fcc96e3fb9b in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #31 0x00007fcc96e411d7 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #32 0x00007fcc96e41577 in g_main_loop_run () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
        No symbol table info available.
        #33 0x000055d5ff07dc59 in mainloop_run () at src/shared/mainloop-glib.c:65
        No locals.
        #34 0x000055d5ff07e58b in mainloop_run_with_signal (func=func@entry=0x55d5feec8960 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-notify.c:196
                data = 0x7bfc951e35b0
                io = 0x7c0c951f9690
                ret = <optimized out>
        #35 0x000055d5febf93ac in main (argc=<optimized out>, argv=<optimized out>) at src/main.c:1778
                context = <optimized out>
                err = <optimized out>
                sdp_mtu = 0
                sdp_flags = <optimized out>
                gdbus_flags = <optimized out>
                __func__ = "main""


https://github.com/bluez/bluez/pull/2761

---
Regards,
Linux Bluetooth


--===============2056447727760078505==--
