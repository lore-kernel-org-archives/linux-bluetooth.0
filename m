Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F06C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 17:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1C521873
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 17:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJlhcz9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeLRRH4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:07:56 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40082 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeLRRHz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 12:07:55 -0500
Received: by mail-wm1-f49.google.com with SMTP id f188so2887459wmf.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Dec 2018 09:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MA8SyUOEcyuroS9hSjaU10Y3UPOUtpH5BVzkt5YN53M=;
        b=uJlhcz9aHrNFZ24DsqawSRdSscuxuKEMIzbJ+m1mRbUl8jjoHZ1F2q9QqPeGgJgNY/
         mN1f2AlOBukTYVkJcce7s8jUcU6/GMYC+2WaXh0p8s8dxyEg+paRn4Uxt+kuceJXo2uF
         7xSeCjAGRQhGuvvtzd22WPpvlqjRTY/v3V6aMd8Ot/sCC2IfZ292e9tV8mUXcuRrvpfL
         mYU3dLILl8Wb0Km0yzb8mqaKJ67zQ6czs7ad2gygEpOAqTLNWr1hEragtUeIPoxf7jMN
         jFzB45HRVVHs7LRIo3MmV3EEOU9+v1sWZgHeLBmANlOnZZ3O34JwVMklDqD+u5S3BwUR
         h+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MA8SyUOEcyuroS9hSjaU10Y3UPOUtpH5BVzkt5YN53M=;
        b=K+Aq2+TcgVskAVloQ4zP6egJILJCUVIuVu1b685iVZ/RHYcy5HXtQ7R+sMbbCMtQdB
         eudHcwB8AtVSo82hL78k0gSBkbH19pzkHzzy/SzcAH/kXwi/m7j9uefQHO6G9qQthaJx
         vX9XCoXS3Jql/dfLK5KkQI1liUBJWuC7vTQdt4ALCIL6q0UlHh01CyYOYFgPX59EN7mK
         OtPdNnxSF/t1IkKMv8o2UGRZuPkJoXY+8MkuN5jO1lq5FwRnMpnT+Lnj0aj7ShTmb4Db
         ubv8QPcJjeVuNAgRQlfLvIYXgBJDkJcBcyf+400TNseqBrTndyNruflYKfAVCmdQYsRF
         Vefg==
X-Gm-Message-State: AA+aEWYQhUQRhg2CQtgSRrquWNYiJQKOS25kAv1JJi1xScfZA9OwN5s4
        am9vc1K/wweWowNBzmTQVwp3M6nws5OdC55lrYY=
X-Google-Smtp-Source: AFSGD/XPXKEPdckkI9nxkmD9GDB/cqb3rAnxCL596tAqHNRCb8gDQy/Q16BG93RKz2S1i0SWrWtmPsxwf+TkH/DXF3Q=
X-Received: by 2002:a7b:c315:: with SMTP id k21mr3828104wmj.145.1545152872996;
 Tue, 18 Dec 2018 09:07:52 -0800 (PST)
MIME-Version: 1.0
References: <CACXRGxyMGt1zecvRmgoa5uuSwy4H9UpSECM0tOuC+uXGmQoGNg@mail.gmail.com>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E02FE@ORSMSX101.amr.corp.intel.com>
 <20181218110838.ollsqils5ci7cq4v@scytale> <DEBB0CAA2616974FAE35E4B560B9A4375D8E0B35@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4375D8E0B35@ORSMSX101.amr.corp.intel.com>
From:   Danielle Costantino <danielle.costantino@gmail.com>
Date:   Tue, 18 Dec 2018 09:07:41 -0800
Message-ID: <CAAVjN7f2bW5pB-1zB1wZPq-usnHeyoie5M5izQa1-Eqj+9Q2Cg@mail.gmail.com>
Subject: Re: Plans for meshd
To:     brian.gix@intel.com
Cc:     michal.lowas-rzechonek@silvair.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the work done on BLE Mesh but I have to agree with the
request to support GATT and BLE Mesh simultaneously on a single
controller. There are many applications that use GATT for higher
bandwidth point to point connections used in OTA update where the
overhead and functionality of mesh are not needed or wanted. Until
Mesh supports routed packets large SAR uploads flood the mesh network
and make OTA over mesh nearly impossible when the node count goes
above 4 relay nodes. Limiting the number of GATT nodes to 1 at a time
is not a problem for our application needs.

What I am unclear on is why it is not possible to support generic GATT
and PB-GATT + Proxy Client/Server on the same controller. If PB-ADV is
only used for provisioning then the time spent in ADV will not affect
steady state operations.

Thanks,
Danielle

On Tue, Dec 18, 2018 at 8:28 AM Gix, Brian <brian.gix@intel.com> wrote:
>
> Hi Michal,
>
> > -----Original Message-----
> > From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> > owner@vger.kernel.org] On Behalf Of Michal Lowas-Rzechonek
> > Sent: Tuesday, December 18, 2018 3:09 AM
> > To: linux-bluetooth@vger.kernel.org
> > Subject: Re: Plans for meshd
> >
> [...]
> > What I'm thinking about is having both modes of communication available=
,
> > even if the embedded device has just one Controller, as is the case wit=
h the
> > majority of off-the-shelf platforms.
> >
> > The reason we want/need both BLE/GATT and Mesh on the same node has a
> > lot to do with provisioning - at the moment we configure our networks u=
sing
> > a mobile app, meaning we need devices to support PB-GATT. This is becau=
se
> > Controllers present in mobile devices do not support Mesh natively, and=
 we
> > can't assume there is a GATT Proxy nearby, especially when configuring =
a
> > new network.
> >
> > > And I am not opposed to someone starting a project that will allow th=
e
> > > bluetoothd and meshd share a single controller and taking
> > > responsibility the reduced performance of each, but that is not work
> > > we have planned.
> > Ack.
> >
> > FYI, it seems we might be interested in making that happen.
>
> Maybe we should start with what you actually need.
> * Do you need GATT support only for the Provisioning procedure?
> * or also as a GATT proxy Server?
>
> There is a possibility...   We had an internal project where we supported=
 a GATT Proxy server without using the bluetooothd services at all.  For bl=
uetoothd, the result is the same:  The controller was entirely under the co=
ntrol of the mesh executable (it was not a daemon, but a proof-of-concept c=
ommand line tool).  But there are problems with that particular idea given =
the architecture of the meshd daemon:
>
> * I do not think we should try to support Proxy Client *at all*. The Prox=
y Client assumes a single Node, which defeats the purpose of having a daemo=
n at all.
>
> * Only a single node (or unprovisioned GATT server) can use GATT at a tim=
e.  The protocol does not allow for the multi-node architecture of the daem=
on.
>
> *  If we do try to put a GATT Proxy Server on a single controller impleme=
ntation, we may need a special node that loops back data received from the =
Mesh to the Gatt Client.
>
> * We will probably need to limit this special GATT supporting node to a s=
ingle node on the daemon.
>
> * We may want to make this a build-time option, because ADV handling will=
 probably be affected whether an existing GATT connection is established or=
 not, if it is possible that a GATT connection could be requested.
>
> * This affects the times when we can use Randomized, ever changing BD ADD=
Rs, and requires us to interleave connectable advertisements and "be connec=
table", which is not technically allowed with mesh network ADV packets.
>
>
>
>
> >
> > regards
> > --
> > Micha=C5=82 Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
> > Silvair http://silvair.com
> > Jasnog=C3=B3rska 44, 31-358 Krakow, POLAND



--=20
- Danielle Costantino
