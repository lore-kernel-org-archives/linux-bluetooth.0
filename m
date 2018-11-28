Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB404C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7393A208E7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7393A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeK2CGk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:06:40 -0500
Received: from a3.inai.de ([88.198.85.195]:36552 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeK2CGk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:06:40 -0500
Received: by a3.inai.de (Postfix, from userid 25121)
        id E8293EB961C; Wed, 28 Nov 2018 16:04:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id DFDF03BACCB1;
        Wed, 28 Nov 2018 16:04:39 +0100 (CET)
Date:   Wed, 28 Nov 2018 16:04:39 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH bluez] build system refresh (take 3)
In-Reply-To: <CABBYNZKaBff5xU=9K=4D8id_dw+MNjmCRt8ugZ0k8g1x2Z=K9A@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1811281603540.16342@n3.vanv.qr>
References: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com> <20181125092012.8001-1-jengelh@inai.de> <CABBYNZ+AY6NPO68P5WJEtL_CKumTEywsuoGC4Roe4evm5mia1w@mail.gmail.com>
 <CABBYNZKaBff5xU=9K=4D8id_dw+MNjmCRt8ugZ0k8g1x2Z=K9A@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 2018-11-28 15:38, Luiz Augusto von Dentz wrote:

>Hi Jan,
>
>> >  6 files changed, 119 insertions(+), 104 deletions(-)
>> Applied, thanks.
>
>Looks like this is breaking the build if coverage is enabled (set when
>lcov is available).

How are you specifically enabling coverage on your system?
