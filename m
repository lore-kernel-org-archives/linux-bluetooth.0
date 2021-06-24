Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C43C48BC2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 01:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8FE61026
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 01:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFXBWT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 21:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhFXBWS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 21:22:18 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13D3C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 18:19:59 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id fq1so1979294qvb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 18:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rm0nuJddH7nq8DTOKxrbLs9f+UmR7y750thJpdXRgxw=;
        b=eYuD6jEgfsMznHSM4fL+Aujp+AIQvlLUltZRsEAh+3QrPmqL26eNWygRRpPgNHWEXC
         PCz2VbebLLr+GCIITUNdTk2CFSjIJyNH9SZDWqHbEQOq7jEZxPlGL4SYfeXj174Sfc8e
         jqBv+SWiKOcVH3b5KUzUoGXoJHTVboFPsci50s6ZBMVe0mdqjeztIR38EgYYoWoGW1PD
         XY50uBaIl1AvzyxAEIIvosF6ZIm0hunJl4afYFWkCUwrf4pPj75b6f8AKxo9sN3GFwj4
         7e6F8/gv5YYpErSbmXkW3jhUsj302Q5jx0HMD4XiVlVxS3LoVu/i7RX05pV1swM6jiZ2
         GnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rm0nuJddH7nq8DTOKxrbLs9f+UmR7y750thJpdXRgxw=;
        b=JeN/OBBCzG+Wqwf9FK9yFSq0sL7xkpYuvbhkuZ3Uz5y/5DV05wJRiTX12uNS1U6zJW
         MhHn4bqd3PGPQt23XB74NxyiLphaYCuzOxElyW7X0IZG0tVE0H8MDc5U3vJCHKpGvCEy
         V1jfyZaHMmXznIDlAU0mPXWQgAV9mf7Kg7cQT59gx2dG04rdeD5RoMZ0QnS0Lw6sG8hS
         P5qThlim9wljpvmcJGNhxUvxdu23aOgeaFoiyuI6rWnvncPzp1/9Zhuk9f65sM4kPo9J
         b5XR0Gy31sdpFU3JPAB3I0acxr9EIHxa95zk+2Acl9GLVzp4t4xBxXVW1zAEK2C3IzCS
         yGJA==
X-Gm-Message-State: AOAM532NYBrFC3/3ltgtqnu8T8PC9gnpOj5ZD7GKnJLjCkb2UHQ/8xMJ
        2qIN0v34BwQp/Kvez0DO6y/ZKkQ4ZgyEIQ==
X-Google-Smtp-Source: ABdhPJwu+9Vj3PcNrN0CeQuca9kS8JH72wv6eFehrLLg++TNUDdBlFPusJ26ywQklvnlZrCr9fve2A==
X-Received: by 2002:a0c:ef8b:: with SMTP id w11mr2883731qvr.37.1624497598901;
        Wed, 23 Jun 2021 18:19:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.223.170])
        by smtp.gmail.com with ESMTPSA id c4sm1352391qkj.81.2021.06.23.18.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 18:19:58 -0700 (PDT)
Message-ID: <60d3ddbe.1c69fb81.bcf49.932f@mx.google.com>
Date:   Wed, 23 Jun 2021 18:19:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0708523204310520354=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v3,1/2] emulator/btdev: Update the white list and resolving list size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210624003659.32410-1-hj.tedd.an@gmail.com>
References: <20210624003659.32410-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0708523204310520354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=506061

---Test result---

Test Summary:
CheckPatch                    PASS      1.02 seconds
GitLint                       PASS      0.21 seconds
Prep - Setup ELL              PASS      40.02 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.00 seconds
Build - Make                  PASS      174.93 seconds
Make Check                    PASS      8.44 seconds
Make Distcheck                PASS      207.02 seconds
Build w/ext ELL - Configure   PASS      7.04 seconds
Build w/ext ELL - Make        PASS      164.28 seconds

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


--===============0708523204310520354==--
