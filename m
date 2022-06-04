Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F73C43334
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jun 2022 00:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349854AbiFDAw5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 20:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFDAw4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 20:52:56 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F742E9F0
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 17:52:55 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id k6so4210268qkf.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jun 2022 17:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nvHm1OQlsNblNBNg5o7IglZhRY7dsVgBTKbnHHaH0kk=;
        b=l8glmTKAb/5OW2IdQWbdWCIHf0ytpOxG/z87YpS8jltpA3BYYpNkpwi9MaZ0wW5rDk
         sfLzQVuKWIFx58/+sdHxs3J6PpN2sfwlwBjLCabF5UB6ZBh/G5c5E3x095SH+j9u3CwK
         /W8gbZW0fnbNTARSWac7Nc8dcAxrjK/zgKlEU2us3jv21uo69GgXWauDxJ4JXQYb8UjV
         zwQmpYfOy0CPdCXri/+O9Fp4oD5SzlyP4sgsscpluQgtOwD2FxAAl10i1RZVnGIg4phh
         USbZc+fC0c5xhT0GKyQRq//EjKYVQBgh5bLy3vqZ2qJ02aoxm1NT5Xnf+DiPr3K9e+sC
         uzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nvHm1OQlsNblNBNg5o7IglZhRY7dsVgBTKbnHHaH0kk=;
        b=MK6x6AJhZvXf9rXuPX2zmBE+zwKy7DFjK+8InX+kyx73aLn+VI8c5JclUaF9+fYnc2
         jtyCI97t/dWHeCnQvJt/7Aq53jAGqEmF6+xJ2Bh3ISjMWbIiCF9T6htdBdi1q2mXDHRS
         Mo4W6r1Y3yZ2hBJ4NYriEs3kE4Scy6gOjhgebifntFZKjdHar7be/Sx1CDJOKxpOwo45
         f9GX66ZbKezt4WQ4ZDVrXQCDD6H4LxcGn/x6mlMCHsRevTbq521g4QJFQoCuI/eX3IWv
         6nP5kVjdGrw80ABCDzFGcO6MSmuRv2iVdgQ3e4rbLqjt8R61wBdnC5xfCqfzOtTp7Ndp
         CAeg==
X-Gm-Message-State: AOAM530WRVQR+G/HEEmYB0p9wi88Yu9NBoMIc8O6It207ZspKUA8sHU8
        /+4i1s7xpbCO/6di10la7cLoAs7zO5H/Og==
X-Google-Smtp-Source: ABdhPJx1uVlxgFzzGa3nb28PRp0OdR1tJhtad5uZq9y3+jeomjdl95lRyvuvPKmUuqIIIuER7mK86g==
X-Received: by 2002:a37:a24d:0:b0:6a6:9d16:174d with SMTP id l74-20020a37a24d000000b006a69d16174dmr3878346qke.766.1654303974179;
        Fri, 03 Jun 2022 17:52:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.37.144])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a24c600b006a6a7b4e7besm1143137qkn.109.2022.06.03.17.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 17:52:53 -0700 (PDT)
Message-ID: <629aace5.1c69fb81.6a8b7.6226@mx.google.com>
Date:   Fri, 03 Jun 2022 17:52:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1496061867660912665=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, puffy.taco@gmail.com
Subject: RE: LE OOB pairing support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220603223225.20296-2-puffy.taco@gmail.com>
References: <20220603223225.20296-2-puffy.taco@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1496061867660912665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647337

---Test result---

Test Summary:
CheckPatch                    FAIL      4.62 seconds
GitLint                       PASS      3.05 seconds
Prep - Setup ELL              PASS      46.37 seconds
Build - Prep                  PASS      0.75 seconds
Build - Configure             PASS      9.61 seconds
Build - Make                  PASS      1341.77 seconds
Make Check                    PASS      11.78 seconds
Make Check w/Valgrind         PASS      471.83 seconds
Make Distcheck                PASS      249.57 seconds
Build w/ext ELL - Configure   PASS      9.16 seconds
Build w/ext ELL - Make        PASS      1349.46 seconds
Incremental Build with patchesPASS      4218.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[1/3] eir: parse data types for LE OOB pairing
WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#137: FILE: src/eir.h:40:
+#define EIR_LE_SC_CONF              0x22  /* LE: Secure Connections Confirmation Value */

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#138: FILE: src/eir.h:41:
+#define EIR_LE_SC_RAND              0x23  /* LE: Secure Connections Random Value */

/github/workspace/src/12869444.patch total: 0 errors, 2 warnings, 52 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12869444.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[2/3] Accept LE formatted EIR data with neard plugin
WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#147: FILE: plugins/neard.c:577:
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#156: FILE: plugins/neard.c:595:
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#169: FILE: plugins/neard.c:613:
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#197: FILE: plugins/neard.c:744:
+								remote.address_type);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#206: FILE: plugins/neard.c:768:
+							remote.address_type, io_cap);

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#229: FILE: src/adapter.c:8772:
+					const bdaddr_t *bdaddr, uint8_t bdaddr_type,

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#250: FILE: src/adapter.h:216:
+					const bdaddr_t *bdaddr, uint8_t bdaddr_type,

/github/workspace/src/12869445.patch total: 0 errors, 7 warnings, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12869445.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1496061867660912665==--
