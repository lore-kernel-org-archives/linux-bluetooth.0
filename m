Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1764C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844062087F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQLVh9oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfAHQvt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:51:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36016 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHQvt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 11:51:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so4772345wrp.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 08:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4dnB0TkC2zw1e9lS6cd8hHYdvZcBURz95EB3rUHz/zI=;
        b=RQLVh9oRAGYyD9809x44Mx+G7zeCAQhHlXE3yXGcmNaP3se983o5pDHw0nntFqAkFR
         mKQMehoqLuH1AgvqZxl6iJdwsjB0Xvt/XTnH8GakKD39Ac9VzmEhUKJYEWiSvQ8NwEAq
         tiEcIlcNuzEpANCxXRNPr7DBF82xbsMyRYoncvsEDun8bUjxjScXcFguA5Gd+YLNFwsm
         YY1Gguym+Y81Y+mtWDByXJOHaKlhK4HvnV3sxMe68o3SRa74SjX7bIplAD0ZOJkPmqQq
         QEhQjWDwHIRy4aArkzQIcpeG8Us95S4d2hhP2RvNfn97mGxUYoASfx40ma21H9lcRLqi
         YjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4dnB0TkC2zw1e9lS6cd8hHYdvZcBURz95EB3rUHz/zI=;
        b=ohUvWe/HjblTCB3y1gICCf/iLuvnf+Ai5tAEODCHHKkO6qNRVdpwyW9/wAaDCiOatF
         MozmDGqmHailEDlGU5aSd7FJWF/xuRD4x52fNTm4XRw1XD0thEaD9lNwnzs4ALjH51Wo
         tTF9MBdgBt7dj86tom8ssiQW/U45K3swOUQbcKFyRzcKHWghkjDt46l1T5PL7OtVIoGD
         PK0DpPkH/fnfQkqb4bh4+h5SgQ5HeZRtQkrfm58Vh/Z+dUy4zsY6DJEWM8AS6fZc+SwP
         BlP0rDFYko7GjP7RhNrBG17HSa/ktfrASJo4JR6JtawpQrGoRhgL49EbpSVuZPYxKDF+
         brkg==
X-Gm-Message-State: AJcUukdEPmBwWxiDWqpW2icWceXMU6bspgwNJ1eb234euUBbL6uiTWHS
        e/LqpbJO/D+zaa6lIK4X10w=
X-Google-Smtp-Source: ALg8bN5i26F6bKT5vXTuRu2+UmQzCkWDZtDJG9dNR6NGLoWzXdWKa1CctyhAjm/B2YjXNoCtbfJzng==
X-Received: by 2002:adf:f449:: with SMTP id f9mr2095108wrp.40.1546966306873;
        Tue, 08 Jan 2019 08:51:46 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r69sm14265746wmd.4.2019.01.08.08.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 08:51:46 -0800 (PST)
Date:   Tue, 8 Jan 2019 17:51:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20190108165145.yiqjwvg52owvdybr@pali>
References: <20180711082352.oo6srapfnol5nkxq@pali>
 <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali>
 <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net>
 <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
 <20181229130818.jdcpwlpyoyhdqlf3@pali>
 <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zfvr76rlrl5jfc3e"
Content-Disposition: inline
In-Reply-To: <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--zfvr76rlrl5jfc3e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 January 2019 13:44:24 Luiz Augusto von Dentz wrote:
> On Sat, Dec 29, 2018 at 10:08 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > And forth thing, people lot of times listen music and their music is
> > stored in some lossy compression codecs (MP3, AAC, ...). A2DP supports
> > of these codecs and pulseaudio has already support for pass-through
> > different codec payloads to sound card (if sound card driver support
> > is). So this would allow us to e.g. pass-through MP3 or AAC data to
> > supported headset without need to decode and encode again. Pulseaudio in
> > this case can take care for switching from "better A2DP codec" to AAC
> > when input application source is already in AAC; and then back to that
> > previous "better A2DP codec" after AAC playback file finish.
> >
> > I think that similar technique is already used in Apple products which
> > propagates AAC format.
> >
> > Therefore I do not think switching codec is some king of workaround or
> > hack, but fully valid use case.
>=20
> Except that we can't do that because we cannot garanteed there wont be
> other sources active e.g. system notifications, etc, so in practice
> complex/expensive codecs such as MP3 and AAC are hard to use since
> that would mean we would have to encode on the fly. Perhaps there we
> could have a setting for these type of codecs so the user would have
> to opt-in if he want to just listen to those files, though if they are
> using streaming services they normally decode on their own so AAC and
> MP3 endpoint are not that useful with the likes of youtube, spotify,
> etc.

IIRC pulseaudio has already API for pass-through of MP3 and AAC and at
one time can only one application send stream, so there are no system
notifications.

You can also see checkboxes for codecs which can be enabled for
pass-through for digital sound cards (e.g. HDMI output) in pavucontrol.

So I do not think that this is a problem. Bluetooth "A2DP card" in
pulseaudio can behave in exactly same way like existing HDMI AAC output,
which is already working.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--zfvr76rlrl5jfc3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXDTVHwAKCRCL8Mk9A+RD
UjGQAKCwvq1+oToFTUn5kiij9+HCan47wACgwil4ht/efwd84siQq0bw3CaWhh0=
=d7Mq
-----END PGP SIGNATURE-----

--zfvr76rlrl5jfc3e--
