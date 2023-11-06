Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A937C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 23:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjKFXBH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 18:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjKFXBG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 18:01:06 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E6410D
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Nov 2023 15:01:00 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35809893291so19954255ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Nov 2023 15:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699311659; x=1699916459; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rCAotI9PBrUDSXwUP+JQ+Qy4qnXy7v3gDGTZcXhi02c=;
        b=GUfzYv/6vN+516Q/LmjQtmGX6ipBQHkXaEPuvEHhiKHa6TVJws+GDZl7+JxpIE8H9S
         kogz5rMwap4HpW04uu4dHumLoL8Tov6uzjLwjEesjdnDMtNXthndHj7e9U3Ef3/vKdwj
         jKu54OASRwCa/MLv9hIyTlSTqAopL2Iz+Pfd/4RTE8XVj9+/5qsMmwt68NH/IE9X+4JF
         5HmpkY1+tV1h7DCBUa5PCycy3EKSszSBCXUjoZN36E45g14Cn7JrgWyNiSVORW0BFLrM
         rZzAQv8dj9QpENcLfhMmqC4XxiJiGUTd+i3Jyk9sSPjzJjkLDpU4hpeldRekQmbi67ze
         eH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311659; x=1699916459;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCAotI9PBrUDSXwUP+JQ+Qy4qnXy7v3gDGTZcXhi02c=;
        b=Q9lkbI2YbQEfuaJ34Z8whuNg9bpGEFcj0+0FIepjT+InaftWNiq4l7ENl2jxJ4MwRQ
         Uqs7mICwwpl0NpAtpnLzd7m7VsKq8gPxNmXaWDdOO/Owz9BfafumsJfX8OTn7Gv+LC5N
         nhTJqrNR8Rn2QefvJttoI5dGo8nM6ma9FhccTF/FulbTgOSqktrTMHuHL/DMiTSot+8X
         aYGBBkT1FwSOZSz19YU6kVuWko41dBNRZ+1ZcJhYGMGQ9TW4DsmE4gRyRF58rWRASgZT
         VIA80k3ePFWdwtlCJJIg62WikodYJjbyhePjEcoMeWhlTmbnOORewmgfFq8jv/w0uvMO
         7MAw==
X-Gm-Message-State: AOJu0YyXnDDzdkwxr071j1J9tG19pj93mNoUWpRXK26SXlTanIwNJVSN
        NQS/G8n59pFbtBn1pFoCiQltZbT172w=
X-Google-Smtp-Source: AGHT+IFjO9VJXxTZA7z9Xxv678Qt7D8c5Zt2WMQ8qW2n55Vk8jtpxAR90NSb/Tx3uypqFu6XgUsMOA==
X-Received: by 2002:a05:6e02:1a06:b0:359:4048:38df with SMTP id s6-20020a056e021a0600b00359404838dfmr1398885ild.7.1699311659375;
        Mon, 06 Nov 2023 15:00:59 -0800 (PST)
Received: from [172.17.0.2] ([40.77.92.125])
        by smtp.gmail.com with ESMTPSA id e3-20020a92de43000000b0035265088c52sm2727540ilr.34.2023.11.06.15.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 15:00:59 -0800 (PST)
Message-ID: <6549702b.920a0220.42548.3976@mx.google.com>
Date:   Mon, 06 Nov 2023 15:00:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2965714463578443686=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yuran.pereira@hotmail.com
Subject: RE: Bluetooth: Add documentation and replace printk calls
In-Reply-To: <DB3PR10MB68355F5AE036ABD128F91535E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB68355F5AE036ABD128F91535E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2965714463578443686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=799231

---Test result---

Test Summary:
CheckPatch                    FAIL      1.54 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      32.85 seconds
CheckAllWarning               PASS      35.98 seconds
CheckSparse                   PASS      41.19 seconds
CheckSmatch                   PASS      116.09 seconds
BuildKernel32                 PASS      32.19 seconds
TestRunnerSetup               PASS      502.42 seconds
TestRunner_l2cap-tester       PASS      29.45 seconds
TestRunner_iso-tester         PASS      53.84 seconds
TestRunner_bnep-tester        PASS      10.02 seconds
TestRunner_mgmt-tester        PASS      203.88 seconds
TestRunner_rfcomm-tester      PASS      15.10 seconds
TestRunner_sco-tester         PASS      18.24 seconds
TestRunner_ioctl-tester       PASS      16.98 seconds
TestRunner_mesh-tester        PASS      12.28 seconds
TestRunner_smp-tester         PASS      13.22 seconds
TestRunner_userchan-tester    PASS      10.21 seconds
IncrementalBuild              PASS      34.94 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] Bluetooth: Add documentation to exported functions in lib
WARNING: please, no space before tabs
#121: FILE: net/bluetooth/lib.c:36:
+ * ^I^I bd address.$

ERROR: trailing whitespace
#142: FILE: net/bluetooth/lib.c:60:
+ * Return: $

total: 1 errors, 1 warnings, 0 checks, 125 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13447550.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2965714463578443686==--
