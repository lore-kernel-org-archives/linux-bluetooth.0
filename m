Return-Path: <SRS0=tgYb=OD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3717AC43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Nov 2018 13:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F303F2086B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Nov 2018 13:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F303F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeKYAQ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Nov 2018 19:16:26 -0500
Received: from a3.inai.de ([88.198.85.195]:54552 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeKYAQ0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Nov 2018 19:16:26 -0500
Received: by a3.inai.de (Postfix, from userid 25121)
        id 3CD713BACCAB; Sat, 24 Nov 2018 14:27:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 32B2D3BB6970;
        Sat, 24 Nov 2018 14:27:59 +0100 (CET)
Date:   Sat, 24 Nov 2018 14:27:59 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/7] build: change @foo@ to $(foo) in automake
 makefiles
In-Reply-To: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1811241421150.5864@n3.vanv.qr>
References: <CABBYNZ+pLp5W0_sNC4ih_KuW2WmX5drBL2bPX4rG4fHQ4kyecg@mail.gmail.com> <20181121125753.15476-1-jengelh@inai.de> <20181121125753.15476-2-jengelh@inai.de> <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thursday 2018-11-22 10:47, Luiz Augusto von Dentz wrote:

>Hi Jan,
>> When using automake, all AC_SUBSTed variables are made available as
>> make variables, so that they can also be set at make time. Therefore,
>> they need not use the @harcoded@ style.
>>
>> -pkglibexecdir = @libexecdir@/bluetooth
>> +pkglibexecdir = $(libexecdir)/bluetooth
>> -includedir = @includedir@/bluetooth
>> +includedir = $(includedir)/bluetooth
>
>Makefile:2392: *** Recursive variable 'includedir' references itself
>(eventually).  Stop.

Thank you. Not sure why my system does not give the recursive warning here (it
*did* for libexecdir though, which is what brought commit 78bce48009 forth).
I'll do the distcheck too (apparently that --enables-android, which I missed).
