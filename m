Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C79C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 23:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbiCVXpi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 19:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiCVXpf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 19:45:35 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692BD6435
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:44:06 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v35so36478521ybi.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9e/KJdvE36xdOKaE/9T1Re3oLvwqU/KuaFENdyQDGtc=;
        b=ByUMVxnxr2H+BLqzztt19HttNQUNCZCwydK0UAe9No+4ctoPWFIAHDWAsBBIa2NLNC
         1MO2yZajzOy1foW6RQDqE42ruehkUDjxsxUSgmkpeIPo/mRpdXtC4vtA5YkFdtsD/x2X
         w3BVoSvudq5XxQmm9G/FDAHG0AyuWA5adSSmhLqQw+aj49BViUq1BBEB4FeNjHtLGqo8
         WNMVH5AhYK3G3yvSgj4YIu9UP6sG7DHMq7hjosDG6wIz3S+ivKZo/+FmyR9bd3LYPAu5
         QF+Axchi6sgKY37SOU+09qvMiLa/7a11BpvqxYTSoBMZvBw/HeDtksYUGJvoEu9OpJ5/
         1jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9e/KJdvE36xdOKaE/9T1Re3oLvwqU/KuaFENdyQDGtc=;
        b=Y5/exBil9aJ1BggoZ2YlxDymBr/u6hAelH3nXEthowkMHPDb3dpfyfegNYuBU05iYP
         DK27GzTMrHFJ0EBs9d9zLnjoMBmIromXC50ShT00Vkq7yqDTerzBMcbyho02fiUmop0B
         nYOnafaX8+pV/nDNa4rwgFzILu1hfVkXtlGtE7zY+i3HBPaWQLjx6noMTdd4RGJDoS4D
         1hiOyw6KCcQyeZ8ejs8zFk3lFfXDI5yU4/sVLE0+nSkLxuYIuBSkasW1yd3UmiMTTDMB
         WdV51jArRHS72j7sNhxFfPbHnHpAlOv3v6wilnCnMWSaYVkMdwxiV6Rx0fekogmIuQna
         pgAw==
X-Gm-Message-State: AOAM531QmB6s5AW6k6IzB2zExTpqk7ME077C3cC/89ztq6ElfnBYjl+n
        2xBYnrag6t0bSY5c0UCuWiE3RL+CNo4dQT78WrhxcI8pv8I=
X-Google-Smtp-Source: ABdhPJw77eMdbuPGNdFGrjoo1LP6vcsUM0wyKmWltamukyFj2PGo0vwLL1UML+EYScfEw8P0mpV7huPKYXLOyQyN4q0=
X-Received: by 2002:a05:6902:1009:b0:634:674f:ef16 with SMTP id
 w9-20020a056902100900b00634674fef16mr606179ybt.459.1647992645511; Tue, 22 Mar
 2022 16:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
 <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
 <CANFkB1yr3N_Twac=ocxBRst79-gmdu8=6VTD6oPgdGT0rb_HaQ@mail.gmail.com>
 <CANFkB1xEesP1cMmK4VGi5cH-v80ho00wT24q=+4QQSdyPegPQQ@mail.gmail.com>
 <CABBYNZKSsyqfiWYjpuZNYtKAZb4C2q73YwOj=KoUFq71gLs7Hg@mail.gmail.com>
 <CANFkB1zHTZF3Mcgn5GPBA0km+BNyL3bb9=MJFuSNFe6x5zgimQ@mail.gmail.com> <CABBYNZLWN3+51F-sNJ5yPc2bw+x4Ep6rCwcFLn0bfrwArL=Hyw@mail.gmail.com>
In-Reply-To: <CABBYNZLWN3+51F-sNJ5yPc2bw+x4Ep6rCwcFLn0bfrwArL=Hyw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Mar 2022 16:43:54 -0700
Message-ID: <CABBYNZL-fjTd8JdmRRM5Y26d41KwDxvvuaED+j2+yPT-RBpMtw@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Adam Pigg <adam@piggz.co.uk>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Adam,

