Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D280F2251E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 13:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgLVNVd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 08:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgLVNVc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 08:21:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C34632251E;
        Tue, 22 Dec 2020 13:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608643251;
        bh=fVxI/FsMGbpVNtGwSmjiqBW+7gDtAS2BbFKIse/x5rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwiWaMzWuv0OvHDYbaAC0VW8IV/26LAyHiE4Z/imiOMRhyKLHIvLi7ELQF9y3GE4x
         fdW+SFrae4felB0gzCS1YJddBlTXDFvEtGTw9qfUb7sYcIRuC3Tq71s7MxU6JjY8dt
         z/psKsU82NlGjccDnj/x0T5tDHeYOhFXEfUsz7ldMw+WpapmbKPvAsU8lMjPU6onY4
         iUCCQ+FPHsyF/WKhlaLe1zmSSbV0cZDIZXboxQH6XdsTSl2+M5a2LsGDaBPdKZwIGk
         GccQ+qcUHQUeI5HjBHw9H2vMKFU8X6LOMZWK+FKwOc2s0aOkxCBCYEQOZbjHM6SGT8
         BnenqZbc8Npkg==
Received: by pali.im (Postfix)
        id DC68E8B8; Tue, 22 Dec 2020 14:20:49 +0100 (CET)
Date:   Tue, 22 Dec 2020 14:20:49 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201222132049.de24v7rarpuf7hoh@pali>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <20201221210707.evrdeyiki45pivux@pali>
 <20201222114024.GG20371@reaktio.net>
 <20201222114940.egjhi3jangsqvpnb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201222114940.egjhi3jangsqvpnb@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 22 December 2020 12:49:40 Pali Rohár wrote:
> On Tuesday 22 December 2020 13:40:24 Pasi Kärkkäinen wrote:
> > Hello Pali,
> > 
> > On Mon, Dec 21, 2020 at 10:07:07PM +0100, Pali Rohár wrote:
> > > 
> > > > Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?
> > > 
> > > For usage mSBC hw encoder you need to use Enhanced Setup Synchronous
> > > Connection HCI command for establishing SCO connection.
> > > 
> > > For using HW encoder you need to stop feeding socket with mSBC encoded
> > > data and instead put into this socket RAW pcm samples. Also you need
> > > somehow inform kernel about this change.
> > > 
> > > For both things I designed new setsockopt() API which I described in:
> > > https://lore.kernel.org/linux-bluetooth/20200419234937.4zozkqgpt557m3o6@pali/
> > >
> > 
> > In that thread Luiz asked for changes to the patch, eg. kernel module option is needed which allows enabling new/experimental features, and your changes should be enabled only when experimental option is given while loading the module.
> > 
> > See here:
> > https://lore.kernel.org/linux-bluetooth/CABBYNZJTBM87Yr+rqUm6MwwSR60YNe+UFr0HHj5T2DkY7LqJqA@mail.gmail.com/
> > 
> > Could you please add that kernel module option, and re-send the patch ? 

Pasi, I understood that Marcel is against it. But if bluetooth
maintainers approve this API, I may try to implement it. If API must be
hidden under compile time CONFIG_* kernel option it is also possible.
Just I need to know exact answer "yes" or "no".

> I have not implemented it. I just proposed API between userspace and
> kernel. But I have not implemented this API yet.
