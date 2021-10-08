Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB60C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 01:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1806120C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 01:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJHBeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Oct 2021 21:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJHBeD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Oct 2021 21:34:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE26C061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 18:32:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u7so6792875pfg.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 18:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=87dyFrImn+QA+dwqG46qqBDxMNauqPEruZgeF21OQaQ=;
        b=Cb5ClIOyb3eJXzWsJdE0fVSu+b0m7DdFXstbmBV5IEce7Irs22Ecm3L0CbZdMoJplb
         vqBgMeG4kdmCOUHpMtFeDqGF0KezjQ6XFe9UK33Jp1uDBQFscUgPiVqgw0FIXmIbVsZQ
         xuUnl7zbZLuNGC64N2bX6aO99tD+gwYZ+JP8YQ2YI4WqOTKvqA/0W14cuSTB8TseU+Sm
         vWI7QIs7oKBTsEWWnWHI9wI5DR76aSs+jwY8url0P2tf3hqi7IvFXi6wCy7QyYVbcITY
         owmATFX9SDnoVkrnzm8yrN2ufTtYr/7KEffvKbUlLEFGF4MCX3Dgqtd/Sb5QfNH4AJm5
         +UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=87dyFrImn+QA+dwqG46qqBDxMNauqPEruZgeF21OQaQ=;
        b=4u7ygSWmVkz+dR7NOJ4AwcXzPRdjjLFafV3vChyk6/YRG9sYUB1ZO2DGxGd50f/jwV
         h+D6JSOq8jyVjuZk5/bn8vCdiEnBFcKKR/pqaGBXq6D4EBYBvzQa+IpnF0mEvJE8edmK
         H3EZMAEe4AX3PVXIi4B6svWQnXJRAhpevvycIANX/rsh6v2jQNfjtpHrWcuo6Iu71ICU
         GT0EbHK0K9nZyf7O3IH05sPxHfi6qw6ot5HSSagSthtyEA7InK04Oo3fOGai3le1+2yu
         TwdiWMQRKZnMKp8ZDI+DGhmR9k/JSvdWmWo+6nyn3EqxPyhHThlR5K8AMBwshiXX3vk2
         EoHQ==
X-Gm-Message-State: AOAM530MBjBQtVKs/cZG8J/TxN8MwHqb+lXAPmTzMKDZDMQUwgiry2ZE
        YKDfDAGtODrWBbZhAOhW3EwgSVdZEoM=
X-Google-Smtp-Source: ABdhPJwLwqUe75rPpruKAoCy+JimZtYIePrDkuGHRu6/TAQJyoeOlvNDluqJrNq4DpUP96tM6fYblw==
X-Received: by 2002:a65:47cd:: with SMTP id f13mr2344792pgs.439.1633656728507;
        Thu, 07 Oct 2021 18:32:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.24.209])
        by smtp.gmail.com with ESMTPSA id o12sm417387pjm.57.2021.10.07.18.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 18:32:07 -0700 (PDT)
Message-ID: <615f9f97.1c69fb81.7cebf.1f71@mx.google.com>
Date:   Thu, 07 Oct 2021 18:32:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5014863636058251002=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bernie@allthenticate.net
Subject: RE: [BlueZ] gatt: more fixes with cleanup on disconnect/timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211008001629.7024-1-bernie@allthenticate.net>
References: <20211008001629.7024-1-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5014863636058251002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=559591

---Test result---

Test Summary:
CheckPatch                    FAIL      0.74 seconds
GitLint                       FAIL      0.32 seconds
Prep - Setup ELL              PASS      43.52 seconds
Build - Prep                  PASS      0.22 seconds
Build - Configure             PASS      8.39 seconds
Build - Make                  PASS      186.80 seconds
Make Check                    PASS      8.86 seconds
Make Distcheck                PASS      219.70 seconds
Build w/ext ELL - Configure   PASS      7.52 seconds
Build w/ext ELL - Make        PASS      181.99 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] gatt: more fixes with cleanup on disconnect/timeout
WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#187: FILE: src/shared/gatt-db.c:1922:
+		p->disconn_id = bt_att_register_disconnect(att, pending_read_cb, p, NULL);

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#212: FILE: src/shared/gatt-db.c:2027:
+		p->disconn_id = bt_att_register_disconnect(att, pending_write_cb, p, NULL);

/github/workspace/src/12543903.patch total: 0 errors, 2 warnings, 107 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12543903.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] gatt: more fixes with cleanup on disconnect/timeout
7: B2 Line has trailing whitespace: "being properly unregistered because they were not assigned a disconn_id. "
12: B2 Line has trailing whitespace: "read/write if a disconnect has occurred to skip the use.  "




---
Regards,
Linux Bluetooth


--===============5014863636058251002==--
