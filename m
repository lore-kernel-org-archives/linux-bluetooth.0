Return-Path: <SRS0=LC31=TQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68DC04AB4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 07:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96FE2082E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 May 2019 07:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQsdm4ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEPHdH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 May 2019 03:33:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35816 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPHdH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 May 2019 03:33:07 -0400
Received: by mail-oi1-f195.google.com with SMTP id a132so1806253oib.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2019 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svQHTXQHzreah5koEal6PCFwkcQLPQzHsdn/FKRnsME=;
        b=hQsdm4iryh2qHQgVl7FH/J2oN8JZAG/+ccjKbSD35xP0YKpXJSZS3Bb091JadTIxtc
         wp4mnPiC9+XJtHvi1i0e5GGu+xzubdStjZFnxPUGS/93GNDnfQ7H+1yvWQzvrN8jzCJL
         kmbmT07ZsrJMoJidG/bc8NoVDPk8OEvxFV0cb6XzVk4mKxK1VI6pgcSgIPzsBvY9Yrom
         tXKCssYx+Lzd2/MuJPjYqCuHc6VPeAJr5p5KhMB+3yC3M+SccnMxbuuh5moRv4P3x54z
         cwwBvJIF7F+IX/IDRyECvDhYMPRFYzLmXckwhBmpqiTmy+l7dQFx1gVk8MqTiLXb99ME
         bejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svQHTXQHzreah5koEal6PCFwkcQLPQzHsdn/FKRnsME=;
        b=c7zMMPITbk34maGFr7FrZ4to8LpWfBV4A+7wsjVSBqRupAHIpQjEXY74CohiRsu3Y9
         Ru9ANQtD6Um9BA0VuueYxhwJ5SusZj3bDtVap8wIbgWczG2Bo4DyV6RBLfJc+DySueRK
         yFttj+gQCmv3JDjUD+ABr25fT5srY9qoKNvfC2szyg2t1hCA5PNOxj+nmRPeOi830O9Q
         VMDDGn83Q06moL8txt5z8Dg/I5Q1kOphncOuDZ/Ik+q2ROHbroGTVGFCkfDKIgjZozuE
         LQqBvAFWsX0ZhOQBrNIpxCv+iA3+Ld/j50+AuZf1ecwPdr2q1CGpNEXFsqf1QXizPaxb
         UuLA==
X-Gm-Message-State: APjAAAXhfMN7CLkaXHU9275hpp2KV3rXKcDEl5n1nQSaS8zxOj+xC/2G
        EEVUbIZL50Jl2nQ2vAnkUIDexizrUMSnogyuibI=
X-Google-Smtp-Source: APXvYqxq9zs1yRulJLQ++u9Y7a6xKaIlxvKguAXpw+hGxlBUOlGfa36LA4292cmaxyMS8TtV21OTm4xRIcmATlIB/Es=
X-Received: by 2002:aca:5189:: with SMTP id f131mr1161290oib.8.1557991986112;
 Thu, 16 May 2019 00:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <33a1f056-12c2-1aaa-4172-ea1fba341428@phytec.in>
 <a133a8d46955c9c3d248cf06e52d445a82ed7621.camel@ewol.com> <0ec70f654132923489ee2603fe9ac885ac547830.camel@ewol.com>
 <CACumGOKJckqHDsB==1MwNFOtZVtduRPZhTmtbQT-fTaztuv+dQ@mail.gmail.com>
 <4fa544fa04d907de54ab713eb0d0901593d2687e.camel@ewol.com> <c39d487d-7e7f-b4d2-17a8-fe8e9d293159@phytec.in>
In-Reply-To: <c39d487d-7e7f-b4d2-17a8-fe8e9d293159@phytec.in>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 16 May 2019 10:32:53 +0300
Message-ID: <CABBYNZKTdC1VQK0sfRwummypkPG1cr4Txp2T=z9g25=H2jVioA@mail.gmail.com>
Subject: Re: Issue with mesh provisioning.
To:     Shaik Mahaboob Nazeer <nazeer.m@phytec.in>
Cc:     Steve Brown <sbrown@ewol.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Jonas Remmert <j.remmert@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Steve,

Let me know when you have a patch.

