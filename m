Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534C0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 03:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3368661506
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 03:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhJVDkp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhJVDkn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 23:40:43 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6290AC061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 20:38:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s61-20020a17090a69c300b0019f663cfcd1so4722932pjj.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jHxJnA7wbR+qHekwtAmiGVx+FGvESk1Jnbypb5LpKYw=;
        b=Y3/RxuHGYXqEvCMCnbD2/IBalwLLpzON1eAGzGH1bvG+uvdVAmaTYc23/1tPsBMUKY
         738wIegNq2mBa1GXpbjJ48EDIjfJA+pDkwtpDuoRlAQOwTe/yCeGRVKxEdDGJ8HnSwFe
         FlVHy+xpIlr/u4AX8fyM3oJi5Fp4QCVemfeKRwVcNA7Jd3aNdm5VT0frBY0XyuHZ885d
         N4c3nE3lYzqXR8yIwuQOuGUG+XDJy9cZVIgcYUAV+Wa8/JS4ayP2g4nFwthaw/ez35p/
         ZXjqOdGdX+y8E9D75Aclvoja/W+lWSQJVJusPqnlgaBrFpKkexFF0ElMsxTthz1ZOscx
         TVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jHxJnA7wbR+qHekwtAmiGVx+FGvESk1Jnbypb5LpKYw=;
        b=L1K4jmfkFi5EF/1nsQMx8OghjoXfyf3usiWgP69ENFRYDIV0jfMEc6Xgots7a1jdJ1
         YmGmXXaRRdw4EpLFu6Mwp0tMaD8PMxcCMF89a13FO7nIobvrh0btYxikEPm34SycUHuu
         wd6ALzuKKLw7U/40TerW5jyrZX07NJ1ezgalN8DYMG9PmD9edqMTM4O5CWRFGXcogQ0g
         wgnSHj6l4D2L588qkYr7nhtH+PptXX9wz7yQRT8pJqIGmEfeAoU8kL1/nF0oaqmg2+on
         GQxXoJonroxXZpRHGBpp3LAtoHJHimAfyABHfRw8oto9gm/h100q8jS1Jew4yuv1WMzC
         HvMg==
X-Gm-Message-State: AOAM533Ik6YyimuzwGd003pHV+IFNs/HmTDAs4gQhi4k+ZOAWg8d7hua
        0wRFuuySjbyGvO914Bj34oY7JpCp0mW28A==
X-Google-Smtp-Source: ABdhPJxiO4Z+G9//v96g1OxFF8OKFkqZ9Bt3RTk8RgaNUhpeIZOh+JTqk5moze3FTL1yWEzOJhT3bA==
X-Received: by 2002:a17:902:dccc:b0:140:b9a:d1e5 with SMTP id t12-20020a170902dccc00b001400b9ad1e5mr4764145pll.36.1634873905568;
        Thu, 21 Oct 2021 20:38:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.191.159])
        by smtp.gmail.com with ESMTPSA id lw14sm8241499pjb.34.2021.10.21.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:38:25 -0700 (PDT)
Message-ID: <61723231.1c69fb81.c2c2b.71d6@mx.google.com>
Date:   Thu, 21 Oct 2021 20:38:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0370392424059256376=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] src/device: Fix glib assertion
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211022031456.373471-1-hj.tedd.an@gmail.com>
References: <20211022031456.373471-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0370392424059256376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=568303

---Test result---

Test Summary:
CheckPatch                    FAIL      0.47 seconds
GitLint                       FAIL      0.31 seconds
Prep - Setup ELL              PASS      46.06 seconds
Build - Prep                  PASS      0.24 seconds
Build - Configure             PASS      8.38 seconds
Build - Make                  PASS      201.97 seconds
Make Check                    PASS      8.62 seconds
Make Distcheck                PASS      240.72 seconds
Build w/ext ELL - Configure   PASS      8.57 seconds
Build w/ext ELL - Make        PASS      191.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] src/device: Fix glib assertion
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#87: 
bluetoothd[370193]: GLib: g_file_set_contents: assertion 'error == NULL || *error == NULL' failed

/github/workspace/src/12576965.patch total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12576965.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] src/device: Fix glib assertion
7: B1 Line exceeds max length (97>80): "bluetoothd[370193]: GLib: g_file_set_contents: assertion 'error == NULL || *error == NULL' failed"
9: B1 Line exceeds max length (105>80): "bluetoothd[370193]: #1  g_logv+0x21c (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314559455c]"
10: B1 Line exceeds max length (103>80): "bluetoothd[370193]: #2  g_log+0x93 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f3145594743]"
11: B1 Line exceeds max length (117>80): "bluetoothd[370193]: #3  g_file_set_contents+0x68 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f3145577a68]"
12: B1 Line exceeds max length (86>80): "bluetoothd[370193]: #4  store_device_info_cb+0x3b6 (src/device.c:475) [0x55be0a3591e6]"
13: B1 Line exceeds max length (122>80): "bluetoothd[370193]: #5  g_main_context_dispatch+0x14e (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314558d04e]"
14: B1 Line exceeds max length (95>80): "bluetoothd[370193]: #6  ?? (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314558d400]"
15: B1 Line exceeds max length (113>80): "bluetoothd[370193]: #7  g_main_loop_run+0x83 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6) [0x7f314558d6f3]"
16: B1 Line exceeds max length (90>80): "bluetoothd[370193]: #8  mainloop_run+0x19 (src/shared/mainloop-glib.c:68) [0x55be0a394149]"
17: B1 Line exceeds max length (105>80): "bluetoothd[370193]: #9  mainloop_run_with_signal+0xf0 (src/shared/mainloop-notify.c:190) [0x55be0a3945b0]"
19: B1 Line exceeds max length (89>80): "bluetoothd[370193]: #11 __libc_start_main+0xf3 (../csu/libc-start.c:342) [0x7f314521e0b3]"
20: B1 Line exceeds max length (95>80): "bluetoothd[370193]: #12 _start+0x2e (/home/han1/work/dev/bluez/src/bluetoothd) [0x55be0a2dac7e]"




---
Regards,
Linux Bluetooth


--===============0370392424059256376==--
