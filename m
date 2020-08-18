Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDF42065D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvJJhgsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHRWuU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRWuR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 18:50:17 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30181C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:50:17 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id n129so19936186qkd.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CCPDV1hJpdSA2bIXqQHtDY/VDLkLLkoksM0uXPUalj0=;
        b=EvJJhgsHDyUf88k01+FA5SwYZdEeEC1hcCH39pThxFXEmlGtDIsFCiA0MbMO1YFYjX
         bVW3eAx8XN829uVY1QgE8PBQNax0Z3B8h3bX2NZHVwae0x9oj13Ze+RdyD9obMeQAs8i
         SpGzjMlTJwm+GVCcWXRGaf9d2/OSVPccayB5PpbWdcr1YjmrURUt/iZ7NMuZ9zvd9Q0F
         1NS9gHClxqeIUdWNDfCi4Wo0nJrErr8Cd/17wz7ZB6NJZ50l3i1gZM0S2NB6SUECeM7h
         tlbjix5txka05YshYv2t6z7iam0Gn+kFtc5IMDb2pcEw/gDa03ikqp9bE8YYvTRRCH0G
         pcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CCPDV1hJpdSA2bIXqQHtDY/VDLkLLkoksM0uXPUalj0=;
        b=FOtnro7x4JtmG1nPEaP2iVdlYXZ9UEc/9RRUR3ZNpe7BOcJRZLP1KhC+hHkZYQiWGX
         1ipo091o51m3W1bvwpQrVQBxqhrhHAZls6HDKr9+lYyYyEJE8+dCOoDc/ccEErNi+8eX
         4wcOezvnokOn0mLzylXR8Nl/YoFbul1gVv7QfH2zEgV2mL2ygxJ9sIqiT0VhOXo+fxAy
         OPNcQTHuzmsii9ppHWAbVJoNJ2u/NZzzTpqWkqklgCrLV+gH8r0TBBF5ETBD5gpuvDEj
         ervsRH6efAP2URLVDjMx0eqW9fLJAxneh5umPnV2oFfVHQIpYSXdNLsaCqxJPI9vPJ9s
         YtNA==
X-Gm-Message-State: AOAM533iXkKDpXk9gJsrNwY80tY9qVXTqbm8+ycUZXjnqPcdamKmbP1K
        GB8d+7iQNtI1w7E+tJlttfDFhYRXrCbcxQ==
X-Google-Smtp-Source: ABdhPJz4+eDJABiuW3P2lYzPj1do/7jPFSCLU9z6IF6vfuUVLvHMgTidBg+EzJxdIwzNG/5hXfZPNA==
X-Received: by 2002:a05:620a:a0b:: with SMTP id i11mr20015760qka.65.1597791015023;
        Tue, 18 Aug 2020 15:50:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.53.181])
        by smtp.gmail.com with ESMTPSA id 7sm22677106qky.89.2020.08.18.15.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:50:14 -0700 (PDT)
Message-ID: <5f3c5b26.1c69fb81.c0d25.dd5f@mx.google.com>
Date:   Tue, 18 Aug 2020 15:50:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3861455486647989601=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v1,1/7] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200818152612.BlueZ.v1.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3861455486647989601==
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
#254: FILE: src/adv_monitor.h:1:
+/*

- total: 0 errors, 2 warnings, 237 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3861455486647989601==--
