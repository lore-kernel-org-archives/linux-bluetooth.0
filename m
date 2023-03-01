Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A10C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 06:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCAGNP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 01:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCAGNN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 01:13:13 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16BC9752
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 22:13:11 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id nf5so8574126qvb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 22:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677651190;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLIYU62qkGF2/g5npUNVfLDvBa0iOXwn24evCTUMbEE=;
        b=bzneHm2W49wdtpcb4Fh/FV2zunQFG9tIwDsKkQftSDeM2wCdydy0HTj2u8lAwAYT5L
         S5nixvmGE5KGaXqG2X1qUdzesP8zkbWsjdphmYeKHT6Htli2vieTJjz8lq95SjiPP136
         V1mYNnoXENbpfAfQUHLRrg1esI3RN5WnWcHrw/F64FOd0J3UOlsZGzR6Gf7gxG/AnqHt
         YxQKvLr+jr2+ZBG7TdLW4+wSqPmAHPZuz0DT4HtMsnqSVq+UC7khyzoivii5kg5ucSIb
         DxC0g2w9vWGvHWKIZk4AOYu0ZnudnIbK76XpNoCPp+/3vl740gaocdFaD7qJxsyPT5bn
         +2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677651190;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLIYU62qkGF2/g5npUNVfLDvBa0iOXwn24evCTUMbEE=;
        b=fF1R90cZNKg2EdqEpgt234JTAjZ1qGgSSExOzo+9esrk1ITGOjYR7zwiFO7t5O6E6v
         MjfNofxE07ZfvI0ssuO0aqUTLZxB0PlgEODNeVnaqqJzfgh6xZT8uAd2wmDn1rbDa9gg
         f+JvMDt69eDdKdHns7N+02kj2268S1CbEG8w7aPXhfwtI+7lAEeeAkkoNJhBkqfM1qMN
         GALKPKItiB7l9bzyaJpcfzf2KcyB+OTH/M9orxDyZO7bbnuVtu8qfYo5TFCtux18n1dJ
         56DL8ytmCzg7KieC/aMUHtvpUiUxsUL6fCdoGP7F67+C+y86my3ec8TZDwtY4BV3I/wd
         8SDA==
X-Gm-Message-State: AO0yUKV9Qv/soAQSrkEnneVAVVCiR8ITzY1OuHkhCzXznatHkE8N87Q7
        QIL2tUgJnHsR0hgpYKHa0s/5ZFe4TXg=
X-Google-Smtp-Source: AK7set9XfFQhUsH50AvlsRQszgpiVHTdbsEs8koyUyjg5q72+NdwzZj0xA6ltQZ+aow0OxWgQvozXg==
X-Received: by 2002:ad4:5f0f:0:b0:56e:b7a1:c9e with SMTP id fo15-20020ad45f0f000000b0056eb7a10c9emr10909583qvb.15.1677651190577;
        Tue, 28 Feb 2023 22:13:10 -0800 (PST)
Received: from [172.17.0.2] ([52.226.113.32])
        by smtp.gmail.com with ESMTPSA id t64-20020ae9df43000000b0074231ac1723sm8279529qkf.28.2023.02.28.22.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 22:13:10 -0800 (PST)
Message-ID: <63feecf6.e90a0220.f7abe.ba24@mx.google.com>
Date:   Tue, 28 Feb 2023 22:13:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0788728424211280287=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, eatabakhsh04@gmail.com
Subject: RE: obexd: launch obexd directly from dbus service
In-Reply-To: <20230301050242.47225-1-eatabakhsh04@gmail.com>
References: <20230301050242.47225-1-eatabakhsh04@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0788728424211280287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=725708

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
GitLint                       FAIL      0.52 seconds
BuildEll                      PASS      27.14 seconds
BluezMake                     PASS      859.79 seconds
MakeCheck                     PASS      11.92 seconds
MakeDistcheck                 PASS      150.99 seconds
CheckValgrind                 PASS      244.70 seconds
CheckSmatch                   PASS      331.61 seconds
bluezmakeextell               PASS      98.85 seconds
IncrementalBuild              PASS      715.91 seconds
ScanBuild                     PASS      1021.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
obexd: launch obexd directly from dbus service
WARNING:TYPO_SPELLING: 'Whenver' may be misspelled - perhaps 'Whenever'?
#80: 
Whenver obexd is summoned via dbus with the systemdservice file, the
^^^^^^^

WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#81: 
daemon exits with the following error: Failed to start org.bluez.obex service: Process org.bluez.obex exite.

WARNING:TYPO_SPELLING: 'whenver' may be misspelled - perhaps 'whenever'?
#83: 
whenver an app calls for obexd via dbus, it seems like it forces to use
^^^^^^^

/github/workspace/src/src/13155603.patch total: 0 errors, 3 warnings, 5 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13155603.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
obexd: launch obexd directly from dbus service

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B1 Line exceeds max length (108>80): "daemon exits with the following error: Failed to start org.bluez.obex service: Process org.bluez.obex exite."


---
Regards,
Linux Bluetooth


--===============0788728424211280287==--
