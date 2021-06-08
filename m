Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A56C47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 18:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55735613AE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhFHSTF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 14:19:05 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:44956 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhFHSTE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 14:19:04 -0400
Received: by mail-qt1-f173.google.com with SMTP id t17so15980948qta.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jun 2021 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OF0cYKeIQy8HbbjQAIzh1wCKmRB+jfXXpc3lpYUA6FI=;
        b=HiwO048BUjJIlZiHVbkZ0SAIUT3EwZHrppTU5wyVVakTlYCQh8OMAp58VutYicivfA
         MVqJTyyEOZcexprXA39k5UZU0KoY7pv0+Uxl/OTErE9MvNI2eEmM8pInjEx+eLsAow6C
         5b6lLxwcSflztTsrsZ+0u4P4ONDu/NHUBXEVuWCN9XISRLMBEKnHXeSZ7vIq8y/sC/yR
         AVSTzEbrwpqnZ1JvR54Q+eFTX7wmQe4R53WXltk+MqPh9jHnc0h0+sV05vZfAaliEHid
         f+QAYO7sjtKSpBikOwWg2DBFylSEMr2jYCEX1eexNn3jF1ijo3YINoA8IxjxcwnFyx/r
         n/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OF0cYKeIQy8HbbjQAIzh1wCKmRB+jfXXpc3lpYUA6FI=;
        b=StwZcCaaG/wvVUifY89lCnGgbN1fJF8pXPuyibrf7N7d9Nh4j5yZkMUh9JYemwzg1W
         xqK7tSI/3qJaLo8pCqlXpM/mwd/Z2j0LJQterxft0U/Smvcf1BiydyMlExQVAUGKUAOS
         L3SAtV93csVaDiMwCdo8sVshfT+TAPyWfsar0j8M9P7CimpzbtjvCNqe/1Yp2EtY9JjI
         2jx4wwI954FgrezBn2Q+uzwIKOtR1slEqTi7I00EO9T7bKAfe9+Kom3Gz3H7Yo4p9dqE
         AogX4eviZ/7KOnsjtTMovT96urCEoucWEpkO46eXsoyJdnIOV2PGdIiWIYs0h2RpGwJI
         UXBg==
X-Gm-Message-State: AOAM530YUTpftLyjlTl7l6UbnBL0do4PB6q59f8nOH++QSCGsH6kcBDL
        QhDtKsjPTjAKofc3G1qpEBGzWuaW5Yw=
X-Google-Smtp-Source: ABdhPJz+n4yBNbMBqUS0y2imMqyBFwvRigLwN/GTspLDd8duNktNdigYJjt1TaKnwSA8mWCV/r+JlA==
X-Received: by 2002:ac8:7699:: with SMTP id g25mr16234955qtr.309.1623176157630;
        Tue, 08 Jun 2021 11:15:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.162.134])
        by smtp.gmail.com with ESMTPSA id i14sm13127547qkn.99.2021.06.08.11.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:15:57 -0700 (PDT)
Message-ID: <60bfb3dd.1c69fb81.26dfe.9490@mx.google.com>
Date:   Tue, 08 Jun 2021 11:15:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3947344791971373098=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [BlueZ,v1] avrcp: fix byte order of PDU parameter length compare
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210608103940.BlueZ.v1.1.Ifed45e2dfac25b2627fcaabc66cd29f6894ba07b@changeid>
References: <20210608103940.BlueZ.v1.1.Ifed45e2dfac25b2627fcaabc66cd29f6894ba07b@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3947344791971373098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=496449

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      39.24 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.04 seconds
Build - Make                  PASS      167.01 seconds
Make Check                    PASS      8.71 seconds
Make Distcheck                PASS      200.39 seconds
Build w/ext ELL - Configure   PASS      6.98 seconds
Build w/ext ELL - Make        PASS      159.92 seconds

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


--===============3947344791971373098==--
