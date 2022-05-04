Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C21C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 03:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbiEDDPq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 May 2022 23:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiEDDPq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 May 2022 23:15:46 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B456524F28
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 May 2022 20:12:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y3so41243qtn.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 May 2022 20:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=t2afG+I0DMHPYfBB/+PAReQ9zxZeQ9oTVyiiEHryU7Q=;
        b=jFkgDD7fdVT5sVipvHNsXSvUjqtSvspkhS0nNjE3TtfcBzzGf9UYC9ofg0L9N/9i3r
         WJPJp5A/TJgMcoezuQ5tdV1Lx5Mhy7aHFGIplSghkEpSKCZSj5efRoGMkv3E/MHLv8dw
         reXaX1f49K5sLoIeHkPx6d6hPVkXx/8gpg5PbZ4FpmqoSAfRE4syc+CSR+EIjRjEAtyh
         xA1vVHoIo4V2JIMKvcMWCktJxGoEAAaHLL0/ww3wF7n4RzcOFymNvj4BterO1KpyLHbV
         X1hlQn7aZ8POeHa9FeM+K/0hKxuupGzNjSyZxMCAp2XV14uJkCps+78BHEqN77ZmJ1gV
         NsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=t2afG+I0DMHPYfBB/+PAReQ9zxZeQ9oTVyiiEHryU7Q=;
        b=WJXHp8IkFY5wkncKS/qpnCCmzTec8t6Xs5svCSzm+PYkKvw5CJXk6kJj0TOM454Lvp
         uiroOn37kWhGaLleJz0KtU7z6vcPwaum04B6h+jiGSAbneRPzbLRmplVXDIqyA1hqBof
         Ov8j+iFiNwXlJ390nMdpR5AG4gYOI5dwROrk0D4OeEShpYykYBOqU5H/eN3+fMN8AStK
         w/yO62aOq5GFj98ULMN5SQrbBtNzDC3nDfGsnqBsqSWd4llz/ip8N2aZQmu9PJt4cosM
         vJXFIxJ6f83ecFoQrYO7nTO9wE9XcLgWEvBIcj5srjTmDTc8x8CNTtiRME0HWwF1UA7Y
         U1Bw==
X-Gm-Message-State: AOAM532rXVYsq48JSTMFUTnx8XO6WI94TjWejFNANtdyvJ4m2GSa9nkF
        0xvc8oajt12+4KYUN5W4+CA4VViZbJYjOA==
X-Google-Smtp-Source: ABdhPJwOC0wapPEW8Mk3+kJqL2xNMaqLoHzcKrxYU6UKsCGuWCBUhoYpgc1buvenDxXnCDbD4WcEvg==
X-Received: by 2002:a05:622a:1489:b0:2f3:9ba4:2feb with SMTP id t9-20020a05622a148900b002f39ba42febmr16624329qtx.592.1651633929657;
        Tue, 03 May 2022 20:12:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.121.184.139])
        by smtp.gmail.com with ESMTPSA id c15-20020ac86e8f000000b002f39b99f6a2sm6853910qtv.60.2022.05.03.20.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 20:12:09 -0700 (PDT)
Message-ID: <6271ef09.1c69fb81.ec4d5.2112@mx.google.com>
Date:   Tue, 03 May 2022 20:12:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1216943057250854325=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, keescook@chromium.org
Subject: RE: Introduce flexible array struct memcpy() helpers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220504014440.3697851-2-keescook@chromium.org>
References: <20220504014440.3697851-2-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1216943057250854325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=638153

---Test result---

Test Summary:
CheckPatch                    FAIL      15.45 seconds
GitLint                       FAIL      7.70 seconds
SubjectPrefix                 FAIL      28.23 seconds
BuildKernel                   PASS      36.05 seconds
BuildKernel32                 PASS      34.02 seconds
Incremental Build with patchesPASS      324.75 seconds
TestRunner: Setup             PASS      541.23 seconds
TestRunner: l2cap-tester      PASS      19.53 seconds
TestRunner: bnep-tester       PASS      7.22 seconds
TestRunner: mgmt-tester       PASS      110.30 seconds
TestRunner: rfcomm-tester     PASS      10.98 seconds
TestRunner: sco-tester        PASS      10.26 seconds
TestRunner: smp-tester        PASS      10.29 seconds
TestRunner: userchan-tester   PASS      7.09 seconds

Details
##############################
Test: CheckPatch - FAIL - 15.45 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[01/32] netlink: Avoid memcpy() across flexible array boundary\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#172: 
memcpy: detected field-spanning write (size 32) of single field "&errmsg->msg" (size 16)

