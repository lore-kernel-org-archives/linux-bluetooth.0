Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B062C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Feb 2022 23:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiBWXcM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbiBWXcL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 18:32:11 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F331CFC3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 15:31:42 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id d84so435720qke.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 15:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=p076cskAqtHBWdRrP+TmuvfKj9tMfEyIGIG+ivYMbXc=;
        b=T5iSkzZyv/h1Ns9/8GsPvilUbuVnFUMMQmC7sZlctP2CZMp4QX5jPF7bKRHyNOPAe5
         cg5WK2I1sPGiCZb9XN4I38FYXT8xSvbrfkCFzt76cbSaP8e/5EgP4GrPJY3s6+UkcA7o
         zAksW5GTB5NPrdsI/bDDDVzUrpzoZIuKIlzP2g19/TcZyGJdZT1V+wZgKB/aC/5x5Eow
         30UXi93+p3Fa93jXdh8Ghe/MzvmA43ZAaG7F0fefmcup6ynz2m4NLiPFch1zJWI5nn8l
         rKVB/7IQ5E/UeaZENNh+NWIe8Rmy5twTrY/YaNLR2ar2DvLxxFSDM/nFSp5LrN1w/zcl
         d7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=p076cskAqtHBWdRrP+TmuvfKj9tMfEyIGIG+ivYMbXc=;
        b=iOq/H2Uq1sp0cTr7lwux92jfidoBrDOdhS97Fmp+uSjkuJGzmlgL8WwPQTBlPQd6+o
         87KiaOWlP64j8whbHpNV3tyawVc82C0FtVcMHqzt8JJVIV18wI4Dj5zfcx0bBA2mirQa
         gGrF7uXsAfremXdRnC+PDmcLn57I5sczII11k6CL0+RjTYWBE251cJqfKOmtbYaxsCu/
         ZdWOOCJ1z/VkDV+Gg9PfKJI17+k4BNvJ6uOccfeYED4m1k9gVph7BDPyJG1cpau4dM9S
         bq9beZEEQLPiHK3h7wnjN/XguuwMmN59EQRJAEoFCznT6B7HLBNiHi4oQTiolilFmfCj
         CF/Q==
X-Gm-Message-State: AOAM5305dfvyreNY2/qUTNSiomUsIqGkJXRkvaGsC5rH1DYLhnpDhDXW
        /c/Dl5EZ889BblAQh+MecIm/qtF49wuixg==
X-Google-Smtp-Source: ABdhPJwONtELcA9/nbuB3hldOvMNo7NI4gofTHBWFI55TTKO1CekyJQjdiKEOkiSN63ee8BHjBOOZA==
X-Received: by 2002:a05:620a:2183:b0:648:cd3f:b255 with SMTP id g3-20020a05620a218300b00648cd3fb255mr103234qka.86.1645659100936;
        Wed, 23 Feb 2022 15:31:40 -0800 (PST)
Received: from [172.17.0.2] ([20.185.194.123])
        by smtp.gmail.com with ESMTPSA id d65sm518853qkg.104.2022.02.23.15.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:31:40 -0800 (PST)
Message-ID: <6216c3dc.1c69fb81.30b93.4760@mx.google.com>
Date:   Wed, 23 Feb 2022 15:31:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6083741473541087012=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nicolas.fella@gmx.de
Subject: RE: [BlueZ] neard: Fix reading State message
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220223215618.335489-1-nicolas.fella@gmx.de>
References: <20220223215618.335489-1-nicolas.fella@gmx.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6083741473541087012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=617325

---Test result---

Test Summary:
CheckPatch                    FAIL      1.51 seconds
GitLint                       FAIL      1.03 seconds
Prep - Setup ELL              PASS      53.57 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      10.69 seconds
Build - Make                  PASS      1531.03 seconds
Make Check                    PASS      12.69 seconds
Make Check w/Valgrind         PASS      536.98 seconds
Make Distcheck                PASS      285.06 seconds
Build w/ext ELL - Configure   PASS      10.59 seconds
Build w/ext ELL - Make        PASS      1478.81 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] neard: Fix reading State message
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#71: 
dbus_message_iter_recurse only makese sense for container types, this is a string.

/github/workspace/src/12757527.patch total: 0 errors, 1 warnings, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12757527.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] neard: Fix reading State message
3: B1 Line exceeds max length (82>80): "dbus_message_iter_recurse only makese sense for container types, this is a string."




---
Regards,
Linux Bluetooth


--===============6083741473541087012==--
