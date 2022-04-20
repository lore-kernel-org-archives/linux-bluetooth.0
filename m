Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513ABC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 08:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376941AbiDTI6L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377045AbiDTI5q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Apr 2022 04:57:46 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8145FC1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 01:55:00 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 480AD60008;
        Wed, 20 Apr 2022 08:54:58 +0000 (UTC)
Message-ID: <8f12681aea9335dd83d104b9930a1e276905f05e.camel@hadess.net>
Subject: Re: [PATCH v2 BlueZ 3/3] build: Make use of StateDirectory and
 ConfigurationDirectory
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Wed, 20 Apr 2022 10:54:57 +0200
In-Reply-To: <CABBYNZJmGGSZbWZ1=aYkAt6yFo=uP_760mHt_-nq8TeYEbRiBg@mail.gmail.com>
References: <20220415223049.1155838-1-luiz.dentz@gmail.com>
         <20220415223049.1155838-3-luiz.dentz@gmail.com>
         <7222b71167dd3ec90d7b4ad1b12b6179cc95f94d.camel@hadess.net>
         <CABBYNZJmGGSZbWZ1=aYkAt6yFo=uP_760mHt_-nq8TeYEbRiBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 2022-04-19 at 11:40 -0700, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Tue, Apr 19, 2022 at 3:33 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Fri, 2022-04-15 at 15:30 -0700, Luiz Augusto von Dentz wrote:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > 
> > > This makes use of StateDirectory[1] and ConfigurationDirectory[1]
> > > to
> > > inform systemd what those paths are used for instead of using
> > > ReadWritePaths and ReadOnlyPaths which can lead to issues.
> > > 
> > > Fixes: https://github.com/bluez/bluez/issues/329
> > 
> > FYI, my reviews on those patches are at:
> > https://github.com/bluez/bluez/issues/329#issuecomment-1102459104
> > 
> > Cheers
> 
> Ive sent a couple of patches addressing them, please have a look.

Patches look good, thanks!
