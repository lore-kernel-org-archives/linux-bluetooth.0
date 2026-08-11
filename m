Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED01138837A
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466013; cv=none; b=DmqstewPlwrtGJY6gaY8AaC03zXSQOd4XTyv3DLqbCipmIx++OCwc2Wa1qMjKtHDy3N4yON3rbYbtmG5vKOBV/iQxZVMy4a9ybDJOWejLiGuQlQeYmNwEfUwwrredYyfE+u+GAE8nzWJSyHDcMIo7J9NquhdVapHh0Yqnz0c8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466013; c=relaxed/simple;
	bh=/UYE5SAi32qwiT2fCsTc3YQ7JGFiPFj55ptR3if0hCs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tMT8d6wPK0gbpAEJu8lZw3eYTuZNeEsDHrL4ApZBnEWvc+S8A/Qk5z5iWj5JnKuiMJ9eZH6eeIGs7YfzHHC4HebPiAmg+aOM7npMTP7FzOk7YM7TWITQvgbu27Y5gQJOtoCcGBdCWYbyFvGi5Dq6h6hFpFsXNFKnP162GdXJ5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6wAdsLz; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6wAdsLz"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so43943eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786466011; x=1787070811; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kZ6g67x3peJnYTfHJ2ttbnieteMga5k+0+5DEBfO2EY=;
        b=B6wAdsLzxumELwX5knCc7yLua9CSDCvpe/k5CWotA+2J9b+ruGMSFVSrlpzMTPN9Hc
         Tsnxs3JHaXWDvkn28NEl3AAwLmMKGPCxRkeGT0lkGd06L/IykDgMu9q5y48OHqlMv7BN
         +m/RbVcQ5ckpdeDB3NpHJmxbKgTzLs4iUlB7x45zzCL97d2szRtY8TWVGqECGn4ViET+
         HJkJoYvDGj2Nfm5k7dzcCYFnrAZ3j+4zNVhATbTnfx6EWoV89T/jHvm5WZV6DQjiPETM
         y0EO5p0L7E829TV2cerOHbd62MRFPS8uJD4hslciX5iuAv0X5e+i0MMyePhbcoqPTa9R
         7XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466011; x=1787070811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kZ6g67x3peJnYTfHJ2ttbnieteMga5k+0+5DEBfO2EY=;
        b=tFiZRP/Izyl1TgIwLPMXnpYy3EPqgiK96d10dBC81y+3M7smeyil7s2IDyIZQl1q8f
         naz8IEEuL/9LYVzTZ14d0xG5dlfSR4vc5RX6o33APmarJCd/W+vFpx2rQdTEEVOsq5iI
         GsBjEuXIDQmLDYrgg3SHWVrST4l2buYkNWdDR90aTXMrvIoJZ/JyRMOwZT1DeLfhiUiP
         RPQmkI6FFGAxox+tQG0Qit0y5fzip1z2m7/ow8yFyCVECJGEhcpEoRjZYM/1pthmByWQ
         rRrDd4WBfVWEuxkpFycYbxO0sJu4RPFdNe10l1AEwCwaF0Dci67HNBv+GK8VLVVCg9NH
         hydA==
X-Gm-Message-State: AOJu0YzqJJjXE4GcF2U3QrhhOJgh1saaAucfSSyXiQSVbCRY+ZhYj/Dr
	QWVAMSk4hYGG6XZkkwOdPt3gZZe/OGgU1Uvr0Q3JrGx4Mi9A92K+esuOmHkzzg==
X-Gm-Gg: AR+sD123BcUNe8L5Ld+wj4GNr6E4NBM/Xa3lPQSqB5NTWhVbkraChxEC5P4pc8iZC72
	/wD/IFAuk9iby4Q6LJnHlsdBXc3HgLo1tWwZ2fCmOpA/td2+9xn0T2y20MEG4dNFP4CDET4K0ks
	1hPyoHhHl3jzvvu7KQQwyo6GAiiaVAZfQtiM/ASsNJUCghopP2PusgnXkjkwQ+0g4qAZ8/uX3lw
	DNkussqmlG2WNNjk7fiK4gBg77NDCzsx+QVXsQdbLmbJnCRYXyhuQxm8adA+JCVhK3RgUVzdUgM
	x8Lo4o+HMyLQow0fzx9RHcqOSHCFNpVVD/BMx6j8WbFTCEbj5zzuqRe8nhxYXSnsl7k11v76aqp
	Ou/l4lCIGGLfuqP5jL6qtgN+a7VhZ4cD51VCG0arP42pDQv0IY2yCFkAKa/ifmaAMurXlLxBMcG
	+onNDkY4S7yMPJ8Hy3anxxEElnWx+r0pWUm//fDki9d8mCGs4XPpuZc/fa2q770BhawFtzRg==
