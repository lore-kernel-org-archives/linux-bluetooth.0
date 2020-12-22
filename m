Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FC1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889D72312D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgLVLuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 06:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgLVLuY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 06:50:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EEF12311D;
        Tue, 22 Dec 2020 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608637783;
        bh=oK0OHThwNyYMlAq3CsvAEPYB7f7apr8xylr5mleYPcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lY2SO9CBr5m5NQDnvz13clxe1UzYtU8u4y1qpwHI0K9ITv94fiuDOHu4JXs6llTtK
         AbsXWIJmoO7uVs26H9y0qEZPhBIXRLhLvDrpIK6uyMz6Fardl8dl4bl08Zuq8zES7x
         Wf555cFJtlli3yI18YpcXz6lWV/Giu/K0qAnVUYNETMga0GaoBPpp01kSoO7dxMI4M
         34nbGinwbAqSonSOuC7Vm4gmG0yM2iREjzySLEUmpKEYon41bUVWt2I9+qSEu/Mhy3
         6bu47HNUWwPuvSnF5cqfRRgaki5nkPs9WteUunRNPU2NWBxBQ+DKD94NbsaBX3RpGK
         VwiTXfaPnbBxA==
Received: by pali.im (Postfix)
        id B5BB8848; Tue, 22 Dec 2020 12:49:40 +0100 (CET)
Date:   Tue, 22 Dec 2020 12:49:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201222114940.egjhi3jangsqvpnb@pali>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <20201221210707.evrdeyiki45pivux@pali>
 <20201222114024.GG20371@reaktio.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201222114024.GG20371@reaktio.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 22 December 2020 13:40:24 Pasi Kärkkäinen wrote:
> Hello Pali,
> 
> On Mon, Dec 21, 2020 at 10:07:07PM +0100, Pali Rohár wrote:
> > 
> > > Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?
> > 
> > For usage mSBC hw encoder you need to use Enhanced Setup Synchronous
> > Connection HCI command for establishing SCO connection.
> > 
> > For using HW encoder you need to stop feeding socket with mSBC encoded
> > data and instead put into this socket RAW pcm samples. Also you need
> > somehow inform kernel about this change.
> > 
> > For both things I designed new setsockopt() API which I described in:
> > https://lore.kernel.org/linux-bluetooth/20200419234937.4zozkqgpt557m3o6@pali/
> >
> 
> In that thread Luiz asked for changes to the patch, eg. kernel module option is needed which allows enabling new/experimental features, and your changes should be enabled only when experimental option is given while loading the module.
> 
> See here:
> https://lore.kernel.org/linux-bluetooth/CABBYNZJTBM87Yr+rqUm6MwwSR60YNe+UFr0HHj5T2DkY7LqJqA@mail.gmail.com/
> 
> Could you please add that kernel module option, and re-send the patch ? 

I have not implemented it. I just proposed API between userspace and
kernel. But I have not implemented this API yet.
