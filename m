Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93FC47080
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 21:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357209AbiDDV3N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380172AbiDDTJ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 15:09:58 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D5344E8
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 12:07:57 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id bn33so14205567ljb.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Apr 2022 12:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACsR6pdzHc2zMnshizR7W81/grG0nL3AJnIQSuX5Wn8=;
        b=0jX8g9nS0Uslrie9G2uO/2rZI53OLTQo1NaA2XXzZhb9uBzSofBflvRz3tHEV0WeCs
         mfeIetJzagYhf3X8KbLFqi6ovktWEBEK740hWADzWbMlRFKt+bsIqA5fi20QldsfRuEa
         W8yt+Axh9pTK/iXZuStZLxTg92bhWDjn2S5uwAqQB7O+4v5B2201ORMwOUxI+nwPrx/x
         GOZvYUYduOU0pvNgYz6Lxc99A9UaRsTSSVJqw25ERid0o0M1aaM+niVQTlQhEQSpQwcI
         SuzovIsiZGMcCAzO9LetmV4LUq8OddeQ91y/ffMqhGNU7czbyYiy12wTRuPlpJBk2dG3
         GKlQ==
X-Gm-Message-State: AOAM532ncweha5cCJ9tZql6p828Eo1zXt5a1v+J40Xhgz2XldmkrX5C1
        hcRwC9tsQtoEokHxiA7Y6skQJIf6dQ3YpcsczRk=
X-Google-Smtp-Source: ABdhPJxgMsAVKGlmUXCliUU3kXqrVQLUB6WmSv4f/wgXQrI0fxU75qwamE3OMrC2bE3EWYcCw3l52sJLf+tkbXaKedQ=
X-Received: by 2002:a2e:9794:0:b0:249:8488:7dbd with SMTP id
 y20-20020a2e9794000000b0024984887dbdmr666373lji.176.1649099275287; Mon, 04
 Apr 2022 12:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
 <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
 <CANFkB1yr3N_Twac=ocxBRst79-gmdu8=6VTD6oPgdGT0rb_HaQ@mail.gmail.com>
 <CANFkB1xEesP1cMmK4VGi5cH-v80ho00wT24q=+4QQSdyPegPQQ@mail.gmail.com>
 <CABBYNZKSsyqfiWYjpuZNYtKAZb4C2q73YwOj=KoUFq71gLs7Hg@mail.gmail.com>
 <CANFkB1zHTZF3Mcgn5GPBA0km+BNyL3bb9=MJFuSNFe6x5zgimQ@mail.gmail.com>
 <CABBYNZLWN3+51F-sNJ5yPc2bw+x4Ep6rCwcFLn0bfrwArL=Hyw@mail.gmail.com>
 <CABBYNZL-fjTd8JdmRRM5Y26d41KwDxvvuaED+j2+yPT-RBpMtw@mail.gmail.com>
 <CANFkB1w2UUq7W0EqEdskebhKcEtkZ-33q-Co5VF_WKf7dHsJtg@mail.gmail.com>
 <CANFkB1zMOYTD8ZsDHczHqce9ipgyu9-fEeXEZqTzuf=T4UufLQ@mail.gmail.com>
 <CANFkB1yOadrpibp4ZNE8e0E+-Wy4z_FV3LC=B7HZzUjGAh3DVA@mail.gmail.com>
 <CABBYNZK_CdiXaZzw++x8fzarP_WhCehLia17EpruVTduKZ=Png@mail.gmail.com>
 <CANFkB1y-bgt4NgMdrJ30OUR9z-KRuAdRydpz8wRoUmj7-dj0zw@mail.gmail.com>
 <CANFkB1xVcwNrr99AESPkSAxMO0kacyyP9MLzTrzoXfVTJ3xM6g@mail.gmail.com>
 <CANFkB1y19zibcjaUfT7QnDTmkYzWESOnuOr+pYKvZtx7BNjQpg@mail.gmail.com>
 <CABBYNZL60KgmdY7EPBy=7nPkUogpqXw64j1FeT72=w0Zdj2Z7w@mail.gmail.com>
 <CANFkB1x4QYohZUjq2ujN5OtWWRnf1DP3tSYB7W2sg-b0fv1nOA@mail.gmail.com> <CANFkB1xuXMZH41GXxh8Dh2zE6t_UgVX4-RdyHH6_4fH5b7Bt3w@mail.gmail.com>
In-Reply-To: <CANFkB1xuXMZH41GXxh8Dh2zE6t_UgVX4-RdyHH6_4fH5b7Bt3w@mail.gmail.com>
From:   Adam Pigg <adam@piggz.co.uk>
Date:   Mon, 4 Apr 2022 20:07:43 +0100
Message-ID: <CANFkB1ySDWH0LmDD4_21uB+XudEYrjDxKniZHYM--rZ5evEDuA@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000080eb7c05dbd8d828"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--00000000000080eb7c05dbd8d828
Content-Type: text/plain; charset="UTF-8"

Hi Luiz

