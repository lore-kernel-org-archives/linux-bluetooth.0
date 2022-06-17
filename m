Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F134C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 05:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379014AbiFQF2v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 01:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiFQF2u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 01:28:50 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC306620E
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 22:28:49 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c1so4724138qvi.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 22:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=f7VTVBGR5ocu4FGMSsZUXep8PJLvXux05XVBZnNaQNM=;
        b=ov+xUXhzbW8ac6zvd0puLxcNwUkhXVB5mm3pj7CXwj7bN7yt9zGwTjfLS7iC/huTz2
         iDhkgwte2gVG39pF5t9yX18OJnNhTQ6AKOUHubeWHEYYaJJWnMD4zJYJR0i72iaa5xxB
         rEhqds1VA00Jsp91M9z1tT3wf2ZPTgsS+1PtEmGv7BUAKqfEXGIWN9k/Ph9FBcTUbNDd
         x9zYEOpDmZNLkiEDpjXedXDVVhPw3m7G8vzZlrExp7fG+7MmHbdvd2RAPO4L9iPqALRM
         ua6yOfWsPD+IrAton/Hr4fwIuIEnOZ5WJpQwJOCgU8xmXNLSzg4uVGsRT2e78xB4Y2oe
         wxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=f7VTVBGR5ocu4FGMSsZUXep8PJLvXux05XVBZnNaQNM=;
        b=y/Qgwlk4oZn3tWI0j+2F7OnQiXz3tXrL2H2TLekvvuv57eQuKox9o2wvA8coBnhibc
         gxSIz+OC1XD7do/DlRd2aCwodkDh6Iw0+SvT9Vd2Z+iU5CdeVGDGskHSJ+Y/nXhjnz/M
         AfXpVdhDGD1+ByI3DDlQ77H68lGwcf4qwyJAz47Sc50XQmj9+3KyGcQuUfVxp+J0SLYD
         9naTpyQYOFb4uNEsZN5ES6y7Lo3k7o10S5fh7XsCEMeIPU1pnDDrsmQ+s2V+nDQq/J+J
         xrkDKeSynvM+ojhpORHpWyZ9LQbvaKvXGw6nnAA06AYT+PlpdDDmmLhxOQShIsxR8wGs
         mNIg==
X-Gm-Message-State: AJIora/XNbjoLSSz+I1qndWeLwoe1E6zL2gjuUPBRjjf8orK7IOHt0KO
        q54ZFUFeTcAZz4alXs3QfxqyLKvE4Pw3FA==
X-Google-Smtp-Source: AGRyM1tQCQ/pGLD0p54pS3REhe8UBQFKBKeuqfkMEksl7nRWSlJe37ypnrS76p9h6QwHx/CYm6TFvw==
X-Received: by 2002:ac8:5a44:0:b0:304:f19e:779c with SMTP id o4-20020ac85a44000000b00304f19e779cmr7121464qta.480.1655443728388;
        Thu, 16 Jun 2022 22:28:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.25.7])
        by smtp.gmail.com with ESMTPSA id z2-20020a379702000000b006a6d20386f6sm3595447qkd.42.2022.06.16.22.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 22:28:48 -0700 (PDT)
Message-ID: <62ac1110.1c69fb81.ebac8.6e90@mx.google.com>
Date:   Thu, 16 Jun 2022 22:28:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0822082024510854205=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] monitor/att: Print attribute information on ATT_REQ_RSP
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220617004957.1148939-1-luiz.dentz@gmail.com>
References: <20220617004957.1148939-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0822082024510854205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=651225

---Test result---

Test Summary:
CheckPatch                    FAIL      6.23 seconds
GitLint                       PASS      4.01 seconds
Prep - Setup ELL              PASS      44.24 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.79 seconds
Build - Make                  PASS      1783.85 seconds
Make Check                    PASS      11.64 seconds
Make Check w/Valgrind         PASS      475.19 seconds
Make Distcheck                PASS      244.82 seconds
Build w/ext ELL - Configure   PASS      9.09 seconds
Build w/ext ELL - Make        PASS      1725.65 seconds
Incremental Build with patchesPASS      7055.43 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,4/4] monitor/att: Add LTV deconding support for PAC/ASE
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#86: 
      Channel: 65 len 27 sdu 25 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}

/github/workspace/src/12885016.patch total: 0 errors, 1 warnings, 770 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12885016.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0822082024510854205==--
