Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF21C07E9A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 08:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CFB613B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 08:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbhGNIkj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbhGNIkj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 04:40:39 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6677BC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 01:37:47 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id h9so654377qvs.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 01:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KmDCB8Txt3kJrU5rEWiE3lxWAsAwEHhbjMCjrN4qgQg=;
        b=rFxb699Bwx5eGlX9ADvX9tPI1H+2JMdfCkeh3QGIBaOgLXWsSWEkIP7jOVZi8Di31B
         e2h0mJdMs4mM42UzjyRI/O3cLjxZYizm0qqt7Lgc/SKVb11WERUWvLRd+HPZJGu0pr4R
         9et+DxVIqi6WeYa0kgUIv/z6lq8Jf5jt12wMKXrMXaYmIqZ0x6jifqLd2F2qPwr25AOC
         AbZaFNSafc6cHcc/IxF1s3YM2NQ1d02Qb3ARNBGQiqqktmheN60yU7Imex6YHPq4i7c0
         vuDDcPp+CLi7sF5WUkYWmp/9Uj6Ezq/AmAe6njebUzgOD3XsLGC8HTuVvMSF6vlDJ7Ol
         HNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KmDCB8Txt3kJrU5rEWiE3lxWAsAwEHhbjMCjrN4qgQg=;
        b=HtlFT94c+FyHjMf0irik6OV0Hy8jIFIK5SHNdevm9MhXBdZzoZ5ZFrjSv0yx+ja/mb
         OVDOzAnYiQcYpS5g1aFYjAuJhcRIOebrnK8pobed6hXFQQqhEnjkUcwx6PKNOyv7XDcp
         6lhgox/8JkA9x3U9xgp/zqkQ4QnLb18y/k3Y+qBBbFGV/n8P7Qee++YEsVrd89RuqxnQ
         YQ8byMpuQs8C7Stvc6etmKp44HBwohw5QHT1InLOX+I8Rra4wKrYvVjvigBr2drqMcNa
         BAiWNb/V02QZb64br9wARdt+vjmNkEyFGqoqUwkiz843/nkMHKjwjOYoQE56OzERQ7vb
         hWlw==
X-Gm-Message-State: AOAM531S/2L1R+MAwGF7wKDUMTkYKpgHQlnBJJWzesj4Km03qvGo7k9l
        GwmwH1h77FqcmquHvRk5tKE9E8Wx4UJy3A==
X-Google-Smtp-Source: ABdhPJyBt6SkastRmHgCW71wr51ycWqy768CBMROnVolq4pkHxvp/qTwymReNbiSjdMI9DlS5x6Buw==
X-Received: by 2002:ad4:5f8b:: with SMTP id jp11mr9650237qvb.26.1626251866258;
        Wed, 14 Jul 2021 01:37:46 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.1.14])
        by smtp.gmail.com with ESMTPSA id o13sm542269qti.84.2021.07.14.01.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:37:45 -0700 (PDT)
Message-ID: <60eea259.1c69fb81.e089e.34bf@mx.google.com>
Date:   Wed, 14 Jul 2021 01:37:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1653930047290515698=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v7,1/2] emulator: Add support to config the white and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210714073726.169006-1-hj.tedd.an@gmail.com>
References: <20210714073726.169006-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1653930047290515698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515229

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      0.20 seconds
Prep - Setup ELL              PASS      39.30 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      6.86 seconds
Build - Make                  PASS      171.28 seconds
Make Check                    PASS      8.60 seconds
Make Distcheck                PASS      200.70 seconds
Build w/ext ELL - Configure   PASS      6.91 seconds
Build w/ext ELL - Make        PASS      161.16 seconds

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


--===============1653930047290515698==--
