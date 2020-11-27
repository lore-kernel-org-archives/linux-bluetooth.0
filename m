Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBFBC63798
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 12:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA8920B1F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 12:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgK0MfH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Nov 2020 07:35:07 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:32869 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgK0MfH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Nov 2020 07:35:07 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 43B4560005;
        Fri, 27 Nov 2020 12:35:04 +0000 (UTC)
Message-ID: <29c9a9a64209ce2c05617d0843f40e3b970b525a.camel@hadess.net>
Subject: Re: [PATCH BlueZ v3 4/7] doc: Add Battery Provider API doc
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Date:   Fri, 27 Nov 2020 13:35:04 +0100
In-Reply-To: <CAO271mmNvaFuuG9Sv8EHZ6+giYvom8FfWCmQJvJTUfgmsJ3GjA@mail.gmail.com>
References: <20201120205728.339325-1-sonnysasaka@chromium.org>
         <20201120205728.339325-4-sonnysasaka@chromium.org>
         <CABBYNZLsGs5KDC8kGY4ahfA1Bmdhz1XaR9kNRBKNxN7dTZoFHw@mail.gmail.com>
         <CAO271m=Bsz8NXtHzjAn5iYxMs0hxd17DW9QCUnXZACywTDVcvg@mail.gmail.com>
         <CABBYNZ+ZtmfNxQRd1Zai__htG=xhg+iz-LZw=ktn3b49PwP1xg@mail.gmail.com>
         <CAO271mmNvaFuuG9Sv8EHZ6+giYvom8FfWCmQJvJTUfgmsJ3GjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2020-11-24 at 17:20 -0800, Sonny Sasaka wrote:
> 
> If we move BatteryProviderManager1 to the device object, that means
> we
> can't use the object manager style and providers have to register
> each
> battery once rather than registering once in the beginning and expose
> several objects afterwards, so this would lose your suggestion to use
> object manager in the first place. I prefer we stick to using object
> manager style, it is simple, easy to understand and implement for
> providers (refer to my python test app in one of the patches in this
> series).

org.freedesktop.DBus.ObjectManager.InterfacesAdded would show the
interface appearing. It's also what UPower expects bluez to do.


