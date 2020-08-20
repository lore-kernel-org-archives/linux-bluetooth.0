Return-Path: <SRS0=lMkY=B6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19876C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 11:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0437207BB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 11:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="aEqc3gBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHTLxh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:53:37 -0400
Received: from ns.omicron.at ([212.183.10.25]:55590 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbgHTLuz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Aug 2020 07:50:55 -0400
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 07KBoreh024837
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 13:50:53 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 07KBoreh024837
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1597924253;
        bh=8LwV4S/Ipp95OyTQw0O8bT2y9pn5XiWmHjkkmSbWO7M=;
        h=Subject:From:To:CC:Date:In-Reply-To:References:From;
        b=aEqc3gBdz7na16oqA/jVFagBleAf2dQA+kBHnvVMvgv990yWf630StEJVVFZG07E0
         CPAJTZLCVDaLW8XoAktXg3lUcvdTn8N49nNKwrk8C+8ExZEtkbof40xOP5dm52JdJk
         oqXynIyb/uPnnn7+kxKG9t5Z6mYOQKVr54g9+u6U=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id 44450A0053
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 13:50:52 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id 418DCA0072
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 13:50:52 +0200 (CEST)
Received: from EXC04-ATKLA.omicron.at ([172.22.100.189])
        by MGW01-ATKLA.omicron.at  with ESMTP id 07KBorLO003488-07KBorLQ003488
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL);
        Thu, 20 Aug 2020 13:50:53 +0200
Received: from marmar13.omicron.at (172.22.32.104) by EXC04-ATKLA.omicron.at
 (172.22.100.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 13:50:52 +0200
Message-ID: <fdb46a6be1ea6ae018d733126108aa8b84c1a08b.camel@omicronenergy.com>
Subject: Re: [PATCH BlueZ 1/2] src/profile.c: Allow the "Address Type" to be
 set
From:   Mark Marshall <mark.marshall@omicronenergy.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Thu, 20 Aug 2020 13:50:51 +0200
In-Reply-To: <CABBYNZLyv_B4CtnqtHXdKnyEKx0Xo8Ta=Y--sOEu+yokaV_U=A@mail.gmail.com>
References: <20200819150931.3005-1-mark.marshall@omicronenergy.com>
         <98fed7ef-1975-48ca-9ea3-1482d938a806@EXC04-ATKLA.omicron.at>
         <CABBYNZLyv_B4CtnqtHXdKnyEKx0Xo8Ta=Y--sOEu+yokaV_U=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.22.32.104]
X-ClientProxiedBy: EXC04-ATKLA.omicron.at (172.22.100.189) To
 EXC04-ATKLA.omicron.at (172.22.100.189)
X-FE-Policy-ID: 1:1:1:SYSTEM
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

On Wed, 2020-08-19 at 11:46 -0700, Luiz Augusto von Dentz wrote:
> Hi Mark,
> 
> On Wed, Aug 19, 2020 at 8:13 AM Mark Marshall
> <mark.marshall@omicronenergy.com> wrote:
> > 
> > This allows us to have profiles that use LE L2CAP connections.
> > ---
> >  doc/profile-api.txt | 10 ++++++++++
> >  src/profile.c       | 18 +++++++++++++++++-
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/doc/profile-api.txt b/doc/profile-api.txt
> > index 183c6c11a..8c7d0a06d 100644
> > --- a/doc/profile-api.txt
> > +++ b/doc/profile-api.txt
> > @@ -112,6 +112,16 @@ Object path        /org/bluez
> > 
> >                                         Profile features (for SDP record)
> > 
> > +                               uint16 AddressType
> > +
> > +                                       Allows the Address Type to be
> > +                                       selected, can be either
> > +                                       BDADDR_BREDR, BDADDR_LE_PUBLIC
> > +                                       or BDADDR_LE_RANDOM.  If an LE
> > +                                       address is selected and the
> > +                                       device is not found, the other
> > +                                       sort of LE address is tried.
> 
> This sounds like a good idea but aren't we missing the GATT service
> that actually exposes the PSM for the client to connect to? We should
> probably make RegisterApplication accept Profile1 interfaces in such
> cases so one can register both at the same time. Also note that this
> should be consistent with Device.AddressType which uses a string to
> not a uint16.

