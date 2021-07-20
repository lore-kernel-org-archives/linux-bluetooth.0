Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA43C07E9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 02:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F0361166
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 02:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237910AbhGTCGI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jul 2021 22:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344917AbhGTBwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jul 2021 21:52:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25590C061766
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jul 2021 19:33:19 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id p202so18763905qka.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jul 2021 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hwojMUQBA3F/rsvwq9ct0Sw/gFIdtbQd0rUksbexAko=;
        b=ZLobYUWtFNNFVoBEATQB4wUPLJYo+5fdaHbmN4Tqw8XYqu0PtpE6/dr4v+XHMeYtXu
         g7AORGXlnmAsJ1Hpho5l9JZ9PsNAQUTimZ/k0LpodOQhxTVLcw/8hMBksXfdQEHr5VBB
         IW926DdiNMlj83H715tLf10jn6o5RWn21+M62Ez+7Ju8UQzyHGklego66pnMn7yxIWO3
         uauigKArEu7UioQ3Qg6q29bQQIgShWfIKt53QGfR85nfa93062TTkynq0EG0uKkJwP7J
         FjrKxJ24wXC4tE/n8kGBpW9cyBiRlC9tjBkQjJEIzGuquCb2FqMXvF11XjCIPhE8R/bT
         60SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hwojMUQBA3F/rsvwq9ct0Sw/gFIdtbQd0rUksbexAko=;
        b=Pm7fBdNPbc0qZrz9ghm3KtyDRx+4bzUHAz5f5WTJr6QZvrT9ZUNE5NYYPXkkawuQMn
         j7g6ELuZ4VC9wCkX0D2rMDPV8haXAOeyYe5noCrQjtIbusovDOkezhLCCkDVahzREJIO
         6lmNCXWCJo7cpgkh+Qkr5EGX1f4ajXM4E1Mc8K0OzG/p7lOYyAp4ujd6CR5O6+OQUAra
         AKx21JOgHN+tfhGaxZbQltwr8KQGV7+SDq7ECQmvY09/Nqm311PjsXNqeDMH3zxjhfbC
         c4mSnTDXtka+NfG7m7fv/f1QvDlHSqbi1UPUx1/2MqsQWUlokJYB3BllqSw3vJ7W0ycl
         XZfw==
X-Gm-Message-State: AOAM532/VyVMg0wLz7ub4By5ax9hu7YZmogNjQPYOQPvDjyixwGLZYhG
        6386Ud0TmzM/Y2vsWQ2idAdcTqNnZniZDQ==
X-Google-Smtp-Source: ABdhPJy5emv7pAQu1K7s0dumszBBu7eCARVM02RxH5/rvJOoW7bVoYQ15Bw908qYA9+iEVVO0duBoQ==
X-Received: by 2002:a05:620a:192a:: with SMTP id bj42mr27087975qkb.29.1626748398194;
        Mon, 19 Jul 2021 19:33:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.96.27.162])
        by smtp.gmail.com with ESMTPSA id o126sm8873498qka.74.2021.07.19.19.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 19:33:17 -0700 (PDT)
Message-ID: <60f635ed.1c69fb81.fd757.843f@mx.google.com>
Date:   Mon, 19 Jul 2021 19:33:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8897263450069135935=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v8,1/2] emulator: Add support to config the white and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210720013630.478929-1-hj.tedd.an@gmail.com>
References: <20210720013630.478929-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8897263450069135935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=517985

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
GitLint                       PASS      0.24 seconds
Prep - Setup ELL              PASS      46.43 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      8.23 seconds
Build - Make                  PASS      202.22 seconds
Make Check                    PASS      9.28 seconds
Make Distcheck                PASS      240.82 seconds
Build w/ext ELL - Configure   PASS      8.37 seconds
Build w/ext ELL - Make        PASS      192.48 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

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


--===============8897263450069135935==--
