Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF22C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jun 2023 13:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbjFFNbU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjFFNbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jun 2023 09:31:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3074310C0
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 06:31:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75ec7e8e826so114028685a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jun 2023 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686058276; x=1688650276;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lE0+dhKKFcmGn4WlxVuaSAhUZ+MRUtUufLkbYAuvKVU=;
        b=InWwPX54QE1O5jNEXVb0KkpGc7LDpq8i8JS6MvnAuoW0qxIX8Cr9o9iGBatbG2jPYt
         KL9C1h5iCjGWBZQpZpPimkd3meH5+03Myp1h/ihsCLkIgvNlPZILyD7mTQauJkbkJlwY
         znyvPv61lHK2oJ47iflyi4RhjsOj/3zdHERHMoob+h1JcAQClJBDQynDivhUwJQGTdPf
         vlF9xqpe1AZz+ozeeOjr+n6H1WLOiBUX9rq41g0IBoW6Pjn5TLB6KszceTKJKB5d01Az
         bt8BtRqFzAvXj1Drj9iyD3KY8woCifxH0lAb8cr8RABqDEEuHzps3fiD7v3W5c3LWtcm
         kBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058276; x=1688650276;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE0+dhKKFcmGn4WlxVuaSAhUZ+MRUtUufLkbYAuvKVU=;
        b=GJYqN/7zIotzbHIXsZVQj4BXT6bHJhqf4MSznk6B20FQXw0QWz+H8nMD4Mq/JQcQeM
         hiIlJKl6A9ijyzxYlPPgFzGPoWlKHtBtG8HBCMaHe7+k5ykK39ME1pyKy3oAHilOFEqk
         qvRDOnRRuOV8uGVbGc54XOEHORKvkw9+FMAyee1aj1ytDoV0UHYVZENnQ9+U2aWTcOPp
         GYNniGhRuzBuDhFYeAgFjUMjdevzlACn3yxgH2w8YY4XLp72T1JCFz5MKn+qeSJYzfWX
         nosmGnbfFzggO+/ABs5OS4G3Ms04pMkvrFB9U8SyPh1ZmxpUQQ8cSvg5tjZDM/tPK6lt
         Y5BA==
X-Gm-Message-State: AC+VfDwGqUjyc/7IflAuvrYX6pjlkiJlODMHcFqQxmzohEvjQxY8cyTH
        dbi0NvGyENi4VsYLeWwErIeM1utYCyA=
X-Google-Smtp-Source: ACHHUZ65guHdf9j9iUwieKhD+2I0PjTWBbXtGjdsOEQImN8l5uk/S8khyYjfKS+J9xAxYrX3dfcfPQ==
X-Received: by 2002:a05:620a:2702:b0:75e:c91b:861e with SMTP id b2-20020a05620a270200b0075ec91b861emr1996031qkp.54.1686058276062;
        Tue, 06 Jun 2023 06:31:16 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.125.209])
        by smtp.gmail.com with ESMTPSA id m14-20020ae9e70e000000b007594a7aedb2sm4879614qka.105.2023.06.06.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:31:15 -0700 (PDT)
Message-ID: <647f3523.e90a0220.e74c4.ced8@mx.google.com>
Date:   Tue, 06 Jun 2023 06:31:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4591044676212743865=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nitin.jadhav@nxp.com
Subject: RE: Code handling for VOCS service
In-Reply-To: <20230606120824.4705-2-nitin.jadhav@nxp.com>
References: <20230606120824.4705-2-nitin.jadhav@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4591044676212743865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=754428

---Test result---

Test Summary:
CheckPatch                    FAIL      1.73 seconds
GitLint                       FAIL      0.91 seconds
BuildEll                      PASS      26.19 seconds
BluezMake                     PASS      755.55 seconds
MakeCheck                     PASS      11.55 seconds
MakeDistcheck                 PASS      152.47 seconds
CheckValgrind                 PASS      246.78 seconds
CheckSmatch                   PASS      330.82 seconds
bluezmakeextell               PASS      99.84 seconds
IncrementalBuild              PASS      1273.46 seconds
ScanBuild                     WARNING   986.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/2] Added initial code for handling VOCS
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#97: 
This commit handles the code implementation of VOCS service and characteristics

