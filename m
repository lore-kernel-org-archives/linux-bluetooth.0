Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E98C43332
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 17:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B55220836
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 17:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dryWtxQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgCTRsR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:48:17 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46840 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTRsR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 13:48:17 -0400
Received: by mail-ot1-f48.google.com with SMTP id 111so6760201oth.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oD1s/62V3eNmA4YhFFeTWGQmosH0t8Mycttzq4HVKb4=;
        b=dryWtxQLIxdZynC134t4AwwtaSuQxomxyK5UtRa/sdGhsfHxMNDy4Yn4TbmXJUfR4d
         DjJ5FQAVkQN0zYLXHgynMdpv5ZeuJJiUcWaZ9VzfvSgFXMxJSWTRTQmviL0ihxnwpEuo
         TMVMzXD5UlNIMvZlKfkWalRZ3xSPt5/URDgPmHbKhx+u/SBILvUYrIIShciRqjJpdRmc
         gRDdxVSCFw/g7HHqYa+uSXMWMnSj296aSoDX8S+Mqike8tiAKLpWIh/KbYds+tJfyDL2
         /c9VlVdKOgZzuGoXGfKTKWYyI3SAjeaRUDnkWb7yTdd+kbdqms4ta7pqmEtuqiV+vjov
         ABFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oD1s/62V3eNmA4YhFFeTWGQmosH0t8Mycttzq4HVKb4=;
        b=PAIOGFFWPUy2fQC6E2KQ1fEcGBXCNy+BRCpnqEwpwp2v+hNU4jqWuu/+uV28zkpVDR
         CGrUfGy030xFbzLbBuJnTYlCgkDEMvBR0Psi2YHAOD0NPOUDJ4rAKvGt7Ptf/6+1mEvG
         7v0tPmX8fToNxxUecWXRGMPW/oZLSSKyLv3DWPI9Y38hdvEnH5C5sVdb91fo2jKeB23H
         ibPoqT1LJuiCoYl7XqjM2hPqUfGLlPrveRnFrQrQLQfGCE8ypAv1xus3DVodzzgTJ5hu
         sl92kAYCZooQG8dfqT/doqVz7LIyJr67a8xSKwfDE/pLAIrvVxmjyEYF2lzGfzXdm/bC
         lavg==
X-Gm-Message-State: ANhLgQ06BHuOcUIEIZPtAHLJdiuSprQkLvQVlLT6FJ7T9J61Fqipp3AA
        hLfBc0dFSRjtQhaVhrrkT3YtTAp7cGxZEA3Y1dRVLg==
X-Google-Smtp-Source: ADFU+vvtrnG3Fflj5XZMnCK34zhrbk5SL9qyRU0bl8yYeE7cpjrU1dR3jbfeu+2pYpfK6y+JDWxPrg3eDrIF52vKfnM=
X-Received: by 2002:a9d:720a:: with SMTP id u10mr7335009otj.177.1584726494371;
 Fri, 20 Mar 2020 10:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191212172944.hgt6se2qz2hpsbo2@pali> <CABBYNZKCovNDcAaMMeYZgKAAq-8oz+pcs6xmS3A_Qt-28aoEbQ@mail.gmail.com>
 <20191212230314.g5gt6rxkphzpwucd@pali> <20200209130243.u4kpbj3cwhbdqa56@pali> <20200320130159.cm2shncjg5qo6xgh@pali>
In-Reply-To: <20200320130159.cm2shncjg5qo6xgh@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 20 Mar 2020 10:48:02 -0700
Message-ID: <CABBYNZ+nuBOH8gu1EJ4iF_r8v53g3rvVMcCm_Kt=5SXijhQY7A@mail.gmail.com>
Subject: Re: bluez: Export SDP "Remote audio volume control" item for HSP profile
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Fri, Mar 20, 2020 at 6:02 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Sunday 09 February 2020 14:02:43 Pali Roh=C3=A1r wrote:
> > On Friday 13 December 2019 00:03:14 Pali Roh=C3=A1r wrote:
> > > On Thursday 12 December 2019 21:42:27 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Thu, Dec 12, 2019 at 7:31 PM Pali Roh=C3=A1r <pali.rohar@gmail.c=
om> wrote:
> > > > >
> > > > > Hello!
> > > > >
> > > > > According to HSP 1.2 specification, section 4.7 Remote Audio Volu=
me
> > > > > Control, Support for remote audio volume control is optional, so =
an
> > > > > implementation may support none, either, or both of the controls =
for
> > > > > microphone volume and speaker volume.
> > > > >
> > > > > According to HSP 1.2 specification, section 5.3 SDP Interoperabil=
ity
> > > > > Requirements, bluetooth device with HSP profile announce via SDP =
"Remote
> > > > > audio volume control" field information if device itself supports=
 volume
> > > > > control.
> > > > >
> > > > > But currently I did not found any way how to access "Remote audio=
 volume
> > > > > control" SDP field in (pulseaudio) application as bluez does not =
export
> > > > > it.
> > > > >
> > > > > Can you please export this field? E.g. for HFP profile all option=
al
> > > > > features from SDP are passed to NewConnection() DBus method via
> > > > > fd_properties dictionary under Features key. Could you export tha=
t
> > > > > "Remote audio volume control" bit for HSP profile in Features key=
?
> > > > >
> > > > > And in same way, this needs to be handled also in RegisterProfile=
() DBus
> > > > > method.
> > > >
> > > > Do you have a use case in mind?
> > >
> > > Yes, checking in pulseaudio if remote side announce that supports rem=
ote
> > > volume control or not. And based on this switch to software volume
> > > level.
> >
> > Hello Luiz! Is it is possible to export this field?
>
> Hello, I have not got any answer to my question.
>
> So may I ask again how to retrieve SDP attribute 0x0302 "Remote audio
> volume control" for a remote bluetooth headset with HSP profile?
>
> It is really important as this attribute says if remote bluetooth
> headset supports volume control or not. In case it does not support, we
> need to switch to software volume control on host side.
>
> There is open pulseaudio bug that on some headsets it is not possible to
> control volume level and therefore pulseaudio needs to switch to
> software volume control.
>
> But without checking this SDP attribute 0x0302 this is not possible.

Not sure when I will have time to work on this one, btw can't you
actually detect this via some AT command, or the headset simple don't
respond to the AT command for volume control?

--=20
Luiz Augusto von Dentz
