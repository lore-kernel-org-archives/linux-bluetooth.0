Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D595CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8971664F94
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 15:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhCKPbO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:31:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37818 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhCKPbL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 10:31:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id D80991F442CC
Message-ID: <9fed57047ba6145af64ac00579f8ffb7cd03a55d.camel@collabora.com>
Subject: Re: Bug caused by moving to BlueZ 5.56 (bytes stripped from HoG
 reports)
From:   Ricardo =?ISO-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
To:     taylor85345@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Date:   Thu, 11 Mar 2021 16:31:05 +0100
In-Reply-To: <20210311150556.7ym24egif67k6ilq@taylor-lt>
References: <f6764fe94d45ff9211674c5799b193d15385a056.camel@collabora.com>
         <20210311150556.7ym24egif67k6ilq@taylor-lt>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Taylor,

On Thu, 2021-03-11 at 08:05 -0700, Taylor Phillips wrote:
> Hi Ricardo,
> 
> Just passing over this issue in the steam-for-linux github that seems
> like it may be related:
> https://github.com/ValveSoftware/steam-for-linux/issues/7697.
> 
> The latest BlueZ update seems to be causing issues with the Steam
> Controller's ability to communicate specifically with the Steam client
> over Bluetooth LE. I'm a casual non-dev, so can't tell you much more
> than that.
> 
> Thanks,
> 
> Taylor

Thank you. Yes, I'm aware of that. The bug I was inspecting is sorted out now,
but yes, we had to take into account the change in how BlueZ provides the report
IDs starting in 5.56.

I guess that's something that everyone using hidraw devices with multiple report
IDs will have to take care of when they switch to BlueZ 5.56 or later.

Cheers,
Ricardo

