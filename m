Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D617C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB6B23B4B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 18:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgLHS2M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 13:28:12 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42795 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgLHS2L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 13:28:11 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B15A920007;
        Tue,  8 Dec 2020 18:27:29 +0000 (UTC)
Message-ID: <3fcd56e8b875fb3d4ed6d58ad150e4b054d875ca.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth: L2CAP: Try harder to accept device not
 knowing options
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Florian Dollinger <dollinger.florian@gmx.de>
Date:   Tue, 08 Dec 2020 19:27:29 +0100
In-Reply-To: <CABBYNZJNTDek+kKS5wtrr67Xx8DmFGvcV13cLSxULgJRa5N+3g@mail.gmail.com>
References: <20201208172912.4352-1-hadess@hadess.net>
         <CABBYNZJNTDek+kKS5wtrr67Xx8DmFGvcV13cLSxULgJRa5N+3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2020-12-08 at 10:09 -0800, Luiz Augusto von Dentz wrote:
> Hi Bastien,
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
> 
> While the bellow traces looks fine we need to confirm that it doesn't
> break the qualification tests e.g:
> 
> L2CAP/COS/CFD/BV-14-C [Unknown Mandatory Options Request]
> 
> • Test Purpose Verify that the IUT can give the appropriate error
> code
> when the Lower Tester proposes any number of unknown options where at
> least one is mandatory.
> 
> Afaik it should be fine to continue with another round of
> configuration given that it only expects the error 0x0003, but we
> better confirm PTS doesn't expect a L2CAP Disconnect after it.

I have a Windows machine, and the PTS dongle. How do I set up the
qualification test and run it against the Linux machine before and
after the patch?

