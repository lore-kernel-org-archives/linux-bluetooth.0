Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34675C4707A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 18:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152EE613D6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhEUSLf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 14:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhEUSLf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 14:11:35 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68AC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 11:10:12 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i67so20655234qkc.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OHsapTneTOtuVaJ8O+AoFrVw8kQuePGi2ZZpAo8olo8=;
        b=YxCQgUQiAGYEwInFchEW/hiUjVRXoujUK4OoPxVz1LbZtDaPxq679vKHzJMFqy45XR
         jdXBT9jjw3Ddu/Nr5+EMUCMnc5z/TOwt7Jmx965q/8n3cHDmFyneRyRPoZDclipndxc5
         G4w+p7012q68pc1h8XHOe0Vt0xLPSDKKSpjfYn9MeKsApWvAbv656mF4vwP9kPi0Q7VR
         fuqZk1fA1r0rCaI1djbYxw/Zuzq02K2Abn7U0RjPyMqJeJjk0afcG6sARG/ijPv+AjEE
         UkNN8OEx4bxWHSpd6ZzECRcHzsbclJ+qaPNgoyb8Syc1iHZMeBQ0IxkjZ+9PK9Z7ZYNW
         pkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OHsapTneTOtuVaJ8O+AoFrVw8kQuePGi2ZZpAo8olo8=;
        b=G8PU7qmCzGLkJYfiVcISpxyHyhpN6XqQf2arOSygTREe2mmvZB6aDRqLirpFnFgWFK
         InDKTie35LJqRBkG/uK/9q6W4zi1Ud7hIBuIEUaR7xPjOzIfyK+O+S/zXJx5pjIxHSf6
         kUwoWd1na4iLbpFa1QCsYGRKfFVdacYjgg6ZnlbrJt/Jk8VUWXqIEFLeWgXwQXlitx6j
         QVOXNtfYT/eYA6gDWOgPjr+Wt6NnHlG0Hmj2GXNQcEcK42/j0sb5M/vPAvTuLCDjmpwC
         7EeiHHfDwl9yAg/sP2UAosPwyjgklErfqrZh+VHCKpBQ24zm/7+d7S6PTpHjqnX8Q4iq
         hrJw==
X-Gm-Message-State: AOAM530X9zrIknlkA3Uml3d1uyP+d9PWCdqdGzEYpAk4+bYPoZdpmoZ/
        8nldfnMZyb29jPHK1gnI2wLxcN1TxXQ=
X-Google-Smtp-Source: ABdhPJzYnGEsTaccEr4eR2Bu6i/aJoJ0hMkOTMu2wSFbtSMxL7uXCWn1prk0z/f8Ln3/pvDWe1fKlg==
X-Received: by 2002:a37:a092:: with SMTP id j140mr14063639qke.382.1621620611152;
        Fri, 21 May 2021 11:10:11 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.111.87])
        by smtp.gmail.com with ESMTPSA id 127sm4290399qkl.116.2021.05.21.11.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:10:10 -0700 (PDT)
Message-ID: <60a7f782.1c69fb81.7ea1.c108@mx.google.com>
Date:   Fri, 21 May 2021 11:10:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8719311626355241179=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] src/main: Fix double free str
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210521170407.180152-1-hj.tedd.an@gmail.com>
References: <20210521170407.180152-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8719311626355241179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=486651

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      40.84 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.15 seconds
Build - Make                  PASS      170.35 seconds
Make Check                    PASS      8.91 seconds
Make Distcheck                PASS      205.87 seconds
Build w/ext ELL - Configure   PASS      7.05 seconds
Build w/ext ELL - Make        PASS      159.02 seconds

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


--===============8719311626355241179==--
