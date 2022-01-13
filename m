Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11069C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jan 2022 03:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiAMDpf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiAMDpc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jan 2022 22:45:32 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4166FC06173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 19:45:32 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z3so7605091plg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 19:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=oUasARq/o6zJ/b7T6dTjM5I67oslL75a2DxvM9fVQpM=;
        b=AHohIMUwWSsDaoQwjOPLpvz5/Jw029phM/2VEQ6481c1u13lktJXaUtUUW6CQ/1xdF
         jOXB3x3NipnyaZygblNmyS8Zde75jMVd5Ba3VZnhPUYQPsNiRR5mg/ZRF0hLUDEc03jN
         bMAIKNLy+SWj3I52ikeLYYkUiFw7edhvEpvGAdplbioVA/7a6Xt4aOgSeTib8Bgtn03r
         vWKGtJ6P8+DeqSYl5HaQc0wRO4kw1uHWjHAgx76UatLSX0kzGW2P+Cd43Zk87Y+cXNHu
         3FrBTBVyFiRgKNO584Z83nN0TalUKUY7kdFZRmskt4YVNgFgXkgUCCZRjpezcTd4pk5J
         Cc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=oUasARq/o6zJ/b7T6dTjM5I67oslL75a2DxvM9fVQpM=;
        b=swc17134elC+tE6Q+/Zkh9Yso9D8X2OOEGhM+WSaN3gW5w0ftKPFyEZN3DA7epOIMA
         jL+KypAxJPcbJfavEIhvF3SGeuSWCN4lDYPbWRf950KzF3jWcHOk6om5Q7fNCm6+LwoE
         TTHqN19hqqyS9iBXVs2BFb3ms37cG+MYuuvp0Rt3WMPf1JzJUnbuTN44nKjQ8GUkM+/d
         XA7TL57e9+FBBWhWjxaj1r6Ho/MvUDs5PjCS4EpInzywgnk5cEqa75q6tr5vLZgYP7vH
         JZ0MbQ3AE8QxJ6ezPbZtKbYB77ltPA58xCEauPu+wru7W6eSknIZ4dRs19LMX2fd5eKQ
         4FlA==
X-Gm-Message-State: AOAM530csaBeA3StQ9a/pO0723ZiSfAq1ruJTmTpdPhev+avZIhKKPnn
        dqiBZtYVRwpbDTkW3AnQjNNvl+fsjkI=
X-Google-Smtp-Source: ABdhPJyET9kWwyvA3dKJUXNz5ojKQduqStFTnIQhYJ99s2uXzDm7OjC9MroqzVFI5fTIlR2skxNylA==
X-Received: by 2002:a17:902:7105:b0:149:e08a:b31b with SMTP id a5-20020a170902710500b00149e08ab31bmr2508742pll.171.1642045531452;
        Wed, 12 Jan 2022 19:45:31 -0800 (PST)
Received: from [172.17.0.2] ([13.66.249.173])
        by smtp.gmail.com with ESMTPSA id q19sm891031pgb.77.2022.01.12.19.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 19:45:31 -0800 (PST)
Message-ID: <61dfa05b.1c69fb81.f4256.34dd@mx.google.com>
Date:   Wed, 12 Jan 2022 19:45:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3989213398665739500=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] hog: Fix read order of attributes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220112224842.519814-1-luiz.dentz@gmail.com>
References: <20220112224842.519814-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3989213398665739500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=605008

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
GitLint                       PASS      0.74 seconds
Prep - Setup ELL              PASS      50.27 seconds
Build - Prep                  PASS      0.56 seconds
Build - Configure             PASS      10.06 seconds
Build - Make                  PASS      1882.33 seconds
Make Check                    PASS      13.16 seconds
Make Check w/Valgrind         PASS      563.83 seconds
Make Distcheck                PASS      292.14 seconds
Build w/ext ELL - Configure   PASS      10.16 seconds
Build w/ext ELL - Make        PASS      1806.94 seconds
Incremental Build with patchesPASS      3736.08 seconds



---
Regards,
Linux Bluetooth


--===============3989213398665739500==--
