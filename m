Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5DC4707F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 02:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5E76101B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 May 2021 02:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhEZCGX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 22:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhEZCGV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 22:06:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A32C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 19:04:50 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id o59so17146534qva.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 19:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tntl+yvBx7TEekqohG3HTfMI/n6zQxXOv07cAO1b6Uo=;
        b=bM6MJi5u9exZqjvU4FwLDYzRtyMpDuqwNuT45XEG9QtM0r8gJfNQz15RCrUnjg5T2M
         PY/Ryu1VixLyCLuXuBhLtj4EUL33o/1GVQOCbt/aBrTlrgnEvYR0A4Ue/Jdt2d0g963F
         bjwKRGuE0KIwmPEOVAXfxHyuDCJKNqwEkdM1ACW6yM6QpOVo/MW2D4IFBGfFwhh0RAPA
         xqtzype4ch2umlxPXXFKiiaxaz6Br+8iobSK31Udxi7NHuDwMiulBAeIZ//ycsBMNed+
         YzBRkWGRrkkezyK/egCbXN895CqowoG2srxBganqt7DuDepzQTfAH22CWv0FBJtx6NaR
         9crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tntl+yvBx7TEekqohG3HTfMI/n6zQxXOv07cAO1b6Uo=;
        b=ezWXTQF9bMz+hReNWqF9zFDKnWwTMxGqDrnIU28LrirL7kBZnU9zPKUHb3JIgsXs0F
         HknMh1TEpLULyl4ofChE6KucNFA2LobZile+Iw9vNRgkPW8e50cZQosxwNPVH3fijcM4
         jTOoH8uLDrhrJHqbhavH4rtNfMYa4jzsVP3Jiz48ifUs3HsBygXDtZdhuWFLiwbeBpLW
         hGYsFOfdcwQvqhG9ZXR0qOWyY7dGtGGqwEdDh8KWjOLjX15LWKwO8/i8aE2WdIYEDeZC
         RhT2E8S1aeLu8HUbUAcZvCCdO+WaudIwrKC1spOwJbqAaCOc2Gfey0BeeLcEeWhebvxw
         XRew==
X-Gm-Message-State: AOAM5311MSb7+ktusnroeS3C7ZQytQdrLCWq6/4klX6+7ORXbFU+SRAy
        Zekvaaa88akpic3WAAOWFIpRLkZhlls=
X-Google-Smtp-Source: ABdhPJx8d9vYvWaLVLi9iG5+u2uC84GtGzu+6BQ7rdM361xW5hmol77bawn5GjAyg5BV+SLaHlPYpQ==
X-Received: by 2002:a0c:c3d1:: with SMTP id p17mr40543596qvi.44.1621994689114;
        Tue, 25 May 2021 19:04:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.76.248])
        by smtp.gmail.com with ESMTPSA id e20sm607816qto.93.2021.05.25.19.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 19:04:48 -0700 (PDT)
Message-ID: <60adacc0.1c69fb81.9ef07.474f@mx.google.com>
Date:   Tue, 25 May 2021 19:04:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2458815692179644942=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/4] tools/btmgmt: Add device flags commands
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210526002024.412237-1-hj.tedd.an@gmail.com>
References: <20210526002024.412237-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2458815692179644942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=488499

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       FAIL      0.43 seconds
Prep - Setup ELL              PASS      40.41 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.11 seconds
Build - Make                  PASS      174.58 seconds
Make Check                    PASS      8.92 seconds
Make Distcheck                PASS      206.40 seconds
Build w/ext ELL - Configure   PASS      7.13 seconds
Build w/ext ELL - Make        PASS      164.19 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
tools/btmgmt: Add device flags commands
8: B3 Line contains hard tab characters (\t): "	-t type    Address Type"
9: B3 Line contains hard tab characters (\t): "		   0 BR/EDR"
10: B3 Line contains hard tab characters (\t): "		   1 LE Public"
11: B3 Line contains hard tab characters (\t): "		   2 LE Random"
14: B3 Line contains hard tab characters (\t): "	-t type    Address Type"
15: B3 Line contains hard tab characters (\t): "		   0 BR/EDR"
16: B3 Line contains hard tab characters (\t): "		   1 LE Public"
17: B3 Line contains hard tab characters (\t): "		   2 LE Random"
18: B3 Line contains hard tab characters (\t): "	-f flags   Device flag."
19: B3 Line contains hard tab characters (\t): "		   1 Remote Wake Enable"


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


--===============2458815692179644942==--