On Thu, May 16, 2019 at 9:15 AM Shaik Mahaboob Nazeer
<nazeer.m@phytec.in> wrote:
>
> hi Steve,
>
> Yes with this changes it is working as expected.
>
> Best Regards.
>
> On 15/05/19 17:42, Steve Brown wrote:
> > Hi Luiz,
> >
> > Would this be an appropriate fix.
> >
> > It seems to solve the problem.
> >
> > diff --git a/tools/mesh/gatt.c b/tools/mesh/gatt.c
> > index 2269a20cf..0a942d4eb 100644
> > --- a/tools/mesh/gatt.c
> > +++ b/tools/mesh/gatt.c
> > @@ -415,8 +415,11 @@ static bool sock_read(struct io *io, bool prov, void *user_data)
> >       msg.msg_iovlen = 1;
> >
> >       while ((len = recvmsg(fd, &msg, MSG_DONTWAIT))) {
> > -             if (len <= 0)
> > +             if (len <= 0) {
> > +                     if (errno == EAGAIN)
> > +                             break;
> >                       return false;
> > +             }
> >
> >               res = buf;
> >               len_sar = mesh_gatt_sar(&res, len);
> >
> > If so, I'll submit a patch.
> >
> > Steve
> >
> > On Wed, 2019-05-15 at 13:48 +0300, Von Dentz, Luiz wrote:
> >> Hi Steve,
> >>
> >> That specific patch doesn't change the meshctl, the following one
> >> does:
> >>
> >> commit d6eec1b67d6d9e3336b7e3cd8f655baf408d864a
> >> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> Date:   Mon Nov 19 17:35:54 2018 +0200
> >>
> >>     meshctl: Switch from write to sendmsg for Acquire*
> >>
> >>     Use sendmsg with MSG_NOSIGNAL to prevent crashes involving
> >> SIGPIPE.
> >>
> >> Not sure what is the problem with that since we just switch from a
> >> pipe to a socketpair.
> >>
> >> On Wed, May 15, 2019 at 1:01 PM Steve Brown <sbrown@ewol.com> wrote:
> >>> On Tue, 2019-05-14 at 15:25 -0400, Steve Brown wrote:
> >>>> On Tue, 2019-05-14 at 14:50 +0530, Shaik Mahaboob Nazeer wrote:
> >>>>> hi,
> >>>>>
> >>>>> -> We tried Zephyr Mesh onoff example on nrf52 eval kit to test
> >>>>> the
> >>>>> Mesh Functionality.For provisioning of the node
> >>>>>    we are using meshctl, built from the latest current master
> >>>>> of
> >>>>> the
> >>>>> bluez source.So during the provisioning of the node when we
> >>>>>    start the "meshctl" and run the "discover-unprovisioned on"
> >>>>> we
> >>>>> are
> >>>>> able to get the Device UUID for the provisioning.
> >>>>>
> >>>>>    Later when we try to provision the node using the "provision
> >>>>> <UUID>" command it initiate the provision and does not wait
> >>>>>    for the user to enter OOB .You can find the log as below.
> >>>>>    /*******************************************/
> >>>>>
> >>>>
> >>>> --- snip ---
> >>>>
> >>>>>   /**************************************/
> >>>>>
> >>>>> Could you elaborate a little on the status of the current
> >>>>> master of
> >>>>> bluez in regards to BLE mesh, is it usable or should we look to
> >>>>> older
> >>>>> versions?
> >>>>>
> >>>>> Do you know if there is a common issue while provisioning of
> >>>>> the
> >>>>> node
> >>>>> with the current master and
> >>>>> is there anything that need to be configured before
> >>>>> provisioning?
> >>>>>
> >>>> I get the same results.
> >>>>
> >>>> I check out 48a2c3db1ccff28a615fac56066ca7d721f98d0a
> >>>>
> >>>> That was the last time I used meshctl.
> >>>>
> >>>> It requests an oob string and completes provisioning.
> >>>>
> >>>> Steve
> >>>>
> >>>
> >>> I bisected to
> >>>
> >>> commit 91df85690cc1943e46ef90561dd1ac0d673ee3d7
> >>> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> Date:   Mon Nov 19 15:36:15 2018 +0200
> >>>
> >>>     client: Switch from write to sendmsg for Acquire*
> >>>
> >>>     Use sendmsg with MSG_NOSIGNAL to prevent crashes involving
> >>> SIGPIPE.
> >>>
> >>>
> >>>
> >
>
>


-- 
Luiz Augusto von Dentz
