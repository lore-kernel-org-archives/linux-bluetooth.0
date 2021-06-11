Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88692C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 02:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6177A613AD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 02:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFKCqt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:46:49 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:35838 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhFKCqt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jun 2021 22:46:49 -0400
Received: by mail-pg1-f174.google.com with SMTP id o9so1296262pgd.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 19:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AMPftH3JNzZE7v/vadoPZuK0EieFM+cxAwKWCNSWCkA=;
        b=pxuMUyUtZcqBGDVveMNE1Vf1auXnNi/8Ku5SsnBEHUlcwGUXtQhxTq4atdLT5oBerp
         DM4TwZtUnWdFFkirquY2Ftjxr1Ehqwo0CCRXNBOniTOjo8E0ohXfFpb37+CCXD7xPi+2
         o/pouc6IRqNgUF77oW8GVSV8sameTVu68QcQ0xkJl9dzUIycNCHA0PLcogvfIicZJ9GQ
         GjZDwo7OtwWRMisLYla64MUTkdw6JqgWfAzXcfDjsWeh3QUPXxE3LeyuZ0kENpDhIh+8
         l9f4iMR+qjoO7hUe+uDMr98tqZthaYtQPuMrXmZ+hGxt5B3Kx3Hcah5ci3gE6dS2CJ4i
         Deug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AMPftH3JNzZE7v/vadoPZuK0EieFM+cxAwKWCNSWCkA=;
        b=H3cxtVTUmwE3ruH9hLSp5xriOhcG49DqlXE3bSTtw/8d/P48Au5Xd7StF23WCvDm1p
         7kqGC6Aoq0ycEDvw1GSAg0bmwqh2Whj0txrmyWO87kejX/kR36xiEFKJkoNhBT5dGF61
         c3u4mOT/dIu0J0IXsdQHBzcZ2Fsd95DMo7NlxWeqz0eZEA2bbtJ+gFK2aTT81Fc5vIK3
         +XkMu4KtyQQj0Orh1kyUGLgvlDw3MH2pyaMTqyyUEYIFDW2H2kXMvSCRom8lpS+LAFJ9
         GwufHZ7CEe4JpvKWFjTZV0Q7hm2iBDu/VEjWb7Lo9gr33Bkicpd/ubjIaqWbL74WgTw+
         m1eg==
X-Gm-Message-State: AOAM5321XwohO7U08H+nMDbWYMl8Fv/kkRaruyqqqfM45XimYkA+kJrD
        I3jhj96ZSqVeXFsxVhEccX2fAx6u9Hw=
X-Google-Smtp-Source: ABdhPJxrFIOHkGzgr6LYclUtbCsmQF4t0f0YpfnkfaMLHRazoNuCmNKwvqpdCy1Al73hkw38/Oj+mQ==
X-Received: by 2002:a63:9f02:: with SMTP id g2mr1367554pge.141.1623379418629;
        Thu, 10 Jun 2021 19:43:38 -0700 (PDT)
Received: from [172.17.0.2] ([51.143.6.60])
        by smtp.gmail.com with ESMTPSA id j7sm9599684pjf.0.2021.06.10.19.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 19:43:38 -0700 (PDT)
Message-ID: <60c2cdda.1c69fb81.a7977.1a3e@mx.google.com>
Date:   Thu, 10 Jun 2021 19:43:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1956232280850198209=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jprvita@gmail.com
Subject: RE: [BlueZ] profile: Fail RegisterProfile if UUID already exists
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210611020649.15179-1-jprvita@endlessos.org>
References: <20210611020649.15179-1-jprvita@endlessos.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1956232280850198209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=498501

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.15 seconds
Prep - Setup ELL              PASS      48.95 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.38 seconds
Build - Make                  PASS      205.34 seconds
Make Check                    PASS      9.26 seconds
Make Distcheck                PASS      242.07 seconds
Build w/ext ELL - Configure   PASS      8.52 seconds
Build w/ext ELL - Make        PASS      192.68 seconds

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


--===============1956232280850198209==--
