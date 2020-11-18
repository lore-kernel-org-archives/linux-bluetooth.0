Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D5C5519F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 17:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FEF20719
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 17:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgKRRe3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:34:29 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40887 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKRRe2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Nov 2020 12:34:28 -0500
X-Greylist: delayed 110572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 12:34:28 EST
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id EA32CFF804;
        Wed, 18 Nov 2020 17:34:26 +0000 (UTC)
Message-ID: <922ebf50e343c6116b618ec966def51ece708dcf.camel@hadess.net>
Subject: Re: [PATCH] tools/hcitool.c
From:   Bastien Nocera <hadess@hadess.net>
To:     Bisseling <spam@bisseling.de>, linux-bluetooth@vger.kernel.org,
        marcel@holtmann.org
Date:   Wed, 18 Nov 2020 18:34:26 +0100
In-Reply-To: <1a8fb695-c92d-03fe-3347-6e98480be830@bisseling.de>
References: <96d6eb8d-cf31-7cae-3e78-6761cb74961a@bisseling.de>
         <38dcad476ea9efa71eff2065cdd7d57c184bd6b6.camel@hadess.net>
         <24eb6e46-0563-92fc-5394-f1de9d9e0135@bisseling.de>
         <1a8fb695-c92d-03fe-3347-6e98480be830@bisseling.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2020-11-18 at 17:35 +0100, Bisseling wrote:
> Now a robot tells me to do offer my patch via email to this mailing 
> list. How very frustrating.

I don't think that the fact that PRs weren't going to get merged was
announced after the github repo was. I would have got bitten as well.

Sorry about that.

> 
> On 17.11.20 16:30, Bisseling wrote:
> > Hope I got that pull request right.
> > 
> > Thanks
> > 
> > On 13.11.20 18:00, Bastien Nocera wrote:
> > > On Fri, 2020-11-13 at 17:54 +0100, Bisseling wrote:
> > > > Please review and pull:
> > > > 
> > > > https://github.com/GeorgBisseling/bluez/commit/69b61d7c71d08ddfd1b5b0f1862e456601264a01
> > > >  
> > > > 
> > > > 
> > > > 
> > > You can create a pull request against:
> > > https://github.com/bluez/bluez/pulls
> > > 
> > > Otherwise you'll need to use git-sendemail to send the patch
> > > itself to
> > > the list.
> > > 