X-Received: by 2002:a05:6820:290a:b0:6aa:fe65:4cd1 with SMTP id 006d021491bc7-6b0a32a338cmr3035034eaf.36.1786466010495;
        Tue, 11 Aug 2026 09:33:30 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.195.128])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad500d37sm174097eaf.7.2026.08.11.09.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:33:29 -0700 (PDT)
Message-ID: <6a7b4ed9.77a0a7d7.94448.5972@mx.google.com>
Date: Tue, 11 Aug 2026 09:33:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8418967762037333832=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: 3 SDP XML security fixes
In-Reply-To: <20260811145704.1766949-2-hadess@hadess.net>
References: <20260811145704.1766949-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8418967762037333832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1144151

---Test result---

Test Summary:
CheckPatch                    FAIL      7.01 seconds
GitLint                       FAIL      5.28 seconds
BuildEll                      PASS      18.29 seconds
BluezMake                     PASS      655.00 seconds
MakeCheck                     PASS      18.42 seconds
MakeDistcheck                 FAIL      130.45 seconds
CheckValgrind                 PASS      222.33 seconds
CheckSmatch                   PASS      274.91 seconds
bluezmakeextell               PASS      96.01 seconds
IncrementalBuild              PASS      664.33 seconds
ScanBuild                     PASS      886.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,1/9] unit: Add test for sdp_xml_parse_record()
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#340: FILE: unit/test-sdp-xml.c:54:
+	path = g_build_filename(TOP_SRCDIR, "unit", "sdp-xml", t->filename, NULL);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#353: FILE: unit/test-sdp-xml.c:67:
+#define DEFINE_TEST(fname, res)							\

WARNING:TRAILING_SEMICOLON: macros should not use a trailing semicolon
#353: FILE: unit/test-sdp-xml.c:67:
+#define DEFINE_TEST(fname, res)							\
+	data.expected_result = res;						\
+	data.filename = fname;							\
+	tester_add("/" fname, &data, NULL, parse_xml_for_filename, NULL);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#354: FILE: unit/test-sdp-xml.c:68:
+	data.expected_result = res;						\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#355: FILE: unit/test-sdp-xml.c:69:
+	data.filename = fname;							\

/github/workspace/src/patch/14743502.patch total: 0 errors, 5 warnings, 278 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14743502.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,2/9] sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML
ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#75: 
Reported-by: Aisle Research

WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#76: 
Co-authored-by: Aisle Research

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#76: 
Co-authored-by: Aisle Research

/github/workspace/src/patch/14743501.patch total: 2 errors, 1 warnings, 47 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14743501.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,3/9] unit: Add test for sdp-xml type-confusion bug
WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#58: 
Co-authored-by: Aisle Research

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#58: 
Co-authored-by: Aisle Research

/github/workspace/src/patch/14743500.patch total: 1 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14743500.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,4/9] sdp-xml: Fix memory leak when adding duplicate attributes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#67: 
    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#76: 
Reported-by: Aisle Research

WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#77: 
Co-authored-by: Aisle Research

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#77: 
Co-authored-by: Aisle Research

/github/workspace/src/patch/14743503.patch total: 2 errors, 2 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14743503.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,5/9] unit: Add test for sdp-xml duplicate attribute bug
WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#58: 
Co-authored-by: Aisle Research

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#58: 
Co-authored-by: Aisle Research

/github/workspace/src/patch/14743508.patch total: 1 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14743508.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,6/9] sdp-xml: Optimise parsing large sequences
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#100: FILE: src/sdp-xml.c:624:
+				sdp_seq_append(tail, ctx_data->stack_head->data);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#103: FILE: src/sdp-xml.c:627:
+					sdp_seq_append(NULL, ctx_data->stack_head->data);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#105: FILE: src/sdp-xml.c:629:
+			ctx_data->stack_head->next->tail = ctx_data->stack_head->data;

