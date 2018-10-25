Return-Path: <SRS0=5QOG=NF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C94C46475
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA9820834
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 09:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSjWh1Pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA9820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeJYRwU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:52:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34838 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeJYRwU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Oct 2018 13:52:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id 14so8389636oth.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Oct 2018 02:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3MBTjg8hhszCapKoS0r/EmJHTy9miVwFeGX1GCjiE5A=;
        b=XSjWh1Pftr777Uu6ZSDBIabUa0nqb9UQfye2AU57pMHMTB9Hy/wQZE5hU8s4AhK897
         RCAHN3u+Nxd6pdaYob/SCzhUNDzT3wSY/ErOZDoAvQw1h3DxkBbxKRndqiOpxWNT/0Z4
         VCf/pWE/vgZzd2RaDtbzQFvl7rFO2wBYOQcHbno350VvmJG7evpwvNngJZ3p3w/gR9kH
         Bphc5lHAN1iG9o6+1Wq593Wn58NYIqAHcYLcMzzitTrdx1RV7KZRsFymLP/9RDvq0gIy
         LARJERdrZ00oEQ8L9+K/B8bqttcC/qv5iNuv0xB7fbAi+NIbr7PSuwbL5sS0+p7+xP1V
         td/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3MBTjg8hhszCapKoS0r/EmJHTy9miVwFeGX1GCjiE5A=;
        b=BErK58OsV/rbAeVy1HxpHcKrmlkO4ihJfyBWcFJXV0fp3K1Hv34HaEIX+k8KX2YcKV
         McsRGKndWcj07Sw2RVGVLhfUOYbjDLGSOTYbVtjZ13aTd5VuQ+1w91iy71HBAf1DXMX+
         1N5CGrt+E5+T//L83TYOXnOWes9SfGR+e1ITLTaO4MNTsPx9qMhfgs6kua3CJwNdoGS1
         JN2zFblhmM2bO7J5twa7uSr7ycV30HD+DowlWWnFeieGXdaE9dCTTMhrxeL8+fR+tq2a
         hZDBs9o9PFxOUVpY6WDFg69QeCnNaUv5L7Ajg+gsuY6+2ivFsdwuO4mJYFP/b28ErLeU
         cs1A==
X-Gm-Message-State: AGRZ1gKX7E4+FUP9/Y2XCxtMhGPrrqj7E+4cvRniRZ5pEVKhhpj1IVE/
        yc3Y/SGYMjZBXg0WENvfuzchnBmiKGKHrhbeXS69CySb
X-Google-Smtp-Source: AJdET5fwOc783cwgw23MwifdNTkEVPI+ZN71bTiSflJEJuF3CL4kQD3Mc0MjJgNRNJUHnhY8x5Zk122qVFnTCcbuQq0=
X-Received: by 2002:a9d:141:: with SMTP id 59mr813895otu.52.1540459226427;
 Thu, 25 Oct 2018 02:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181025004210.177441-1-yunhanw@google.com> <CALvjcs83c2B0aq7Vz8WU4DC=ikQfB5W_XfYh+S_rkydi=6agMw@mail.gmail.com>
In-Reply-To: <CALvjcs83c2B0aq7Vz8WU4DC=ikQfB5W_XfYh+S_rkydi=6agMw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 25 Oct 2018 12:20:14 +0300
Message-ID: <CABBYNZ+5i=tv-dcnMr+21D28NZL9ayWVTLkC8DfWQA9jZUWXQg@mail.gmail.com>
Subject: Re: [PATCH] gatt: Fix double att_disconnected issue on disconnection
To:     Yunhan Wang <yunhanw@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yunhan,

On Thu, Oct 25, 2018 at 4:47 AM Yunhan Wang <yunhanw@google.com> wrote:
>
> Hi, Luiz
>
> I am observing the multiple crashes when doing BLE disconnection using
> latest bluez master..It looks like the two att_disconnect are
> triggered from your last gatt commit.. Please help take a look at this
> workaround and comments.. the better solution might be to figure out
> how to handle the disconnection along with random address and public
> address together regarding the previous issue, Gatt: Subscriptions are
> not cleared after disconnection from a temporary device

Ive pushed a similar fix, it should remove the handler before calling
att_disconnected.

> Thanks
> Best wishes
> Yunhan
> On Wed, Oct 24, 2018 at 5:42 PM yunhanw <yunhanw@google.com> wrote:
> >
> > When BLE disconnection happens, att_disconnect is triggered from two lo=
cations, the new added location is gatt_server_cleanup, it would cause seve=
ral blueetoothd crashes. This bus is introduced from commit 634f0a6e1125af8=
d5959bff119d9336a8d81c028, where gatt fix, gatt subscriptions are not clear=
ed after disconnection from a temporary device with private/random address.=
 In order to workaround this issue, btd_gatt_database_att_disconnected can =
only be triggered when address type is random, and for others, it can conti=
nue to use original disconnect code path.
> >
> >     crash 1
> >     Program received signal SIGSEGV, Segmentation fault.
> >     queue_remove (queue=3D0x30, data=3Ddata@entry=3D0x555555872a40) at =
/repo/src/shared/queue.c:256
> >     256     for (entry =3D queue->head, prev =3D NULL; entry;
> >     (gdb) backtrace
> >         at /bluez/repo/src/gatt-database.c:350
> >         at bluez/repo/src/shared/queue.c:220
> >         at bluez/repo/src/shared/att.c:592
> >         at bluez/repo/src/shared/io-glib.c:170
> >
> >     crash 2
> >         at bluez/repo/src/shared/queue.c:220
> >         at bluez/repo/src/shared/att.c:592
> >         at bluez/repo/src/shared/io-glib.c:170
> >
> >     (gdb) print state->db->adapter
> >     Cannot access memory at address 0x61672f6269727474
> > ---
> >  src/gatt-database.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/src/gatt-database.c b/src/gatt-database.c
> > index 783b692d5..2f0eb83b5 100644
> > --- a/src/gatt-database.c
> > +++ b/src/gatt-database.c
> > @@ -3365,6 +3365,8 @@ void btd_gatt_database_att_disconnected(struct bt=
d_gatt_database *database,
> >
> >         addr =3D device_get_address(device);
> >         type =3D btd_device_get_bdaddr_type(device);
> > +    if (type !=3D BDADDR_LE_RANDOM)
> > +        return;
> >
> >         state =3D find_device_state(database, addr, type);
> >         if (!state)
> > --
> > 2.19.1.568.g152ad8e336-goog
> >



--=20
Luiz Augusto von Dentz
