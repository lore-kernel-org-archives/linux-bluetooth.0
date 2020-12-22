Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8CEC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167A72312D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgLVL6b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 06:58:31 -0500
Received: from fgw23-4.mail.saunalahti.fi ([62.142.5.110]:41854 "EHLO
        fgw23-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbgLVL6b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 06:58:31 -0500
X-Greylist: delayed 1043 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2020 06:58:30 EST
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 7b7399c2-444a-11eb-8ccd-005056bdfda7;
        Tue, 22 Dec 2020 13:40:25 +0200 (EET)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id 6970736C0F6; Tue, 22 Dec 2020 13:40:25 +0200 (EET)
Date:   Tue, 22 Dec 2020 13:40:24 +0200
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201222114024.GG20371@reaktio.net>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <20201221210707.evrdeyiki45pivux@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201221210707.evrdeyiki45pivux@pali>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Pali,

On Mon, Dec 21, 2020 at 10:07:07PM +0100, Pali Rohár wrote:
> 
> > Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?
> 
> For usage mSBC hw encoder you need to use Enhanced Setup Synchronous
> Connection HCI command for establishing SCO connection.
> 
> For using HW encoder you need to stop feeding socket with mSBC encoded
> data and instead put into this socket RAW pcm samples. Also you need
> somehow inform kernel about this change.
> 
> For both things I designed new setsockopt() API which I described in:
> https://lore.kernel.org/linux-bluetooth/20200419234937.4zozkqgpt557m3o6@pali/
>

In that thread Luiz asked for changes to the patch, eg. kernel module option is needed which allows enabling new/experimental features, and your changes should be enabled only when experimental option is given while loading the module.

See here:
https://lore.kernel.org/linux-bluetooth/CABBYNZJTBM87Yr+rqUm6MwwSR60YNe+UFr0HHj5T2DkY7LqJqA@mail.gmail.com/

Could you please add that kernel module option, and re-send the patch ? 


Thanks,

-- Pasi

