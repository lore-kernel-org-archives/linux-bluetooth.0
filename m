Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BC0EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jul 2023 01:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjG2BLG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 21:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjG2BLE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 21:11:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F03AA5
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 18:11:02 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-348cd210438so10441985ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690593061; x=1691197861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4goBAOyeXz/EmcBfplSwY7b9w7RJ1ZlCVEyDa20dLH8=;
        b=U8WPm5pTDEG4EBVrO07AyFGC0dDuVZSaD3J1rPH6MYB1iWtTP5DFfzt5rFe2VBN7Jj
         6Xi+Eg5PrwadOeSe/V0F73RnXSQY6witLBNt6XyTwU2LS8B+KD6ZDYjUzpY+Q1/W1YGZ
         9KcapwpBBCBHEppkQRN7ZkKbrFjaXHIZGm8rz9v9yu4eNfyksm2vNX71dqyvivteFPJw
         lf7Rm1pkg5j0ZChPWO0HE/L4Yol0M3QxLk6qz8b9JvKWHwPVdAwRuuClWkh8Y2APQ0RJ
         1fwEm8fHvlYxgfqKqT4iHU7E/pU6fD0JxUZrjcgql4w4MyIL9qeqHnFYj+WqoQCoaXby
         ds1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690593061; x=1691197861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4goBAOyeXz/EmcBfplSwY7b9w7RJ1ZlCVEyDa20dLH8=;
        b=eZTYy2Ua4W0c2wvKCCze4QK1iMH4zq4xyHu1c6QTjGthsMhVrAgrNTtHtBhLGsu+w4
         VN1r5lI07MXhUCEtSoSOJb3l7rOA4l3V8/L1CGXkc1DjxnBfMco+OS5FYnWqcJOekCek
         +JKLTIgL05Zlk9bbwp7tZvtL+pFOE/bCGDnI1QxRxF5utQ4EEGxJ0YryFWxBMxTazCHA
         gGo++tGBxyet2hSKK3cTpG3xThJjLCNoZyukJPsvu4NV87VtFuVbHqY3noN1KyubRNl2
         2miVitRAj2coMscahdhXWx3Tn3KWa+HzhmcVxZqPqUUMPA8yjhnt06O+IzFxGv3rBxX+
         QkUw==
X-Gm-Message-State: ABy/qLa249OpuM/IWOSwn+ReTbKSBWjkFiIlCWSMTt2JaE9XeVbi10Vw
        /+exIbj5A8NO3lNavvA2Kb24uZYteYg=
X-Google-Smtp-Source: APBJJlH7jY3ZNXSR1M+WnN0c/4YzkYW/iLj0kUmKqDIfY483VEnpmldmtRrZhPd5j9/fHVpPYnmo7Q==
X-Received: by 2002:a92:d083:0:b0:349:19e:7656 with SMTP id h3-20020a92d083000000b00349019e7656mr1074936ilh.28.1690593061593;
        Fri, 28 Jul 2023 18:11:01 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.5.156])
        by smtp.gmail.com with ESMTPSA id v21-20020a02cbb5000000b004290fd3a68dsm1458318jap.1.2023.07.28.18.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 18:11:01 -0700 (PDT)
Message-ID: <64c46725.020a0220.d7a4f.2da4@mx.google.com>
Date:   Fri, 28 Jul 2023 18:11:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8239296126960128069=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v5,1/7] monitor: Use gnuplot to plot graph of Latency-Packets
In-Reply-To: <20230728224247.102057-1-luiz.dentz@gmail.com>
References: <20230728224247.102057-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8239296126960128069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770739

---Test result---

Test Summary:
CheckPatch                    FAIL      3.33 seconds
GitLint                       PASS      2.04 seconds
BuildEll                      PASS      26.20 seconds
BluezMake                     PASS      754.54 seconds
MakeCheck                     PASS      11.28 seconds
MakeDistcheck                 PASS      152.27 seconds
CheckValgrind                 PASS      247.21 seconds
CheckSmatch                   WARNING   333.09 seconds
bluezmakeextell               PASS      100.58 seconds
IncrementalBuild              PASS      4437.75 seconds
ScanBuild                     WARNING   981.58 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v5,1/7] monitor: Use gnuplot to plot graph of Latency-Packets
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#86: 
        Address: XX:XX:XX:XX:XX:XX (Sony Home Entertainment&Sound Products Inc)

/github/workspace/src/src/13332712.patch total: 0 errors, 1 warnings, 156 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13332712.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v5,2/7] monitor: Update documentation
ERROR:CODE_INDENT: code indent should use tabs where possible
#115: FILE: monitor/main.c:55:
+                "\t                       system it will also attempt to plot\n"$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#115: FILE: monitor/main.c:55:
+                "\t                       system it will also attempt to plot\n"$

/github/workspace/src/src/13332713.patch total: 1 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13332713.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/l2cap.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3551:52: warning: array of flexible structuresmonitor/bt.h:3539:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3551:52: warning: array of flexible structuresmonitor/bt.h:3539:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3551:52: war
 ning: array of flexible structuresmonitor/bt.h:3539:40: warning: array of flexible structures
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
monitor/packet.c:12399:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(tx, tv, sizeof(*tv));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============8239296126960128069==--
