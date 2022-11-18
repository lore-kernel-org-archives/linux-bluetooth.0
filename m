Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39076C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiKREem (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiKREed (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:34:33 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2118B6DCE6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:34:30 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id g7so2032748ile.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ6i9RdskVqmEdoPe0Ae+VQEu7kxGBZclrjzDL3zux8=;
        b=UNyKohL3JF6sLK9cV/qoMNJ7WT4LV8mfP8OS4UV7I8bmrJsDmtPeEXtk2pxPupScDu
         5SRI7VISceI6NOqlW4B9fkE5zupmhS3oWtCbqWDDp8LK3omi68Lq3bweECGzdx5e+eMX
         jcax8VEzP+VG1MJpBAsnL6j3uK58ytDFhmITjRe7fEb2J4Z1QHzqxRO/l1ztTS9+6u7h
         Mip2c/Toxrt/nvt0MPyrFYeBAoo7oQvMlfFCRLE6ttPicAox5IFptVFLpTpRAE/MUEH8
         QZ7+zQW8zmVS6Xd8o4fJEiHLszokFjLWifJXDkR23y7W+VG6Hr/isilwCRroN/QneU9M
         pO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ6i9RdskVqmEdoPe0Ae+VQEu7kxGBZclrjzDL3zux8=;
        b=f/breCZMD8kMrdKjBoIpS4B4LgLpmv5RzHeJncg/23/8JcBZNtWwFvmu8XExOHWjE9
         sBqYJ5iebnCZmnFh3i9FJsDaV7ey+EU4cehpX8vebhKJobo0K2crboAz7q2RGYwyouwa
         TrIymCFzps+qKkPzslfDI8WWHud3NeEYlUu2D5egX5Du8K1x2NeV4PFD1dTKhGHOvJBP
         W+FjKWr4HbGN1S3mwm70QLd4/rZ/iHIn8yRP/kPO9d/ClF+sJ8WkH57yKCnFDMfqzF8U
         cCUbppcl41rqq3/iQS9+kPDL1mwDl4z7a5vY42tquTVs4d2biINOkzDmBgQHuhZs4i0g
         UCFQ==
X-Gm-Message-State: ANoB5pmO09V1cXzWzxHrVstQjy0QaMUUtu9PeA7P+YelRTOw912Q0S6m
        32nbXufQ/1sBAfP/nZLMdUmX69gj284=
X-Google-Smtp-Source: AA0mqf4sdgRrZOZX/VdQEIZ6EkqZVdSdCSnpHR7mkWosfeNe750DKbFIqh5NwjJO86j8B7Wgi/gfrw==
X-Received: by 2002:a05:6e02:d94:b0:302:a008:83e5 with SMTP id i20-20020a056e020d9400b00302a00883e5mr1877805ilj.293.1668746069997;
        Thu, 17 Nov 2022 20:34:29 -0800 (PST)
Received: from [172.17.0.2] ([40.122.186.35])
        by smtp.gmail.com with ESMTPSA id l187-20020a6bbbc4000000b00688faad4741sm1012824iof.24.2022.11.17.20.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:34:29 -0800 (PST)
Message-ID: <63770b55.6b0a0220.19aaa.232d@mx.google.com>
Date:   Thu, 17 Nov 2022 20:34:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6549105500409720468=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
In-Reply-To: <20221031220205.91975-1-brian.gix@intel.com>
References: <20221031220205.91975-1-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6549105500409720468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690652

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      34.10 seconds
BuildKernel32                 PASS      30.42 seconds
TestRunnerSetup               PASS      420.82 seconds
TestRunner_l2cap-tester       PASS      15.66 seconds
TestRunner_iso-tester         PASS      14.89 seconds
TestRunner_bnep-tester        PASS      5.26 seconds
TestRunner_mgmt-tester        PASS      106.33 seconds
TestRunner_rfcomm-tester      PASS      9.09 seconds
TestRunner_sco-tester         PASS      8.65 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        PASS      6.66 seconds
TestRunner_smp-tester         PASS      8.39 seconds
TestRunner_userchan-tester    PASS      5.53 seconds
IncrementalBuild              PASS      30.62 seconds



---
Regards,
Linux Bluetooth


--===============6549105500409720468==--
