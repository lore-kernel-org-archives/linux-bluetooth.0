Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E2E7AD72
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 15:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjJCPgH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjJCPgG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 11:36:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E35AB
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 08:36:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c434c33ec0so7876865ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696347362; x=1696952162; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jQcafb6kFeVLgbd7LaYCAd4PvGokU0fq4gAQYFdeOz0=;
        b=SnOT9eR+dygNzFcmjq2anMgx3CrWqrweoCyvZWSLPeheHqbJAn8HnvWk8hhoor5D9y
         7BIDwqeFquvqpzhdaENZ6TqaX8WHc4b3ycakpwL5zRxDBLUeXcCNwJy9tvwxVUX+EiH/
         +IZFP3RM1k5zkukW4EaIjq1b19IzDShaY0yhrbdJvpIeDsHmF/G7ihYETqXyv+Ctd9Ai
         XXtfbavUhyEckE2Wk90rkPIRuICxVuKcyFpo4UgGR7jEEURgjdD8X/wyTO9T1o2FqO49
         CKmNm0KMO1mDSSjO2HBlaZyyPg0w1X9O/tQDFREYiOQ2XC0/8AjqWZJog1KwkEDwmZGH
         S+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696347362; x=1696952162;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQcafb6kFeVLgbd7LaYCAd4PvGokU0fq4gAQYFdeOz0=;
        b=S/pkYPT3PbX7L/v04uVtT1arvqMrU+3xEQ5kySBOkcz+w/ng+EjKpgwpnnjEbFHpBc
         hbVGzxIyW996PGZWI+AlcERWLm6VSalL2Xutq0ReWyt/zzGNKJeKQlFkZI67hZ+PXYRJ
         0yQKamaF896D+BTE+AweEKj/eoj24KfnOS2Yje27RjakcgvmHqKVREhGScDK/RZkxJne
         OgfDPjmH21GyixHT304cR+0ftsBvpxrp7c+EPXwaT1dQS1GOo5/QiwGhRDEQ+TK6IYeL
         e6lVNUInpI8f/I8Ys1v1ZQIMV9MXt7bh062041vvi+ecbjsX4xdK7jUkwjkwIZJBv5WC
         6V9Q==
X-Gm-Message-State: AOJu0Ywba/YyXrDDIIsW/VdefhjsUl2tRNdCmQ3rkBdLz1rJJY6Vq5vM
        6HaaGvJMjqv4BS4TOIynXdxp3aGUuew=
X-Google-Smtp-Source: AGHT+IErqqxm+6f4QIVRN3TliK3/sZG+TDNifFQkD9XqYB4gfhDSCvIJ5/orHc+PMUh5hOk/a3uoCg==
X-Received: by 2002:a17:902:ea8d:b0:1c6:19da:b2a5 with SMTP id x13-20020a170902ea8d00b001c619dab2a5mr12391076plb.32.1696347362095;
        Tue, 03 Oct 2023 08:36:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.135.60])
        by smtp.gmail.com with ESMTPSA id iw9-20020a170903044900b001a5fccab02dsm1716486plb.177.2023.10.03.08.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:36:01 -0700 (PDT)
Message-ID: <651c34e1.170a0220.75305.3c5c@mx.google.com>
Date:   Tue, 03 Oct 2023 08:36:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8124097607116422627=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, technicaluserx@outlook.com
Subject: RE: LE Extended Advertising Report structure
In-Reply-To: <AS8P189MB260298A86DD024F75EB934CCC6C4A@AS8P189MB2602.EURP189.PROD.OUTLOOK.COM>
References: <AS8P189MB260298A86DD024F75EB934CCC6C4A@AS8P189MB2602.EURP189.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8124097607116422627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789619

---Test result---

Test Summary:
CheckPatch                    FAIL      0.62 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      27.54 seconds
BluezMake                     PASS      780.40 seconds
MakeCheck                     PASS      11.58 seconds
MakeDistcheck                 PASS      160.03 seconds
CheckValgrind                 PASS      255.21 seconds
CheckSmatch                   PASS      351.24 seconds
bluezmakeextell               PASS      110.90 seconds
IncrementalBuild              PASS      682.85 seconds
ScanBuild                     PASS      1048.80 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] hci: Add LE Extended Advertising Report structure
WARNING:NEW_TYPEDEFS: do not add new typedefs
#107: FILE: lib/hci.h:2168:
+typedef struct{

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#121: FILE: lib/hci.h:2182:
+} __attribute__ ((packed)) le_extended_advertising_info;

/github/workspace/src/src/13407699.patch total: 0 errors, 2 warnings, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13407699.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8124097607116422627==--
