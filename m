Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0F6C77B6E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 19:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjDMTxt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 15:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDMTxr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 15:53:47 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9066182
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 12:53:46 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ly9so14481784qvb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681415625; x=1684007625;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BoigDtyTD5u0oBVonjiP84yy4p3/CReem3aNC+JjrOY=;
        b=PlFM5vkDJpHrPtbejfWRKAhTIJc9oUI80lIRvGl7wCjQvKsXgj3NZVVOhGrCI8mUz8
         TfXD02N8bl5j9mLsZ7tUEM2P7ZlGNu83NSqIlgcAZ91CaNlz+ILLn48tjDNMJrkDnuzx
         CyVkvCjVYuXP6N/ADw0m+jaAwqymPXAdH8R4sLEQmX3R67UWNQODKw7GPXl6kPR2wtrW
         3XTQb256uLi1e4au1e0LJEV/saF6fdARA/5PmREQIabZ+UwqglVwLBQ+l/FB5qrtGD1R
         fIlxDXv7Tk+mOyovvjuB8eRJ9gC9rIPvv3jfwkroeqNPP7T3x266oW2zfnp2JJB0mFum
         N67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681415625; x=1684007625;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoigDtyTD5u0oBVonjiP84yy4p3/CReem3aNC+JjrOY=;
        b=SXTugkSUeAxAXupKBep4NQnk67KFo7RmOZ4aO7DctdOW9SJ/3kJJ60B99VNBknJN4Z
         36yNicoj0nmPgLCxgWXR5zNsRJb4etxpZW0AiZwec0Wv5yJnINjHXEbKIvUO7t2cYeRZ
         GyEBk750IgHltW+RaeRYCKsB2ZlHk0UekSUhamn1DtQS0bPU3T1ukvjIamgnSCbqI42q
         T6IZXvn1actqSqf9PK7l9aXu8mhnDxnFnWIcWQcR6hSeK2bxhCfLn/qPuXgwkwtTG4Ei
         qtte9r6WfaG7xqJnPtdh4WUGnMEVZpmWuNji54RBBszvlkC8pqu8yLGrP7SdoYqBjfmr
         4ZHw==
X-Gm-Message-State: AAQBX9eKiagTu/eGZm6O2VpSlcp7g0FZfumyq8QEVli/KPniRMXVVyUe
        H6AeJcqCFCWHSrDZdX98U4HQtsppPCg=
X-Google-Smtp-Source: AKy350bPjMmilBXW42ifW8pxgWd53cWTrH5mN2q8nWnNe1Lcpl3A51Ewtq6kB7JBP5nZzPoWoJfYXA==
X-Received: by 2002:a05:6214:2264:b0:5ef:4ae4:4da6 with SMTP id gs4-20020a056214226400b005ef4ae44da6mr5841424qvb.31.1681415625515;
        Thu, 13 Apr 2023 12:53:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.22])
        by smtp.gmail.com with ESMTPSA id dw17-20020a0562140a1100b005eb28315286sm643347qvb.113.2023.04.13.12.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 12:53:45 -0700 (PDT)
Message-ID: <64385dc9.050a0220.9b3e5.3861@mx.google.com>
Date:   Thu, 13 Apr 2023 12:53:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8288691299275890110=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] btdev: Fix not setting CIS parameters properly
In-Reply-To: <20230413181528.860660-1-luiz.dentz@gmail.com>
References: <20230413181528.860660-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8288691299275890110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=739570

---Test result---

Test Summary:
CheckPatch                    FAIL      1.53 seconds
GitLint                       PASS      0.68 seconds
BuildEll                      PASS      26.95 seconds
BluezMake                     PASS      986.88 seconds
MakeCheck                     PASS      11.62 seconds
MakeDistcheck                 PASS      149.78 seconds
CheckValgrind                 PASS      246.19 seconds
CheckSmatch                   WARNING   330.56 seconds
bluezmakeextell               PASS      99.32 seconds
IncrementalBuild              PASS      1653.35 seconds
ScanBuild                     PASS      1029.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] iso-tester: Add BAP Audio Configuration tests
ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#258: FILE: tools/iso-tester.c:796:
+static const struct iso_client_data connect_ac_6i= {
                                                  ^

ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#265: FILE: tools/iso-tester.c:803:
+static const struct iso_client_data connect_ac_6ii= {
                                                   ^

ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#272: FILE: tools/iso-tester.c:810:
+static const struct iso_client_data connect_ac_7i= {
                                                  ^

ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#279: FILE: tools/iso-tester.c:817:
+static const struct iso_client_data connect_ac_7ii= {
                                                   ^

ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#286: FILE: tools/iso-tester.c:824:
+static const struct iso_client_data connect_ac_8i= {
                                                  ^

ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#293: FILE: tools/iso-tester.c:831:
+static const struct iso_client_data connect_ac_8ii= {
                                                   ^

ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#300: FILE: tools/iso-tester.c:838:
+static const struct iso_client_data connect_ac_9i= {
                                                  ^

ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#307: FILE: tools/iso-tester.c:845:
+static const struct iso_client_data connect_ac_9ii= {
                                                   ^

ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#314: FILE: tools/iso-tester.c:852:
+static const struct iso_client_data connect_ac_11i= {
                                                   ^

ERROR:SPACING: spaces required around that '=' (ctx:VxW)
#321: FILE: tools/iso-tester.c:859:
+static const struct iso_client_data connect_ac_11ii= {
                                                    ^

/github/workspace/src/src/13210503.patch total: 10 errors, 0 warnings, 388 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13210503.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:412:29: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8288691299275890110==--
