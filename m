Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D8C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FFB23104
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 15:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgLPPu1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Dec 2020 10:50:27 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58885 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgLPPu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Dec 2020 10:50:27 -0500
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 28A30E0011;
        Wed, 16 Dec 2020 15:49:44 +0000 (UTC)
Message-ID: <6e6d72ff9aa14a65d6d0df5bd68a6ad6887f31c2.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth: L2CAP: Try harder to accept device not
 knowing options
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Florian Dollinger <dollinger.florian@gmx.de>
Date:   Wed, 16 Dec 2020 16:49:44 +0100
In-Reply-To: <CABBYNZJNTDek+kKS5wtrr67Xx8DmFGvcV13cLSxULgJRa5N+3g@mail.gmail.com>
References: <20201208172912.4352-1-hadess@hadess.net>
         <CABBYNZJNTDek+kKS5wtrr67Xx8DmFGvcV13cLSxULgJRa5N+3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
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

The tests fail for me in the same on a kernel with and without the
patch:
- Expected that the IUT transmits an L2CAP_ConfigRsp includes the
unsupported option that Lower Tester sent.
Final Verdict:FAIL
L2CAP/COS/CFD/BV-14-C finished

Is this expected? I was using an 5.10-rc7 kernel with and without the
patch I sent. I can send you the full results off-list if you want
them.

