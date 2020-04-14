Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81839C352BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 23:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534C52072D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 23:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586905632;
	bh=ieD82P08YTfY/G82UOdtm/Vbiq6/iOjVevWPdZpen1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fj9wnSecwiSQhvLL+SHpFzkKJkRFj9DhLyIgxUlA1uJGg+NtUjKGDqbzyI4BSXSdx
	 F33lmT+eMbL6V/2N4e9WclG21Iyt+hHyCB47dHgBxfd/lT+sYX676N9KoP98jSVPIM
	 W9otOp4lsQ1SuxdO3j0m45AGFBAkAZnNPeSheA9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634352AbgDNXHK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731133AbgDNXHI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 19:07:08 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B622A2054F;
        Tue, 14 Apr 2020 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586905627;
        bh=ieD82P08YTfY/G82UOdtm/Vbiq6/iOjVevWPdZpen1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIEc5R04gywZMMrc71uCHzSof2qGeQqpiHcGu13QWvSESY1BI7TBuBJfC0ahgMTYW
         csxfDtnI4ssTNDV6nHRdtcSx8orGnIc9dfvvsCc84wUP4i53oEK3DYI6jlnQQ1W0t9
         pZ7MKN2xc5D1mV0RKF+JhHiUTQ3SRBnhOJ+g+2nM=
Received: by pali.im (Postfix)
        id CA40F7DE; Wed, 15 Apr 2020 01:07:05 +0200 (CEST)
Date:   Wed, 15 Apr 2020 01:07:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        David Heidelberg <david@ixit.cz>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Undocumented property "DelayReporting" (Was: Re: [PATCH BlueZ 1/4]
 doc/media-api: Add RegisterApplication method)
Message-ID: <20200414230705.7cwffdkal34efyag@pali>
References: <20190721155522.3vqt7vsprhpxflqf@pali>
 <CABBYNZK6cuz9n4Hu9uRCbQvn9uFEYkn9=mY8J5Fqu0u-D3B1EA@mail.gmail.com>
 <20190829125734.GH2840@reaktio.net>
 <20190829200513.6xnta5jx3trbmgxp@pali>
 <20191003181855.GF28704@reaktio.net>
 <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006120245.tkrooh45q7irtm6l@pali>
 <20191009132040.tqnzfabp3llbg2g3@pali>
 <20191114112753.4h7xifkvpjpzgm7x@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191114112753.4h7xifkvpjpzgm7x@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thursday 14 November 2019 12:27:53 Pali Rohár wrote:
> On Wednesday 09 October 2019 15:20:40 Pali Rohár wrote:
> > On Sunday 06 October 2019 14:02:45 Pali Rohár wrote:
> > > On Sunday 06 October 2019 13:53:37 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > > 
> > > > It is just another D-Bus method, the only difference is that it
> > > > carries the entire object tree, btw I did add an example of how to
> > > > register Endpoints in python:
> > > > 
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/example-endpoint
> > > 
> > > This example uses undocumented property "DelayReporting". What it is doing?
> > 
> > And I would like to know what is that undocumented DelayReporting is
> > doing? And to which value should I initialize it in pulseaudio?
> 
> Luiz, any comments on this?

Luiz, could you please tell me some information about this undocumented
property to which value should I set it? I really need it for proper
implementation of endpoints in pulseaudio.

I was not able to decode its meaning from source code nor found any
other information about it.
