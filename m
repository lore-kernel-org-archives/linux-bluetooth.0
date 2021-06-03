Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16ACC47082
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 22:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5AA613FF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 22:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCWwq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 18:52:46 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:42688 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCWwp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 18:52:45 -0400
Received: by mail-pg1-f174.google.com with SMTP id t8so6269898pgb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jun 2021 15:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=yjwLN4ukVonteSx9IEhmKfR/n502+IK8rv/TYdDoDHc=;
        b=iiapdCXPzgk3myKADX0Po72qOMymjiJrrwXoxLlm0ya7K9lEADsWkTHRtfMmElDnLn
         TnScbFGDpezKoWJjt0rETHFEyx8yOkFoRzUoXs48RSvOziIh5V8ZEONekeGOkahP3nt0
         JUMk+rKYoiFuHAtH4Keb/jD0TTzUTJ3VZA7QJD8DotrIuSkAPanKDWyXlblq6EjbMFFW
         SaiZ3/lKlkzz4DXJB+lz2J2EA76Fkf+OtZBb190l1HJcrSd+MZq/CO9eRsI2hh7cFLVV
         HrOYEIxSStmNtCWMvGmb3vBiK0mUq6w/Lpkf7bKc3qqgHPS1Ike7riuTBW6Jw2B+R0QC
         DXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=yjwLN4ukVonteSx9IEhmKfR/n502+IK8rv/TYdDoDHc=;
        b=X9ljS7MwZyivLRGXyvMOFoiSWgGUJA/Ot0HOTC7Z2HOG5N5tJmuhc1eB8WNPZtwhfP
         vWtvuq9jgISRGHkDhr5LUaN4SBfqEjwd6arC3AzXWydHmwF/XwDuUmjgdsOX8EnZTYMZ
         nspLhlhpxWogzlFy0qlmgt3FFSD2BkS8FTRzXm+vc+mR3wz84sciWeYXcDfmOTlYv57p
         s+X/mD6wf9b9lniOcaOksXuKTJesLT3WoRMQt6IE4seDKxiIfNrLhWIVNeOjzgvWOjrv
         MsPM13nCbtEC5d7E59vuMZGp7bRizERz3IPYHPyHdYFHt6wmmVVV2/2+60BXXHmhb3wJ
         T0hA==
X-Gm-Message-State: AOAM531kj+yn/PyKLxum4rA7pSXiouOw9kg6jahHRJ3/3t1MKgInzfQm
        FPgoDHrh39Fr83IifmzRIGCTha6bog==
X-Google-Smtp-Source: ABdhPJx3RtTjYQ86uQon9pRduf5tMlWnJsK6k8CWsjX5gTui9aiIQbFB1Sc3QM6Abl9i2eAjhdUGPw==
X-Received: by 2002:a63:1d61:: with SMTP id d33mr1675007pgm.331.1622760599957;
        Thu, 03 Jun 2021 15:49:59 -0700 (PDT)
Received: from [10.0.0.24] (c-73-15-154-65.hsd1.ca.comcast.net. [73.15.154.65])
        by smtp.gmail.com with ESMTPSA id f7sm86318pfk.191.2021.06.03.15.49.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:49:58 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org
From:   Cinaed Simson <cinaed.simson@gmail.com>
Subject: bluetooth mesh
Message-ID: <16f88f89-d3ad-350c-0a7c-e3da3ea202fd@gmail.com>
Date:   Thu, 3 Jun 2021 15:49:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi - what are minum requirements for using mesh?

I'm in the process of installing the latest git version of bluez on 2 
single board computer ARM 64 odroid running stretch.

Both have 4.x kernels but I doubt if they have the crypotgraich kernel 
modules.

I'm doing this to learn about bluetooth mesh so I don't care about 
performance.

-- Cinaed


