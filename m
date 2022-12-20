Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65146C10F1E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Dec 2022 12:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiLTMaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Dec 2022 07:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiLTMaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Dec 2022 07:30:20 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF4138AB
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 04:30:17 -0800 (PST)
Received: (Authenticated sender: arthur@marmottus.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 301012000E;
        Tue, 20 Dec 2022 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
        s=gm1; t=1671539416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=jzwW8daCb4crSW17ytKkDU1gASutWgHilecLGlVLNsI=;
        b=DsBzgjGkdf3tKdE0fgMu2fUCT4msSI49Hew3SNg4SkUs11CqjyQUVm86aBqkksSnBRlEZ8
        KawXU88oJq2mKHHxMqAs+ccV5pOLiYw8R76MPV8BOhu3rQSy6SFVpz5Gd2MC7l1uzstHxH
        X1rY3TyaoZlYNpvS1nyDD2TxrZ8NcppJ9TYkfgom259JWd23MrW70/fU2XKF61cNEg5QOl
        ijXSAPLvreqSz5yv5UbTW9tMG8or74h8YLOPMNwVE2mB7xt3Vt4qSaJrsiTuaHhE+pcPya
        Na/HFOZmQoO70YJZl0Vqag/bUrPJ7ZOTAyKFK+U6AQCxcBHz5oLxNZjoJqM58Q==
From:   "Arthur Crepin-Leblond" <arthur@marmottus.net>
In-Reply-To: <CABBYNZ+qY1H5TFYGAuM4iLRqgBHAaip1F23=GtaajqRqg-d66Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Tue, 20 Dec 2022 13:30:15 +0100
Cc:     "Bastien Nocera" <hadess@hadess.net>,
        linux-bluetooth@vger.kernel.org
To:     "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
MIME-Version: 1.0
Message-ID: <483a-63a1ab00-45b-340fb6c0@10667613>
Subject: =?utf-8?q?Re=3A?= [PATCH BlueZ 0/1] Expose the disconnect reason over D-Bus
User-Agent: SOGoMail 5.5.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday, December 13, 2022 21:45 CET, Luiz Augusto von Dentz <luiz.d=
entz@gmail.com> wrote: 
 
> Hi Arthur,
> 
> On Mon, Dec 12, 2022 at 7:38 AM Arthur Crepin-Leblond
> <arthur@marmottus.net> wrote:
> >
> > On Monday, December 12, 2022 15:49 CET, Bastien Nocera <hadess@hade=
ss.net> wrote:
> >
> > > On Mon, 2022-12-12 at 14:32 +0100, Arthur Crepin-Leblond wrote:
> > > > Hello,
> > > >
> > > > I am trying to expose the device disconnect reason over D-Bus a=
nd the
> > > > most elegant way I found was to subscribe to the adapter notify=

> > > > callback that gives the reason as an argument.
> > >
> > > Any reason why this can't be a signal with the reason as an argum=
ent?
> >
> > I chose the easy path by copying the existing code for the device p=
roperties
> > that get updated like the "Connected" or "ServicesResolved".
> > I am not too familiar with BlueZ signals other than PropertiesChang=
ed,
> > InterfacesRemoved/Added. What would you have in mind?
> >
> > And apologies in advance, it's my first time submitting here, I do =
not have
> > an advanced knowledge of the BlueZ internals.
> 
> Can you explain what is the use case here? I hope it is not to
> reimplement something like the reconnect policy:
> 
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf=
#n281
> 
> 
> -- 
> Luiz Augusto von Dentz
 
 Hi Luiz,

No, nothing to do with the reconnect policy.
My device (a Raspberry Pi) is acting as a central and is losing randoml=
y
the connection with a device.
So, the use case is purely to be able to have information about the
disconnection. 

-- 
Arthur Crepin-Leblond

