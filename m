Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A8BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 15:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiKIPzq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiKIPzp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 10:55:45 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90544C7B
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 07:55:43 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 20D0DE0008;
        Wed,  9 Nov 2022 15:55:41 +0000 (UTC)
Message-ID: <c89bbf14a147ddcecbf52043927cac31e21ee6bf.camel@hadess.net>
Subject: Re: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 09 Nov 2022 16:55:41 +0100
In-Reply-To: <CABBYNZKXvcUjyuf1DzjB=NX1xVt8bynZQ9KNrOOYGQMtPt5PKA@mail.gmail.com>
References: <20221102101224.1463549-1-hadess@hadess.net>
         <CABBYNZKXvcUjyuf1DzjB=NX1xVt8bynZQ9KNrOOYGQMtPt5PKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.0 (3.46.0-2.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2022-11-03 at 13:26 -0700, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Wed, Nov 2, 2022 at 3:22 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > ---
> >  src/main.conf | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/src/main.conf b/src/main.conf
> > index 2796f155e..fbe0a97be 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -125,6 +125,8 @@
> >  # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental
> > Bluetooth Quality Report)
> >  # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload
> > Codecs)
> >  # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO
> > socket)
> > +# 00002bcb-0000-1000-8000-00805f9b34fb (BlueZ Experimental LE
> > Audio BAP source)
> > +# 00002bc9-0000-1000-8000-00805f9b34fb (BlueZ Experimental LE
> > Audio BAP sink)
> >  # Defaults to false.
> >  #KernelExperimental = false
> 
> Not really following, these UUID are actually part of LE Audio
> standard, they are not experimental, or perhaps you want to document
> what UUIDs can be registered using MediaEndpoint?

I got confused because those UUIDs would show up when I set
"KernelExperimental = true". But that's because those UUIDs in the
audio plugin are dependent on "ISO socket" support which also gets
enabled when "KernelExperimental = true" is set.

Feel free to drop.
