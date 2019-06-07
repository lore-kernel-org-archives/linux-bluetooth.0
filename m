Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58B2C2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 13:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815F0212F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 13:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlXB5YbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfFGNEj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:04:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54343 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfFGNEi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 09:04:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so2005080wme.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3rbZXts+Y3CdM5ONJ6UlOJ71XRjHHnk1/HI9FFjhMBA=;
        b=DlXB5YbXFXsPvpNSfdRT5z6nFjJ4bAXC9LJWZQL90+RlL0shewhMS6T7fSIdW2ml/m
         VhYk/i59pQrv6LzLzT3dxLVbMYNkwOhcdi5rNSlNK32p/LRPj1l+/G8iaSFlVaNPbJjs
         2q4uxVgZ1LUNfTyR6l4H/nv7L7OU3YwjNyuVnZRUcLQrS7areuGCki9bN2Sjdlx0Guej
         ZpMRYl2a/czqj4f7Gc7MDJxDp9tKFFpa8uYbrUTHVCZdp9SzL3KlS0Wn4rPYs8TDZfO5
         PuYXLB7mSmf9OpgD45M5R8e8XxnYkpNApafTE8V+tU6/0+HDTy/SqxxDyz79gYsBO6Xg
         KN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3rbZXts+Y3CdM5ONJ6UlOJ71XRjHHnk1/HI9FFjhMBA=;
        b=fKxFATLZ0SFSbtKNtSK7nVldu5S9tttr5UioDpYNB2D/QpxXRMHkxgLecwKL7SqqFe
         FHtdEkzmkZYbg8sfRq/osZSb2S3DTIb5xm6Coeo7UtK6bI0arE/fzXhIBqJKBpHWPipk
         Txgao9EDB/iQUpo/v3ZJRUe7PZ9BPxr5BkaqsLPOn2dpnU+zljMbC/CyTP+ntIgGHKOY
         3HmCepjpIxTU+J7vgQlUeYAyGBw6WecefhT2LCR4D7/jtcPQDPHC6QdvwfdIbfQrVJ2w
         hL/gi7UvlD9q8z71zAnWTlqlfVDli94TVPbwy0z7h3HvTqyVNnChOj64T67Me7WA8DKh
         baEw==
X-Gm-Message-State: APjAAAV0m90bli9zUWo1DC+Smonq9Z7mMk79NYUzp3JZ91p7mwGhV2Cv
        G+k5ZzmPMFYjpTRSjwuF/pE=
X-Google-Smtp-Source: APXvYqx3l3q3RhkuU6pBqvIOZ6830A3vnyRfueypbReJdu9x2eNDqbDk0LpVi0Tj2e6A6DmK8jFd1g==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr3938932wmf.34.1559912676064;
        Fri, 07 Jun 2019 06:04:36 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f24sm2083326wmb.16.2019.06.07.06.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 06:04:35 -0700 (PDT)
Date:   Fri, 7 Jun 2019 15:04:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] a2dp: Reword LastUsed
Message-ID: <20190607130434.lw5vfapnkflp65cq@pali>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
 <20190506124310.19151-6-luiz.dentz@gmail.com>
 <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
 <20190506130225.smlwgw5cgvhdb35v@pali>
 <20190507085255.zplj5ddopl3z5n2v@pali>
 <CABBYNZJz1jXF6DtTerwZz4cpKYpzDP7TyO1fjnYTyEJ026M3LQ@mail.gmail.com>
 <20190507185740.ywubjwgm7mer7txf@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507185740.ywubjwgm7mer7txf@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 07 May 2019 20:57:40 Pali Rohár wrote:
> On Tuesday 07 May 2019 13:13:17 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > 
> > On Tue, May 7, 2019 at 11:52 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > On Monday 06 May 2019 15:02:25 Pali Rohár wrote:
> > > > On Monday 06 May 2019 15:46:03 Luiz Augusto von Dentz wrote:
> > > > > Hi Pali,
> > > > >
> > > > > I hope this fixes the problems you have been seeing, it should at
> > > > > least take care of the issues with wrong order of SelectConfiguration
> > > > > and restoring the exact same endpoint used last time.
> > > >
> > > > Hi Luiz! Great, this should make bluez to be more deterministic.
> > >
> > > Hi! Now I looked at it and in cache file I see:
> > >
> > > LastUsed=04:01
> > >
> > > What would happen when A2DP application (e.g. pulseaudio) register DBus
> > > endpoints in different order? Or e.g. do not register some endpoints due
> > > to missing codec librayr (aptX).
> > >
> > > I guess that in this case LastUsed information stops working...
> > 
> > It would most likely fail at SelectConfiguration and then try with the
> > other endpoints.
> 
> Yes, that is truth. My point is just about validity of LastUsed value.
> 
> > >
> > > Should not be there stored rather dbus endpoint name identifier?
> > 
> > Originally I tried to avoid having the local endpoints because of this
> > problem, but now that SelectConfiguration can fail it shouldn't really
> > be a problem. At least with the seid if you have a system that didn't
> > changed the order or number of endpoints it will keep working as
> > expected,
> 
> But this may happen. And such thing is allowed. Any application,
> including unprivileged can register own new endpoint to bluez. It is not
> specific to pulseaudio. And in my opinion central bluetooth daemon which
> expose such functionality should be robust and be prepared that
> application on "other side of dbus IPC" does not have to be well
> behaved.
> 
> > if we choose to encode the D-Bus connection, etc, as soon as
> > PA is restarted, the system is rebooted, etc, the D-Bus connection may
> > have changed making the stored values in LastUsed invalid.
> 
> That is truth.
> 
> My idea was to encode just dbus path of local dbus endpoint. We can say
> (in IPC API) that client application should preserve dbus path for one
> same endpoint between dbus daemon / computer restarts. Because otherwise
> functionality of "choose last used endpoint" would not work.
> 
> This is less strict requirement and current one (that registration order
> of all existing applications in system must be same across reboots),
> less error prone and still should be easily implemented.

So what about this my idea? Is there anything wrong with such thing?

> > Anyway
> > chances are the LastUsed is only invalidated if you update PA, in
> 
> Or once we include support for dynamic codec loading (based on encoder
> library presence in system), installation of any irrelevant application
> may bring a new supported codec and therefore a new endpoint. So codecs
> can become in any order...
> 
> Or another example, when different application (not PA) register also
> some endpoint.
> 
> > which case there could be new endpoints or a change in their order and
> > package can also provide a script to clear the LastUsed if that
> > happens, but then again LastUsed setting does not actually store the
> > configuration just the endpoint so SelectConfiguration has control
> > over the configuration.
> 
> Yes, whole thing is only about initial codec selection. In the worst
> case user would have pre-selected different codec as which was last
> used.
> 
> But I think that storing dbus path of endpoint as described above should
> be more reliable solution.
> 
> Applications (e.g. PA) talking to bluetooth daemon does not register or
> request directly SEID. Instead they register their dbus path and dbus
> connection and bluetooth daemon later allocates SEID for that path.
> 

-- 
Pali Rohár
pali.rohar@gmail.com
