Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B5C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 16:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB5161075
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 16:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbhHaQuu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbhHaQuu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 12:50:50 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A7C061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 09:49:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a10so3132015qka.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Aug 2021 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9oKTzMzmTy2l7dcOZ1i9MpC4o1lkPopXWmgKRqrf/wg=;
        b=MphEWuHls84opWB3YVWy/tabbljOJrNWlaFZWJlGmxKzXX94711iIUJLgZAF/aOvGN
         cZfOa7vg2J6vGmB3LIAaKSOgjRyOhJryGIH47+RWfpnZNnd8vg3hrX3wRrWh74Gzh4vL
         UxIp0i1bKgfvK+gx4wHNV6E0zD2HnBI7frbfSdGiW5iXZ5hNE/YYW25Dm/nm7SPeL2S6
         MrIwvHRNs6vDNQj5aqVe1mi+gWYVcItTUrQm7VRTOj7DynydgSt2VAJmKN1dwkw9lmXL
         Bbje1x58UM4ixuqeSnn+sqHOHH5OdBCFKt7L/uvIreLLxf9lsGPgnL5FeKHQJ2G7BS2Z
         peRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9oKTzMzmTy2l7dcOZ1i9MpC4o1lkPopXWmgKRqrf/wg=;
        b=NXAFgP/oorCfeXcBfgzOe9CufJNHmrRRckDm9bREkZW/OA+SzP6GLt1FWBsjd6oSKW
         4S5cyaBMkYI0PqWO2TNEMsTlMDllmll2kUcMjG9CaTXL4ah0zmZFUg/oLtsCqO9ABSap
         u7pRIf0KoJLrQXrLehTmd0mkZo4kgGLD6byvYZ9G+3Zm/WZwAgNgopMl7hjcO2u/dSp5
         sx5e3hiuqN5kY3L2NqfTRYxmRodkP8K8++CJwqikVjdBr1rh0GSoh2T9AvjWVEJb26xk
         yOvCss0zjpJQF9pPT8ikjMN2m0ZueiN5nDbtKg7y4UAr3PP7NsP5ObhNq+hASvcJ7ASG
         FpeQ==
X-Gm-Message-State: AOAM533JuUGq3QGndBP2rX7Q6qknf6WVxw7/VOgIC8oxyTVkYjMyr6aT
        yNFFsJWsKXhf7nzeFu/94T6KLBrL50maGQ==
X-Google-Smtp-Source: ABdhPJz78HJ2iaZMApyZ2ZPZXoyS9erJzf5HN+ULm2rzLAA+PwJaKgiFIwVOF9qPBQzTss/n07lY/Q==
X-Received: by 2002:a05:620a:1086:: with SMTP id g6mr4095197qkk.105.1630428594017;
        Tue, 31 Aug 2021 09:49:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.59.67])
        by smtp.gmail.com with ESMTPSA id m5sm13511984qkn.33.2021.08.31.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:49:53 -0700 (PDT)
Message-ID: <612e5db1.1c69fb81.a1f57.de68@mx.google.com>
Date:   Tue, 31 Aug 2021 09:49:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7391233845771384284=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pab@pabigot.com
Subject: RE: lib: fix variable-length array declarations in hci structures
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210831162546.3643599-1-pab@pabigot.com>
References: <20210831162546.3643599-1-pab@pabigot.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7391233845771384284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=539933

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      40.53 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.07 seconds
Build - Make                  PASS      176.50 seconds
Make Check                    PASS      8.48 seconds
Make Distcheck                PASS      210.66 seconds
Build w/ext ELL - Configure   PASS      7.18 seconds
Build w/ext ELL - Make        PASS      167.26 seconds

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


--===============7391233845771384284==--
