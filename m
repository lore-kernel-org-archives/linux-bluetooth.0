Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE99C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 02:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9F422EBF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 02:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbhAYSae (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:30:34 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59053 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbhAYSa3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 13:30:29 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.1.150] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 643211BF206;
        Mon, 25 Jan 2021 18:29:44 +0000 (UTC)
Message-ID: <23573e40ef24668f33fac9a648213b81cad41568.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth: L2CAP: Try harder to accept device not
 knowing options
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Florian Dollinger <dollinger.florian@gmx.de>
Date:   Mon, 25 Jan 2021 19:29:43 +0100
In-Reply-To: <CABBYNZ+41BSkQEGbXsemCgWQhmaEjB3KOkLrFyOjv_=_zMQy_Q@mail.gmail.com>
References: <20201208172912.4352-1-hadess@hadess.net>
         <CABBYNZ+41BSkQEGbXsemCgWQhmaEjB3KOkLrFyOjv_=_zMQy_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2021-01-07 at 17:29 -0800, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Dec 8, 2020 at 9:36 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > The current implementation of L2CAP options negotiation will
> > continue
> > the negotiation when a device responds with L2CAP_CONF_UNACCEPT
> > ("unaccepted
> > options"), but not when the device replies with L2CAP_CONF_UNKNOWN
> > ("unknown
> > options").
> > 
> > Trying to continue the negotiation without ERTM support will allow
> > Bluetooth-capable XBox One controllers (notably models 1708 and
> > 1797)
> > to connect.
> > 
> > <snip>
> > Signed-off-by: Florian Dollinger <dollinger.florian@gmx.de>
> > Co-developed-by: Florian Dollinger <dollinger.florian@gmx.de>
> 
> Reviewed-by: Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>

Marcel, any chance of a review on this one? I've sent you the results
of the PTS tests privately, but looks like you weren't CC:ed on the
earlier mail thread.

Cheers

