Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F61C56202
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 10:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444BF2245A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 10:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgKTKds (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 05:33:48 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53425 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgKTKdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 05:33:47 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EFD5260006;
        Fri, 20 Nov 2020 10:33:42 +0000 (UTC)
Message-ID: <8b0420db9d7a9ee73c323fb311ee4faadacead1f.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Date:   Fri, 20 Nov 2020 11:33:42 +0100
In-Reply-To: <CAO271mn-3qK6TqDUf2ua06EAN58K592ondrZjC-pt6byPQXG8Q@mail.gmail.com>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
         <20201111011745.2016-7-sonnysasaka@chromium.org>
         <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
         <CAO271m=O3hyS6Pp4fQ1pnsir7wYbLFwDm7f-a5yd0o4NTUUewA@mail.gmail.com>
         <815b138fb849b56a5ec71045b54c86f99ed9df2c.camel@hadess.net>
         <CAO271mn-3qK6TqDUf2ua06EAN58K592ondrZjC-pt6byPQXG8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2020-11-19 at 12:20 -0800, Sonny Sasaka wrote:
> Hi Bastien,
> 
> On Thu, Nov 19, 2020 at 2:44 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Tue, 2020-11-17 at 14:16 -0800, Sonny Sasaka wrote:
> > > Hi Bastien,
> > > 
> > > Thank you for the feedback. Please find my answers below.
> > > 
> > > On Tue, Nov 17, 2020 at 2:51 AM Bastien Nocera
> > > <hadess@hadess.net>
> > > wrote:
> > > > 
> > > > Hey Sonny,
> > > > 
> > > > On Tue, 2020-11-10 at 17:17 -0800, Sonny Sasaka wrote:
> > > > > This patch implements the BatteryProvider1 and
> > > > > BatteryProviderManager1
> > > > > API. This is a means for external clients to feed battery
> > > > > information
> > > > > to
> > > > > BlueZ if they handle some profile and can decode battery
> > > > > reporting.
> > > > > 
> > > > > The battery information is then exposed externally via the
> > > > > existing
> > > > > Battery1 interface. UI components can consume this API to
> > > > > display
> > > > > Bluetooth peripherals' battery via a unified BlueZ API.
> > > > 
> > > > Was this patch reviewed for potential security problems? From
> > > > the
> > > > top
> > > > of my head, the possible problems would be:
> > > > - I don't see any filters on which user could register battery
> > > > providers, so on a multi user system, you could have a user
> > > > logged
> > > > in
> > > > via SSH squatting all the battery providers, while the user "at
> > > > the
> > > > console" can't have their own providers. Also, what happens if
> > > > the
> > > > user
> > > > at the console changes (fast user switching)?
> > > > - It looks like battery providers don't check for paired,
> > > > trusted
> > > > or
> > > > even connected devices, so I would be able to create nearly
> > > > unbound
> > > > number of battery providers depending on how big the cache for
> > > > "seen"
> > > > devices is.
> > > For security, the API can be access-limited at D-Bus level using
> > > D-
> > > Bus
> > > configuration files. For example, we can let only trusted UNIX
> > > users
> > > as the callers for this API. This D-Bus config file would be
> > > distribution-specific. In Chrome OS, for example, only the
> > > "audio"
> > > and
> > > "power" users are allowed to call this API. This way we can make
> > > sure
> > > that the callers do not abuse the API for denial-of-service kind
> > > of
> > > attack.
> > 
> > That wouldn't solve it, the point is to avoid one user causing
> > problems
> > for another logged in user. If both users are in the audio group,
> > which
> > they'd likely be to be able to use the computer, they'd be able to
> > cause problems to each other.
> 
> If I understand your case correctly, both users being in "audio"
> group
> still won't allow them both to become battery providers because the
> D-Bus policy only allows "audio" user and not "audio" group.

OK, I guess that means that this is a separate daemon running as a
different user, not, say, PulseAudio running in the user's session
feeding information. Is that right?

Either way, I guess we'll need to test this out once the feature is
merged.

Apart from the concern about having to duplicate the exported
properties, the rest looks good. I've made some additional comments
about the architecture in the design document you shared, but those
should not have any impact on the implementation.

Good job :)

