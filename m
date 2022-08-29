Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D05ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 21:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiH2VcB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiH2Vbe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 17:31:34 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F0A00C9
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 14:30:32 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s22so4588767qkj.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=/jtuJblk8iVmvNgjRfNdddK8MkjmXSVZ0vXU+o1Pgl0=;
        b=fTULlYPZfvLRYrUB4uuzrs/nD/Rdm53UqF/IYS1DjYypfTiyMx/5RMApcyRjpNSzF1
         2PSoQKLJopCkEC6NYSoVApioA/PKj7YM6o2IQ30CmJ6xk6IWDGaMH/j0b5vzD6OOimnj
         FqJm4Xqbz/kkzFpsoXvhW/5Txx+CKuYSO3V+3jakiuaCxXjNeW51CpQgCz9IWC7L7gCX
         jPJZu/xLBHCpeExuBMBj6h8OEIRXaX9gY2g2unOEQTE0+2r/4TXU2225qG4hlhXK5rAt
         T6+n758UAx2dbSrPtFm5n+LdunJnbYQFIMwMJZpvpAtMWfWQsmm2fa61CSVTujoG5nHz
         2zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=/jtuJblk8iVmvNgjRfNdddK8MkjmXSVZ0vXU+o1Pgl0=;
        b=tt1HasLSmGngLQBUTo7Fyys3trIf2Qt8QHA6wyHETjBPGNA4ROrPcORpnOldtOq8tT
         PR3L/sZCVP9BwypLphdTSYQL9MNyaTtSmTDIqXDYKGHroePsSXB8fWyfckoJiG91EehM
         udVunHs9qtpGyvCrKmswf5SlNtECgx9StiP5aFzWCkgTbVG0avFGbnsIUdPyVT2EnmMw
         u55wuOdggByGkHJ7xBiPfeRK4u9EXxxx/ymf2xLkRgiR1hT9e9xGHEY87gwbk5OR/zyn
         XOayLQzqJMWFKiegSvK7RP+9SU75V9Eph6rUntMWN4QaHzqUMKbIGC8NXVOCdrTLS7hH
         8Ufg==
X-Gm-Message-State: ACgBeo1dY9UpPCDb4cfZwM+WTh9udiRSCS2WKiNQvC8XW7+BW1acGcpc
        9ADIXe7592HQ7fomU89V/IjkKqo+mak=
X-Google-Smtp-Source: AA6agR4MMlQj3SPGU1COh/+zIUa4zQASlajgYELaKZbOx50BN45QZFGBnykUG2go+MLtt1PVofTU1A==
X-Received: by 2002:a05:620a:4306:b0:6bc:5751:4b4c with SMTP id u6-20020a05620a430600b006bc57514b4cmr9787447qko.387.1661808583223;
        Mon, 29 Aug 2022 14:29:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.250.100])
        by smtp.gmail.com with ESMTPSA id v10-20020ac873ca000000b00342f960d26esm5737163qtp.15.2022.08.29.14.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:29:42 -0700 (PDT)
Message-ID: <630d2fc6.c80a0220.2e29f.e9b4@mx.google.com>
Date:   Mon, 29 Aug 2022 14:29:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8661280699505275238=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: profiles: Add remote endpoint path to SelectProperties
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220829203122.51343-2-frederic.danis@collabora.com>
References: <20220829203122.51343-2-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8661280699505275238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672169

---Test result---

Test Summary:
CheckPatch                    FAIL      2.95 seconds
GitLint                       PASS      2.01 seconds
Prep - Setup ELL              PASS      27.91 seconds
Build - Prep                  PASS      0.84 seconds
Build - Configure             PASS      8.96 seconds
Build - Make                  PASS      1039.25 seconds
Make Check                    PASS      11.03 seconds
Make Check w/Valgrind         PASS      276.22 seconds
Make Distcheck                PASS      238.53 seconds
Build w/ext ELL - Configure   PASS      8.61 seconds
Build w/ext ELL - Make        PASS      82.44 seconds
Incremental Build w/ patches  PASS      201.30 seconds
Scan Build                    WARNING   580.56 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/2] profiles: Add remote endpoint path to SelectProperties
WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#99: FILE: profiles/audio/media.c:921:
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &remote_ep_path);

/github/workspace/src/12958401.patch total: 0 errors, 1 warnings, 51 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12958401.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
profiles/audio/media.c:1453:6: warning: 8th function call argument is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2999:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3002:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.




---
Regards,
Linux Bluetooth


--===============8661280699505275238==--
