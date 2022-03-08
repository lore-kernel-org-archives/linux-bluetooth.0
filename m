Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF406C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Mar 2022 11:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbiCHLdO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 06:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346601AbiCHLdL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 06:33:11 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF64705B
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Mar 2022 03:32:15 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v3so15776632qta.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Mar 2022 03:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KtvIiqY2dgxseoQ63cQfPVGKOrHyW7hndXPagW4MCOo=;
        b=WF+w6i0E4KeVOYH5l7vwPmr7PQlOWPgFfF5IBgCocu2VuHpFjVB9J4YJQcP0aOsaR4
         XrEuD50tTs6Oy5E6lYcG2mk98c3wmJDmia3BxTtXWPtVlp2FAHGnD9wGFJB6qFObT6f2
         fQCEy6vxgpbgWv4LpIFnBlTa2JNLpTmm+CCfmazjI1wqIQ8PW5vzgZ+llNSKuktEnZAb
         TtBrmGiFp3hTXwMXlWoZXhMAaNUxhOK1P7VEUhJ7ssgucjUYTSDJVa3iNm+LiWVMhPvW
         u2vF2dMmttj2AaD2MEnWXtaVcxxwBvxNgH6xnnB9hsluNXuuA1us4m86c+s+maeaWozk
         7cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KtvIiqY2dgxseoQ63cQfPVGKOrHyW7hndXPagW4MCOo=;
        b=oJWqELSEZmnGtQK0zxAlVZFcCt/goF3sa1qRVnYJXzBeD9ZaH0OZEMAyiiN8MJW7zb
         CiE54r6zXcMDKNperW8Q5S1fYl28+rqLYrRejr89bB5ihOhQlSfvI9j+O102xnMc/E8m
         gCc6gVHF1iNxBki+QRxsdx6N/njpyiDyfhMNAx2vXm+bLs8/qGs3G44JMQNa1BnxTn0g
         sCTgKhUPIflO3xw0q8PJYoKDaNLbKbH+fxniJK+9LG1oWpq2MiFkC8oYa9PYMSFUy4YZ
         bxxBATJMsbJCYrWk3sZHtSBbIubcoAH9XiULDJ7c9UQX0V887f+FDs75T66l5IFxHUS5
         e1mA==
X-Gm-Message-State: AOAM531Mln88CEVWSfGXMFqYRHtXHYx3x/ve4HM/oHXs98EFTImjoAQ8
        U06gLH/7l7sFL3t96zGBSQGdsGrGZwe84g==
X-Google-Smtp-Source: ABdhPJzu1Luw7NLXryrvzcKdsS0HPyVbLn3HrFPUcGQOZqhdze0vEtak1E4uiaRcWWZNPlHJznx4sg==
X-Received: by 2002:a05:622a:1e07:b0:2dd:d74c:b6bd with SMTP id br7-20020a05622a1e0700b002ddd74cb6bdmr12884497qtb.320.1646739134002;
        Tue, 08 Mar 2022 03:32:14 -0800 (PST)
Received: from [172.17.0.2] ([13.77.91.132])
        by smtp.gmail.com with ESMTPSA id x12-20020ac85f0c000000b002de8931d4d6sm10514094qta.77.2022.03.08.03.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:32:13 -0800 (PST)
Message-ID: <62273ebd.1c69fb81.5ddb7.87be@mx.google.com>
Date:   Tue, 08 Mar 2022 03:32:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8610813253139356069=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v2] audio: fix crash in a2dp_discover
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220308174253.Bluez.v2.1.Ieb7448d3d951876e1f412452fcfd27cdc7bd015b@changeid>
References: <20220308174253.Bluez.v2.1.Ieb7448d3d951876e1f412452fcfd27cdc7bd015b@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8610813253139356069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=621407

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       PASS      1.06 seconds
Prep - Setup ELL              PASS      43.82 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.66 seconds
Build - Make                  PASS      1737.37 seconds
Make Check                    PASS      11.41 seconds
Make Check w/Valgrind         PASS      459.80 seconds
Make Distcheck                PASS      248.64 seconds
Build w/ext ELL - Configure   PASS      9.35 seconds
Build w/ext ELL - Make        PASS      1311.54 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============8610813253139356069==--
