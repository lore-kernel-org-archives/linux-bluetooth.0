Return-Path: <SRS0=NsPc=YL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC145CA9EA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 10:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F08721D7C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Oct 2019 10:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJjeYIKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407532AbfJRKz1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:55:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46861 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405188AbfJRKz0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Oct 2019 06:55:26 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so4800545oiw.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2019 03:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MopQ8usmB8KPj/8eXO3bonUHS5De8IGMTZRJVmlrCfk=;
        b=UJjeYIKYBYGfxnxWdKm/t4icpZjAXmarVWqjbIRGAL8U89fX3Gw0tMcVy0UTlYdZq+
         86kf52aG5w1faXFxFE2MQPBzjkmD6zbyzA0rfPW4qjnuWyzUlS28GXUkVEuIz6WFZjii
         jdPHyaF4h3rVs7NQkTvGzMV8gPAHMcEW+CCIffZPwOo8tfipUX/YGDLKfixL6RdVZ6WC
         acq+mxk2eOLEx0SziwPthSmO3LSCWj2rLrEaGIDTWPJxfpIIPQ60x9WenaTmoqO189T5
         Jl6tUuKl6lFyb7np/U4ABMQ0lhAfsW20FVxXFRZxZNCx/+FWcebJ1vtVhuuDJgQCaZcJ
         yz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MopQ8usmB8KPj/8eXO3bonUHS5De8IGMTZRJVmlrCfk=;
        b=LbrJVdv+Y330p7mIjRQPBsBEEyGJWmeKse8z8qhBHvM21zpv9OQMQkLLnfmyM41uDJ
         yuTfOZxZQQKeTUkpPDUXauIJQS5DI3CW10lW/CSw4O7XqHWm5GZ+qS6jzmwGAYSH29qC
         /onhWrt6sIxV16BTSzhe3tlVlYdls/+yOMoMevzt76MiltHm+fffUolwlZYc275y8b56
         ThDfZw03VNKU8fMvf1LgLnSXMCfKh9RrlWGsW39uvImKCYSyBUBA95T56qk6Oloy2Utg
         liBX36vW9cQcFj+7cyXrCqkoK0c1P9UPSl9MxhM7AOthfjvUJNrFIy7QE4wm21xxLptF
         VR7A==
X-Gm-Message-State: APjAAAWCQS3R06Lg+rOi75zl857R04tiGErhTgpgj8TeNMHhTEaIAgxq
        lQbYyQvDPaVOyWTpPoFvmwMwHUki9jnHKjGeq40=
X-Google-Smtp-Source: APXvYqxYVui2VVGP+1RvW7lS9YUDge0fwCStOT6UKzGxJzW9UAc6T17hPBI+F+GThM15CAZiIFge5Rst+D2NFIXnx50=
X-Received: by 2002:aca:4584:: with SMTP id s126mr7513598oia.21.1571396123935;
 Fri, 18 Oct 2019 03:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191003181855.GF28704@reaktio.net> <20191006100503.fsbttcschr6wgsdq@pali>
 <CABBYNZLS4MMxJ=gQED-BVfn81D0bvx8aLw5OO3tNmXAnWeA57Q@mail.gmail.com>
 <20191006120245.tkrooh45q7irtm6l@pali> <20191007143307.ez6g466afu3trlxn@pali>
 <CABBYNZ+2CGn2rONg+Tpdh9vr7E40_SFFT4Mmru2vQw7MKHTFjQ@mail.gmail.com>
 <20191008103333.rqn2btlkwtcrpouo@pali> <CABBYNZKKUf6-FPBEGjuC5GbsNzNsDLy7LgCHxqiW_g98BaX+QA@mail.gmail.com>
 <20191009131921.ysl3ianpv5e4m677@pali> <20191017095957.cce7jzejvn76kwkc@pali> <20191018083731.GJ28704@reaktio.net>
In-Reply-To: <20191018083731.GJ28704@reaktio.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Oct 2019 13:55:10 +0300
Message-ID: <CABBYNZLnFYV12U+X--cZdoTXqLkwhTFo6U_KrX2+X_N=zLJG1w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] doc/media-api: Add RegisterApplication method
To:     =?UTF-8?B?UGFzaSBLw6Rya2vDpGluZW4=?= <pasik@iki.fi>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Oct 18, 2019 at 1:32 PM Pasi K=C3=A4rkk=C3=A4inen <pasik@iki.fi> wr=
ote:
>
> On Thu, Oct 17, 2019 at 11:59:57AM +0200, Pali Roh=C3=A1r wrote:
> > > > >
> > > > > So... what should applications expects and how they should implem=
ent
> > > > > above decision?
> > > >
> > > > Actually the decision should be based on the presence of
> > > > RegisterApplication method, if that exists then endpoint switching
> > > > should be supported as well, so has nothing to do the
> > > > GetManagedObjects API of the bluetoothd. That said RegisterApplicat=
ion
> > > > was not made experimental which kind makes 5.51 broken because it
> > > > would appear that it endpoint objects would be exposed but when in
> > > > fact there are not, anyway lets finally have the code to use this
> > > > interface and then we can remove the experimental flag from
> > > > MediaEndpoint.
> > >
> > > Ok, so can pulseaudio do following?
> > >
> > > Call RegisterApplication. If success then expects that codec switchin=
g
> > > is possible and via GetManagedObjects exports all available codecs.
> > > If RegisterApplication fails then fallback to RegisterEndpoint, expec=
ts
> > > that codec switching is not possible and so register only one SBC cod=
ec.
> >
> > Also can we solve this problem in bluez ASAP? Last released bluez
> > version is due to that non-experimental API broken and once application=
s
> > (e.g. pulseaudio) starts using this new API then A2DP without bluetooth=
d
> > -E would be broken.
> >
> > I would propose to remove experimental mark for codec switching API and
> > release a new bugfix version of bluez, so people would not use released
> > 5.51 broken version... which could prevent breakage of A2DP in future.
> >
>
> +1
>
> It would be nice to get bluez 5.52 released before 5.51 gets released by =
distros..

Just sent a patch marking these APIs as stable, when are we expecting
a new PA release btw?
--=20
Luiz Augusto von Dentz
