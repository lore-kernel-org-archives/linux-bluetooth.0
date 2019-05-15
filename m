Return-Path: <SRS0=OL4k=TP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F18C04E53
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 10:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E612084F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 10:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NHRogkKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfEOKsf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 May 2019 06:48:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41491 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOKsf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 May 2019 06:48:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so2054263lja.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2019 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8Qkwzk2vtu7b/SV1BcLiIIrN+8gyAJJvJsm58+0Pzs=;
        b=NHRogkKcGMS0gLmCGBEZju53lVZ56bMBenofzXy34/0B9dno94504d6HPGr3GQ/lcn
         Km7ICeg1p+qQz3cLBNnEehFKEJo3Dv6BUqdfMFn0NlAJl0fGJrb9gUVL7k2dp9GzCpZN
         Wlf573PeUXCJNS2AUusmNK1+Nnd+NHIyyjz6fGc0MkMgSR3UVAw4zVj3O3nZR1M2luO4
         RAbtL3Fm4MX0uUTvnxB2TpFRgRnp5blA/c1YtR+ZPw/pXprdPz/ONcBmJb8UacrOtC/0
         wvzOgK743eCTb9zQ9fmLD+wNeO+9CoJEJ9ZTEDZmLddDwdLeoKnMCQP8QhJGo4rypHg+
         PqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8Qkwzk2vtu7b/SV1BcLiIIrN+8gyAJJvJsm58+0Pzs=;
        b=IoZ7oVbLvOF8ZVjwLck/d3ArcAxKeQLOszvZHBG0Dt6mtEdeXMIC3TjE9J9s3tlHCC
         ES59ilbxK+i5gHZVzv4OCMOkVufAvPnBXalaIErnG1uXjSwatIFh1vBkG4a7u5ggW5l5
         NCTETKfztmoGp80UV1Yg18OauUx8k4lGmblMd9C4YBB3oJAMOG66DXjv3M2XF5pFX6Xt
         8BVjgHKI/0Yt+3QB8Rk+XeG9+x3093rLafF5xQ3qcJ77LT+yN019NYcpUkCBNLGfYTlt
         o10pn1jcxvJeL2KS+rX5NVyBMBzcqXZ7c1sT1WxjWZf0asqzYCzPLsjYDTzWu0qjv8DE
         o+MA==
X-Gm-Message-State: APjAAAXLEMgkRyFco1SgcK1lT11ge3gqpO6qx7SAQmTtT3qhQBSGczx+
        2OZTJ6xwbLTCn1jN5J3867/7Ym8cupv0vEdaR0jrXw==
X-Google-Smtp-Source: APXvYqxVUGLQmNnO4+3MaRlvdaaK49u5Rm4cAFbFAgDN5pTXGwx07mVAOs7/EW2EGi0A5o0B41NrAMKD0SOUA0CLWpk=
X-Received: by 2002:a2e:91c6:: with SMTP id u6mr2281642ljg.143.1557917313824;
 Wed, 15 May 2019 03:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <33a1f056-12c2-1aaa-4172-ea1fba341428@phytec.in>
 <a133a8d46955c9c3d248cf06e52d445a82ed7621.camel@ewol.com> <0ec70f654132923489ee2603fe9ac885ac547830.camel@ewol.com>
In-Reply-To: <0ec70f654132923489ee2603fe9ac885ac547830.camel@ewol.com>
From:   "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date:   Wed, 15 May 2019 13:48:21 +0300
Message-ID: <CACumGOKJckqHDsB==1MwNFOtZVtduRPZhTmtbQT-fTaztuv+dQ@mail.gmail.com>
Subject: Re: Issue with mesh provisioning.
To:     Steve Brown <sbrown@ewol.com>
Cc:     Shaik Mahaboob Nazeer <nazeer.m@phytec.in>,
        linux-bluetooth@vger.kernel.org,
        Jonas Remmert <j.remmert@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steve,

That specific patch doesn't change the meshctl, the following one does:

commit d6eec1b67d6d9e3336b7e3cd8f655baf408d864a
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Nov 19 17:35:54 2018 +0200

    meshctl: Switch from write to sendmsg for Acquire*

    Use sendmsg with MSG_NOSIGNAL to prevent crashes involving SIGPIPE.

Not sure what is the problem with that since we just switch from a
pipe to a socketpair.

On Wed, May 15, 2019 at 1:01 PM Steve Brown <sbrown@ewol.com> wrote:
>
> On Tue, 2019-05-14 at 15:25 -0400, Steve Brown wrote:
> > On Tue, 2019-05-14 at 14:50 +0530, Shaik Mahaboob Nazeer wrote:
> > > hi,
> > >
> > > -> We tried Zephyr Mesh onoff example on nrf52 eval kit to test the
> > > Mesh Functionality.For provisioning of the node
> > >    we are using meshctl, built from the latest current master of
> > > the
> > > bluez source.So during the provisioning of the node when we
> > >    start the "meshctl" and run the "discover-unprovisioned on" we
> > > are
> > > able to get the Device UUID for the provisioning.
> > >
> > >    Later when we try to provision the node using the "provision
> > > <UUID>" command it initiate the provision and does not wait
> > >    for the user to enter OOB .You can find the log as below.
> > >    /*******************************************/
> > >
> >
> > --- snip ---
> >
> > >   /**************************************/
> > >
> > > Could you elaborate a little on the status of the current master of
> > > bluez in regards to BLE mesh, is it usable or should we look to
> > > older
> > > versions?
> > >
> > > Do you know if there is a common issue while provisioning of the
> > > node
> > > with the current master and
> > > is there anything that need to be configured before provisioning?
> > >
> > I get the same results.
> >
> > I check out 48a2c3db1ccff28a615fac56066ca7d721f98d0a
> >
> > That was the last time I used meshctl.
> >
> > It requests an oob string and completes provisioning.
> >
> > Steve
> >
>
> I bisected to
>
> commit 91df85690cc1943e46ef90561dd1ac0d673ee3d7
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Mon Nov 19 15:36:15 2018 +0200
>
>     client: Switch from write to sendmsg for Acquire*
>
>     Use sendmsg with MSG_NOSIGNAL to prevent crashes involving SIGPIPE.
>
>
>