/github/workspace/src/patch/14743504.patch total: 0 errors, 3 warnings, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14743504.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,7/9] unit: Add test for slow element_end() append
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#72: FILE: unit/test-sdp-xml.c:67:
+#define XML_START								\

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#73: FILE: unit/test-sdp-xml.c:68:
+	"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n"				\

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#74: FILE: unit/test-sdp-xml.c:69:
+	"<record>\n"								\

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#75: FILE: unit/test-sdp-xml.c:70:
+	"	<attribute id=\"0x0004\">\n"					\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#78: FILE: unit/test-sdp-xml.c:73:
+#define XML_VALUE								\

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#81: FILE: unit/test-sdp-xml.c:76:
+#define XML_END									\

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#82: FILE: unit/test-sdp-xml.c:77:
+	"		</sequence>\n"						\

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#83: FILE: unit/test-sdp-xml.c:78:
+	"	</attribute>\n"							\

WARNING:LINE_SPACING: Missing a blank line after declarations
#89: FILE: unit/test-sdp-xml.c:84:
+	struct test_data *t = (struct test_data *) data;
+	parse_xml(t->s->str, t->s->len, TRUE);

WARNING:LINE_SPACING: Missing a blank line after declarations
#108: FILE: unit/test-sdp-xml.c:103:
+	struct test_data *t = (struct test_data *) data;
+	g_string_free(t->s, TRUE);

/github/workspace/src/patch/14743507.patch total: 0 errors, 10 warnings, 56 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14743507.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,8/9] sdp-xml: Fix stack overflow when converting large sequences to XML
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#62: 
==1684518==ERROR: AddressSanitizer: stack-overflow on address 0x7fff7fb40d98 (pc 0x7fbe1ee95c2b bp 0x7fff7fb41610 sp 0x7fff7fb40d70 T0)

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#88: FILE: src/sdp-xml.c:685:
+static inline void convert_raw_data_to_xml_element(sdp_data_t *value, int indent_level,

WARNING:BRACES: braces {} are not necessary for single statement blocks
#102: FILE: src/sdp-xml.c:1009:
+	for (; value != NULL; value = value->next) {
+		convert_raw_data_to_xml_element(value, indent_level, data, appender);
+	}

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#103: FILE: src/sdp-xml.c:1010:
+		convert_raw_data_to_xml_element(value, indent_level, data, appender);

/github/workspace/src/patch/14743505.patch total: 0 errors, 4 warnings, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14743505.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,2/9] sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML

1: T1 Title exceeds max length (87>80): "[BlueZ,v3,2/9] sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML"
[BlueZ,v3,4/9] sdp-xml: Fix memory leak when adding duplicate attributes

13: B1 Line exceeds max length (113>80): "    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
17: B1 Line exceeds max length (113>80): "    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
[BlueZ,v3,8/9] sdp-xml: Fix stack overflow when converting large sequences to XML

1: T1 Title exceeds max length (81>80): "[BlueZ,v3,8/9] sdp-xml: Fix stack overflow when converting large sequences to XML"
8: B1 Line exceeds max length (135>80): "==1684518==ERROR: AddressSanitizer: stack-overflow on address 0x7fff7fb40d98 (pc 0x7fbe1ee95c2b bp 0x7fff7fb41610 sp 0x7fff7fb40d70 T0)"
9: B1 Line exceeds max length (156>80): "    #0 0x7fbe1ee95c2b in printf_common(void*, char const*, __va_list_tag*) (/lib64/libasan.so.8+0x95c2b) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
10: B1 Line exceeds max length (116>80): "    #1 0x7fbe1eeb72d6 in vsnprintf (/lib64/libasan.so.8+0xb72d6) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
11: B1 Line exceeds max length (115>80): "    #2 0x7fbe1eeb94f4 in snprintf (/lib64/libasan.so.8+0xb94f4) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
12: B1 Line exceeds max length (101>80): "    #3 0x000000401fc2 in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:709"
13: B1 Line exceeds max length (101>80): "    #4 0x000000401c4f in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:994"
15: B1 Line exceeds max length (103>80): "    #246 0x000000401c4f in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:994"
17: B1 Line exceeds max length (121>80): "SUMMARY: AddressSanitizer: stack-overflow ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:709 in convert_raw_data_to_xml"
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[4]: *** [Makefile:10329: test-suite.log] Error 1
make[3]: *** [Makefile:10437: check-TESTS] Error 2
make[2]: *** [Makefile:10915: check-am] Error 2
make[1]: *** [Makefile:10917: check] Error 2
make: *** [Makefile:10838: distcheck] Error 1


https://github.com/bluez/bluez/pull/2395

---
Regards,
Linux Bluetooth


--===============8418967762037333832==--
