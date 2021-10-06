Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF418C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 03:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C65611F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 03:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhJFDEC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhJFDEB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 23:04:01 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6321C061749
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 20:02:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a13so1128312qtw.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 20:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=f4hZcCNsWzY5b3dwl82nAfXkX4uAkst/4vjZ/lF686k=;
        b=JYBjNSTqpJePg2cCTqzzXnEVZoyFIf1Dasc05lGsPhHtB1xsMQgtba2Ukr8/RPqZ2i
         K8tANAMprClZXgPVeaqMFXbYgevbQIiZKtp+rQAFhvYGTL4bUduzPw1aMjTHmxdk+yMl
         icSQC95lmddbfWjNadnmweAmM2ZJyBzC2+lDet7DbIQ5OpjWtKk7wIvKQHUsRXWlwWFE
         /VBffFJQDx1G35yjuZlzVeEMYg/7wq+6dzYjzgRb27gmWNnGlqZeHBF6fAbdKDovc8JO
         NboCo0BxOZwSgfT5/aZqyn5aYl6u135HQDorwnW3Y5eTJxG+uq9sgnOU8TuxswF039Oe
         euLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=f4hZcCNsWzY5b3dwl82nAfXkX4uAkst/4vjZ/lF686k=;
        b=fQVO7VJBiIMcx2ibPdIBQKlMmD0olNG3BREGQDdcN0BUpSkEi/ukbezW43piSRWQcC
         3tkStL/WVJjinBNiJ6mTEQThh/vTkKc7I0AB8uZs5YSat9xVPCmRL9nW8W8MU/YTgO64
         Nlu9A2RWv43GG5aQE97k/cj+NR+aYpW3Y1tCuwAgXWM5MKBLw2Gr6gF24z8JuO7T7QQj
         qC39J8ggOear1I1zfpGA7SwICeB000P598M8866oVNCqkedyk6LLdtkMlxroRX+mq1vA
         qMaMuuaRDzdZ8buD+svG5jCYqDmIeN/IkZHmatLXwD6fumi0Db9+0clqO7gTuL5Ln7FY
         jipg==
X-Gm-Message-State: AOAM533/fJlwWhV2lYOBnr16wubVp2sY1hIdbM2XxMbYRHCC3n2rIvyE
        Uer4/2iWa0lN7Oe9HqzQnRFXpynUcjcbXw==
X-Google-Smtp-Source: ABdhPJyWxcAhGTYCUgZwbBakwfuIIrz86Y9P0FDlWoNjZK8N3bwK2laSsFsGk/0nYJhkBDljWYvP+A==
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr24818207qtd.345.1633489328743;
        Tue, 05 Oct 2021 20:02:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.196.166])
        by smtp.gmail.com with ESMTPSA id x9sm213265qtw.84.2021.10.05.20.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:02:08 -0700 (PDT)
Message-ID: <615d11b0.1c69fb81.689fa.1bd2@mx.google.com>
Date:   Tue, 05 Oct 2021 20:02:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7239119544006627918=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/mgmt-tester: Update the correct suspend reason for disconnect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211006024022.111584-1-hj.tedd.an@gmail.com>
References: <20211006024022.111584-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7239119544006627918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=558253

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.92 seconds
Prep - Setup ELL              PASS      47.11 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      9.03 seconds
Build - Make                  PASS      201.78 seconds
Make Check                    PASS      9.71 seconds
Make Distcheck                PASS      238.39 seconds
Build w/ext ELL - Configure   PASS      8.76 seconds
Build w/ext ELL - Make        PASS      190.52 seconds



---
Regards,
Linux Bluetooth


--===============7239119544006627918==--
