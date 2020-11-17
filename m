Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98911C5519F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 10:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC36238E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 10:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgKQK7g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 05:59:36 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:34028 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQK7g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 05:59:36 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 237353B5425
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 10:51:57 +0000 (UTC)
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 26AC7FF812;
        Tue, 17 Nov 2020 10:51:34 +0000 (UTC)
Message-ID: <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>,
        linux-bluetooth@vger.kernel.org
Cc:     Miao-chen Chou <mcchou@chromium.org>
Date:   Tue, 17 Nov 2020 11:51:34 +0100
In-Reply-To: <20201111011745.2016-7-sonnysasaka@chromium.org>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
         <20201111011745.2016-7-sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey Sonny,

On Tue, 2020-11-10 at 17:17 -0800, Sonny Sasaka wrote:
> This patch implements the BatteryProvider1 and
> BatteryProviderManager1
> API. This is a means for external clients to feed battery information
> to
> BlueZ if they handle some profile and can decode battery reporting.
> 
> The battery information is then exposed externally via the existing
> Battery1 interface. UI components can consume this API to display
> Bluetooth peripherals' battery via a unified BlueZ API.

Was this patch reviewed for potential security problems? From the top
of my head, the possible problems would be:
- I don't see any filters on which user could register battery
providers, so on a multi user system, you could have a user logged in
via SSH squatting all the battery providers, while the user "at the
console" can't have their own providers. Also, what happens if the user
at the console changes (fast user switching)?
- It looks like battery providers don't check for paired, trusted or
even connected devices, so I would be able to create nearly unbound
number of battery providers depending on how big the cache for "seen"
devices is.

Given that the interface between upower and bluez is supposedly
trusted, it might be good to ensure that there are no fuzzing problems
on the bluez API side that could translate to causing problems in
upower itself.

I didn't review the code in depth, but, having written this mechanism
for Bluetooth battery reporting, I think that this is the right way to
go to allow daemons like pulseaudio to report battery status.

Cheers