On Sat, 2 Apr 2022 at 10:14, Adam Pigg <adam@piggz.co.uk> wrote:
>
> On Sat, 2 Apr 2022 at 09:26, Adam Pigg <adam@piggz.co.uk> wrote:
> >
> > Hi Luiz
> >
> > On Fri, 1 Apr 2022 at 22:50, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Fri, Apr 1, 2022 at 1:12 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > >
> > > > Hi Luiz
> > > >
> > > > On Mon, 28 Mar 2022 at 17:37, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > >
> > > > > Hi Luiz
> > > > >
> > > > > On Wed, 23 Mar 2022 at 19:57, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > >
> > > > > > Hi Luiz
> > > > > >
> > > > > > Thanks for having the patience with me on this....
> > > > > >
> > > > > > On Wed, 23 Mar 2022 at 19:46, Luiz Augusto von Dentz
> > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Adam,
> > > > > > >
> > > > > > > On Wed, Mar 23, 2022 at 7:46 AM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > >
> > > > > > > > On Wed, 23 Mar 2022 at 13:36, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > >
> > > > > > > > > Hi Luiz
> > > > > > > > >
> > > > > > > > > On Wed, 23 Mar 2022 at 09:11, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Luiz
> > > > > > > > > >
> > > > > > > > > > Good that you clearly know more about this than me!...
> > > > > > > > > >
> > > > > > > > > > On Tue, 22 Mar 2022 at 23:44, Luiz Augusto von Dentz
> > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Adam,
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Mar 22, 2022 at 4:35 PM Luiz Augusto von Dentz
> > > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Adam,
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Mar 22, 2022 at 4:09 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks Luiz
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, 22 Mar 2022 at 21:35, Luiz Augusto von Dentz
> > > > > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Adam,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Tue, Mar 22, 2022 at 3:40 AM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi Luiz
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Tue, 22 Mar 2022 at 07:55, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi Luiz
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Tue, 22 Mar 2022 at 00:44, Luiz Augusto von Dentz
> > > > > > > > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Hi Adam,
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Hi
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > A bit of background, I write a linux desktop/mobile app called
> > > > > > > > > > > > > > > > > > Amazfish which interfaces with several watches over BLE using their
> > > > > > > > > > > > > > > > > > GATT services.  To do this, I use the bluez dbus api (technically a
> > > > > > > > > > > > > > > > > > thin wrapper around it I wrote called qble
> > > > > > > > > > > > > > > > > > https://github.com/piggz/qble)
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > All has been good so far, I support several generations of
> > > > > > > > > > > > > > > > > > Huami/Amazfit watches, as well as the open source Pinetime and
> > > > > > > > > > > > > > > > > > Bangle.js.  For the Amazfit watches, i have implementations for older
> > > > > > > > > > > > > > > > > > devies such as the Bip, and newer ones such as the GTS.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Much of the reverse engineering comes from the Android Gadget Bridge
> > > > > > > > > > > > > > > > > > project, which supports many more devices.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > My community of users donated to buy me a newer device called a GTR2,
> > > > > > > > > > > > > > > > > > which, according to the GB devs uses the same protocol as the slightly
> > > > > > > > > > > > > > > > > > older GTS, and the packet captures I have from Android would support
> > > > > > > > > > > > > > > > > > this.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > But this is where my trouble starts with Bluez, my existing
> > > > > > > > > > > > > > > > > > implementation doesnt work at all.  Normally, after a connection, I
> > > > > > > > > > > > > > > > > > would wait for the ServicesResolved signal, which happens pretty fast
> > > > > > > > > > > > > > > > > > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > > > > > > > > > > > > > > > > > which time, the watch has disconnected. (i get a disconnected signal
> > > > > > > > > > > > > > > > > > immediately after the ServicesResolved signal)
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > To rule out my code, I have tried several things:
> > > > > > > > > > > > > > > > > > Gatttool
> > > > > > > > > > > > > > > > > > With gattool, i can connect, get the services, enable a notification,
> > > > > > > > > > > > > > > > > > write a value and get the expected results seemingly fine
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Python-gatt (using the bluez dbus api)
> > > > > > > > > > > > > > > > > > Im unable to iterate the services, like my app, it takes 30 seconds to
> > > > > > > > > > > > > > > > > > get the signal and then swiftly disconnects
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Gattlib (https://github.com/labapart/gattlib)
> > > > > > > > > > > > > > > > > > Gattlib is interesting as it appears to have "borrowed" much of its
> > > > > > > > > > > > > > > > > > code directly from bluez.  When built against the system bluez, if the
> > > > > > > > > > > > > > > > > > version is > 5.42, it will use the dbus api.  When I do this, again im
> > > > > > > > > > > > > > > > > > unable to list services on the watch.  However, if I edit the build to
> > > > > > > > > > > > > > > > > > force it to use its internal gatt implementation, which appears to be
> > > > > > > > > > > > > > > > > > the same one used by gatttool, then, it IS able to interrogate the
> > > > > > > > > > > > > > > > > > watch.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I have attached 3 files
> > > > > > > > > > > > > > > > > > 1. test python program which should print services, and associated btmon
> > > > > > > > > > > > > > > > > > 2. btmon output while using gatttool
> > > > > > > > > > > > > > > > > > 3. btmon output running gattlib discover example
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Note, other than discovery, I havnt been able to get gattlib to
> > > > > > > > > > > > > > > > > > read/write/notify!
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > It seems as though I may be triggering a bug in the bluez dbus api?
> > > > > > > > > > > > > > > > > > Can anyone suggest anything?
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > What version are you using? I would first try with the latest to see
> > > > > > > > > > > > > > > > > if that something already fixed.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Im using 5.63 already, which is the latest tag (on opensuse tumbleweed)
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I'll also try bluetoothctl and attach logs using that, though I
> > > > > > > > > > > > > > > > suspect it will behave the same as the python library and my own
> > > > > > > > > > > > > > > > library.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Attached is the output of btmon while using bluetoothctl
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > bluetoothctl behaves the same as my lib and python, it is unable to
> > > > > > > > > > > > > > > list services, and after a while, emits the ServicesResolved and
> > > > > > > > > > > > > > > disconnected messages at the same time.  Im sure it should be able to
> > > > > > > > > > > > > > > list the services immediately after connect just like gatttool can.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Looks like there is multiple rounds of MTU Exchange, not sure if that
> > > > > > > > > > > > > > is actually a problem but the spec does say it shall only be sent once
> > > > > > > > > > > > > > per client:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> > > > > > > > > > > > > > page 1424:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > This request shall only be sent once during a connection by the client.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > There is also no response to frame #30:
> > > > > > > > > > > > > > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >                            #30 [hci0] 26.641557
> > > > > > > > > > > > > >       ATT: Read Request (0x0a) len 2
> > > > > > > > > > > > > >         Handle: 0x0018
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > So after 30 seconds (ATT timeout) without receiving any response it disconnects:
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > So, the verdict is that the watch isnt acting to spec right?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Why does gatttool work ok, is it a completely different implementation?
> > > > > > > > > > > > >
> > > > > > > > > > > > > I understand if wouldnt be to spec, but would it be possible to make
> > > > > > > > > > > > > bluez more resilient to devices not acting to spec?  Android and iOS
> > > > > > > > > > > > > work just fine in this regard, so could bluez handle mis-behaving
> > > > > > > > > > > > > devices more flexibly?
> > > > > > > > > > > >
> > > > > > > > > > > > That I can't really explain, perhaps it is timing related, something
> > > > > > > > > > > > with Exchange MTU since it appears to stop the device from responding
> > > > > > > > > > > > when it happens a second time.
> > > > > > > > > > > >
> > > > > > > > > > > > > Do you have any suggestions for things I could try? I looked for
> > > > > > > > > > > > > similar lines in the working gatttool log, and it doesnt have anything
> > > > > > > > > > > > > like that, seems to send flags 0x00 dlen 9 (instead of 7?)  ... how is
> > > > > > > > > > > > > it behaving differently?
> > > > > > > > > > > >
> > > > > > > > > > > > Not sure really, does Android/iOS Exchange the MTU? Maybe we need a
> > > > > > > > > > > > timer to start it later or perhaps the problem first response to
> > > > > > > > > > > > exchange MTU does actually use the final_mtu which makes the watch to
> > > > > > > > > > > > trigger yet another exchange to have both rx and tx MTU the same so
> > > > > > > > > > > > try with the following change:
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > > > > > > > > > > > index 2adb4afbf..d326782bf 100644
> > > > > > > > > > > > --- a/src/shared/gatt-server.c
> > > > > > > > > > > > +++ b/src/shared/gatt-server.c
> > > > > > > > > > > > @@ -1499,7 +1499,7 @@ static void exchange_mtu_cb(struct bt_att_chan
> > > > > > > > > > > > *chan, uint8_t opcode,
> > > > > > > > > > > >         final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
> > > > > > > > > > > >
> > > > > > > > > > > >         /* Respond with the server MTU */
> > > > > > > > > > > > -       put_le16(server->mtu, rsp_pdu);
> > > > > > > > > > > > +       put_le16(final_mtu, rsp_pdu);
> > > > > > > > > > > >         bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
> > > > > > > > > > > >
> > > > > > > > > > > >         /* Set MTU to be the minimum */
> > > > > > > > > > >
> > > > > > > > > > > Hmm Im not sure if this will work since the peripheral seems to
> > > > > > > > > > > respond different values 252 vs 247, also the spec does say that:
> > > > > > > > > > >
> > > > > > > > > > > 'The Server Rx MTU parameter shall be set to the *maximum size* of the
> > > > > > > > > > > Attribute protocol PDU that the server can receive.
> > > > > > > > > > > The server and client shall set ATT_MTU to the *minimum of the Client Rx MTU
> > > > > > > > > > > and the Server Rx MTU*. The size is the same to ensure that a client can
> > > > > > > > > > > correctly detect the final packet of a long attribute read.'
> > > > > > > > > > >
> > > > > > > > > > > So my interpretation is that the minimum is calculated after the
> > > > > > > > > > > Exchange is complete so it doesn't require the Server MTU to be
> > > > > > > > > > > limited by the Client MTU, anyway if Android and iOS does apply the
> > > > > > > > > > > minimum logic before responding we can do the same.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Maybe it will help if I attach an android packet capture....
> > > > > > > > > >
> > > > > > > > > > The attachedhttps://marc.info/?l=linux-bluetooth&m=164799909020040&w=2
> > > > > > > > > > log can be opened in Wireshark, and to my untrained eye, it looks like
> > > > > > > > > > the MTU negotiation is at packets 451 and 452, and 247 is used?
> > > > > > > > > >
> > > > > > > > > > Ill try and get the proposed patch built and see how it behaves
> > > > > > > > >
> > > > > > > > > Attached if the btmon and bluetoothctl.  It doesnt seem to be there quite yet.
> > > > > > > > >
> > > > > > > > > There was one point before i applied the patch where bluetoothctl
> > > > > > > > > seemed to list the attributes quickly, but i havnt been able to
> > > > > > > > > reproduce that again with or without the patch.
> > > > > > > > >
> > > > > > > >
> > > > > > > > For completeness, also attached the output of my program and btmon
> > > > > > > >
> > > > > > > > My program should connect, wait for resolved signal, then read a char,
> > > > > > > > enable some notifications, and do a write.  You can see the 30 second
> > > > > > > > wait between connect, resolved, and quickly followed by a disconnect.
> > > > > > >
> > > > > > >
> > > > > > > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> > > > > > >
> > > > > > >                            #22 [hci0] 12.507730
> > > > > > >       ATT: Exchange MTU Request (0x02) len 2
> > > > > > >         Client RX MTU: 517
> > > > > > > > ACL Data RX: Handle 3585 flags 0x02 dlen 7                                                                                                                             #23 [hci0] 12.556081
> > > > > > >       ATT: Exchange MTU Request (0x02) len 2
> > > > > > >         Client RX MTU: 247
> > > > > > > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> > > > > > >
> > > > > > >                            #24 [hci0] 12.556256
> > > > > > >       ATT: Exchange MTU Response (0x03) len 2
> > > > > > >         Server RX MTU: 247
> > > > > > > > ACL Data RX: Handle 3585 flags 0x02 dlen 7                                                                                                                             #27 [hci0] 12.655972
> > > > > > >       ATT: Exchange MTU Response (0x03) len 2
> > > > > > >         Server RX MTU: 252
> > > > > > >
> > > > > > > So we are now responding with 247 and the peripheral responds with 252
> > > > > > > to our request :/, so we would need to probably delay our request or
> > > > > > > something, that said we are the central so I really which we don't
> > > > > > > have to do it since that would penalize well behaving devices, could
> > > > > > > we perhaps inform the vendor about these issues? I'd considered this
> > > > > > > to be really bad behavior from the remote side since they are not
> > > > > > > following the spec in many respects as even their MTU changes from
> > > > > > > request to response and it does multiple rounds of Exchange MTU and
> > > > > > > stop responding while doing it.
> > > > > > >
> > > > > >
> > > > > > I can certainly look into how to contact Huami/Amazfit ... I wouldnt
> > > > > > count on a response though!
> > > > > >
> > > > > > I see you looked at the android log already.
> > > > > >
> > > > > > Do you have an idea for a patch I could try out?  Im deep in this now
> > > > > > anyway, and over-wrote my system bluez :D
> > > > > >
> > > > > > Its strange how they have messed up this generation of device as all
> > > > > > the older ones work fine, and I imagine they must just build on the
> > > > > > old code base.
> > > > > >
> > > > >
> > > > > I have submitted a support request to Amazfit, describing the issue
> > > > > and linking to the details in the ML... maybe they will read it!
> > > > >
> > > > > Do you think there is anything I can try to make bluez work in the
> > > > > mean time, even just on my own device?
> > > > >
> > > > I had another go at making this work before attempting to write my own
> > > > gatt lib (!) and i seem to have got it to work, though I dont know if
> > > > it will be acceptable to bluez, or if there is another way.
> > > >
> > > > Probably easiest with the diff:
> > > > diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
> > > > index ea3249be9..701677e0a 100644
> > > > --- a/profiles/gap/gas.c
> > > > +++ b/profiles/gap/gas.c
> > > > @@ -142,8 +142,8 @@ static void read_appearance_cb(bool success,
> > > > uint8_t att_ecode,
> > > >
> > > > static void handle_appearance(struct gas *gas, uint16_t value_handle)
> > > > {
> > > > -       if (!bt_gatt_client_read_value(gas->client, value_handle,
> > > > -                                               read_appearance_cb, gas, NULL))
> > > > +       //if (!bt_gatt_client_read_value(gas->client, value_handle,
> > > > +       //                                      read_appearance_cb, gas, NULL))
> > > >                DBG("Failed to send request to read appearance");
> > >
> > > Does disabling the read make it work? Does it stop the second MTU exchange?
> > >
> > > > }
> > > >
> > > > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > > > index 776e5ce2b..ac0fac1fc 100644
> > > > --- a/src/shared/gatt-server.c
> > > > +++ b/src/shared/gatt-server.c
> > > > @@ -1498,7 +1498,8 @@ static void exchange_mtu_cb(struct bt_att_chan
> > > > *chan, uint8_t opcode,
> > > >        final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
> > > >
> > > >        /* Respond with the server MTU */
> > > > -       put_le16(server->mtu, rsp_pdu);
> > > > +       //put_le16(server->mtu, rsp_pdu);
> > > > +       put_le16(final_mtu, rsp_pdu);
> > > >        bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
> > > >
> > > >        /* Set MTU to be the minimum */
> > > >
> > > > I was running bluetoothd with -n -d, and noticed that the read to the
> > > > appearance was failing, so, I commented it out.  The read to the name
> > > > works ok and happens just prior to reading the appearance.
> > > >
> > > > I gather it only reads the appearance if the char exists, so, i dont
> > > > know why that fail, however I dont see 2a01 in the list of
> > > > services/characteristics, which is the appearance one right?
> > >
> > > #define GATT_CHARAC_APPEARANCE 0x2A01
> > >
> > > You don't see it on bluetoothd logs or over D-Bus? The latter may not
> > > contain all the attributes since some are claimed.
> > >
> >
> > Gathered some logs this morning, see attached.
> >
> > So, 2A01 is listed in the bluetoothd debug output, so, I guess its a
> > fault that it cant be read?  It is not listed in the output of
> > bluetoothctl list-attributes (also attached) so I could not read the
> > value using that tool.
> >
> > Without any other changes, my own lib/app was able to connect to the
> > watch and start reading data seemingly fine, though I did get an
> > unexpected disconnected after reading a large amount of step/activity
> > data, but that  may be unrelated, read/write and notify were all
> > working.
> >
> > Could some quirk be used to get around this issue?
> >
>
> More info
>
> Reading 2a04 and 2a05 works fine in blueoothctl
> [Amazfit GTR 2]# select-attribute 00002a05-0000-1000-8000-00805f9b34fb
> [Amazfit GTR 2:/service0001/char0002]# read
> Attempting to read /org/bluez/hci0/dev_CD_1B_C3_94_5B_77/service0001/char0002
> [CHG] Attribute
> /org/bluez/hci0/dev_CD_1B_C3_94_5B_77/service0001/char0002 Value:
>  01 00 ff ff                                      ....
>  01 00 ff ff                                      ....
> [Amazfit GTR 2:/service0001/char0002]# select-attribute
> 00002a04-0000-1000-8000-00805f9b34fb
> [Amazfit GTR 2:/service0040/char0044]# read
> Attempting to read /org/bluez/hci0/dev_CD_1B_C3_94_5B_77/service0040/char0044
> [CHG] Attribute
> /org/bluez/hci0/dev_CD_1B_C3_94_5B_77/service0040/char0044 Value:
>  18 00 18 00 09 00 f4 01                          ........
>  18 00 18 00 09 00 f4 01                          ........
>
> And. looking back in the android packet capture, I dont see any reads
> for the name/appearance.
>

Attached are 2 logs from bluetoothd, the good and bad one.  The "good"
one is with the previous patch applied to not read the appearance.

My aim was to come up with a method of making its failure non fatal,
which might be a better solution rather than remove the call for all
devices.

However, i traced through the code and got to line 500 of shared/att.c
which states that the timeout should be fatal, and immediately
disconnects.  So, if the timeout is fatal by design, im not sure what
a fix would look like.

Thanks
>
> > > > Any thoughts?
> > > >
> > > > Cheers
> > > >
> > > >
> > > >
> > > > > Thanks
> > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > > < HCI Command: Disconnect (0x01|0x0006) plen 3
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >                            #48 [hci0] 58.673128
> > > > > > > > > > > > > >         Handle: 3585
> > > > > > > > > > > > > >         Reason: Remote User Terminated Connection (0x13)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thanks
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > --
> > > > > > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > --
> > > > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > Luiz Augusto von Dentz
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz

--00000000000080eb7c05dbd8d828
Content-Type: text/plain; charset="US-ASCII"; name="bt-bad.txt"
Content-Disposition: attachment; filename="bt-bad.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_l1l34b001>
X-Attachment-Id: f_l1l34b001

Ymx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6ZGV2aWNlX2Nvbm5lY3RfbGUoKSBDb25uZWN0aW9u
IGF0dGVtcHQgdG86IENEOjFCOkMzOjk0OjVCOjc3CmJsdWV0b290aGRbXTogc3JjL2FkYXB0ZXIu
Yzpjb25uZWN0ZWRfY2FsbGJhY2soKSBoY2kwIGRldmljZSBDRDoxQjpDMzo5NDo1Qjo3NyBjb25u
ZWN0ZWQgZWlyX2xlbiAzMQpibHVldG9vdGhkW106IGF0dHJpYi9nYXR0cmliLmM6Z19hdHRyaWJf
cmVmKCkgMHg1NjQxZmE0NDYwZDA6IGdfYXR0cmliX3JlZj0xCmJsdWV0b290aGRbXTogc3JjL2Rl
dmljZS5jOmxvYWRfZ2F0dF9kYigpIFJlc3RvcmluZyBDRDoxQjpDMzo5NDo1Qjo3NyBnYXR0IGRh
dGFiYXNlIGZyb20gZmlsZQpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2Uo
KSBsb2FkaW5nIHNlcnZpY2U6IDB4MDAwMSwgZW5kOiAweDAwMDQsIHV1aWQ6IDAwMDAxODAxLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2Fk
X3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDAxNCwgZW5kOiAweDAwMTgsIHV1aWQ6IDAw
MDAxODAwLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZp
Y2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDAyOCwgZW5kOiAweDAwMzUs
IHV1aWQ6IDAwMDAxODBhLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106
IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDAzOCwgZW5k
OiAweDAwM2QsIHV1aWQ6IDAwMDAxNTMwLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMApibHVl
dG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4
MDA0MCwgZW5kOiAweDAwNmQsIHV1aWQ6IDAwMDBmZWUwLTAwMDAtMTAwMC04MDAwLTAwODA1Zjli
MzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNl
cnZpY2U6IDB4MDA3MCwgZW5kOiAweDAwODEsIHV1aWQ6IDAwMDBmZWUxLTAwMDAtMTAwMC04MDAw
LTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBs
b2FkaW5nIHNlcnZpY2U6IDB4MDA4NCwgZW5kOiAweDAwODksIHV1aWQ6IDAwMDAxODBkLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3Nl
cnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDA4YywgZW5kOiAweDAwOTEsIHV1aWQ6IDAwMDAx
ODExLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2Uu
Yzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDA5NCwgZW5kOiAweDAwOTYsIHV1
aWQ6IDAwMDAxODAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNy
Yy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDA5OSwgZW5kOiAw
eDAwOWMsIHV1aWQ6IDAwMDAzODAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9v
dGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhh
bmRsZTogMHgwMDAyLCB2YWx1ZSBoYW5kbGU6IDB4MDAwMywgcHJvcGVydGllcyAweDAwMjIgdmFs
dWU6ICB1dWlkOiAwMDAwMmEwNS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3Ro
ZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTog
MHgwMDA0LCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9h
ZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDAxNSwgdmFsdWUgaGFuZGxlOiAweDAwMTYs
IHByb3BlcnRpZXMgMHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMDJhMDAtMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRp
bmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwMTcsIHZhbHVlIGhhbmRsZTogMHgwMDE4LCBw
cm9wZXJ0aWVzIDB4MDAwMiB2YWx1ZTogIHV1aWQ6IDAwMDAyYTAxLTAwMDAtMTAwMC04MDAwLTAw
ODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5n
IGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDI5LCB2YWx1ZSBoYW5kbGU6IDB4MDAyYSwgcHJv
cGVydGllcyAweDAwMDIgdmFsdWU6ICB1dWlkOiAwMDAwMmEyNS0wMDAwLTEwMDAtODAwMC0wMDgw
NWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBj
aGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDAyYiwgdmFsdWUgaGFuZGxlOiAweDAwMmMsIHByb3Bl
cnRpZXMgMHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMDJhMjctMDAwMC0xMDAwLTgwMDAtMDA4MDVm
OWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hh
cmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwMmQsIHZhbHVlIGhhbmRsZTogMHgwMDJlLCBwcm9wZXJ0
aWVzIDB4MDAwMiB2YWx1ZTogIHV1aWQ6IDAwMDAyYTI4LTAwMDAtMTAwMC04MDAwLTAwODA1Zjli
MzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJh
Y3RlcmlzdGljIGhhbmRsZTogMHgwMDJmLCB2YWx1ZSBoYW5kbGU6IDB4MDAzMCwgcHJvcGVydGll
cyAweDAwMDIgdmFsdWU6ICB1dWlkOiAwMDAwMmEyMy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0
ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0
ZXJpc3RpYyBoYW5kbGU6IDB4MDAzMSwgdmFsdWUgaGFuZGxlOiAweDAwMzIsIHByb3BlcnRpZXMg
MHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMDJhNTAtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZi
CmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVy
aXN0aWMgaGFuZGxlOiAweDAwMzMsIHZhbHVlIGhhbmRsZTogMHgwMDM0LCBwcm9wZXJ0aWVzIDB4
MDAxNCB2YWx1ZTogIHV1aWQ6IDAwMDAwMDE0LTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMApi
bHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3Ig
aGFuZGxlOiAweDAwMzUsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2No
cmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDM5LCB2YWx1ZSBoYW5kbGU6
IDB4MDAzYSwgcHJvcGVydGllcyAweDAwMTggdmFsdWU6ICB1dWlkOiAwMDAwMTUzMS0wMDAwLTM1
MTItMjExOC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNj
KCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDNiLCB2YWx1ZTogMHgwMDAwLCB2YWx1
ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtd
OiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6
IDB4MDAzYywgdmFsdWUgaGFuZGxlOiAweDAwM2QsIHByb3BlcnRpZXMgMHgwMDA0IHZhbHVlOiAg
dXVpZDogMDAwMDE1MzItMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbXTog
c3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAw
eDAwNDEsIHZhbHVlIGhhbmRsZTogMHgwMDQyLCBwcm9wZXJ0aWVzIDB4MDAxYSB2YWx1ZTogIHV1
aWQ6IDAwMDAyYTJiLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNy
Yy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNDMs
IHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1
ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNo
YXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDQ0LCB2YWx1ZSBoYW5kbGU6IDB4MDA0NSwgcHJvcGVy
dGllcyAweDAwMWEgdmFsdWU6ICB1dWlkOiAwMDAwMmEwNC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNj
cmlwdG9yIGhhbmRsZTogMHgwMDQ2LCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkw
Mi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6
bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA0NywgdmFsdWUg
aGFuZGxlOiAweDAwNDgsIHByb3BlcnRpZXMgMHgwMDE0IHZhbHVlOiAgdXVpZDogMDAwMDAwMDEt
MDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxv
YWRfZGVzYygpIGxvYWRpbmcgZGVzY3JpcHRvciBoYW5kbGU6IDB4MDA0OSwgdmFsdWU6IDB4MDAw
MCwgdmFsdWUgdXVpZDogMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0
b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMg
aGFuZGxlOiAweDAwNGEsIHZhbHVlIGhhbmRsZTogMHgwMDRiLCBwcm9wZXJ0aWVzIDB4MDAxMCB2
YWx1ZTogIHV1aWQ6IDAwMDAwMDAyLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMApibHVldG9v
dGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxl
OiAweDAwNGMsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04
MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBs
b2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDRkLCB2YWx1ZSBoYW5kbGU6IDB4MDA0
ZSwgcHJvcGVydGllcyAweDAwMTQgdmFsdWU6ICB1dWlkOiAwMDAwMDAwMy0wMDAwLTM1MTItMjEx
OC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9h
ZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDRmLCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlk
OiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMv
ZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA1
MCwgdmFsdWUgaGFuZGxlOiAweDAwNTEsIHByb3BlcnRpZXMgMHgwMDE0IHZhbHVlOiAgdXVpZDog
MDAwMDAwMDQtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbXTogc3JjL2Rl
dmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcgZGVzY3JpcHRvciBoYW5kbGU6IDB4MDA1MiwgdmFs
dWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIz
NGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFj
dGVyaXN0aWMgaGFuZGxlOiAweDAwNTMsIHZhbHVlIGhhbmRsZTogMHgwMDU0LCBwcm9wZXJ0aWVz
IDB4MDAxMCB2YWx1ZTogIHV1aWQ6IDAwMDAwMDA1LTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcw
MApibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0
b3IgaGFuZGxlOiAweDAwNTUsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2Fk
X2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDU2LCB2YWx1ZSBoYW5k
bGU6IDB4MDA1NywgcHJvcGVydGllcyAweDAwMTIgdmFsdWU6ICB1dWlkOiAwMDAwMDAwNi0wMDAw
LTM1MTItMjExOC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9k
ZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDU4LCB2YWx1ZTogMHgwMDAwLCB2
YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3Ro
ZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5k
bGU6IDB4MDA1OSwgdmFsdWUgaGFuZGxlOiAweDAwNWEsIHByb3BlcnRpZXMgMHgwMDEyIHZhbHVl
OiAgdXVpZDogMDAwMDAwMDctMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRb
XTogc3JjL2RldmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcgZGVzY3JpcHRvciBoYW5kbGU6IDB4
MDA1YiwgdmFsdWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRp
bmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwNWYsIHZhbHVlIGhhbmRsZTogMHgwMDYwLCBw
cm9wZXJ0aWVzIDB4MDAxMCB2YWx1ZTogIHV1aWQ6IDAwMDAwMDEwLTAwMDAtMzUxMi0yMTE4LTAw
MDlhZjEwMDcwMApibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5n
IGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNjEsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAw
MDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZp
Y2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDYyLCB2
YWx1ZSBoYW5kbGU6IDB4MDA2MywgcHJvcGVydGllcyAweDAwMDggdmFsdWU6ICB1dWlkOiAwMDAw
MDAwZS0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNl
LmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDY0LCB2YWx1ZTog
MHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkwMS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIK
Ymx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJp
c3RpYyBoYW5kbGU6IDB4MDA2NSwgdmFsdWUgaGFuZGxlOiAweDAwNjYsIHByb3BlcnRpZXMgMHgw
MDE2IHZhbHVlOiAgdXVpZDogMDAwMDAwMjAtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJs
dWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcgZGVzY3JpcHRvciBo
YW5kbGU6IDB4MDA2NywgdmFsdWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAwMDI5MDItMDAwMC0x
MDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hy
YygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwNjgsIHZhbHVlIGhhbmRsZTog
MHgwMDY5LCBwcm9wZXJ0aWVzIDB4MDAxNCB2YWx1ZTogIHV1aWQ6IDAwMDAwMDE2LTAwMDAtMzUx
Mi0yMTE4LTAwMDlhZjEwMDcwMApibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2Mo
KSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNmEsIHZhbHVlOiAweDAwMDAsIHZhbHVl
IHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106
IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTog
MHgwMDZiLCB2YWx1ZSBoYW5kbGU6IDB4MDA2YywgcHJvcGVydGllcyAweDAwMTQgdmFsdWU6ICB1
dWlkOiAwMDAwMDAxNy0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBz
cmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDZk
LCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgw
NWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBj
aGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA3MSwgdmFsdWUgaGFuZGxlOiAweDAwNzIsIHByb3Bl
cnRpZXMgMHgwMDE2IHZhbHVlOiAgdXVpZDogMDAwMDAwMDktMDAwMC0zNTEyLTIxMTgtMDAwOWFm
MTAwNzAwCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcgZGVz
Y3JpcHRvciBoYW5kbGU6IDB4MDA3MywgdmFsdWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAwMDI5
MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5j
OmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwNzQsIHZhbHVl
IGhhbmRsZTogMHgwMDc1LCBwcm9wZXJ0aWVzIDB4MDAwOCB2YWx1ZTogIHV1aWQ6IDAwMDBmZWRk
LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzps
b2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDc2LCB2YWx1ZSBo
YW5kbGU6IDB4MDA3NywgcHJvcGVydGllcyAweDAwMDIgdmFsdWU6ICB1dWlkOiAwMDAwZmVkZS0w
MDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9h
ZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA3OCwgdmFsdWUgaGFu
ZGxlOiAweDAwNzksIHByb3BlcnRpZXMgMHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMGZlZGYtMDAw
MC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRf
Y2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwN2EsIHZhbHVlIGhhbmRs
ZTogMHgwMDdiLCBwcm9wZXJ0aWVzIDB4MDAwYSB2YWx1ZTogIHV1aWQ6IDAwMDBmZWQwLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2No
cmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDdjLCB2YWx1ZSBoYW5kbGU6
IDB4MDA3ZCwgcHJvcGVydGllcyAweDAwMGEgdmFsdWU6ICB1dWlkOiAwMDAwZmVkMS0wMDAwLTEw
MDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJj
KCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA3ZSwgdmFsdWUgaGFuZGxlOiAw
eDAwN2YsIHByb3BlcnRpZXMgMHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMGZlZDItMDAwMC0xMDAw
LTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygp
IGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwODAsIHZhbHVlIGhhbmRsZTogMHgw
MDgxLCBwcm9wZXJ0aWVzIDB4MDAwYSB2YWx1ZTogIHV1aWQ6IDAwMDBmZWQzLTAwMDAtMTAwMC04
MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBs
b2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDg1LCB2YWx1ZSBoYW5kbGU6IDB4MDA4
NiwgcHJvcGVydGllcyAweDAwMTAgdmFsdWU6ICB1dWlkOiAwMDAwMmEzNy0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9h
ZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDg3LCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlk
OiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMv
ZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA4
OCwgdmFsdWUgaGFuZGxlOiAweDAwODksIHByb3BlcnRpZXMgMHgwMDBhIHZhbHVlOiAgdXVpZDog
MDAwMDJhMzktMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2Rl
dmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwOGQs
IHZhbHVlIGhhbmRsZTogMHgwMDhlLCBwcm9wZXJ0aWVzIDB4MDAwYSB2YWx1ZTogIHV1aWQ6IDAw
MDAyYTQ2LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZp
Y2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDhmLCB2
YWx1ZSBoYW5kbGU6IDB4MDA5MCwgcHJvcGVydGllcyAweDAwMWEgdmFsdWU6ICB1dWlkOiAwMDAw
MmE0NC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNl
LmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDkxLCB2YWx1ZTog
MHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIK
Ymx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJp
c3RpYyBoYW5kbGU6IDB4MDA5NSwgdmFsdWUgaGFuZGxlOiAweDAwOTYsIHByb3BlcnRpZXMgMHgw
MDA0IHZhbHVlOiAgdXVpZDogMDAwMDJhMDYtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJs
dWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0
aWMgaGFuZGxlOiAweDAwOWEsIHZhbHVlIGhhbmRsZTogMHgwMDliLCBwcm9wZXJ0aWVzIDB4MDAx
YSB2YWx1ZTogIHV1aWQ6IDAwMDA0YTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVl
dG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFu
ZGxlOiAweDAwOWMsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAw
MC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHByb2ZpbGVzL2RldmljZWluZm8vZGV2
aWNlaW5mby5jOmRldmljZWluZm9fYWNjZXB0KCkgZGV2aWNlaW5mbyBwcm9maWxlIGFjY2VwdCAo
Q0Q6MUI6QzM6OTQ6NUI6NzcpCmJsdWV0b290aGRbXTogcHJvZmlsZXMvZGV2aWNlaW5mby9kZXZp
Y2VpbmZvLmM6aGFuZGxlX2NoYXJhY3RlcmlzdGljKCkgVW5zdXBwb3J0ZWQgY2hhcmFjdGVyaXN0
aWM6IDAwMDAyYTI1LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHBy
b2ZpbGVzL2RldmljZWluZm8vZGV2aWNlaW5mby5jOmhhbmRsZV9jaGFyYWN0ZXJpc3RpYygpIFVu
c3VwcG9ydGVkIGNoYXJhY3RlcmlzdGljOiAwMDAwMmEyNy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIKYmx1ZXRvb3RoZFtdOiBwcm9maWxlcy9kZXZpY2VpbmZvL2RldmljZWluZm8uYzpoYW5k
bGVfY2hhcmFjdGVyaXN0aWMoKSBVbnN1cHBvcnRlZCBjaGFyYWN0ZXJpc3RpYzogMDAwMDJhMjgt
MDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogcHJvZmlsZXMvZGV2aWNl
aW5mby9kZXZpY2VpbmZvLmM6aGFuZGxlX2NoYXJhY3RlcmlzdGljKCkgVW5zdXBwb3J0ZWQgY2hh
cmFjdGVyaXN0aWM6IDAwMDAyYTIzLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9v
dGhkW106IHByb2ZpbGVzL2RldmljZWluZm8vZGV2aWNlaW5mby5jOmhhbmRsZV9jaGFyYWN0ZXJp
c3RpYygpIFVuc3VwcG9ydGVkIGNoYXJhY3RlcmlzdGljOiAwMDAwMDAxNC0wMDAwLTM1MTItMjEx
OC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvc2VydmljZS5jOmNoYW5nZV9zdGF0ZSgp
IDB4NTY0MWZhNDMyN2YwOiBkZXZpY2UgQ0Q6MUI6QzM6OTQ6NUI6NzcgcHJvZmlsZSBkZXZpY2Vp
bmZvIHN0YXRlIGNoYW5nZWQ6IGRpc2Nvbm5lY3RlZCAtPiBjb25uZWN0ZWQgKDApCmJsdWV0b290
aGRbXTogcHJvZmlsZXMvZ2FwL2dhcy5jOmdhcF9hY2NlcHQoKSBHQVAgcHJvZmlsZSBhY2NlcHQg
KENEOjFCOkMzOjk0OjVCOjc3KQpibHVldG9vdGhkW106IHNyYy9zZXJ2aWNlLmM6Y2hhbmdlX3N0
YXRlKCkgMHg1NjQxZmE0MzcxZjA6IGRldmljZSBDRDoxQjpDMzo5NDo1Qjo3NyBwcm9maWxlIGdh
cC1wcm9maWxlIHN0YXRlIGNoYW5nZWQ6IGRpc2Nvbm5lY3RlZCAtPiBjb25uZWN0ZWQgKDApCmJs
dWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50LmM6YnRkX2dhdHRfY2xpZW50X2Nvbm5lY3RlZCgp
IERldmljZSBjb25uZWN0ZWQuCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmdhdHRfZGVidWco
KSAoY2hhbiAweDU2NDFmYTQ0NTNkMCkgQVRUIFBEVSByZWNlaXZlZDogMHgwMgpibHVldG9vdGhk
W106IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgTVRVIGV4Y2hhbmdlIGNvbXBsZXRlLCB3aXRo
IE1UVTogMjQ3CmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSBNVFUgZXhj
aGFuZ2UgY29tcGxldGUsIHdpdGggTVRVOiAyNTIKYmx1ZXRvb3RoZFtdOiBwcm9maWxlcy9nYXAv
Z2FzLmM6cmVhZF9kZXZpY2VfbmFtZV9jYigpIEdBUCBEZXZpY2UgTmFtZTogQW1hemZpdCBHVFIg
MgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgKGNoYW4gMHg1NjQxZmE0
NDUzZDApIEFUVCBQRFUgcmVjZWl2ZWQ6IDB4MDIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6
Z2F0dF9kZWJ1ZygpIE1UVSBleGNoYW5nZSBjb21wbGV0ZSwgd2l0aCBNVFU6IDI0NwpibHVldG9v
dGhkW106IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgKGNoYW4gMHg1NjQxZmE0NDUzZDApIEFU
VCBQRFUgcmVjZWl2ZWQ6IDB4MDgKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6Z2F0dF9kZWJ1
ZygpIFJlYWQgQnkgVHlwZSAtIHN0YXJ0OiAweDAwMDEgZW5kOiAweGZmZmYKYmx1ZXRvb3RoZFtd
OiBzcmMvZGV2aWNlLmM6Z2F0dF9kZWJ1ZygpIChjaGFuIDB4NTY0MWZhNDQ1M2QwKSBBVFQgUERV
IHJlY2VpdmVkOiAweDA4CmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSBS
ZWFkIEJ5IFR5cGUgLSBzdGFydDogMHgwMDE0IGVuZDogMHhmZmZmCmJsdWV0b290aGRbXTogc3Jj
L2RldmljZS5jOmdhdHRfZGVidWcoKSAoY2hhbiAweDU2NDFmYTQ0NTNkMCkgQVRUIFBEVSByZWNl
aXZlZDogMHgwOApibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgUmVhZCBC
eSBUeXBlIC0gc3RhcnQ6IDB4MDAwMSBlbmQ6IDB4ZmZmZgpibHVldG9vdGhkW106IHNyYy9nYXR0
LWRhdGFiYXNlLmM6Z2FwX2RldmljZV9uYW1lX3JlYWRfY2IoKSBHQVAgRGV2aWNlIE5hbWUgcmVh
ZCByZXF1ZXN0CmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSAoY2hhbiAw
eDU2NDFmYTQ0NTNkMCkgT3BlcmF0aW9uIHRpbWVkIG91dDogMHgwYQpibHVldG9vdGhkW106IHBy
b2ZpbGVzL2dhcC9nYXMuYzpyZWFkX2FwcGVhcmFuY2VfY2IoKSBSZWFkaW5nIGFwcGVhcmFuY2Ug
ZmFpbGVkIHdpdGggQVRUIGVycm9yOiAxNApibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpnYXR0
X2RlYnVnKCkgKGNoYW4gMHg1NjQxZmE0NDUzZDApIEZhaWxlZCB0byBvYnRhaW4gZGlzY29ubmVj
dCBlcnJvcjogQmFkIGZpbGUgZGVzY3JpcHRvcgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpn
YXR0X2RlYnVnKCkgQ2hhbm5lbCAweDU2NDFmYTQ0NTNkMCBkaXNjb25uZWN0ZWQ6IFN1Y2Nlc3MK
Ymx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6Z2F0dF9kZWJ1ZygpIFByaW1hcnkgc2VydmljZSBk
aXNjb3ZlcnkgZmFpbGVkLiBBVFQgRUNPREU6IDB4MDAKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNl
LmM6Z2F0dF9kZWJ1ZygpIEZhaWxlZCB0byBpbml0aWFsaXplIGdhdHQtY2xpZW50CmJsdWV0b290
aGRbXTogc3JjL2RldmljZS5jOmdhdHRfY2xpZW50X3JlYWR5X2NiKCkgc3RhdHVzOiBmYWlsZWQs
IGVycm9yOiAwCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmRldmljZV9zdmNfcmVzb2x2ZWQo
KSAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3IGVyciAtNQpibHVldG9vdGhk
W106IHNyYy9kZXZpY2UuYzphdHRfZGlzY29ubmVjdGVkX2NiKCkKYmx1ZXRvb3RoZFtdOiBzcmMv
ZGV2aWNlLmM6YXR0X2Rpc2Nvbm5lY3RlZF9jYigpIFN1Y2Nlc3MgKDApCmJsdWV0b290aGRbXTog
c3JjL3NlcnZpY2UuYzpjaGFuZ2Vfc3RhdGUoKSAweDU2NDFmYTQzMjdmMDogZGV2aWNlIENEOjFC
OkMzOjk0OjVCOjc3IHByb2ZpbGUgZGV2aWNlaW5mbyBzdGF0ZSBjaGFuZ2VkOiBjb25uZWN0ZWQg
LT4gZGlzY29ubmVjdGluZyAoMCkKYmx1ZXRvb3RoZFtdOiBzcmMvc2VydmljZS5jOmNoYW5nZV9z
dGF0ZSgpIDB4NTY0MWZhNDMyN2YwOiBkZXZpY2UgQ0Q6MUI6QzM6OTQ6NUI6NzcgcHJvZmlsZSBk
ZXZpY2VpbmZvIHN0YXRlIGNoYW5nZWQ6IGRpc2Nvbm5lY3RpbmcgLT4gZGlzY29ubmVjdGVkICgw
KQpibHVldG9vdGhkW106IHNyYy9zZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1NjQxZmE0Mzcx
ZjA6IGRldmljZSBDRDoxQjpDMzo5NDo1Qjo3NyBwcm9maWxlIGdhcC1wcm9maWxlIHN0YXRlIGNo
YW5nZWQ6IGNvbm5lY3RlZCAtPiBkaXNjb25uZWN0aW5nICgwKQpibHVldG9vdGhkW106IHNyYy9z
ZXJ2aWNlLmM6Y2hhbmdlX3N0YXRlKCkgMHg1NjQxZmE0MzcxZjA6IGRldmljZSBDRDoxQjpDMzo5
NDo1Qjo3NyBwcm9maWxlIGdhcC1wcm9maWxlIHN0YXRlIGNoYW5nZWQ6IGRpc2Nvbm5lY3Rpbmcg
LT4gZGlzY29ubmVjdGVkICgwKQpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmJ0ZF9n
YXR0X2NsaWVudF9kaXNjb25uZWN0ZWQoKSBEZXZpY2UgZGlzY29ubmVjdGVkLiBDbGVhbmluZyB1
cC4KYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6YXR0X2Rpc2Nvbm5lY3RlZF9jYigpIEF1dG9t
YXRpYyBjb25uZWN0aW9uIGRpc2FibGVkCmJsdWV0b290aGRbXTogc3JjL2dhdHQtZGF0YWJhc2Uu
YzpidGRfZ2F0dF9kYXRhYmFzZV9hdHRfZGlzY29ubmVjdGVkKCkKYmx1ZXRvb3RoZFtdOiBhdHRy
aWIvZ2F0dHJpYi5jOmdfYXR0cmliX3VucmVmKCkgMHg1NjQxZmE0NDYwZDA6IGdfYXR0cmliX3Vu
cmVmPTAKYmx1ZXRvb3RoZFtdOiBzcmMvYWRhcHRlci5jOmRldl9kaXNjb25uZWN0ZWQoKSBEZXZp
Y2UgQ0Q6MUI6QzM6OTQ6NUI6NzcgZGlzY29ubmVjdGVkLCByZWFzb24gMgpibHVldG9vdGhkW106
IHNyYy9hZGFwdGVyLmM6YWRhcHRlcl9yZW1vdmVfY29ubmVjdGlvbigpCmJsdWV0b290aGRbXTog
cGx1Z2lucy9wb2xpY3kuYzpkaXNjb25uZWN0X2NiKCkgcmVhc29uIDIK
--00000000000080eb7c05dbd8d828
Content-Type: text/plain; charset="US-ASCII"; name="bt-good.txt"
Content-Disposition: attachment; filename="bt-good.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_l1l34az30>
X-Attachment-Id: f_l1l34az30

Ymx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6ZGV2aWNlX2Nvbm5lY3RfbGUoKSBDb25uZWN0aW9u
IGF0dGVtcHQgdG86IENEOjFCOkMzOjk0OjVCOjc3CmJsdWV0b290aGRbXTogc3JjL2FkYXB0ZXIu
Yzpjb25uZWN0ZWRfY2FsbGJhY2soKSBoY2kwIGRldmljZSBDRDoxQjpDMzo5NDo1Qjo3NyBjb25u
ZWN0ZWQgZWlyX2xlbiAzMQpibHVldG9vdGhkW106IGF0dHJpYi9nYXR0cmliLmM6Z19hdHRyaWJf
cmVmKCkgMHg1NTgzNmNlNGQ0MTA6IGdfYXR0cmliX3JlZj0xCmJsdWV0b290aGRbXTogc3JjL2Rl
dmljZS5jOmxvYWRfZ2F0dF9kYigpIFJlc3RvcmluZyBDRDoxQjpDMzo5NDo1Qjo3NyBnYXR0IGRh
dGFiYXNlIGZyb20gZmlsZQpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2Uo
KSBsb2FkaW5nIHNlcnZpY2U6IDB4MDAwMSwgZW5kOiAweDAwMDQsIHV1aWQ6IDAwMDAxODAxLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2Fk
X3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDAxNCwgZW5kOiAweDAwMTgsIHV1aWQ6IDAw
MDAxODAwLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZp
Y2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDAyOCwgZW5kOiAweDAwMzUs
IHV1aWQ6IDAwMDAxODBhLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106
IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDAzOCwgZW5k
OiAweDAwM2QsIHV1aWQ6IDAwMDAxNTMwLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMApibHVl
dG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4
MDA0MCwgZW5kOiAweDAwNmQsIHV1aWQ6IDAwMDBmZWUwLTAwMDAtMTAwMC04MDAwLTAwODA1Zjli
MzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNl
cnZpY2U6IDB4MDA3MCwgZW5kOiAweDAwODEsIHV1aWQ6IDAwMDBmZWUxLTAwMDAtMTAwMC04MDAw
LTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBs
b2FkaW5nIHNlcnZpY2U6IDB4MDA4NCwgZW5kOiAweDAwODksIHV1aWQ6IDAwMDAxODBkLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX3Nl
cnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDA4YywgZW5kOiAweDAwOTEsIHV1aWQ6IDAwMDAx
ODExLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2Uu
Yzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDA5NCwgZW5kOiAweDAwOTYsIHV1
aWQ6IDAwMDAxODAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNy
Yy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDA5OSwgZW5kOiAw
eDAwOWMsIHV1aWQ6IDAwMDAzODAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9v
dGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhh
bmRsZTogMHgwMDAyLCB2YWx1ZSBoYW5kbGU6IDB4MDAwMywgcHJvcGVydGllcyAweDAwMjIgdmFs
dWU6ICB1dWlkOiAwMDAwMmEwNS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3Ro
ZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTog
MHgwMDA0LCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9h
ZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDAxNSwgdmFsdWUgaGFuZGxlOiAweDAwMTYs
IHByb3BlcnRpZXMgMHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMDJhMDAtMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRp
bmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwMTcsIHZhbHVlIGhhbmRsZTogMHgwMDE4LCBw
cm9wZXJ0aWVzIDB4MDAwMiB2YWx1ZTogIHV1aWQ6IDAwMDAyYTAxLTAwMDAtMTAwMC04MDAwLTAw
ODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5n
IGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDI5LCB2YWx1ZSBoYW5kbGU6IDB4MDAyYSwgcHJv
cGVydGllcyAweDAwMDIgdmFsdWU6ICB1dWlkOiAwMDAwMmEyNS0wMDAwLTEwMDAtODAwMC0wMDgw
NWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBj
aGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDAyYiwgdmFsdWUgaGFuZGxlOiAweDAwMmMsIHByb3Bl
cnRpZXMgMHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMDJhMjctMDAwMC0xMDAwLTgwMDAtMDA4MDVm
OWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hh
cmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwMmQsIHZhbHVlIGhhbmRsZTogMHgwMDJlLCBwcm9wZXJ0
aWVzIDB4MDAwMiB2YWx1ZTogIHV1aWQ6IDAwMDAyYTI4LTAwMDAtMTAwMC04MDAwLTAwODA1Zjli
MzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJh
Y3RlcmlzdGljIGhhbmRsZTogMHgwMDJmLCB2YWx1ZSBoYW5kbGU6IDB4MDAzMCwgcHJvcGVydGll
cyAweDAwMDIgdmFsdWU6ICB1dWlkOiAwMDAwMmEyMy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0
ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0
ZXJpc3RpYyBoYW5kbGU6IDB4MDAzMSwgdmFsdWUgaGFuZGxlOiAweDAwMzIsIHByb3BlcnRpZXMg
MHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMDJhNTAtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZi
CmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVy
aXN0aWMgaGFuZGxlOiAweDAwMzMsIHZhbHVlIGhhbmRsZTogMHgwMDM0LCBwcm9wZXJ0aWVzIDB4
MDAxNCB2YWx1ZTogIHV1aWQ6IDAwMDAwMDE0LTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMApi
bHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3Ig
aGFuZGxlOiAweDAwMzUsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2No
cmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDM5LCB2YWx1ZSBoYW5kbGU6
IDB4MDAzYSwgcHJvcGVydGllcyAweDAwMTggdmFsdWU6ICB1dWlkOiAwMDAwMTUzMS0wMDAwLTM1
MTItMjExOC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNj
KCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDNiLCB2YWx1ZTogMHgwMDAwLCB2YWx1
ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtd
OiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6
IDB4MDAzYywgdmFsdWUgaGFuZGxlOiAweDAwM2QsIHByb3BlcnRpZXMgMHgwMDA0IHZhbHVlOiAg
dXVpZDogMDAwMDE1MzItMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbXTog
c3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAw
eDAwNDEsIHZhbHVlIGhhbmRsZTogMHgwMDQyLCBwcm9wZXJ0aWVzIDB4MDAxYSB2YWx1ZTogIHV1
aWQ6IDAwMDAyYTJiLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNy
Yy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNDMs
IHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1
ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNo
YXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDQ0LCB2YWx1ZSBoYW5kbGU6IDB4MDA0NSwgcHJvcGVy
dGllcyAweDAwMWEgdmFsdWU6ICB1dWlkOiAwMDAwMmEwNC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNj
cmlwdG9yIGhhbmRsZTogMHgwMDQ2LCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkw
Mi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6
bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA0NywgdmFsdWUg
aGFuZGxlOiAweDAwNDgsIHByb3BlcnRpZXMgMHgwMDE0IHZhbHVlOiAgdXVpZDogMDAwMDAwMDEt
MDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxv
YWRfZGVzYygpIGxvYWRpbmcgZGVzY3JpcHRvciBoYW5kbGU6IDB4MDA0OSwgdmFsdWU6IDB4MDAw
MCwgdmFsdWUgdXVpZDogMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0
b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMg
aGFuZGxlOiAweDAwNGEsIHZhbHVlIGhhbmRsZTogMHgwMDRiLCBwcm9wZXJ0aWVzIDB4MDAxMCB2
YWx1ZTogIHV1aWQ6IDAwMDAwMDAyLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMApibHVldG9v
dGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxl
OiAweDAwNGMsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04
MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBs
b2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDRkLCB2YWx1ZSBoYW5kbGU6IDB4MDA0
ZSwgcHJvcGVydGllcyAweDAwMTQgdmFsdWU6ICB1dWlkOiAwMDAwMDAwMy0wMDAwLTM1MTItMjEx
OC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9h
ZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDRmLCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlk
OiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMv
ZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA1
MCwgdmFsdWUgaGFuZGxlOiAweDAwNTEsIHByb3BlcnRpZXMgMHgwMDE0IHZhbHVlOiAgdXVpZDog
MDAwMDAwMDQtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbXTogc3JjL2Rl
dmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcgZGVzY3JpcHRvciBoYW5kbGU6IDB4MDA1MiwgdmFs
dWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIz
NGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFj
dGVyaXN0aWMgaGFuZGxlOiAweDAwNTMsIHZhbHVlIGhhbmRsZTogMHgwMDU0LCBwcm9wZXJ0aWVz
IDB4MDAxMCB2YWx1ZTogIHV1aWQ6IDAwMDAwMDA1LTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcw
MApibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0
b3IgaGFuZGxlOiAweDAwNTUsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2Fk
X2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDU2LCB2YWx1ZSBoYW5k
bGU6IDB4MDA1NywgcHJvcGVydGllcyAweDAwMTIgdmFsdWU6ICB1dWlkOiAwMDAwMDAwNi0wMDAw
LTM1MTItMjExOC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9k
ZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDU4LCB2YWx1ZTogMHgwMDAwLCB2
YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3Ro
ZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5k
bGU6IDB4MDA1OSwgdmFsdWUgaGFuZGxlOiAweDAwNWEsIHByb3BlcnRpZXMgMHgwMDEyIHZhbHVl
OiAgdXVpZDogMDAwMDAwMDctMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRb
XTogc3JjL2RldmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcgZGVzY3JpcHRvciBoYW5kbGU6IDB4
MDA1YiwgdmFsdWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRp
bmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwNWYsIHZhbHVlIGhhbmRsZTogMHgwMDYwLCBw
cm9wZXJ0aWVzIDB4MDAxMCB2YWx1ZTogIHV1aWQ6IDAwMDAwMDEwLTAwMDAtMzUxMi0yMTE4LTAw
MDlhZjEwMDcwMApibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5n
IGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNjEsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAw
MDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZp
Y2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDYyLCB2
YWx1ZSBoYW5kbGU6IDB4MDA2MywgcHJvcGVydGllcyAweDAwMDggdmFsdWU6ICB1dWlkOiAwMDAw
MDAwZS0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNl
LmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDY0LCB2YWx1ZTog
MHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkwMS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIK
Ymx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJp
c3RpYyBoYW5kbGU6IDB4MDA2NSwgdmFsdWUgaGFuZGxlOiAweDAwNjYsIHByb3BlcnRpZXMgMHgw
MDE2IHZhbHVlOiAgdXVpZDogMDAwMDAwMjAtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJs
dWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcgZGVzY3JpcHRvciBo
YW5kbGU6IDB4MDA2NywgdmFsdWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAwMDI5MDItMDAwMC0x
MDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hy
YygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwNjgsIHZhbHVlIGhhbmRsZTog
MHgwMDY5LCBwcm9wZXJ0aWVzIDB4MDAxNCB2YWx1ZTogIHV1aWQ6IDAwMDAwMDE2LTAwMDAtMzUx
Mi0yMTE4LTAwMDlhZjEwMDcwMApibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2Mo
KSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNmEsIHZhbHVlOiAweDAwMDAsIHZhbHVl
IHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106
IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTog
MHgwMDZiLCB2YWx1ZSBoYW5kbGU6IDB4MDA2YywgcHJvcGVydGllcyAweDAwMTQgdmFsdWU6ICB1
dWlkOiAwMDAwMDAxNy0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBz
cmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDZk
LCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgw
NWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBj
aGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA3MSwgdmFsdWUgaGFuZGxlOiAweDAwNzIsIHByb3Bl
cnRpZXMgMHgwMDE2IHZhbHVlOiAgdXVpZDogMDAwMDAwMDktMDAwMC0zNTEyLTIxMTgtMDAwOWFm
MTAwNzAwCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcgZGVz
Y3JpcHRvciBoYW5kbGU6IDB4MDA3MywgdmFsdWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAwMDI5
MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5j
OmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwNzQsIHZhbHVl
IGhhbmRsZTogMHgwMDc1LCBwcm9wZXJ0aWVzIDB4MDAwOCB2YWx1ZTogIHV1aWQ6IDAwMDBmZWRk
LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzps
b2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDc2LCB2YWx1ZSBo
YW5kbGU6IDB4MDA3NywgcHJvcGVydGllcyAweDAwMDIgdmFsdWU6ICB1dWlkOiAwMDAwZmVkZS0w
MDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9h
ZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA3OCwgdmFsdWUgaGFu
ZGxlOiAweDAwNzksIHByb3BlcnRpZXMgMHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMGZlZGYtMDAw
MC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRf
Y2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwN2EsIHZhbHVlIGhhbmRs
ZTogMHgwMDdiLCBwcm9wZXJ0aWVzIDB4MDAwYSB2YWx1ZTogIHV1aWQ6IDAwMDBmZWQwLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2No
cmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDdjLCB2YWx1ZSBoYW5kbGU6
IDB4MDA3ZCwgcHJvcGVydGllcyAweDAwMGEgdmFsdWU6ICB1dWlkOiAwMDAwZmVkMS0wMDAwLTEw
MDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJj
KCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA3ZSwgdmFsdWUgaGFuZGxlOiAw
eDAwN2YsIHByb3BlcnRpZXMgMHgwMDAyIHZhbHVlOiAgdXVpZDogMDAwMGZlZDItMDAwMC0xMDAw
LTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygp
IGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwODAsIHZhbHVlIGhhbmRsZTogMHgw
MDgxLCBwcm9wZXJ0aWVzIDB4MDAwYSB2YWx1ZTogIHV1aWQ6IDAwMDBmZWQzLTAwMDAtMTAwMC04
MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBs
b2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDg1LCB2YWx1ZSBoYW5kbGU6IDB4MDA4
NiwgcHJvcGVydGllcyAweDAwMTAgdmFsdWU6ICB1dWlkOiAwMDAwMmEzNy0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9h
ZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDg3LCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlk
OiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMv
ZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA4
OCwgdmFsdWUgaGFuZGxlOiAweDAwODksIHByb3BlcnRpZXMgMHgwMDBhIHZhbHVlOiAgdXVpZDog
MDAwMDJhMzktMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogc3JjL2Rl
dmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwOGQs
IHZhbHVlIGhhbmRsZTogMHgwMDhlLCBwcm9wZXJ0aWVzIDB4MDAwYSB2YWx1ZTogIHV1aWQ6IDAw
MDAyYTQ2LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZp
Y2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDhmLCB2
YWx1ZSBoYW5kbGU6IDB4MDA5MCwgcHJvcGVydGllcyAweDAwMWEgdmFsdWU6ICB1dWlkOiAwMDAw
MmE0NC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNl
LmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDkxLCB2YWx1ZTog
MHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIK
Ymx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJp
c3RpYyBoYW5kbGU6IDB4MDA5NSwgdmFsdWUgaGFuZGxlOiAweDAwOTYsIHByb3BlcnRpZXMgMHgw
MDA0IHZhbHVlOiAgdXVpZDogMDAwMDJhMDYtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJs
dWV0b290aGRbXTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0
aWMgaGFuZGxlOiAweDAwOWEsIHZhbHVlIGhhbmRsZTogMHgwMDliLCBwcm9wZXJ0aWVzIDB4MDAx
YSB2YWx1ZTogIHV1aWQ6IDAwMDA0YTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVl
dG9vdGhkW106IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFu
ZGxlOiAweDAwOWMsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAw
MC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHByb2ZpbGVzL2RldmljZWluZm8vZGV2
aWNlaW5mby5jOmRldmljZWluZm9fYWNjZXB0KCkgZGV2aWNlaW5mbyBwcm9maWxlIGFjY2VwdCAo
Q0Q6MUI6QzM6OTQ6NUI6NzcpCmJsdWV0b290aGRbXTogcHJvZmlsZXMvZGV2aWNlaW5mby9kZXZp
Y2VpbmZvLmM6aGFuZGxlX2NoYXJhY3RlcmlzdGljKCkgVW5zdXBwb3J0ZWQgY2hhcmFjdGVyaXN0
aWM6IDAwMDAyYTI1LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHBy
b2ZpbGVzL2RldmljZWluZm8vZGV2aWNlaW5mby5jOmhhbmRsZV9jaGFyYWN0ZXJpc3RpYygpIFVu
c3VwcG9ydGVkIGNoYXJhY3RlcmlzdGljOiAwMDAwMmEyNy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIKYmx1ZXRvb3RoZFtdOiBwcm9maWxlcy9kZXZpY2VpbmZvL2RldmljZWluZm8uYzpoYW5k
bGVfY2hhcmFjdGVyaXN0aWMoKSBVbnN1cHBvcnRlZCBjaGFyYWN0ZXJpc3RpYzogMDAwMDJhMjgt
MDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbXTogcHJvZmlsZXMvZGV2aWNl
aW5mby9kZXZpY2VpbmZvLmM6aGFuZGxlX2NoYXJhY3RlcmlzdGljKCkgVW5zdXBwb3J0ZWQgY2hh
cmFjdGVyaXN0aWM6IDAwMDAyYTIzLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9v
dGhkW106IHByb2ZpbGVzL2RldmljZWluZm8vZGV2aWNlaW5mby5jOmhhbmRsZV9jaGFyYWN0ZXJp
c3RpYygpIFVuc3VwcG9ydGVkIGNoYXJhY3RlcmlzdGljOiAwMDAwMDAxNC0wMDAwLTM1MTItMjEx
OC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFtdOiBzcmMvc2VydmljZS5jOmNoYW5nZV9zdGF0ZSgp
IDB4NTU4MzZjZTFiMjAwOiBkZXZpY2UgQ0Q6MUI6QzM6OTQ6NUI6NzcgcHJvZmlsZSBkZXZpY2Vp
bmZvIHN0YXRlIGNoYW5nZWQ6IGRpc2Nvbm5lY3RlZCAtPiBjb25uZWN0ZWQgKDApCmJsdWV0b290
aGRbXTogcHJvZmlsZXMvZ2FwL2dhcy5jOmdhcF9hY2NlcHQoKSBHQVAgcHJvZmlsZSBhY2NlcHQg
KENEOjFCOkMzOjk0OjVCOjc3KQpibHVldG9vdGhkW106IHByb2ZpbGVzL2dhcC9nYXMuYzpoYW5k
bGVfYXBwZWFyYW5jZSgpIEZhaWxlZCB0byBzZW5kIHJlcXVlc3QgdG8gcmVhZCBhcHBlYXJhbmNl
CmJsdWV0b290aGRbXTogc3JjL3NlcnZpY2UuYzpjaGFuZ2Vfc3RhdGUoKSAweDU1ODM2Y2UyNWFk
MDogZGV2aWNlIENEOjFCOkMzOjk0OjVCOjc3IHByb2ZpbGUgZ2FwLXByb2ZpbGUgc3RhdGUgY2hh
bmdlZDogZGlzY29ubmVjdGVkIC0+IGNvbm5lY3RlZCAoMCkKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0
dC1jbGllbnQuYzpidGRfZ2F0dF9jbGllbnRfY29ubmVjdGVkKCkgRGV2aWNlIGNvbm5lY3RlZC4K
Ymx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6Z2F0dF9kZWJ1ZygpIChjaGFuIDB4NTU4MzZjZTMx
NzAwKSBBVFQgUERVIHJlY2VpdmVkOiAweDAyCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmdh
dHRfZGVidWcoKSBNVFUgZXhjaGFuZ2UgY29tcGxldGUsIHdpdGggTVRVOiAyNDcKYmx1ZXRvb3Ro
ZFtdOiBzcmMvZGV2aWNlLmM6Z2F0dF9kZWJ1ZygpIE1UVSBleGNoYW5nZSBjb21wbGV0ZSwgd2l0
aCBNVFU6IDI1MgpibHVldG9vdGhkW106IHByb2ZpbGVzL2dhcC9nYXMuYzpyZWFkX2RldmljZV9u
YW1lX2NiKCkgR0FQIERldmljZSBOYW1lOiBBbWF6Zml0IEdUUiAyCmJsdWV0b290aGRbXTogc3Jj
L2RldmljZS5jOmdhdHRfZGVidWcoKSBQcmltYXJ5IHNlcnZpY2VzIGZvdW5kOiAxMApibHVldG9v
dGhkW106IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDAwMSwgZW5kOiAweDAw
MDQsIHV1aWQ6IDAwMDAxODAxLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhk
W106IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDAxNCwgZW5kOiAweDAwMTgs
IHV1aWQ6IDAwMDAxODAwLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106
IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDAyOCwgZW5kOiAweDAwMzUsIHV1
aWQ6IDAwMDAxODBhLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNy
Yy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDAzOCwgZW5kOiAweDAwM2QsIHV1aWQ6
IDAwMDAxNTMwLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMApibHVldG9vdGhkW106IHNyYy9k
ZXZpY2UuYzpnYXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDA0MCwgZW5kOiAweDAwNmQsIHV1aWQ6IDAw
MDBmZWUwLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZp
Y2UuYzpnYXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDA3MCwgZW5kOiAweDAwODEsIHV1aWQ6IDAwMDBm
ZWUxLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2Uu
YzpnYXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDA4NCwgZW5kOiAweDAwODksIHV1aWQ6IDAwMDAxODBk
LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpn
YXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDA4YywgZW5kOiAweDAwOTEsIHV1aWQ6IDAwMDAxODExLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpnYXR0
X2RlYnVnKCkgc3RhcnQ6IDB4MDA5NCwgZW5kOiAweDAwOTYsIHV1aWQ6IDAwMDAxODAyLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpnYXR0X2Rl
YnVnKCkgc3RhcnQ6IDB4MDA5OSwgZW5kOiAweDAwOWMsIHV1aWQ6IDAwMDAzODAyLTAwMDAtMTAw
MC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpnYXR0X2NsaWVu
dF9yZWFkeV9jYigpIHN0YXR1czogc3VjY2VzcywgZXJyb3I6IDEwCmJsdWV0b290aGRbXTogc3Jj
L2dhdHQtY2xpZW50LmM6YnRkX2dhdHRfY2xpZW50X3JlYWR5KCkgR0FUVCBjbGllbnQgcmVhZHkK
Ymx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpjcmVhdGVfc2VydmljZXMoKSBFeHBvcnRp
bmcgb2JqZWN0cyBmb3IgR0FUVCBzZXJ2aWNlczogQ0Q6MUI6QzM6OTQ6NUI6NzcKYmx1ZXRvb3Ro
ZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpzZXJ2aWNlX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgc2Vy
dmljZTogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAwMQpi
bHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4
cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwMDEvY2hhcjAwMDIKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGll
bnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVz
Y3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAw
MS9jaGFyMDAwMi9kZXNjMDAwNApibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZp
Y2VfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBzZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NE
XzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDI4CmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50
LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzog
L29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAyOC9jaGFyMDAy
OQpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgp
IEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJf
QzNfOTRfNUJfNzcvc2VydmljZTAwMjgvY2hhcjAwMmIKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1j
bGllbnQuYzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3Rlcmlz
dGljOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDI4L2No
YXIwMDJkCmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3Jl
YXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9D
RF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAyOC9jaGFyMDAyZgpibHVldG9vdGhkW106IHNyYy9n
YXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFj
dGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAw
MjgvY2hhcjAwMzEKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpjaGFyYWN0ZXJpc3Rp
Y19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAvb3JnL2JsdWV6L2hjaTAv
ZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDI4L2NoYXIwMDMzCmJsdWV0b290aGRbXTog
c3JjL2dhdHQtY2xpZW50LmM6ZGVzY3JpcHRvcl9jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJh
Y3RlcmlzdGljIGRlc2NyaXB0b3I6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJf
Nzcvc2VydmljZTAwMjgvY2hhcjAwMzMvZGVzYzAwMzUKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1j
bGllbnQuYzpzZXJ2aWNlX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgc2VydmljZTogL29yZy9ibHVl
ei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAzOApibHVldG9vdGhkW106IHNy
Yy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hh
cmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vydmlj
ZTAwMzgvY2hhcjAwMzkKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9y
X2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9i
bHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAzOC9jaGFyMDAzOS9kZXNj
MDAzYgpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0
ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0Rf
MUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMzgvY2hhcjAwM2MKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0
dC1jbGllbnQuYzpzZXJ2aWNlX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgc2VydmljZTogL29yZy9i
bHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MApibHVldG9vdGhkW106
IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQg
Y2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vy
dmljZTAwNDAvY2hhcjAwNDEKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlw
dG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29y
Zy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0MS9k
ZXNjMDA0MwpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2Ny
ZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZf
Q0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNDQKYmx1ZXRvb3RoZFtdOiBzcmMv
Z2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVy
aXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9z
ZXJ2aWNlMDA0MC9jaGFyMDA0NC9kZXNjMDA0NgpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVu
dC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6
IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAw
NDcKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4
cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rl
dl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0Ny9kZXNjMDA0OQpibHVldG9v
dGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVk
IEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJf
Nzcvc2VydmljZTAwNDAvY2hhcjAwNGEKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpk
ZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRv
cjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFy
MDA0YS9kZXNjMDA0YwpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3Rlcmlz
dGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNGQKYmx1ZXRvb3RoZFtd
OiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hh
cmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81
Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0ZC9kZXNjMDA0ZgpibHVldG9vdGhkW106IHNyYy9nYXR0
LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVy
aXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAv
Y2hhcjAwNTAKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0
ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9o
Y2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA1MC9kZXNjMDA1Mgpi
bHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4
cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNTMKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGll
bnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVz
Y3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0
MC9jaGFyMDA1My9kZXNjMDA1NQpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJh
Y3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1
ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNTYKYmx1ZXRv
b3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdB
VFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9D
M185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA1Ni9kZXNjMDA1OApibHVldG9vdGhkW106IHNy
Yy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hh
cmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vydmlj
ZTAwNDAvY2hhcjAwNTkKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9y
X2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9i
bHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA1OS9kZXNj
MDA1YgpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0
ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0Rf
MUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNWYKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0
dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0
aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2
aWNlMDA0MC9jaGFyMDA1Zi9kZXNjMDA2MQpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5j
OmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9v
cmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNjIK
Ymx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9y
dGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9D
RF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2Mi9kZXNjMDA2NApibHVldG9vdGhk
W106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdB
VFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcv
c2VydmljZTAwNDAvY2hhcjAwNjUKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNj
cmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjog
L29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2
NS9kZXNjMDA2NwpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGlj
X2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9k
ZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNjgKYmx1ZXRvb3RoZFtdOiBz
cmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFj
dGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83
Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2OC9kZXNjMDA2YQpibHVldG9vdGhkW106IHNyYy9nYXR0LWNs
aWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0
aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hh
cjAwNmIKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgp
IEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kw
L2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2Yi9kZXNjMDA2ZApibHVl
dG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZpY2VfY3JlYXRlKCkgRXhwb3J0ZWQgR0FU
VCBzZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2Uw
MDcwCmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRl
KCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8x
Ql9DM185NF81Ql83Ny9zZXJ2aWNlMDA3MC9jaGFyMDA3MQpibHVldG9vdGhkW106IHNyYy9nYXR0
LWNsaWVudC5jOmRlc2NyaXB0b3JfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3Rp
YyBkZXNjcmlwdG9yOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDcwL2NoYXIwMDcxL2Rlc2MwMDczCmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50LmM6
Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29y
Zy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA3MC9jaGFyMDA3NApi
bHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4
cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwNzAvY2hhcjAwNzYKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGll
bnQuYzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGlj
OiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDcwL2NoYXIw
MDc4CmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRl
KCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8x
Ql9DM185NF81Ql83Ny9zZXJ2aWNlMDA3MC9jaGFyMDA3YQpibHVldG9vdGhkW106IHNyYy9nYXR0
LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVy
aXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNzAv
Y2hhcjAwN2MKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGllbnQuYzpjaGFyYWN0ZXJpc3RpY19j
cmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAvb3JnL2JsdWV6L2hjaTAvZGV2
X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDcwL2NoYXIwMDdlCmJsdWV0b290aGRbXTogc3Jj
L2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFy
YWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNl
MDA3MC9jaGFyMDA4MApibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZpY2VfY3Jl
YXRlKCkgRXhwb3J0ZWQgR0FUVCBzZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0Mz
Xzk0XzVCXzc3L3NlcnZpY2UwMDg0CmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50LmM6Y2hh
cmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9i
bHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA4NC9jaGFyMDA4NQpibHVl
dG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmRlc2NyaXB0b3JfY3JlYXRlKCkgRXhwb3J0ZWQg
R0FUVCBjaGFyYWN0ZXJpc3RpYyBkZXNjcmlwdG9yOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFC
X0MzXzk0XzVCXzc3L3NlcnZpY2UwMDg0L2NoYXIwMDg1L2Rlc2MwMDg3CmJsdWV0b290aGRbXTog
c3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBj
aGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2
aWNlMDA4NC9jaGFyMDA4OApibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZpY2Vf
Y3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBzZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFC
X0MzXzk0XzVCXzc3L3NlcnZpY2UwMDhjCmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50LmM6
Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29y
Zy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA4Yy9jaGFyMDA4ZApi
bHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4
cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwOGMvY2hhcjAwOGYKYmx1ZXRvb3RoZFtdOiBzcmMvZ2F0dC1jbGll
bnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVz
Y3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA4
Yy9jaGFyMDA4Zi9kZXNjMDA5MQpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZp
Y2VfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBzZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NE
XzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDk0CmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50
LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzog
L29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA5NC9jaGFyMDA5
NQpibHVldG9vdGhkW106IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZpY2VfY3JlYXRlKCkgRXhwb3J0
ZWQgR0FUVCBzZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3Nl
cnZpY2UwMDk5CmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNf
Y3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rl
dl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA5OS9jaGFyMDA5YQpibHVldG9vdGhkW106IHNy
Yy9nYXR0LWNsaWVudC5jOmRlc2NyaXB0b3JfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0
ZXJpc3RpYyBkZXNjcmlwdG9yOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3
L3NlcnZpY2UwMDk5L2NoYXIwMDlhL2Rlc2MwMDljCmJsdWV0b290aGRbXTogc3JjL2dhdHQtY2xp
ZW50LmM6YnRkX2dhdHRfY2xpZW50X3JlYWR5KCkgRmVhdHVyZXMgMHgwMApibHVldG9vdGhkW106
IHNyYy9nYXR0LWNsaWVudC5jOmJ0ZF9nYXR0X2NsaWVudF9yZWFkeSgpIFVwZGF0ZSBGZWF0dXJl
cyAweDAwCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmRldmljZV9zdmNfcmVzb2x2ZWQoKSAv
b3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3IGVyciAwCmJsdWV0b290aGRbXTog
c3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSBSZWdpc3RlcmVkIGhhbmRsZXIgZm9yICJTZXJ2aWNl
IENoYW5nZWQiOiAxCmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSAoY2hh
biAweDU1ODM2Y2UzMTcwMCkgQVRUIFBEVSByZWNlaXZlZDogMHgwMgpibHVldG9vdGhkW106IHNy
Yy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgTVRVIGV4Y2hhbmdlIGNvbXBsZXRlLCB3aXRoIE1UVTog
MjQ3CmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSAoY2hhbiAweDU1ODM2
Y2UzMTcwMCkgQVRUIFBEVSByZWNlaXZlZDogMHgwOApibHVldG9vdGhkW106IHNyYy9kZXZpY2Uu
YzpnYXR0X2RlYnVnKCkgUmVhZCBCeSBUeXBlIC0gc3RhcnQ6IDB4MDAwMSBlbmQ6IDB4ZmZmZgpi
bHVldG9vdGhkW106IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgKGNoYW4gMHg1NTgzNmNlMzE3
MDApIEFUVCBQRFUgcmVjZWl2ZWQ6IDB4MDgKYmx1ZXRvb3RoZFtdOiBzcmMvZGV2aWNlLmM6Z2F0
dF9kZWJ1ZygpIFJlYWQgQnkgVHlwZSAtIHN0YXJ0OiAweDAwMTQgZW5kOiAweGZmZmYKYmx1ZXRv
b3RoZFtdOiBzcmMvZGV2aWNlLmM6Z2F0dF9kZWJ1ZygpIChjaGFuIDB4NTU4MzZjZTMxNzAwKSBB
VFQgUERVIHJlY2VpdmVkOiAweDA4CmJsdWV0b290aGRbXTogc3JjL2RldmljZS5jOmdhdHRfZGVi
dWcoKSBSZWFkIEJ5IFR5cGUgLSBzdGFydDogMHgwMDAxIGVuZDogMHhmZmZmCmJsdWV0b290aGRb
XTogc3JjL2dhdHQtZGF0YWJhc2UuYzpnYXBfZGV2aWNlX25hbWVfcmVhZF9jYigpIEdBUCBEZXZp
Y2UgTmFtZSByZWFkIHJlcXVlc3QK
--00000000000080eb7c05dbd8d828--