ERROR:TRAILING_WHITESPACE: trailing whitespace
#528: FILE: src/shared/vcp.c:1076:
+^I$

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#593: FILE: src/shared/vcp.c:1267:
+static void vcp_audio_descriptor_notify(struct bt_vcp *vcp, uint16_t value_handle,

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#611: FILE: src/shared/vcp.c:1339:
+static void read_vol_offset_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#622: FILE: src/shared/vcp.c:1350:
+		DBG(vcp, "Unable to read Vol Offset State: error 0x%02x", att_ecode);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#636: FILE: src/shared/vcp.c:1364:
+static void read_vocs_audio_location(struct bt_vcp *vcp, bool success, uint8_t att_ecode,

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#647: FILE: src/shared/vcp.c:1375:
+		DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02x", att_ecode);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#661: FILE: src/shared/vcp.c:1389:
+static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success, uint8_t att_ecode,

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#672: FILE: src/shared/vcp.c:1400:
+		DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%02x", att_ecode);

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#696: FILE: src/shared/vcp.c:1573:
+	bt_uuid_t uuid, uuid_vostate, uuid_audio_loc, uuid_vo_cp, uuid_audio_op_decs;

WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#720: FILE: src/shared/vcp.c:1597:
+						     vcp_voffset_state_notify, NULL);

WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#726: FILE: src/shared/vcp.c:1603:
+		DBG(vcp, "VOCS Volume Audio Location found: handle 0x%04x", value_handle);

ERROR:TRAILING_WHITESPACE: trailing whitespace
#729: FILE: src/shared/vcp.c:1606:
+^I^Iif (!vocs || vocs->voal) $

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#734: FILE: src/shared/vcp.c:1611:
+		vcp_read_value(vcp, value_handle, read_vocs_audio_location, vcp);

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#737: FILE: src/shared/vcp.c:1614:
+						     vcp_audio_loc_notify, NULL);

WARNING:LONG_LINE: line length of 89 exceeds 80 columns
#755: FILE: src/shared/vcp.c:1632:
+		DBG(vcp, "VOCS Vol Audio Descriptor found: handle 0x%04x", value_handle);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#763: FILE: src/shared/vcp.c:1640:
+		vcp_read_value(vcp, value_handle, read_vocs_audio_descriptor, vcp);

WARNING:LONG_LINE: line length of 87 exceeds 80 columns
#765: FILE: src/shared/vcp.c:1642:
+						    vcp_audio_descriptor_notify, NULL);

/github/workspace/src/src/13269044.patch total: 2 errors, 16 warnings, 672 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13269044.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,2/2] Fixed the following issue observed during PTS testing for mandatory test cases - Specified Upper and Lower Limit for Volume offset - Corrected the number of handles for VOCS - VOCS is made as included service of VCS because VOCS is secondar
WARNING:LEADING_SPACE: please, no spaces at the start of a line
#137: FILE: src/shared/vcp.c:174:
+    int16_t vol_offset;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#138: FILE: src/shared/vcp.c:175:
+    uint8_t counter;$

WARNING:LONG_LINE: line length of 116 exceeds 80 columns
#146: FILE: src/shared/vcp.c:712:
+	if(req->set_vol_offset > VOCS_VOL_OFFSET_UPPER_LIMIT || req->set_vol_offset < VOCS_VOL_OFFSET_LOWER_LIMIT) {

ERROR:SPACING: space required before the open parenthesis '('
#146: FILE: src/shared/vcp.c:712:
+	if(req->set_vol_offset > VOCS_VOL_OFFSET_UPPER_LIMIT || req->set_vol_offset < VOCS_VOL_OFFSET_LOWER_LIMIT) {

/github/workspace/src/src/13269045.patch total: 1 errors, 3 warnings, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13269045.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/2] Fixed the following issue observed during PTS testing for mandatory test cases - Specified Upper and Lower Limit for Volume offset - Corrected the number of handles for VOCS - VOCS is made as included service of VCS because VOCS is secondar

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (255>80): "[BlueZ,v1,2/2] Fixed the following issue observed during PTS testing for mandatory test cases - Specified Upper and Lower Limit for Volume offset - Corrected the number of handles for VOCS - VOCS is made as included service of VCS because VOCS is secondar"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/vcp.c:1271:2: warning: Null pointer passed to 1st parameter expecting 'nonnull'
        memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============4591044676212743865==--
