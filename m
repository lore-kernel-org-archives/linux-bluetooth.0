Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB680C4743C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 19:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14D761220
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 19:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWTIi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 15:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWTIi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 15:08:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED96C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 12:06:19 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q192so3087932pfc.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xot9sQWDrgB0Rb1iQtRmTrWTO6V7hIoSyqSubKxQ2W0=;
        b=I/IjgcvOmNAQRXWD6cPLao9c1HP22cvkUJ+TPdFNF+cfUNBQFf8bMFgSrqXe0+D5k0
         S10K4tUlrPswgbxDrll6R7QQGSIz9qLUPM3fcUTs/C4XGk6YuGdM0n7CoW5s9aQ1Xm43
         56jrq903Vdsg62QmGdpbzm0ldx/riuMk5ZGyBEm905dh+W9/eeucOugBF8pIc9n+jvW5
         dgMgXoreRRpgPbAWwL77b99xeOrTdI+UYYMuGNii+Z+LEAsO21BMyLQyQpiAvtFpXFDu
         +6/+6UVMnosIpYnIcrfcr5sXkkVk/8gylVa9dhSFnjA0UHFRAIh7NI7UaMaTVPGcwIQo
         AbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xot9sQWDrgB0Rb1iQtRmTrWTO6V7hIoSyqSubKxQ2W0=;
        b=fp3AYJoAOPB+Z2P4oZbjyy11p8r4zI96RPItT/usEnxznFeCTRgCU7ijag8jQtNZki
         +8lX/ySt9DTmimOw/dOc3TCVXZ51zEtTZjhq6MCL+0Exaa7sdU6oeeJFNLPkxv5TBXRh
         PYvpwNGjcZF1PrLEQvR8eu2oye4xh/SqhHO0G28L/uH7u/8awigyC7nWlxj/GoXjpLgH
         Ff3wJPRkVlBh33pNNcdUioTkzgqSdMn/gBh1ugqR9XipcSkGXCrTfwUaOJrs6JpM4WmC
         c34WW04lIt6Zae9j6y+Nq1oUcehUgnIYuXjiwy4ylOsiK7Wzjm+Mduf86H0YTFCJszVZ
         IkfA==
X-Gm-Message-State: AOAM533msee+AMED7BaEEMxqd+uObBuGAdcbwd4iPmXNgpNMxdAZzM5W
        GMfT+/qtNhHPO3bFp89UqvBTa2OR9tA=
X-Google-Smtp-Source: ABdhPJxHKt9Q5Y1Jzf0pZYiBjfyr/jQjkpRTiCWNX5+ozvaFnHo5orDt1nE/d4q6SUOrpEnlhrndug==
X-Received: by 2002:a63:7354:: with SMTP id d20mr927541pgn.290.1624475178331;
        Wed, 23 Jun 2021 12:06:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.250.176])
        by smtp.gmail.com with ESMTPSA id h11sm542299pgq.68.2021.06.23.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:06:17 -0700 (PDT)
Message-ID: <60d38629.1c69fb81.cae79.1f4c@mx.google.com>
Date:   Wed, 23 Jun 2021 12:06:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1494792895895825218=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] doc/agent-api: Add AuthenticationFailed method
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210623184355.3685859-1-luiz.dentz@gmail.com>
References: <20210623184355.3685859-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1494792895895825218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=505973

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.04 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      8.09 seconds
Build - Make                  PASS      201.81 seconds
Make Check                    PASS      8.76 seconds
Make Distcheck                PASS      242.55 seconds
Build w/ext ELL - Configure   PASS      8.60 seconds
Build w/ext ELL - Make        PASS      194.76 seconds

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


--===============1494792895895825218==--