WARNING:BAD_SIGN_OFF: Non-standard signature: Fixed-by:
#179: 
Fixed-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

total: 0 errors, 2 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12836836.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[02/32] Introduce flexible array struct memcpy() helpers\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#300: 
new file mode 100644

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#523: FILE: include/linux/flex_array.h:219:
+	typeof(*(src)) *__fc_src = (src);				\
 	               ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#576: FILE: include/linux/flex_array.h:272:
+	typeof(**(alloc)) *__fd_alloc;					\
 	                  ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#754: FILE: include/linux/flex_array.h:450:
+	typeof((*__mtfd_alloc)dot_fas_member) *__mtfd_fas;		\
 	                                      ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#861: FILE: include/linux/flex_array.h:557:
+	typeof(*(bytes_written)) *__ftm_written = (bytes_written);	\
 	                         ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#910: FILE: include/linux/flex_array.h:606:
+	typeof(*(alloc_size)) *__ftmd_alloc_size = (alloc_size);	\
 	                      ^

total: 5 errors, 1 warnings, 662 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12836837.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[03/32] flex_array: Add Kunit tests\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:CONFIG_DESCRIPTION: please write a paragraph that describes the config symbol fully
#205: FILE: lib/Kconfig.debug:2565:
+config FLEX_ARRAY_KUNIT_TEST

WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#228: 
new file mode 100644

total: 0 errors, 2 warnings, 554 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12836839.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[04/32] fortify: Add run-time WARN for cross-field memcpy()\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#178: 
  memcpy: detected field-spanning write (size N) of single field "var->dest" (size M)

total: 0 errors, 1 warnings, 96 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12836838.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[07/32] iwlwifi: calib: Use mem_to_flex_dup() with struct iwl_calib_result\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#176: 
memcpy: detected field-spanning write (size 8) of single field "&res->hdr" (size 4)

total: 0 errors, 1 warnings, 0 checks, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12836846.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 7.70 seconds
Run gitlint with rule in .gitlint
[01/32] netlink: Avoid memcpy() across flexible array boundary
7: B1 Line exceeds max length (88>80): "memcpy: detected field-spanning write (size 32) of single field "&errmsg->msg" (size 16)"
15: B1 Line exceeds max length (90>80): "Link: https://lore.kernel.org/lkml/d7251d92-150b-5346-6237-52afc154bb00@rasmusvillemoes.dk"

[02/32] Introduce flexible array struct memcpy() helpers
39: B3 Line contains hard tab characters (\t): "        ...		/* arbitrary members */"
40: B3 Line contains hard tab characters (\t): "        u16 part_count;	/* count of elements stored in "parts" below. */"
41: B3 Line contains hard tab characters (\t): "        ...		/* arbitrary members */"
42: B3 Line contains hard tab characters (\t): "        u32 parts[];	/* flexible array with elements of type u32. */"
49: B3 Line contains hard tab characters (\t): "        ...		/* arbitrary members */"
57: B3 Line contains hard tab characters (\t): "        ...		/* arbitrary members */"
58: B3 Line contains hard tab characters (\t): "        u16 part_count;	/* count of elements stored in "parts" below. */"
59: B3 Line contains hard tab characters (\t): "        ...		/* arbitrary members */"
61: B3 Line contains hard tab characters (\t): "            ...		/* other blob members */"

[04/32] fortify: Add run-time WARN for cross-field memcpy()
14: B1 Line exceeds max length (85>80): "  memcpy: detected field-spanning write (size N) of single field "var->dest" (size M)"
38: B3 Line contains hard tab characters (\t): "	void *a;"
39: B3 Line contains hard tab characters (\t): "	int b;"
40: B3 Line contains hard tab characters (\t): "	size_t array_size;"
41: B3 Line contains hard tab characters (\t): "	u32 c;"
42: B3 Line contains hard tab characters (\t): "	u8 flex_array[];"
60: B3 Line contains hard tab characters (\t): "	int foo;"
61: B3 Line contains hard tab characters (\t): "	char bar;"
62: B3 Line contains hard tab characters (\t): "	struct normal_flex_array embedded;"

[07/32] iwlwifi: calib: Use mem_to_flex_dup() with struct iwl_calib_result
11: B1 Line exceeds max length (83>80): "memcpy: detected field-spanning write (size 8) of single field "&res->hdr" (size 4)"


##############################
Test: SubjectPrefix - FAIL - 28.23 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============1216943057250854325==--
