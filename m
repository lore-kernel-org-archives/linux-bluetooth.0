Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078A41A504
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527958; cv=none; b=HwEfVE5sFjkKvy6oeb26nofM7wTpLl+JNjn4LjPrLvYwycUmgChdSfQrxbEOOT0BVrs7J0rbbFd2vEZd1EQOr9mw0XtEzL0cdLvfam+D1N0W/DQHC7lg++LFMmcqlV07lYec3CreTfv8NUvAh2EZjpGvmPXMk7uNxlUFSaSISnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527958; c=relaxed/simple;
	bh=vOOMazdawpzHWDI+WEw+shGfRGbEKuETkGkE8he4UuI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UCQjTRj/KuL9sf3KCYLnTR71zFHFfLLVIV0RQKFqSqqXLL+K/zClMr1vZhDQ99ejFTDrSnmjtoI3uVOnEvUDSnGMfU+jCWaeCRJDYOha2l3LhVuRSQcOykGNwbVhLpD7P2txF1PYySYqqIUcENDLikn9wlvdat37oy2VoytibEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgK+Ew9P; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgK+Ew9P"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c05dcdf49so9169951cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786527955; x=1787132755; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tX+brUfdYt/szXj/fLFvOyvLOGhms4JHL8sqSNxbzLY=;
        b=MgK+Ew9PGMPYFWC5wGmYPaLx6j7Gvl37w49liwT6fSc3lxyO0azMEm59bbBtaI3Lre
         7IOaGfk5aAFwmWUbAwhdgcKat+ouJF2AWo2p6YV2KQfIHcM6PExUUOlvyw7g6Pihk5BM
         E47Q9FtbJhV/k0P66OgsunqSXkkoZ1mDTGp3DB8IbXBnX7EHHxw5ycWeLFIcQIWuwYAm
         w14Ml3FbFv/z2b1Zgfx2VBK93/9+DkgLHQasQFbMFStV3Hf6Uxr4GGu/ABe10fFNgjRs
         ggA3dFbQJOjWNHGx7R+XX5g4vrnvMQhCZOfBfyK7md1ZToNcIC1tktCAubtzXzgyoIP2
         t4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786527955; x=1787132755;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tX+brUfdYt/szXj/fLFvOyvLOGhms4JHL8sqSNxbzLY=;
        b=II7lr4s2Ynz42AA8mlxxsT14aC7Oe5kFzrPJiNeTq+Rp8+yWPZhYou8nkWo4Dp9PXN
         llnuDr3kCN+Z3/JypInr7WzHC1jTgIp8dcCTg3GBUJMmjRgYs2vRDmWL0tJ84tYenmXU
         SkA3RMR77dsM/qXhtyJ2SQJYIRQIoRXoSBalfJNf7fjwxVnaKFwlyOQZKs86kjUatc58
         xJzSbgHRaBFjpTDQxZyo9PqKu/96KntMFtZa966FeFFRA16dL7HYTs5tSUlOn5LQqQQy
         1CNEAtxhQF9bHAamrXSq2AkGEveQ95L5XInA1vIFkVTeQjsYO+oKWK5GR1oWefy/ggDQ
         wIWw==
X-Gm-Message-State: AOJu0Yz+V5FA1byUGKJb+VligNP2oEp5YHQ4V6B/AE7eZdso2ZXUT3WA
	g2DjCppn3yyVOA/XpvStI3T12QuDaJhYX47wfJ1wWvau+ife/xDGU4pm7zPYAg==
X-Gm-Gg: AR+sD10tJirUyVvq+NKN+SbuG31MZ44QxXR3ZZ7vtPgy3TRXGPRGVsso8OIE6CSquQv
	82aExwNSwkx0ajGAQ1J6/WCSakqr2PrUU7o6rq/7ph/O/Prja0IXBx9UTgqSpkH0DMQAMW3ik1L
	7CH/Fyt9ukZXMh2UqaXDZjk8r5B27GbFShv0pJ91Y3quo9fFUmeeg83my5l89WftARmXdu7sCzG
	tD40qjz/0xQL9sHK3TN0ajG2DeFcs98s0WXHz4facpg9za9VEz6/0cWxwt0QbCEwAueVvfwvBQd
	iEe4A243jt5RCqcPTn74gPrORZXWQ8YxyNbKhC7wNXBIBuUZHio24DfXT3Y/qT9r7xXS1U4yXj/
	LfeqNsjpropqjnhvGeZlFA0Sil25cFeElXJpNO8+8db/7MhI7ww0fds8VX+YOPbHV5iUnoh3zip
	ZbUxHuSOx2gQ/wHJ6Q/yPxPEqXTOWCnDEEXOv+exTLLaTz526NPzvP+BQorY8NMU0pyeEkzXIU
X-Received: by 2002:ac8:5845:0:b0:51c:1a11:75cf with SMTP id d75a77b69052e-52d646b8fd9mr26927581cf.7.1786527955418;
        Wed, 12 Aug 2026 02:45:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.158.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c395efbsm17751696d6.25.2026.08.12.02.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:45:54 -0700 (PDT)
