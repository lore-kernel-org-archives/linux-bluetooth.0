Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E10EE49AC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Aug 2023 13:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjHTNXt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Aug 2023 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHTNXq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Aug 2023 09:23:46 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314A3598
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Aug 2023 06:23:05 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34992058e95so7629455ab.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Aug 2023 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692537785; x=1693142585;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9oaJRPW6xs/iuGhdJIlVMFZEQVXIp1HwrInpQXlDI6A=;
        b=C2c8aNGo5CLUwsT+eLasY6rJyHEKo3m8/vdx+pgSfEmpEeIku3z5RQTKoqu7VyFvTW
         SFDF44KsIG5EDN/nzMNnofIe6fLqvLoO3fEDHU4TKRBu/LJL85cnxXu1HhBQZpsTRr5w
         2F8IBRdI4ckoD1dcSkRDV9pIPtbygJROo4RG64xy7qUhRG5a+XqFIROFFj4T6YAPJYm3
         MbGkObyEtDbTKLOAn1OsCHy1D0x+2lrjtXGE6e80N1T2Mb9uP/N8I8yk23X3TN7pKGeI
         jlnbzDktTg5MtjT93i+s4MK5BJzQsHjjJ2V6sgvXF0fElFjX3ClikR5Q5piI1FdZAzqw
         EMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692537785; x=1693142585;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oaJRPW6xs/iuGhdJIlVMFZEQVXIp1HwrInpQXlDI6A=;
        b=cct5vku8FBAtIB205HqDv8Y2P4SrTXnAqclGPyZCIjOzj1tIzTXfqEe0MxSTJnSqbp
         R7rRL9xT8zippdiks2xazrsJjCqW1pE7BO439RtbqX+xu6XXMhzbcrzwdgOO74CmioMH
         LbmEJ1n0+QqwjoeqLHFG6iWzpn+JSjEwQVooZ/5NyVfcNjD1yKkFwqEGqHWrDeCbfkiS
         xfn1jMlQPll0RLPKNcMUOyo4CvU3Tm4AAAe3908s7oCrrti35IUL1wN5DEqEEqsSyMji
         hmDtKI/CAGC47ikTJgbAw7CQ9JNe4A5G8ncF6+t7As3XuK/14gT1tUV5JNkeTlXjNx05
         0Gjw==
X-Gm-Message-State: AOJu0Yxgzhc00+RTBSQVbm4UawiKGwZMwXLbvXd3CughIS4fsDZzmlNV
        bnzZeD2wo6BrZSUZMEuHe/sscwMiFhE=
X-Google-Smtp-Source: AGHT+IE+O19TlunT9EFXSZ/zGT6KdFzJPx5OecNJJfbNP69Aswj0ldusZNtx069iCoOHm2xrXIzTjw==
X-Received: by 2002:a05:6e02:2189:b0:349:983c:4933 with SMTP id j9-20020a056e02218900b00349983c4933mr7020962ila.11.1692537784751;
        Sun, 20 Aug 2023 06:23:04 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.244.103])
        by smtp.gmail.com with ESMTPSA id y16-20020a92d810000000b003497dc7215dsm380868ilm.36.2023.08.20.06.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 06:23:04 -0700 (PDT)
Message-ID: <64e213b8.920a0220.e5b22.0517@mx.google.com>
Date:   Sun, 20 Aug 2023 06:23:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0391608360835706193=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] adapter: wait for kernel exp features in adapter initialization
In-Reply-To: <00052eaeb78774fd7be365805203cb0c8b189243.1692531437.git.pav@iki.fi>
References: <00052eaeb78774fd7be365805203cb0c8b189243.1692531437.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0391608360835706193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777696

---Test result---

Test Summary:
CheckPatch                    FAIL      0.76 seconds
GitLint                       FAIL      0.52 seconds
BuildEll                      PASS      27.54 seconds
BluezMake                     PASS      904.85 seconds
MakeCheck                     PASS      12.48 seconds
MakeDistcheck                 PASS      162.14 seconds
CheckValgrind                 PASS      259.14 seconds
CheckSmatch                   PASS      352.84 seconds
bluezmakeextell               PASS      106.55 seconds
IncrementalBuild              PASS      775.84 seconds
ScanBuild                     PASS      1108.53 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] adapter: wait for kernel exp features in adapter initialization
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
bluetoothd[981]: src/adapter.c:read_exp_features_complete() 6fbaf188-05e0-496a-9885-d6ddfdb4e03e flags 0 action 1

/github/workspace/src/src/13358759.patch total: 0 errors, 1 warnings, 250 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13358759.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] adapter: wait for kernel exp features in adapter initialization

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B1 Line exceeds max length (113>80): "bluetoothd[981]: src/adapter.c:read_exp_features_complete() 6fbaf188-05e0-496a-9885-d6ddfdb4e03e flags 0 action 1"
14: B1 Line exceeds max length (94>80): "bluetoothd[981]: profiles/audio/bap.c:bap_probe() BAP requires ISO Socket which is not enabled"


---
Regards,
Linux Bluetooth


--===============0391608360835706193==--
