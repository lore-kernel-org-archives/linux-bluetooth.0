Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A235C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDDF610A3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 18:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhFNSOo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhFNSOo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 14:14:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FDDC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 11:12:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p13so11187426pfw.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=FeFPwmLn9kb7nlrJjVIwFuOZ+iZpFKkelyyEhe1y1ws=;
        b=Pc90BjsmAmvg0FVDr4sz0Ug6vyqKkfqoLon9AG6Xhan9JUgGkAr6CVBv3P5eKD+zHv
         cdmjsIGdm9njIEDchpuHWNYi5VSp98cuuXScgYOIgMd/K75hUdnXulRiUq4cOlJWjhPQ
         EMHh3igACdpH3AYO4rXeLH9aV938wBICPRCzqjD92c6KReCOqm42krm/kwqValrlXqvO
         QV5ZxothyZYbzoGyQkJebK8zQgOCQeu2KR3mHp213t+GNWHhjVn501b6Ju85ChOuz7ku
         yT96IYwu9E53PZDDe8vzv+a6pZeqaS4Ugphg21x4GA8wkfBlE+krn0hnO6NyE5H0zpXQ
         baAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=FeFPwmLn9kb7nlrJjVIwFuOZ+iZpFKkelyyEhe1y1ws=;
        b=PykZkA3/sWDcvA1sGi/ProUVIzh5q/9V256EnAxzRW9HXuRVa98/UWGCbgufAW28hz
         b2OOcaKuwDS3/x5JCZAGGwICnADef9C3Jdpk8S96apBQP+mTbuAzsG6HqhfaAkKjLNf3
         EJCB+Q0kUfje32JpnpaumXW9KV+ChUZpK5mvhkeULpRZL/h2MTo3ECyPG+NmSUcGCh/Q
         5zDpN7SaWEAD3BPcbi2AFplZuHGChrGt28DV74WDXVbAoWufH8FBz2iC5zC1QwwtpYhI
         akWwJQ1VlNJDHmku0QwTzIASNWJqomYAb1wfsNNTRGccVN7xUutdeD3lUpjBN0g9T9gX
         HKWA==
X-Gm-Message-State: AOAM533ATom9Fxtfq1TgiWIwsV3bjrBk5uQAa/Wq5/KT2vyYy7aw4ua1
        /1JdNnEX4ZCDx2fAAaP8hKtrLn+30v0=
X-Google-Smtp-Source: ABdhPJx12A1NJbTBNUjTij/zvVozpi7soCiLGeWMfoKQg4R4LXnpRgtLa0oBGZ6w4rbENwvPEPjFZw==
X-Received: by 2002:a63:cd4b:: with SMTP id a11mr18360766pgj.231.1623694360337;
        Mon, 14 Jun 2021 11:12:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.11.197])
        by smtp.gmail.com with ESMTPSA id v15sm13038591pfm.216.2021.06.14.11.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 11:12:40 -0700 (PDT)
Message-ID: <60c79c18.1c69fb81.5961a.5bef@mx.google.com>
Date:   Mon, 14 Jun 2021 11:12:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6212932209276559274=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Enable Kernel Debug Experimental Feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210614174625.1259675-1-luiz.dentz@gmail.com>
References: <20210614174625.1259675-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6212932209276559274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=500073

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.14 seconds
Prep - Setup ELL              PASS      50.16 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.54 seconds
Build - Make                  PASS      218.90 seconds
Make Check                    PASS      9.58 seconds
Make Distcheck                PASS      253.81 seconds
Build w/ext ELL - Configure   PASS      8.71 seconds
Build w/ext ELL - Make        PASS      203.58 seconds

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


--===============6212932209276559274==--
