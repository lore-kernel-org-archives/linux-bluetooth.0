Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C398DC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B24B611AD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 08:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbhESIq7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 04:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbhESIq6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 04:46:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A2EC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 01:45:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h21so9558060qtu.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JZyArUmvvjAkT7sf4fpdepojeBgdiAZqNfO/E5JvYOY=;
        b=BexQySZnzX2LImf2YDtAoppIGK9myCqs00DOpLFeOZJK4dIpdID8dr3+TrVxsibDIB
         ADbMpqUQNT0pf1pXoYX/9ITQvTJz5bx3OUVy4NmXn6WIkwpCcLSp2w2OYNUvSpvsH3Fh
         JGt5kJHRLATtS8TE2aXc2RLuTESRom5lHfDteygJl6DjhUsi6IgqoxepICMuHif+9s1H
         tmR0pVrwEHV5+7rUSIov98a0oHMapfjDbAG29lG944W8KE6e291ViPUpWJquLC21+bNd
         EttoJNm5wg46tDNNwpC6/4QBwCyiCshKqExe2ckvENZcKPhHqy5oXxYqR1ArIk84j7ZD
         6kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JZyArUmvvjAkT7sf4fpdepojeBgdiAZqNfO/E5JvYOY=;
        b=mlX9lxXp8sTG1g9rseUZytS3Vub8V5D+2smo7LvCcVnz8/44EhZbRRYrQxPf6ATycv
         mVk5VIYEBSo7OIWwZk1UC/OxJZ1tUVHEIQel9VYKtoQlxil5LZ34KzR4Gap3KNSAsXum
         iQQvGBnxuGt/SmJHwOLiFZeRYlilY3h9gyCDXCFQDOlLgu5kGHmKshlsKngHVrvK3+oi
         CpQfTDKr606dAgA5314nQbyrQu8t+SeNNyhKpERA6OCRLhXTIqreAZy/QJkciLgzSXWl
         j4miaDth1IpYUr/o2UkNHsLfegcsLFJB7xYSSCMyywSVHVXC1fEcX3kmpQ9dmXKtj3Qr
         jW2g==
X-Gm-Message-State: AOAM531/hWdtYlqWWizlYVzH2HeQ/SbTukO8BSP4AYZ3H3FTNPSpPwQL
        vNxJFrN3zzZ6rStNn0AaSsWeur0w9DUZqw==
X-Google-Smtp-Source: ABdhPJxJUXMdmRy/AOQewpoy8IUpLnRgtKZTJAloU8AtGNrhrENgjTER894NesqevbbzFb5VAyftRw==
X-Received: by 2002:ac8:5553:: with SMTP id o19mr10233965qtr.308.1621413938679;
        Wed, 19 May 2021 01:45:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.29.33])
        by smtp.gmail.com with ESMTPSA id x19sm320623qts.19.2021.05.19.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:45:38 -0700 (PDT)
Message-ID: <60a4d032.1c69fb81.a6191.1a11@mx.google.com>
Date:   Wed, 19 May 2021 01:45:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4157104024294595410=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] lib/uuid: Fix string to uuid32 conversion
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210519162046.Bluez.1.Ic61b294b8337c492e9d4eab47d3c5709d8adacbf@changeid>
References: <20210519162046.Bluez.1.Ic61b294b8337c492e9d4eab47d3c5709d8adacbf@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4157104024294595410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=484827

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      41.04 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.18 seconds
Build - Make                  PASS      176.76 seconds
Make Check                    PASS      9.02 seconds
Make Distcheck                PASS      210.36 seconds
Build w/ext ELL - Configure   PASS      7.24 seconds
Build w/ext ELL - Make        PASS      166.42 seconds

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


--===============4157104024294595410==--