I didn't want to plumb this into the GATT stuff as it is not specified
how it would work.  I thought we would have to make up attribute UUIDs,
and I thought this was better left to user space?

I can use a string, yes, but I don't care about the difference between
public and private, just that it's LE, not br/edr.  I would treat
"public" as LE/public, "private" as LE/private and "value not present"
as BR/EDR?  Or should I make up a string for BR ("bredr"?)

> 
> > +
> >                         Possible errors: org.bluez.Error.InvalidArguments
> >                                          org.bluez.Error.AlreadyExists
> > 
> > diff --git a/src/profile.c b/src/profile.c
> > index 6961a107b..10850f305 100644
> > --- a/src/profile.c
> > +++ b/src/profile.c
> > @@ -677,6 +677,7 @@ struct ext_profile {
> >         guint id;
> > 
> >         BtIOMode mode;
> > +       uint8_t addr_type;
> >         BtIOSecLevel sec_level;
> >         bool authorize;
> > 
> > @@ -1173,9 +1174,16 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
> >         struct btd_service *service;
> >         struct ext_io *conn;
> >         GIOCondition cond;
> > +       uint8_t addr_type;
> >         char addr[18];
> > 
> > -       device = btd_adapter_find_device(server->adapter, dst, BDADDR_BREDR);
> > +       addr_type = server->ext->addr_type;
> > +       device = btd_adapter_find_device(server->adapter, dst, addr_type);
> > +       if (device == NULL && addr_type != BDADDR_BREDR) {
> > +               addr_type ^= (BDADDR_LE_PUBLIC | BDADDR_LE_RANDOM);
> > +               device = btd_adapter_find_device(server->adapter, dst,
> > +                                                addr_type);
> > +       }
> >         if (device == NULL) {
> >                 ba2str(dst, addr);
> >                 error("%s device %s not found", server->ext->name, addr);
> > @@ -1350,6 +1358,7 @@ static uint32_t ext_start_servers(struct ext_profile *ext,
> >                 io = bt_io_listen(connect, confirm, l2cap, NULL, &err,
> >                                         BT_IO_OPT_SOURCE_BDADDR,
> >                                         btd_adapter_get_address(adapter),
> > +                                       BT_IO_OPT_SOURCE_TYPE, ext->addr_type,
> >                                         BT_IO_OPT_MODE, ext->mode,
> >                                         BT_IO_OPT_PSM, psm,
> >                                         BT_IO_OPT_SEC_LEVEL, ext->sec_level,
> > @@ -1567,6 +1576,8 @@ static int connect_io(struct ext_io *conn, const bdaddr_t *src,
> >                 io = bt_io_connect(ext_connect, conn, NULL, &gerr,
> >                                         BT_IO_OPT_SOURCE_BDADDR, src,
> >                                         BT_IO_OPT_DEST_BDADDR, dst,
> > +                                       BT_IO_OPT_SOURCE_TYPE, ext->addr_type,
> > +                                       BT_IO_OPT_DEST_TYPE, ext->addr_type,
> >                                         BT_IO_OPT_SEC_LEVEL, ext->sec_level,
> >                                         BT_IO_OPT_PSM, conn->psm,
> >                                         BT_IO_OPT_INVALID);
> > @@ -2285,6 +2296,11 @@ static int parse_ext_opt(struct ext_profile *ext, const char *key,
> >                 dbus_message_iter_get_basic(value, &str);
> >                 free(ext->service);
> >                 ext->service = bt_name2string(str);
> > +       } else if (strcasecmp(key, "AddressType") == 0) {
> > +               if (type != DBUS_TYPE_UINT16)
> > +                       return -EINVAL;
> > +               dbus_message_iter_get_basic(value, &u16);
> > +               ext->addr_type = u16;
> >         }
> > 
> >         return 0;
> > --
> > 2.17.1
> > 
> 
> 

