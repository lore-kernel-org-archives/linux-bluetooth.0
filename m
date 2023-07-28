Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC7C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 19:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjG1Tdj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 15:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG1Tdi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 15:33:38 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B9E69
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 12:33:37 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-63d0228d32bso15229346d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690572816; x=1691177616;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4b6SrOEGLkZLTcHocK/1oqEoqfFeLNCu0BNkjlriQaM=;
        b=HfSz9RwLCDwmMvNJSgpnve4u+9/NOZ/XwJvbsqPJPZ4ZcA+dRGNSW9phRDXF39cYsB
         kLDELhvj8nN5aD0b7tdSnu2Vul8pl0T1p8WJcEWL9WjEe3xskQJ+aMt7sRq50/KmpN6i
         BpeQq6MAiI6ENdRqnvKHFrFHI/FYoBvbU57H+xA3YiUAO1bO23y584+s9xkpAwMCfjMP
         H1rJkxpg1FJ8I8EbubkDiyPBRr6a64iTf+AcJOqvalo0/O20KeDlriycoC5hHQqJb1gD
         eHVhLXUpq9jhRQBH66aOKmWX8Gt5QnEw7vCsr84M+C9EYyhRoJJx2dTXqNSEBh8NfuLz
         R9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690572816; x=1691177616;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4b6SrOEGLkZLTcHocK/1oqEoqfFeLNCu0BNkjlriQaM=;
        b=KPmwYJsG/3Vo82g2YZROS1EmvdsJq8SEioxcnjCWAQXCSXiLYu3HzD1zsZn1Fs5kSj
         +Ajjzx0ss3wbNSghbtwAEch5TLL/MXeyjUemzO+BPpmUDURVikqIMR91mwJC/tFNg9yd
         hvCfb4jBLaqXvL2N5CGzvqaBOBgLPTohbrGSRy+1n+j5oggbWQI8n3kBEUYr3nwAr8+B
         XnjzzE9fHp5xnyO1zADjN8S53zUSXYz7wVDbaGbV6PSKvgNOH9Yqh9ff7GHWf0YwHOVW
         H77s4hHftVZRl4SKngZyj1uoLeAi4xzTT3LSDq6IW6rWFp7AesH7O8iIrxd9vM3F2OBa
         ithQ==
X-Gm-Message-State: ABy/qLYqO9bTSC4ynsSl5AStIAj7x8rIJP5KqU4O5rkWXifRul+ExY+c
        ucNTWSeJv78OjcKbzNzeH7bUxoZ7rqU=
X-Google-Smtp-Source: APBJJlEFV5mKOHMOFI4lgqjPjtCsq3oftKuTZwywaicmPp0Vv7pszAhjr0XsO4RvWoooZE3ni6/nhA==
X-Received: by 2002:a0c:e14d:0:b0:63d:3a85:727d with SMTP id c13-20020a0ce14d000000b0063d3a85727dmr3555918qvl.10.1690572816227;
        Fri, 28 Jul 2023 12:33:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.233.61])
        by smtp.gmail.com with ESMTPSA id d8-20020a37c408000000b00767b4fa5d96sm1353003qki.27.2023.07.28.12.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 12:33:35 -0700 (PDT)
Message-ID: <64c4180f.370a0220.78797.5cef@mx.google.com>
Date:   Fri, 28 Jul 2023 12:33:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2359323534629444471=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/3] monitor: Use gnuplot to plot graph of Latency-Packets
In-Reply-To: <20230728175937.42818-1-luiz.dentz@gmail.com>
References: <20230728175937.42818-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2359323534629444471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770670

---Test result---

Test Summary:
CheckPatch                    FAIL      1.87 seconds
GitLint                       PASS      1.07 seconds
BuildEll                      PASS      27.21 seconds
BluezMake                     PASS      781.31 seconds
MakeCheck                     PASS      11.40 seconds
MakeDistcheck                 PASS      157.38 seconds
CheckValgrind                 PASS      251.09 seconds
CheckSmatch                   WARNING   339.62 seconds
bluezmakeextell               PASS      102.83 seconds
IncrementalBuild              PASS      1976.07 seconds
ScanBuild                     WARNING   1026.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,1/3] monitor: Use gnuplot to plot graph of Latency-Packets
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#86: 
        Address: XX:XX:XX:XX:XX:XX (Sony Home Entertainment&Sound Products Inc)

/github/workspace/src/src/13332241.patch total: 0 errors, 1 warnings, 156 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13332241.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,2/3] monitor: Update documentation
ERROR:CODE_INDENT: code indent should use tabs where possible
#115: FILE: monitor/main.c:55:
+                "\t                       system it will also attempt to plot\n"$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#115: FILE: monitor/main.c:55:
+                "\t                       system it will also attempt to plot\n"$

/github/workspace/src/src/13332242.patch total: 1 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13332242.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/l2cap.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3551:52: warning: array of flexible structuresmonitor/bt.h:3539:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
monitor/l2cap.c:1638:4: warning: Value stored to 'data' is never read
                        data += len;
                        ^       ~~~
monitor/l2cap.c:1639:4: warning: Value stored to 'size' is never read
                        size -= len;
                        ^       ~~~
2 warnings generated.
monitor/packet.c:12373:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(tx, tv, sizeof(*tv));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2359323534629444471==--
