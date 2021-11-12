Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315EAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 04:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDD460FBF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 04:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhKLEt2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 23:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKLEt2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 23:49:28 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D5EC061766
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 20:46:37 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id r8so8001405qkp.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 20:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ZZw/uG6/XVksgAbjthLSRugThTdhLrvdCAxL64ZbHDU=;
        b=oX56sM3Fl52iX0KOCbTesIL/SFYy7wubBGmzuwlgjj452f2csFDwfZnyLepcCTVaEB
         oTfcw3vn4dWhEf5bNceuMux5+0V5D/kJEP7CNSvInZLcUMw62DBkXbVxOaJg3pg+3FV+
         SRv1j01pJp3QFmuW1wv0U5X8VTTDEZ7bP4DgcG3j1ztBXsjLZDG6B5VsAmxJLiQZ8jjB
         ShCbaMvgdwooUaSNboG3j/96H9ogtzTGfo/X+aawS2IBe6xc1c1U0SfQb6JOKlK4cnml
         ktxNJd/BgqhnHMgrLeJuct+/BVQ39VNMjkHW997CVM+/UCZdgBaye3mz+Kz5GHHXy9b0
         xhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ZZw/uG6/XVksgAbjthLSRugThTdhLrvdCAxL64ZbHDU=;
        b=i/3dbGJJv+R5/J3J8o2LhbaTdH41P6MX5oXFWqe5IdjNnFMzBQAyrspTT9Uuhqb7xU
         y1/QW+82euzylpc1ZhRx4ThppUkP2vILVnNGGGkCOH5EBTxYgIK+OXDALhuRSNWPgUsW
         +cQ6dOaiz55b/GFr7bhLs8ocKu+Aw4JxrEAnugtM//wSCi1KXT/u/S3q/uRsSaB+JzQM
         iFSZrINnWBmfMMqIEVkg7IDBOwfxdbB0RtVt6o/YFdYSKSrHkxKB1jC39u9XT5BNBRmN
         LatK3kcndTv9XBl7Bp9C3YI3aSDQ2z07ANU43fetvj3L5ur1ySM1OUX1N27PW1/i91o6
         Yb2w==
X-Gm-Message-State: AOAM533qE3LN1gSTN6tSerXDyjHpuuJ+btw3YzV/6I8gdQXDW1ENx+zO
        eun7e0v7zMl1NlKq4A51l2TBYAivyo6n3g==
X-Google-Smtp-Source: ABdhPJz4R7xP6qnN9k/0hd2Agiu3iM1Nrl4rHJ6kw3UekElI9ebt85dWp+EHwmr5J/uHCRgfn6cVuQ==
X-Received: by 2002:a05:620a:3728:: with SMTP id de40mr8999876qkb.68.1636692396653;
        Thu, 11 Nov 2021 20:46:36 -0800 (PST)
Received: from [172.17.0.2] ([52.186.137.252])
        by smtp.gmail.com with ESMTPSA id y14sm2608746qta.86.2021.11.11.20.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 20:46:36 -0800 (PST)
Message-ID: <618df1ac.1c69fb81.b6ec8.17df@mx.google.com>
Date:   Thu, 11 Nov 2021 20:46:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4064607044929329616=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] admin: fix devices not reset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211112120136.Bluez.v1.1.Ie043f3613eba798be6f87213a6737c447634a71f@changeid>
References: <20211112120136.Bluez.v1.1.Ie043f3613eba798be6f87213a6737c447634a71f@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4064607044929329616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=579057

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.90 seconds
Prep - Setup ELL              PASS      51.31 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      9.51 seconds
Build - Make                  PASS      222.93 seconds
Make Check                    PASS      10.10 seconds
Make Distcheck                PASS      262.72 seconds
Build w/ext ELL - Configure   PASS      9.64 seconds
Build w/ext ELL - Make        PASS      212.15 seconds



---
Regards,
Linux Bluetooth


--===============4064607044929329616==--