Message-ID: <6a7c40d2.7f7f1747.34939d.b987@mx.google.com>
Date: Wed, 12 Aug 2026 02:45:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3883684940575870145=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: 3 SDP XML security fixes
In-Reply-To: <20260812080410.2116906-2-hadess@hadess.net>
References: <20260812080410.2116906-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3883684940575870145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1144549

---Test result---

Test Summary:
CheckPatch                    FAIL      4.32 seconds
GitLint                       FAIL      3.30 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      593.99 seconds
MakeCheck                     PASS      19.11 seconds
MakeDistcheck                 PASS      156.18 seconds
CheckValgrind                 PASS      230.92 seconds
CheckSmatch                   PASS      319.34 seconds
bluezmakeextell               PASS      103.13 seconds
IncrementalBuild              PASS      666.91 seconds
ScanBuild                     PASS      994.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,2/9] sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML
ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#72: 
Reported-by: Aisle Research

WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#73: 
Co-authored-by: Aisle Research

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#73: 
Co-authored-by: Aisle Research

/github/workspace/src/patch/14745004.patch total: 2 errors, 1 warnings, 47 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14745004.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,3/9] unit: Add test for sdp-xml type-confusion bug
WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#55: 
Co-authored-by: Aisle Research

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#55: 
Co-authored-by: Aisle Research

/github/workspace/src/patch/14745007.patch total: 1 errors, 1 warnings, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14745007.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,4/9] sdp-xml: Fix memory leak when adding duplicate attributes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#64: 
    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#73: 
Reported-by: Aisle Research

WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#74: 
Co-authored-by: Aisle Research

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#74: 
Co-authored-by: Aisle Research

/github/workspace/src/patch/14745005.patch total: 2 errors, 2 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14745005.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,5/9] unit: Add test for sdp-xml duplicate attribute bug
WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#55: 
Co-authored-by: Aisle Research

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Aisle Research'
#55: 
Co-authored-by: Aisle Research

/github/workspace/src/patch/14745012.patch total: 1 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14745012.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,6/9] sdp-xml: Optimise parsing large sequences
WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#104: FILE: src/sdp-xml.c:631:
+			ctx_data->stack_head->next->tail = ctx_data->stack_head->data;

/github/workspace/src/patch/14745009.patch total: 0 errors, 1 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14745009.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,7/9] unit: Add test for slow element_end() append
WARNING:LINE_SPACING: Missing a blank line after declarations
#86: FILE: unit/test-sdp-xml.c:85:
+	struct test_data *t = (struct test_data *) data;
+	parse_xml(t->s->str, t->s->len, TRUE);

/github/workspace/src/patch/14745011.patch total: 0 errors, 1 warnings, 57 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14745011.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,8/9] sdp-xml: Fix stack overflow when converting large sequences to XML
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#59: 
==1684518==ERROR: AddressSanitizer: stack-overflow on address 0x7fff7fb40d98 (pc 0x7fbe1ee95c2b bp 0x7fff7fb41610 sp 0x7fff7fb40d70 T0)

ERROR:SPACING: space required after that ',' (ctx:VxV)
#87: FILE: src/sdp-xml.c:688:
+		int indent_level,void *data,
 		                ^

/github/workspace/src/patch/14745008.patch total: 1 errors, 1 warnings, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14745008.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v4,2/9] sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML

1: T1 Title exceeds max length (87>80): "[BlueZ,v4,2/9] sdp-xml: Fix crash caused by type confusion when parsing crafted SDP XML"
[BlueZ,v4,4/9] sdp-xml: Fix memory leak when adding duplicate attributes

13: B1 Line exceeds max length (113>80): "    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
17: B1 Line exceeds max length (113>80): "    #0 0x7f896a8ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
[BlueZ,v4,8/9] sdp-xml: Fix stack overflow when converting large sequences to XML

1: T1 Title exceeds max length (81>80): "[BlueZ,v4,8/9] sdp-xml: Fix stack overflow when converting large sequences to XML"
8: B1 Line exceeds max length (135>80): "==1684518==ERROR: AddressSanitizer: stack-overflow on address 0x7fff7fb40d98 (pc 0x7fbe1ee95c2b bp 0x7fff7fb41610 sp 0x7fff7fb40d70 T0)"
9: B1 Line exceeds max length (156>80): "    #0 0x7fbe1ee95c2b in printf_common(void*, char const*, __va_list_tag*) (/lib64/libasan.so.8+0x95c2b) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
10: B1 Line exceeds max length (116>80): "    #1 0x7fbe1eeb72d6 in vsnprintf (/lib64/libasan.so.8+0xb72d6) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
11: B1 Line exceeds max length (115>80): "    #2 0x7fbe1eeb94f4 in snprintf (/lib64/libasan.so.8+0xb94f4) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)"
12: B1 Line exceeds max length (101>80): "    #3 0x000000401fc2 in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:709"
13: B1 Line exceeds max length (101>80): "    #4 0x000000401c4f in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:994"
15: B1 Line exceeds max length (103>80): "    #246 0x000000401c4f in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:994"
17: B1 Line exceeds max length (121>80): "SUMMARY: AddressSanitizer: stack-overflow ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:709 in convert_raw_data_to_xml"


https://github.com/bluez/bluez/pull/2396

---
Regards,
Linux Bluetooth


--===============3883684940575870145==--
