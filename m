Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0E3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 21:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD44F22B4B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 21:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgLUVPV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgLUVPU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 16:15:20 -0500
Date:   Mon, 21 Dec 2020 22:14:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608585280;
        bh=QvsLIK4E2mZN9+cnf/RZLiFpnBateZUlf39BFBK6W1Y=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTaSbra1FcZX69yXy8te04hjer8pL8EFyOKA+ojlv+iB7JAcNdStQrvnzIeSMLJiX
         z3GKnSIpDOp5APKpLWX3NSDmEfNE7b9wD8WIk4knXRWPAoWxgxrc/JsHGMO36ltRYU
         QWRnrHHiLYL8z4dvRSmnTBgXo9lzNE0eNPKf6nhgDKouAzG9I0/AdM+dmqrvVi13S3
         a7Xrgfcm2ytozZeqBcGfX3uT+BAKmM0poFhgfLtkv4nCUJ2KcsPnlUu5FKP04zjsfg
         jYM+MYiRYxCub7Crh+jhNfhww9LX2HBIzNxL4tu7UoJW260Ev5vHzS1/0rmo32XEi8
         JA5l0G/IR41fg==
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201221211437.4s27cl6t4v27sugh@pali>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 18 December 2020 11:43:32 Luiz Augusto von Dentz wrote:
> Hi Joakim,
> 
> On Fri, Dec 18, 2020 at 10:48 AM Joakim Tjernlund
> <Joakim.Tjernlund@infinera.com> wrote:
> >
> > There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC but currently there is no way to select this mode.
> > Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?
> 
> It is in our plan to support HW offloading, but that doesn't mean all
> platforms will be supported since that depends on the PCM lines being
> connected to BT controller in the first place.

Dedicated PCM lines are used in embedded world and maybe also still in
some mobile segment. I remember that e.g. Nokia N900 had this setup. And
it was quite crazy how it was finally configured... but it worked!

But this is nothing for classic x86 laptops with USB bluetooth
controllers on classic intel bluetooth+wifi mPCIe cards where SCO
traffic is routed via HCI (over USB). And not via dedicated PCM pins.
Moreover I think there are not any mainstream laptop which have PCM pins
on mPCIe slots usable for such bluetooth mPCIe cards.

For classic desktop / laptop it is needed to deal with fact that SCO
audio is routed via HCI (like A2DP) and therefore support for Enhanced
Setup Synchronous Connection HCI command.

AFAIK even for routing SCO over PCM when mSBC hw encoder is used,
Enhanced Setup Synchronous Connection HCI command is required.
