Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198AEC388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 10:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC8524695
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 10:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKSKxD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:53:03 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49653 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgKSKxD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 05:53:03 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 13E29E000E;
        Thu, 19 Nov 2020 10:53:00 +0000 (UTC)
Message-ID: <d4ab4a00d074c9f7b80b52eacde380037ac87ff6.camel@hadess.net>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
From:   Bastien Nocera <hadess@hadess.net>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 19 Nov 2020 11:53:00 +0100
In-Reply-To: <CAO271mmYAx8jY4WMN3yRWOvxWpj1otJN0+aFm5LcTJAu+Cu5sg@mail.gmail.com>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
         <20201111011745.2016-7-sonnysasaka@chromium.org>
         <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
         <1273e316b9ec06061a1065c04521ae91ab379af1.camel@hadess.net>
         <CAO271mmYAx8jY4WMN3yRWOvxWpj1otJN0+aFm5LcTJAu+Cu5sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2020-11-17 at 14:22 -0800, Sonny Sasaka wrote:
> Hi Bastien,
> 
> More responses below.
> 
> On Tue, Nov 17, 2020 at 10:01 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Tue, 2020-11-17 at 11:51 +0100, Bastien Nocera wrote:
> > > <
> > > <snip> didn't review the code in depth, but, having written this
> > > mechanism
> > > for Bluetooth battery reporting, I think that this is the right
> > > way
> > > to
> > > go to allow daemons like pulseaudio to report battery status.
> > 
> > It would also be useful to know what external components, or
> > internal
> > plugins you expect to feed this API.
> BlueZ could have internal plugins to read proprietary battery
> reporting, e.g. JBL speakers and Bose QC35.

But you don't need to go over D-Bus to implement this.

> 
> > 
> > Apparently HSP/HFP, for example, provide more information that what
> > can
> > be expressed with the Battery1 API, whether it is charging or not,
> > or
> > whether a battery level is unknown, etc.
> > 
> > So I would say that, even if the current battery API is extended,
> > we
> > need to make sure that the D-Bus API to feed new data is extensible
> > enough to allow new properties, and they don't need to be added
> > separately to org.bluez.BatteryProvider1 or org.bluez.Battery1.
> I proposed the API to start simple, but I believe that it can always
> be extended as we need in the future so I don't think the additional
> features need to be coded now. I documented how this API could evolve
> in the future by extending other features as well in this design
> document that I shared with Luiz and Marcel:
>  
> https://docs.google.com/document/d/1OV4sjHLhTzB91D7LyTVT6R0SX2vXwSG1IA3q5yWQWps
> .

Right. My advice would have been to say "the properties exported by
BatteryProvider1 API match the properties exported by the Battery1
API", so you don't need to update 2 APIs separately when the API is
extended.

> 
> > 


