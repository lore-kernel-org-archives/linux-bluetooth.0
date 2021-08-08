Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66146C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Aug 2021 14:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461C160F38
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Aug 2021 14:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhHHOxr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Aug 2021 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhHHOxr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Aug 2021 10:53:47 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA2C061760
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 Aug 2021 07:53:27 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 14so15573754qkc.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Aug 2021 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9CYe2ScwQsxa0640xPmlkecAyOP6kFvvvs9AUjwxFGY=;
        b=JvRe4oazaVKQtThNQPXhVrM3OE786jrZZz9i9wO7iaCFZHI73s/n3Q+wX0+Am68oRL
         x4jDxFtjhb0bCS9c4IKtbmMemR6UhRMrcP6IKw5KWesS75yp/PqWvRQ5CQ6UtsM7be6N
         2zrq0XUY9AMfzTaY1V23hMD8/sD39sc24FFJjCmig01uwrBQPaxF1u+rUCQlLzGfTpC0
         kJ7BVUKcX7i7NiE5KOlzzfj2Xa9EaVYRNu7yDV+7l1SFZFOAu5NTlHBC+KoQ7g0yo9mG
         cCnLy63ytZhAu62g4itsuYDVNm5pt7wEsZ6lfLt6gDAVip6aDv0zLNwPZFrqAM49jQg/
         XPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9CYe2ScwQsxa0640xPmlkecAyOP6kFvvvs9AUjwxFGY=;
        b=adlj8Hd9k3ZgXqVmO5WD6mbrGWOmsoU+RtnkoYmGHYkUzTAwiWGLwzMjW1n8RsxUPT
         agL6WiALzenwuUm7fxauA60Bf/ieQwzpDHXMphgH0whICEaIlILmOhOFNJ8uEPJrDp8K
         jMGLsDNbqSDDHX/8uL0RBDBNg6ysG0JSr+gr7VOrMYTyBQEFs4F5D7Kv9Wg3kCZXb9KI
         9paW/BfI0+/tzVVBuR3z8Ps0eJQ0wig7DLWSCP/J3wFXuRKwe/XRe9KpQRsWbGwX2uRf
         Ab/RX3TdzYkIN+9KmtAZfALu9Rl+zlVq56D4cPTGJzCUHQAIDo1HodkZlByG2nelfevb
         S+gg==
X-Gm-Message-State: AOAM530OYKYgLlv07cSKcrFlFab2LP9iBrhsASLifxGnVJFBK/8upx2V
        Dt5tdH6NC+EOqB3sFDHUJeSod5Vwq8w=
X-Google-Smtp-Source: ABdhPJzt2LqMpayszGQDKjwXe8aQKZY5xp0n/dWfRIvOx/NmaW7lyASYG8Lg0ASWt8WChO2Pa6Vf+w==
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr18715069qkg.403.1628434406171;
        Sun, 08 Aug 2021 07:53:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.112.139])
        by smtp.gmail.com with ESMTPSA id p187sm7604745qkd.101.2021.08.08.07.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 07:53:25 -0700 (PDT)
Message-ID: <610fefe5.1c69fb81.531e9.1e1a@mx.google.com>
Date:   Sun, 08 Aug 2021 07:53:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9046812757639517462=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijn.suijten@somainline.org
Subject: RE: [BlueZ] audio/avrcp: Use host/network order as appropriate for pdu->params_len
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210808143526.99726-1-marijn.suijten@somainline.org>
References: <20210808143526.99726-1-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9046812757639517462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=528099

---Test result---

Test Summary:
CheckPatch                    FAIL      0.27 seconds
GitLint                       FAIL      0.11 seconds
Prep - Setup ELL              PASS      39.58 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.91 seconds
Build - Make                  PASS      171.89 seconds
Make Check                    PASS      8.76 seconds
Make Distcheck                PASS      201.76 seconds
Build w/ext ELL - Configure   PASS      6.97 seconds
Build w/ext ELL - Make        PASS      161.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
audio/avrcp: Use host/network order as appropriate for pdu->params_len
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e2b0f0d8d', maybe rebased or not pulled?
#15: 
Fixes: e2b0f0d8d ("avrcp: Fix not checking if params_len match number of received bytes")

- total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] audio/avrcp: Use host/network order as appropriate for" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
audio/avrcp: Use host/network order as appropriate for pdu->params_len
11: B1 Line exceeds max length (89>80): "Fixes: e2b0f0d8d ("avrcp: Fix not checking if params_len match number of received bytes")"


##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============9046812757639517462==--
