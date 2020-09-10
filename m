Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9335EC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F27207DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAnmZw29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIJEsN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJErz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:47:55 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC18AC061756
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:47:53 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y11so3876482qtn.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OjW+XcA/Wsl8A4PR8l9Bo2YagaelsACryuZHy/wV6t0=;
        b=PAnmZw29L2ducS4BxgVHihoos47EYipBhdjfN9uJj40yjXAjPT3CxOxxgat6yFKO8C
         SP96rgPzdIswugYExptMBHbZOiCvkkdRp0f61iGNZHAeTFhTCthv4quCr3Ceoo2SMqAy
         Trodsutj/ISJs5btafodk+Ft6E/MFqN2bwN5zdjCljmqF4fJubyczmtVk+JWnb4auM9z
         CSUaBiTVznnfJPYcv+Q1O2E2aqqrmvrJjO4S4jC6s+PmchbTZ+n+J6srKQw1cmvMKE/o
         IEQMbM8a7nB45oIy4lX/s616bp18WQ1qRsPsgdeHEdFcLkg/w7RcJaTR+Gvrr5PYUP5f
         WsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OjW+XcA/Wsl8A4PR8l9Bo2YagaelsACryuZHy/wV6t0=;
        b=ANB1rsh/s3SzYshgLSj1GU+wcHT4lu+d9/S/7rJIa7O0PMTfvB1DEdCcpKYHVJhlf4
         xZYdjcpXb2yUS9nxQiVEMTs+Ya94ecq+QITOn6yxwjKocV5zNMvLaMzYaH2dlag/oZyy
         9KnhO8UjtrwMxc+H0DH0VgNo6mtWuogHKKMI8X4zpYFWQoiypzEcdjqMm6EQ1PFccMfb
         6UsT3uVBckrs5d8lHaBkYSGsV6CWAPnJLvs7ABSwm3Tbx5iTPEam6GYvAEXTiB2AT41+
         pw5Z5QZNpciNEkScDby7UvVN8bfCiu/vrw1pI4t0HqDi5o+VFqsV5tWFKyy7zb4sodPP
         1jYw==
X-Gm-Message-State: AOAM533ggvMILwG5BVOAplwmRDByY1zPOFqZ7uEivLISzqSDkL4CHgwS
        90C8SR29ZX2d2CSeGhGOsTypliOToHihrg==
X-Google-Smtp-Source: ABdhPJwHbeFMIaFZ6qAmMQjYsULhPZ8w6+eZg09crcfJwlAus4+hJV7WNUWFq1dp3ceLR42B1F0jGA==
X-Received: by 2002:ac8:5d43:: with SMTP id g3mr6527553qtx.295.1599713272884;
        Wed, 09 Sep 2020 21:47:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.71.168])
        by smtp.gmail.com with ESMTPSA id z2sm5240853qkg.40.2020.09.09.21.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 21:47:52 -0700 (PDT)
Message-ID: <5f59aff8.1c69fb81.b7415.83be@mx.google.com>
Date:   Wed, 09 Sep 2020 21:47:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3379336798535123357=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v3,1/7] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909214058.BlueZ.v3.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3379336798535123357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#99: FILE: src/adv_monitor.c:1:
+/*

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#253: FILE: src/adv_monitor.h:1:
+/*

- total: 0 errors, 2 warnings, 236 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3379336798535123357==--
