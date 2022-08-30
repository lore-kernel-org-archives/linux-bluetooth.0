Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5971EECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 17:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiH3RAB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 13:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiH3Q7h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 12:59:37 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ABEDB07D
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 09:59:27 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7369B200003;
        Tue, 30 Aug 2022 16:59:25 +0000 (UTC)
Message-ID: <7cc9c749f6e87e5feff30c16422665f10549def6.camel@hadess.net>
Subject: Re: [PATCH] adapter: Implement PowerState property
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Tue, 30 Aug 2022 18:59:25 +0200
In-Reply-To: <039331637535e9cb0c1f9df777cd18d5e34cfe27.camel@hadess.net>
References: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
         <CABBYNZL+NZ_NR8bx+CaayZis4oRywGvqYN8umqaCYEpp3uOwMw@mail.gmail.com>
         <039331637535e9cb0c1f9df777cd18d5e34cfe27.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2022-08-29 at 11:47 +0200, Bastien Nocera wrote:
> The rfkill calls made by GNOME are usually sent to all the rfkill
> devices, rather than targeted at blocking a single adapter. So the
> adapter state isn't super interesting in this case, as all the
> devices
> will be either blocked (computer with no platform rfkill), or gone
> from
> the USB bus (computer with a platform rfkill).
> 
> 
> The good thing about using a string property here is that we can
> extend
> it. One thing we can do though, to make extensibility easier, is take
> a
> leaf out of the icon naming specification, and use prefixes to encode
> the expected state in case the software isn't new enough to know
> about
> a property.
> 
> For example:
> - "on"
> - "off"
> - "on-disabling" (transitioning from on to off)
> - "off-enabling" (transitioning from off to on)
> 
> So we could easily add:
> - "off-rfkill" (off and blocked)
> 
> Let me know what you think.

Poking again, as I really need to land this soon (and by soon I mean
last week ;)
