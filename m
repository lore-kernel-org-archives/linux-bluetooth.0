Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB23C07E9B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 12:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427F561019
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 12:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhGTMJd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jul 2021 08:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhGTMJN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jul 2021 08:09:13 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067D8C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 05:49:51 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i4so10021545qvq.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=U2jLSebloTD7sKordRjLKs0e0eaB3VAttfjv5Z2dEfo=;
        b=frpGun+54+e+xwoi0qwxSt5OW5pEtCbfKInSGBbWuF/ZuhhK44+bvTu8YprT7glpCe
         vFmi+wL9HDlBVetm38gHyfVYwgUWsLOI/XhEdGrfL8o++mC+RLJrNWGA0Ol5rk+DPLJk
         pivdzTh3rCnjjaJuYuNxDntSc2iO+kdJJDT5q+VBr9S3pCMNyxpo5IvCG2+lTdx5S8hC
         ygZtsHNglM7gR4h4oibZqn5tSlYw3iIz34gO8SgvJoCc3jKdVmDg6mlJgr8Di6UiGNiD
         w8jAaAThn/yRC6Rj0/jN+1Jt7XMOmyb8Xyb/BS25OwBdBpt73K/HLB3np74XntKWJrlT
         E49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=U2jLSebloTD7sKordRjLKs0e0eaB3VAttfjv5Z2dEfo=;
        b=cznQOyr8uXYJY5e+KBjgjo+ymY98ytQw1vUy805fchotvDcJfh4HQ4HGZxZVNOfHQH
         h76hFRwCoO4oII7uk2Bmt/5PS3rZfWh91vbc2SQoRMggcu70QucgReOeMgQnaKmHQVG0
         dxlLU13cTcntcJHZGVzZcoPcjSPfQJH0TVOFlyw8tiYFxLpgU5+lR63BAw5U0RTjCSC7
         K9qTgWCuK5wYcooxXT+3yYKqUiCeOo/PYfdbNYhLwcaLm2EnefTkhbDOTIstJncSOQ2W
         M4Pg4qbuCkI/cjg99JojIxTFcLtAug2twiaVQHTnQ72YYFBsZrdFYks6pRmY+abLTMQo
         ZXBw==
X-Gm-Message-State: AOAM533a/Vm3LyTlQV0ydK12HGiZ6Ij5eCJL6bFlGlInshXo3lEghgx9
        xE9KZIYnE7qQEej2nlaZzmz0NrRM7X+oKA==
X-Google-Smtp-Source: ABdhPJwIL2dYj1ujgx3cpbAqydlZb/IUq8Emrf6tsDIncreNrg/mzl3j3VQpUqqnpxPep8liTYllpw==
X-Received: by 2002:ad4:4ae5:: with SMTP id cp5mr29924531qvb.38.1626785390115;
        Tue, 20 Jul 2021 05:49:50 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.36.227])
        by smtp.gmail.com with ESMTPSA id x14sm2388752qts.13.2021.07.20.05.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 05:49:49 -0700 (PDT)
Message-ID: <60f6c66d.1c69fb81.66662.df3b@mx.google.com>
Date:   Tue, 20 Jul 2021 05:49:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3937084863221787125=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] core: fix a possible crash when removing devices
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210720195130.Bluez.v1.1.Ib24a67a8a849f311d5213f83eaac3cfbc54b7b58@changeid>
References: <20210720195130.Bluez.v1.1.Ib24a67a8a849f311d5213f83eaac3cfbc54b7b58@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3937084863221787125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=518263

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      38.35 seconds
Build - Prep                  PASS      0.08 seconds
Build - Configure             PASS      6.70 seconds
Build - Make                  PASS      168.29 seconds
Make Check                    PASS      8.36 seconds
Make Distcheck                PASS      195.34 seconds
Build w/ext ELL - Configure   PASS      6.65 seconds
Build w/ext ELL - Make        PASS      157.00 seconds

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


--===============3937084863221787125==--
