Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C994C48BD1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 19:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C32613B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 19:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJTEA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jun 2021 15:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJTD7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jun 2021 15:03:59 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE352C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 12:01:49 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c18so13360959qkc.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 12:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Sb28ENDXSRKsfOBdIvQm4NnV0eevLxBEnj5LpAEqeIw=;
        b=kXIkAE5uIlSV4z3WYWJFvgjuc5zYuOHQAnI9Vi89tWlU/33oddqY3te1Eqw0SIHWXw
         mkN5cf3qV7ROxe91MXEU+hE3ZPGF/7DsvDY2deqOdRaulLYYuuICsrUfuwWfaiSYKRrL
         2tTUrygYO/jG7KEfHhPjGwiCjw84WfJtFoUY94BSxF62xU+Ro42od4613sUy0Rp7N3s3
         /yEzDkfedLjtw1rfiJUxbXdKOl8UOBijPBggzkfsEShY+SFFUOeNAiO5oH/QDDhrDH+a
         KvI/AXnnPIlohYp+9t3dnPEzCzEHE00q7al4+osLmHLqUxjcKbRl5iaLuE9ck+b+gC+h
         v3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Sb28ENDXSRKsfOBdIvQm4NnV0eevLxBEnj5LpAEqeIw=;
        b=YnZecOlWMsQ6EwnrxT84PixlfaztVWolkVlKeBTIzEhJetfkjSKBTvgg8ECl8s9sRK
         tSj06ZOuWUzJLwz6WUMRewZommdq8id0ISd4J/InolWbx9kMASGvLlXfQOqbJ8lNzsjp
         MdgQVQwnpgU6Y1Ollq+CoPb0xeHzDyR5CB0XlXXecVO4UVmyc5SaOV378DJsgHmTjuE8
         q9gZ13mhlrYK5sk207I+tJQlvy7MtaKEhaxMrOGG2qeXnZZv1aDC23/aGyGW6eTLcBWO
         8KP//dqBgdwgFUPp3oP8XVB5MvWiC4qfxiiNacmQhhgvFBuHMMFz8kJaJblAndpbJJGB
         YVqQ==
X-Gm-Message-State: AOAM531U9r2SHdX5FYpqe9IbzbJI2eDXV+3PlwBD35BzW3PFtU5v0+tE
        pJ5iYIgZPD75ZSu8sVgPv4xXYTepmbg=
X-Google-Smtp-Source: ABdhPJyTuYSpDD0VnK2Sx4yUmTv+I8I/0/UBVX43FTWvf7QDKu5kdT88zrvdu00U4B1G4XByBBcCNg==
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr62275qkj.31.1623351708702;
        Thu, 10 Jun 2021 12:01:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.192.202])
        by smtp.gmail.com with ESMTPSA id 137sm2849660qko.29.2021.06.10.12.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:01:48 -0700 (PDT)
Message-ID: <60c2619c.1c69fb81.2e9d2.5aed@mx.google.com>
Date:   Thu, 10 Jun 2021 12:01:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5446868955707919990=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] Check whether device is connected before attaching EATT
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210610181756.430-1-sonnysasaka@chromium.org>
References: <20210610181756.430-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5446868955707919990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=498303

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.51 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.12 seconds
Build - Make                  PASS      204.53 seconds
Make Check                    PASS      9.47 seconds
Make Distcheck                PASS      240.18 seconds
Build w/ext ELL - Configure   PASS      8.21 seconds
Build w/ext ELL - Make        PASS      192.78 seconds

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


--===============5446868955707919990==--