On Tue, Mar 22, 2022 at 4:35 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Adam,
>
> On Tue, Mar 22, 2022 at 4:09 PM Adam Pigg <adam@piggz.co.uk> wrote:
> >
> > Thanks Luiz
> >
> > On Tue, 22 Mar 2022 at 21:35, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Tue, Mar 22, 2022 at 3:40 AM Adam Pigg <adam@piggz.co.uk> wrote:
> > > >
> > > > Hi Luiz
> > > >
> > > >
> > > > On Tue, 22 Mar 2022 at 07:55, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > >
> > > > > Hi Luiz
> > > > >
> > > > > On Tue, 22 Mar 2022 at 00:44, Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Adam,
> > > > > >
> > > > > > On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > >
> > > > > > > Hi
> > > > > > >
> > > > > > > A bit of background, I write a linux desktop/mobile app called
> > > > > > > Amazfish which interfaces with several watches over BLE using their
> > > > > > > GATT services.  To do this, I use the bluez dbus api (technically a
> > > > > > > thin wrapper around it I wrote called qble
> > > > > > > https://github.com/piggz/qble)
> > > > > > >
> > > > > > > All has been good so far, I support several generations of
> > > > > > > Huami/Amazfit watches, as well as the open source Pinetime and
> > > > > > > Bangle.js.  For the Amazfit watches, i have implementations for older
> > > > > > > devies such as the Bip, and newer ones such as the GTS.
> > > > > > >
> > > > > > > Much of the reverse engineering comes from the Android Gadget Bridge
> > > > > > > project, which supports many more devices.
> > > > > > >
> > > > > > > My community of users donated to buy me a newer device called a GTR2,
> > > > > > > which, according to the GB devs uses the same protocol as the slightly
> > > > > > > older GTS, and the packet captures I have from Android would support
> > > > > > > this.
> > > > > > >
> > > > > > > But this is where my trouble starts with Bluez, my existing
> > > > > > > implementation doesnt work at all.  Normally, after a connection, I
> > > > > > > would wait for the ServicesResolved signal, which happens pretty fast
> > > > > > > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > > > > > > which time, the watch has disconnected. (i get a disconnected signal
> > > > > > > immediately after the ServicesResolved signal)
> > > > > > >
> > > > > > > To rule out my code, I have tried several things:
> > > > > > > Gatttool
> > > > > > > With gattool, i can connect, get the services, enable a notification,
> > > > > > > write a value and get the expected results seemingly fine
> > > > > > >
> > > > > > > Python-gatt (using the bluez dbus api)
> > > > > > > Im unable to iterate the services, like my app, it takes 30 seconds to
> > > > > > > get the signal and then swiftly disconnects
> > > > > > >
> > > > > > > Gattlib (https://github.com/labapart/gattlib)
> > > > > > > Gattlib is interesting as it appears to have "borrowed" much of its
> > > > > > > code directly from bluez.  When built against the system bluez, if the
> > > > > > > version is > 5.42, it will use the dbus api.  When I do this, again im
> > > > > > > unable to list services on the watch.  However, if I edit the build to
> > > > > > > force it to use its internal gatt implementation, which appears to be
> > > > > > > the same one used by gatttool, then, it IS able to interrogate the
> > > > > > > watch.
> > > > > > >
> > > > > > > I have attached 3 files
> > > > > > > 1. test python program which should print services, and associated btmon
> > > > > > > 2. btmon output while using gatttool
> > > > > > > 3. btmon output running gattlib discover example
> > > > > > >
> > > > > > > Note, other than discovery, I havnt been able to get gattlib to
> > > > > > > read/write/notify!
> > > > > > >
> > > > > > > It seems as though I may be triggering a bug in the bluez dbus api?
> > > > > > > Can anyone suggest anything?
> > > > > >
> > > > > > What version are you using? I would first try with the latest to see
> > > > > > if that something already fixed.
> > > > > >
> > > > > >
> > > > > Im using 5.63 already, which is the latest tag (on opensuse tumbleweed)
> > > > >
> > > > > I'll also try bluetoothctl and attach logs using that, though I
> > > > > suspect it will behave the same as the python library and my own
> > > > > library.
> > > > >
> > > >
> > > > Attached is the output of btmon while using bluetoothctl
> > > >
> > > > bluetoothctl behaves the same as my lib and python, it is unable to
> > > > list services, and after a while, emits the ServicesResolved and
> > > > disconnected messages at the same time.  Im sure it should be able to
> > > > list the services immediately after connect just like gatttool can.
> > >
> > > Looks like there is multiple rounds of MTU Exchange, not sure if that
> > > is actually a problem but the spec does say it shall only be sent once
> > > per client:
> > >
> > > BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> > > page 1424:
> > >
> > > This request shall only be sent once during a connection by the client.
> > >
> > > There is also no response to frame #30:
> > > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> > >
> > >                            #30 [hci0] 26.641557
> > >       ATT: Read Request (0x0a) len 2
> > >         Handle: 0x0018
> > >
> > > So after 30 seconds (ATT timeout) without receiving any response it disconnects:
> > >
> >
> > So, the verdict is that the watch isnt acting to spec right?
> >
> > Why does gatttool work ok, is it a completely different implementation?
> >
> > I understand if wouldnt be to spec, but would it be possible to make
> > bluez more resilient to devices not acting to spec?  Android and iOS
> > work just fine in this regard, so could bluez handle mis-behaving
> > devices more flexibly?
>
> That I can't really explain, perhaps it is timing related, something
> with Exchange MTU since it appears to stop the device from responding
> when it happens a second time.
>
> > Do you have any suggestions for things I could try? I looked for
> > similar lines in the working gatttool log, and it doesnt have anything
> > like that, seems to send flags 0x00 dlen 9 (instead of 7?)  ... how is
> > it behaving differently?
>
> Not sure really, does Android/iOS Exchange the MTU? Maybe we need a
> timer to start it later or perhaps the problem first response to
> exchange MTU does actually use the final_mtu which makes the watch to
> trigger yet another exchange to have both rx and tx MTU the same so
> try with the following change:
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index 2adb4afbf..d326782bf 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -1499,7 +1499,7 @@ static void exchange_mtu_cb(struct bt_att_chan
> *chan, uint8_t opcode,
>         final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
>
>         /* Respond with the server MTU */
> -       put_le16(server->mtu, rsp_pdu);
> +       put_le16(final_mtu, rsp_pdu);
>         bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
>
>         /* Set MTU to be the minimum */

Hmm Im not sure if this will work since the peripheral seems to
respond different values 252 vs 247, also the spec does say that:

'The Server Rx MTU parameter shall be set to the *maximum size* of the
Attribute protocol PDU that the server can receive.
The server and client shall set ATT_MTU to the *minimum of the Client Rx MTU
and the Server Rx MTU*. The size is the same to ensure that a client can
correctly detect the final packet of a long attribute read.'

So my interpretation is that the minimum is calculated after the
Exchange is complete so it doesn't require the Server MTU to be
limited by the Client MTU, anyway if Android and iOS does apply the
minimum logic before responding we can do the same.

>
> >
> > > < HCI Command: Disconnect (0x01|0x0006) plen 3
> > >
> > >                            #48 [hci0] 58.673128
> > >         Handle: 3585
> > >         Reason: Remote User Terminated Connection (0x13)
> > >
> > > > Thanks
> > > >
> > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
