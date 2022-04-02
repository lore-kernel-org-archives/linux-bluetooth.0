Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A915FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Apr 2022 08:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbiDBI2S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Apr 2022 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiDBI2R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Apr 2022 04:28:17 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A15133691
        for <linux-bluetooth@vger.kernel.org>; Sat,  2 Apr 2022 01:26:22 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id b21so356385ljf.11
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Apr 2022 01:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duX5mKex1D3dqhfg4I/HawfdvgEqpfDukCnvc/WiFc8=;
        b=nDMgJKApi+GAUH87QEJgD74/Qxry2qDabLJucRL9ap3JFh7pWDl2XxVQhXF+eE9Lnt
         GAQE6n4Ud1nhbclfs19cKqHC7TsNQVAlgjkymJgQqxYVaHtzaZnTt6qiUZaEKvIuipaq
         gyB5EAOAlvx/ei33/Sy/CD/g3dZnqFDDVaBZ9P5a9KwZzA27pVkEwkIR3YbY4IHEveiY
         IJWbYy6W02dk1XquT1NfG2M7M2aXbnYDF2fjPooJPKMWVBU0DUp80Hhqw7uhZf/lfzcN
         5A4CL/Q2bzfaLZyZ+9RMGFVZadmox4KGTccW65FCadE/fZHHv4N0Qp345GnlEAa6loFM
         cLbg==
X-Gm-Message-State: AOAM533Frvl8ykmpijU9ttdarP6alT+iY3pPYCCLlPiKEA3lH0zQ9Jxt
        q3fg1kfx1dzu+67GVo03Y7dSfiIMwrVahTukjCM=
X-Google-Smtp-Source: ABdhPJzWG9bJW9dH/iMS9Eyj+8gc7iSAoHV87G4NSFnOtHq3kiSgKXpez8B1+XVpvuxfq6dUsL458HHeHgW0Pl+Hnwk=
X-Received: by 2002:a2e:a0d5:0:b0:24a:ce91:57f2 with SMTP id
 f21-20020a2ea0d5000000b0024ace9157f2mr15565834ljm.410.1648887980541; Sat, 02
 Apr 2022 01:26:20 -0700 (PDT)
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
 <CANFkB1y19zibcjaUfT7QnDTmkYzWESOnuOr+pYKvZtx7BNjQpg@mail.gmail.com> <CABBYNZL60KgmdY7EPBy=7nPkUogpqXw64j1FeT72=w0Zdj2Z7w@mail.gmail.com>
In-Reply-To: <CABBYNZL60KgmdY7EPBy=7nPkUogpqXw64j1FeT72=w0Zdj2Z7w@mail.gmail.com>
From:   Adam Pigg <adam@piggz.co.uk>
Date:   Sat, 2 Apr 2022 09:26:08 +0100
Message-ID: <CANFkB1x4QYohZUjq2ujN5OtWWRnf1DP3tSYB7W2sg-b0fv1nOA@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000005af7c205dba7a622"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--0000000000005af7c205dba7a622
Content-Type: text/plain; charset="UTF-8"

Hi Luiz

On Fri, 1 Apr 2022 at 22:50, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Adam,
>
> On Fri, Apr 1, 2022 at 1:12 PM Adam Pigg <adam@piggz.co.uk> wrote:
> >
> > Hi Luiz
> >
> > On Mon, 28 Mar 2022 at 17:37, Adam Pigg <adam@piggz.co.uk> wrote:
> > >
> > > Hi Luiz
> > >
> > > On Wed, 23 Mar 2022 at 19:57, Adam Pigg <adam@piggz.co.uk> wrote:
> > > >
> > > > Hi Luiz
> > > >
> > > > Thanks for having the patience with me on this....
> > > >
> > > > On Wed, 23 Mar 2022 at 19:46, Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Adam,
> > > > >
> > > > > On Wed, Mar 23, 2022 at 7:46 AM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > >
> > > > > > On Wed, 23 Mar 2022 at 13:36, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > >
> > > > > > > Hi Luiz
> > > > > > >
> > > > > > > On Wed, 23 Mar 2022 at 09:11, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > >
> > > > > > > > Hi Luiz
> > > > > > > >
> > > > > > > > Good that you clearly know more about this than me!...
> > > > > > > >
> > > > > > > > On Tue, 22 Mar 2022 at 23:44, Luiz Augusto von Dentz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Adam,
> > > > > > > > >
> > > > > > > > > On Tue, Mar 22, 2022 at 4:35 PM Luiz Augusto von Dentz
> > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Adam,
> > > > > > > > > >
> > > > > > > > > > On Tue, Mar 22, 2022 at 4:09 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Thanks Luiz
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 22 Mar 2022 at 21:35, Luiz Augusto von Dentz
> > > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Adam,
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Mar 22, 2022 at 3:40 AM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Hi Luiz
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, 22 Mar 2022 at 07:55, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi Luiz
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Tue, 22 Mar 2022 at 00:44, Luiz Augusto von Dentz
> > > > > > > > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Hi Adam,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Hi
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > A bit of background, I write a linux desktop/mobile app called
> > > > > > > > > > > > > > > > Amazfish which interfaces with several watches over BLE using their
> > > > > > > > > > > > > > > > GATT services.  To do this, I use the bluez dbus api (technically a
> > > > > > > > > > > > > > > > thin wrapper around it I wrote called qble
> > > > > > > > > > > > > > > > https://github.com/piggz/qble)
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > All has been good so far, I support several generations of
> > > > > > > > > > > > > > > > Huami/Amazfit watches, as well as the open source Pinetime and
> > > > > > > > > > > > > > > > Bangle.js.  For the Amazfit watches, i have implementations for older
> > > > > > > > > > > > > > > > devies such as the Bip, and newer ones such as the GTS.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Much of the reverse engineering comes from the Android Gadget Bridge
> > > > > > > > > > > > > > > > project, which supports many more devices.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > My community of users donated to buy me a newer device called a GTR2,
> > > > > > > > > > > > > > > > which, according to the GB devs uses the same protocol as the slightly
> > > > > > > > > > > > > > > > older GTS, and the packet captures I have from Android would support
> > > > > > > > > > > > > > > > this.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > But this is where my trouble starts with Bluez, my existing
> > > > > > > > > > > > > > > > implementation doesnt work at all.  Normally, after a connection, I
> > > > > > > > > > > > > > > > would wait for the ServicesResolved signal, which happens pretty fast
> > > > > > > > > > > > > > > > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > > > > > > > > > > > > > > > which time, the watch has disconnected. (i get a disconnected signal
> > > > > > > > > > > > > > > > immediately after the ServicesResolved signal)
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > To rule out my code, I have tried several things:
> > > > > > > > > > > > > > > > Gatttool
> > > > > > > > > > > > > > > > With gattool, i can connect, get the services, enable a notification,
> > > > > > > > > > > > > > > > write a value and get the expected results seemingly fine
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Python-gatt (using the bluez dbus api)
> > > > > > > > > > > > > > > > Im unable to iterate the services, like my app, it takes 30 seconds to
> > > > > > > > > > > > > > > > get the signal and then swiftly disconnects
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Gattlib (https://github.com/labapart/gattlib)
> > > > > > > > > > > > > > > > Gattlib is interesting as it appears to have "borrowed" much of its
> > > > > > > > > > > > > > > > code directly from bluez.  When built against the system bluez, if the
> > > > > > > > > > > > > > > > version is > 5.42, it will use the dbus api.  When I do this, again im
> > > > > > > > > > > > > > > > unable to list services on the watch.  However, if I edit the build to
> > > > > > > > > > > > > > > > force it to use its internal gatt implementation, which appears to be
> > > > > > > > > > > > > > > > the same one used by gatttool, then, it IS able to interrogate the
> > > > > > > > > > > > > > > > watch.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I have attached 3 files
> > > > > > > > > > > > > > > > 1. test python program which should print services, and associated btmon
> > > > > > > > > > > > > > > > 2. btmon output while using gatttool
> > > > > > > > > > > > > > > > 3. btmon output running gattlib discover example
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Note, other than discovery, I havnt been able to get gattlib to
> > > > > > > > > > > > > > > > read/write/notify!
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > It seems as though I may be triggering a bug in the bluez dbus api?
> > > > > > > > > > > > > > > > Can anyone suggest anything?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > What version are you using? I would first try with the latest to see
> > > > > > > > > > > > > > > if that something already fixed.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > Im using 5.63 already, which is the latest tag (on opensuse tumbleweed)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'll also try bluetoothctl and attach logs using that, though I
> > > > > > > > > > > > > > suspect it will behave the same as the python library and my own
> > > > > > > > > > > > > > library.
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Attached is the output of btmon while using bluetoothctl
> > > > > > > > > > > > >
> > > > > > > > > > > > > bluetoothctl behaves the same as my lib and python, it is unable to
> > > > > > > > > > > > > list services, and after a while, emits the ServicesResolved and
> > > > > > > > > > > > > disconnected messages at the same time.  Im sure it should be able to
> > > > > > > > > > > > > list the services immediately after connect just like gatttool can.
> > > > > > > > > > > >
> > > > > > > > > > > > Looks like there is multiple rounds of MTU Exchange, not sure if that
> > > > > > > > > > > > is actually a problem but the spec does say it shall only be sent once
> > > > > > > > > > > > per client:
> > > > > > > > > > > >
> > > > > > > > > > > > BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> > > > > > > > > > > > page 1424:
> > > > > > > > > > > >
> > > > > > > > > > > > This request shall only be sent once during a connection by the client.
> > > > > > > > > > > >
> > > > > > > > > > > > There is also no response to frame #30:
> > > > > > > > > > > > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> > > > > > > > > > > >
> > > > > > > > > > > >                            #30 [hci0] 26.641557
> > > > > > > > > > > >       ATT: Read Request (0x0a) len 2
> > > > > > > > > > > >         Handle: 0x0018
> > > > > > > > > > > >
> > > > > > > > > > > > So after 30 seconds (ATT timeout) without receiving any response it disconnects:
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > So, the verdict is that the watch isnt acting to spec right?
> > > > > > > > > > >
> > > > > > > > > > > Why does gatttool work ok, is it a completely different implementation?
> > > > > > > > > > >
> > > > > > > > > > > I understand if wouldnt be to spec, but would it be possible to make
> > > > > > > > > > > bluez more resilient to devices not acting to spec?  Android and iOS
> > > > > > > > > > > work just fine in this regard, so could bluez handle mis-behaving
> > > > > > > > > > > devices more flexibly?
> > > > > > > > > >
> > > > > > > > > > That I can't really explain, perhaps it is timing related, something
> > > > > > > > > > with Exchange MTU since it appears to stop the device from responding
> > > > > > > > > > when it happens a second time.
> > > > > > > > > >
> > > > > > > > > > > Do you have any suggestions for things I could try? I looked for
> > > > > > > > > > > similar lines in the working gatttool log, and it doesnt have anything
> > > > > > > > > > > like that, seems to send flags 0x00 dlen 9 (instead of 7?)  ... how is
> > > > > > > > > > > it behaving differently?
> > > > > > > > > >
> > > > > > > > > > Not sure really, does Android/iOS Exchange the MTU? Maybe we need a
> > > > > > > > > > timer to start it later or perhaps the problem first response to
> > > > > > > > > > exchange MTU does actually use the final_mtu which makes the watch to
> > > > > > > > > > trigger yet another exchange to have both rx and tx MTU the same so
> > > > > > > > > > try with the following change:
> > > > > > > > > >
> > > > > > > > > > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > > > > > > > > > index 2adb4afbf..d326782bf 100644
> > > > > > > > > > --- a/src/shared/gatt-server.c
> > > > > > > > > > +++ b/src/shared/gatt-server.c
> > > > > > > > > > @@ -1499,7 +1499,7 @@ static void exchange_mtu_cb(struct bt_att_chan
> > > > > > > > > > *chan, uint8_t opcode,
> > > > > > > > > >         final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
> > > > > > > > > >
> > > > > > > > > >         /* Respond with the server MTU */
> > > > > > > > > > -       put_le16(server->mtu, rsp_pdu);
> > > > > > > > > > +       put_le16(final_mtu, rsp_pdu);
> > > > > > > > > >         bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
> > > > > > > > > >
> > > > > > > > > >         /* Set MTU to be the minimum */
> > > > > > > > >
> > > > > > > > > Hmm Im not sure if this will work since the peripheral seems to
> > > > > > > > > respond different values 252 vs 247, also the spec does say that:
> > > > > > > > >
> > > > > > > > > 'The Server Rx MTU parameter shall be set to the *maximum size* of the
> > > > > > > > > Attribute protocol PDU that the server can receive.
> > > > > > > > > The server and client shall set ATT_MTU to the *minimum of the Client Rx MTU
> > > > > > > > > and the Server Rx MTU*. The size is the same to ensure that a client can
> > > > > > > > > correctly detect the final packet of a long attribute read.'
> > > > > > > > >
> > > > > > > > > So my interpretation is that the minimum is calculated after the
> > > > > > > > > Exchange is complete so it doesn't require the Server MTU to be
> > > > > > > > > limited by the Client MTU, anyway if Android and iOS does apply the
> > > > > > > > > minimum logic before responding we can do the same.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Maybe it will help if I attach an android packet capture....
> > > > > > > >
> > > > > > > > The attachedhttps://marc.info/?l=linux-bluetooth&m=164799909020040&w=2
> > > > > > > > log can be opened in Wireshark, and to my untrained eye, it looks like
> > > > > > > > the MTU negotiation is at packets 451 and 452, and 247 is used?
> > > > > > > >
> > > > > > > > Ill try and get the proposed patch built and see how it behaves
> > > > > > >
> > > > > > > Attached if the btmon and bluetoothctl.  It doesnt seem to be there quite yet.
> > > > > > >
> > > > > > > There was one point before i applied the patch where bluetoothctl
> > > > > > > seemed to list the attributes quickly, but i havnt been able to
> > > > > > > reproduce that again with or without the patch.
> > > > > > >
> > > > > >
> > > > > > For completeness, also attached the output of my program and btmon
> > > > > >
> > > > > > My program should connect, wait for resolved signal, then read a char,
> > > > > > enable some notifications, and do a write.  You can see the 30 second
> > > > > > wait between connect, resolved, and quickly followed by a disconnect.
> > > > >
> > > > >
> > > > > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> > > > >
> > > > >                            #22 [hci0] 12.507730
> > > > >       ATT: Exchange MTU Request (0x02) len 2
> > > > >         Client RX MTU: 517
> > > > > > ACL Data RX: Handle 3585 flags 0x02 dlen 7                                                                                                                             #23 [hci0] 12.556081
> > > > >       ATT: Exchange MTU Request (0x02) len 2
> > > > >         Client RX MTU: 247
> > > > > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> > > > >
> > > > >                            #24 [hci0] 12.556256
> > > > >       ATT: Exchange MTU Response (0x03) len 2
> > > > >         Server RX MTU: 247
> > > > > > ACL Data RX: Handle 3585 flags 0x02 dlen 7                                                                                                                             #27 [hci0] 12.655972
> > > > >       ATT: Exchange MTU Response (0x03) len 2
> > > > >         Server RX MTU: 252
> > > > >
> > > > > So we are now responding with 247 and the peripheral responds with 252
> > > > > to our request :/, so we would need to probably delay our request or
> > > > > something, that said we are the central so I really which we don't
> > > > > have to do it since that would penalize well behaving devices, could
> > > > > we perhaps inform the vendor about these issues? I'd considered this
> > > > > to be really bad behavior from the remote side since they are not
> > > > > following the spec in many respects as even their MTU changes from
> > > > > request to response and it does multiple rounds of Exchange MTU and
> > > > > stop responding while doing it.
> > > > >
> > > >
> > > > I can certainly look into how to contact Huami/Amazfit ... I wouldnt
> > > > count on a response though!
> > > >
> > > > I see you looked at the android log already.
> > > >
> > > > Do you have an idea for a patch I could try out?  Im deep in this now
> > > > anyway, and over-wrote my system bluez :D
> > > >
> > > > Its strange how they have messed up this generation of device as all
> > > > the older ones work fine, and I imagine they must just build on the
> > > > old code base.
> > > >
> > >
> > > I have submitted a support request to Amazfit, describing the issue
> > > and linking to the details in the ML... maybe they will read it!
> > >
> > > Do you think there is anything I can try to make bluez work in the
> > > mean time, even just on my own device?
> > >
> > I had another go at making this work before attempting to write my own
> > gatt lib (!) and i seem to have got it to work, though I dont know if
> > it will be acceptable to bluez, or if there is another way.
> >
> > Probably easiest with the diff:
> > diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
> > index ea3249be9..701677e0a 100644
> > --- a/profiles/gap/gas.c
> > +++ b/profiles/gap/gas.c
> > @@ -142,8 +142,8 @@ static void read_appearance_cb(bool success,
> > uint8_t att_ecode,
> >
> > static void handle_appearance(struct gas *gas, uint16_t value_handle)
> > {
> > -       if (!bt_gatt_client_read_value(gas->client, value_handle,
> > -                                               read_appearance_cb, gas, NULL))
> > +       //if (!bt_gatt_client_read_value(gas->client, value_handle,
> > +       //                                      read_appearance_cb, gas, NULL))
> >                DBG("Failed to send request to read appearance");
>
> Does disabling the read make it work? Does it stop the second MTU exchange?
>
> > }
> >
> > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > index 776e5ce2b..ac0fac1fc 100644
> > --- a/src/shared/gatt-server.c
> > +++ b/src/shared/gatt-server.c
> > @@ -1498,7 +1498,8 @@ static void exchange_mtu_cb(struct bt_att_chan
> > *chan, uint8_t opcode,
> >        final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
> >
> >        /* Respond with the server MTU */
> > -       put_le16(server->mtu, rsp_pdu);
> > +       //put_le16(server->mtu, rsp_pdu);
> > +       put_le16(final_mtu, rsp_pdu);
> >        bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
> >
> >        /* Set MTU to be the minimum */
> >
> > I was running bluetoothd with -n -d, and noticed that the read to the
> > appearance was failing, so, I commented it out.  The read to the name
> > works ok and happens just prior to reading the appearance.
> >
> > I gather it only reads the appearance if the char exists, so, i dont
> > know why that fail, however I dont see 2a01 in the list of
> > services/characteristics, which is the appearance one right?
>
> #define GATT_CHARAC_APPEARANCE 0x2A01
>
> You don't see it on bluetoothd logs or over D-Bus? The latter may not
> contain all the attributes since some are claimed.
>

Gathered some logs this morning, see attached.

So, 2A01 is listed in the bluetoothd debug output, so, I guess its a
fault that it cant be read?  It is not listed in the output of
bluetoothctl list-attributes (also attached) so I could not read the
value using that tool.

Without any other changes, my own lib/app was able to connect to the
watch and start reading data seemingly fine, though I did get an
unexpected disconnected after reading a large amount of step/activity
data, but that  may be unrelated, read/write and notify were all
working.

Could some quirk be used to get around this issue?

> > Any thoughts?
> >
> > Cheers
> >
> >
> >
> > > Thanks
> > >
> > > > > >
> > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > < HCI Command: Disconnect (0x01|0x0006) plen 3
> > > > > > > > > > > >
> > > > > > > > > > > >                            #48 [hci0] 58.673128
> > > > > > > > > > > >         Handle: 3585
> > > > > > > > > > > >         Reason: Remote User Terminated Connection (0x13)
> > > > > > > > > > > >
> > > > > > > > > > > > > Thanks
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > --
> > > > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > Luiz Augusto von Dentz
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Luiz Augusto von Dentz
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz

--0000000000005af7c205dba7a622
Content-Type: text/plain; charset="US-ASCII"; name="gtr2-disable-read-appearance.txt"
Content-Disposition: attachment; filename="gtr2-disable-read-appearance.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_l1hlbk6b0>
X-Attachment-Id: f_l1hlbk6b0

Qmx1ZXRvb3RoY3RsOgoKcGlnZ3pAYWRhbS1sYXB0b3AgfiAkIGJsdWV0b290aGN0bApBZ2VudCBy
ZWdpc3RlcmVkCltibHVldG9vdGhdIyBjb25uZWN0IENEOjFCOkMzOjk0OjVCOjc3CkF0dGVtcHRp
bmcgdG8gY29ubmVjdCB0byBDRDoxQjpDMzo5NDo1Qjo3NwpbQ0hHXSBEZXZpY2UgQ0Q6MUI6QzM6
OTQ6NUI6NzcgQ29ubmVjdGVkOiB5ZXMKQ29ubmVjdGlvbiBzdWNjZXNzZnVsCltORVddIFByaW1h
cnkgU2VydmljZSAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NE
XzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDAxCiAgICAgICAgMDAwMDE4MDEtMDAwMC0xMDAwLTgw
MDAtMDA4MDVmOWIzNGZiCiAgICAgICAgR2VuZXJpYyBBdHRyaWJ1dGUgUHJvZmlsZQpbTkVXXSBD
aGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2
X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDAxL2NoYXIwMDAyCiAgICAgICAgMDAwMDJhMDUt
MDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgU2VydmljZSBDaGFuZ2VkCltORVdd
IERlc2NyaXB0b3IgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9D
RF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAwMS9jaGFyMDAwMi9kZXNjMDAwNAogICAgICAgIDAw
MDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0
ZXJpc3RpYyBDb25maWd1cmF0aW9uCltORVddIFByaW1hcnkgU2VydmljZSAoSGFuZGxlIDB4MDAw
MCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2Uw
MDI4CiAgICAgICAgMDAwMDE4MGEtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAg
RGV2aWNlIEluZm9ybWF0aW9uCltORVddIENoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQog
ICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMjgv
Y2hhcjAwMjkKICAgICAgICAwMDAwMmEyNS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAg
ICAgICBTZXJpYWwgTnVtYmVyIFN0cmluZwpbTkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4
MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDI4L2NoYXIwMDJiCiAgICAgICAgMDAwMDJhMjctMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIz
NGZiCiAgICAgICAgSGFyZHdhcmUgUmV2aXNpb24gU3RyaW5nCltORVddIENoYXJhY3RlcmlzdGlj
IChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRf
NUJfNzcvc2VydmljZTAwMjgvY2hhcjAwMmQKICAgICAgICAwMDAwMmEyOC0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIKICAgICAgICBTb2Z0d2FyZSBSZXZpc2lvbiBTdHJpbmcKW05FV10gQ2hh
cmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9D
RF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAyOC9jaGFyMDAyZgogICAgICAgIDAwMDAyYTIzLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIFN5c3RlbSBJRApbTkVXXSBDaGFyYWN0
ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFC
X0MzXzk0XzVCXzc3L3NlcnZpY2UwMDI4L2NoYXIwMDMxCiAgICAgICAgMDAwMDJhNTAtMDAwMC0x
MDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgUG5QIElECltORVddIENoYXJhY3RlcmlzdGlj
IChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRf
NUJfNzcvc2VydmljZTAwMjgvY2hhcjAwMzMKICAgICAgICAwMDAwMDAxNC0wMDAwLTM1MTItMjEx
OC0wMDA5YWYxMDA3MDAKICAgICAgICBWZW5kb3Igc3BlY2lmaWMKW05FV10gRGVzY3JpcHRvciAo
SGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVC
Xzc3L3NlcnZpY2UwMDI4L2NoYXIwMDMzL2Rlc2MwMDM1CiAgICAgICAgMDAwMDI5MDItMDAwMC0x
MDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQ2xpZW50IENoYXJhY3RlcmlzdGljIENvbmZp
Z3VyYXRpb24KW05FV10gUHJpbWFyeSBTZXJ2aWNlIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9v
cmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMzgKICAgICAgICAw
MDAwMTUzMC0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKICAgICAgICBWZW5kb3Igc3BlY2lm
aWMKW05FV10gQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVl
ei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAzOC9jaGFyMDAzOQogICAgICAg
IDAwMDAxNTMxLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMAogICAgICAgIFZlbmRvciBzcGVj
aWZpYwpbTkVXXSBEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXov
aGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMzgvY2hhcjAwMzkvZGVzYzAwM2IK
ICAgICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGll
bnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpbTkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFu
ZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3
L3NlcnZpY2UwMDM4L2NoYXIwMDNjCiAgICAgICAgMDAwMDE1MzItMDAwMC0zNTEyLTIxMTgtMDAw
OWFmMTAwNzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljCltORVddIFByaW1hcnkgU2VydmljZSAo
SGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVC
Xzc3L3NlcnZpY2UwMDQwCiAgICAgICAgMDAwMGZlZTAtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIz
NGZiCiAgICAgICAgQW5odWkgSHVhbWkgSW5mb3JtYXRpb24gVGVjaG5vbG9neSBDby4sIEx0ZC4K
W05FV10gQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9o
Y2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0MQogICAgICAgIDAw
MDAyYTJiLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIEN1cnJlbnQgVGltZQpb
TkVXXSBEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9k
ZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNDEvZGVzYzAwNDMKICAgICAg
ICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQgQ2hh
cmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpbTkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4
MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDQwL2NoYXIwMDQ0CiAgICAgICAgMDAwMDJhMDQtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIz
NGZiCiAgICAgICAgUGVyaXBoZXJhbCBQcmVmZXJyZWQgQ29ubmVjdGlvbiBQYXJhbWV0ZXJzCltO
RVddIERlc2NyaXB0b3IgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rl
dl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0NC9kZXNjMDA0NgogICAgICAg
IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFy
YWN0ZXJpc3RpYyBDb25maWd1cmF0aW9uCltORVddIENoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgw
MDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vydmlj
ZTAwNDAvY2hhcjAwNDcKICAgICAgICAwMDAwMDAwMS0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3
MDAKICAgICAgICBWZW5kb3Igc3BlY2lmaWMKW05FV10gRGVzY3JpcHRvciAoSGFuZGxlIDB4MDAw
MCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2Uw
MDQwL2NoYXIwMDQ3L2Rlc2MwMDQ5CiAgICAgICAgMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4
MDVmOWIzNGZiCiAgICAgICAgQ2xpZW50IENoYXJhY3RlcmlzdGljIENvbmZpZ3VyYXRpb24KW05F
V10gQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kw
L2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0YQogICAgICAgIDAwMDAw
MDAyLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMAogICAgICAgIFZlbmRvciBzcGVjaWZpYwpb
TkVXXSBEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9k
ZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNGEvZGVzYzAwNGMKICAgICAg
ICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQgQ2hh
cmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpbTkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4
MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDQwL2NoYXIwMDRkCiAgICAgICAgMDAwMDAwMDMtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAw
NzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljCltORVddIERlc2NyaXB0b3IgKEhhbmRsZSAweDAw
MDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNl
MDA0MC9jaGFyMDA0ZC9kZXNjMDA0ZgogICAgICAgIDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAw
ODA1ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0ZXJpc3RpYyBDb25maWd1cmF0aW9uCltO
RVddIENoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNTAKICAgICAgICAwMDAw
MDAwNC0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKICAgICAgICBWZW5kb3Igc3BlY2lmaWMK
W05FV10gRGVzY3JpcHRvciAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAv
ZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDUwL2Rlc2MwMDUyCiAgICAg
ICAgMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQ2xpZW50IENo
YXJhY3RlcmlzdGljIENvbmZpZ3VyYXRpb24KW05FV10gQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAw
eDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2
aWNlMDA0MC9jaGFyMDA1MwogICAgICAgIDAwMDAwMDA1LTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEw
MDcwMAogICAgICAgIFZlbmRvciBzcGVjaWZpYwpbTkVXXSBEZXNjcmlwdG9yIChIYW5kbGUgMHgw
MDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vydmlj
ZTAwNDAvY2hhcjAwNTMvZGVzYzAwNTUKICAgICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0w
MDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpb
TkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hj
aTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDU2CiAgICAgICAgMDAw
MDAwMDYtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmlj
CltORVddIERlc2NyaXB0b3IgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kw
L2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA1Ni9kZXNjMDA1OAogICAg
ICAgIDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIENsaWVudCBD
aGFyYWN0ZXJpc3RpYyBDb25maWd1cmF0aW9uCltORVddIENoYXJhY3RlcmlzdGljIChIYW5kbGUg
MHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vy
dmljZTAwNDAvY2hhcjAwNTkKICAgICAgICAwMDAwMDAwNy0wMDAwLTM1MTItMjExOC0wMDA5YWYx
MDA3MDAKICAgICAgICBWZW5kb3Igc3BlY2lmaWMKW05FV10gRGVzY3JpcHRvciAoSGFuZGxlIDB4
MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDQwL2NoYXIwMDU5L2Rlc2MwMDViCiAgICAgICAgMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiCiAgICAgICAgQ2xpZW50IENoYXJhY3RlcmlzdGljIENvbmZpZ3VyYXRpb24K
W05FV10gQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9o
Y2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA1ZgogICAgICAgIDAw
MDAwMDEwLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMAogICAgICAgIFZlbmRvciBzcGVjaWZp
YwpbTkVXXSBEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNWYvZGVzYzAwNjEKICAg
ICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQg
Q2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpbTkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFuZGxl
IDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3Nl
cnZpY2UwMDQwL2NoYXIwMDYyCiAgICAgICAgMDAwMDAwMGUtMDAwMC0zNTEyLTIxMTgtMDAwOWFm
MTAwNzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljCltORVddIERlc2NyaXB0b3IgKEhhbmRsZSAw
eDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2
aWNlMDA0MC9jaGFyMDA2Mi9kZXNjMDA2NAogICAgICAgIDAwMDAyOTAxLTAwMDAtMTAwMC04MDAw
LTAwODA1ZjliMzRmYgogICAgICAgIENoYXJhY3RlcmlzdGljIFVzZXIgRGVzY3JpcHRpb24KW05F
V10gQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kw
L2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2NQogICAgICAgIDAwMDAw
MDIwLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMAogICAgICAgIFZlbmRvciBzcGVjaWZpYwpb
TkVXXSBEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9k
ZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNjUvZGVzYzAwNjcKICAgICAg
ICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQgQ2hh
cmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpbTkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4
MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDQwL2NoYXIwMDY4CiAgICAgICAgMDAwMDAwMTYtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAw
NzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljCltORVddIERlc2NyaXB0b3IgKEhhbmRsZSAweDAw
MDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNl
MDA0MC9jaGFyMDA2OC9kZXNjMDA2YQogICAgICAgIDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAw
ODA1ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0ZXJpc3RpYyBDb25maWd1cmF0aW9uCltO
RVddIENoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNmIKICAgICAgICAwMDAw
MDAxNy0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKICAgICAgICBWZW5kb3Igc3BlY2lmaWMK
W05FV10gRGVzY3JpcHRvciAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAv
ZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDZiL2Rlc2MwMDZkCiAgICAg
ICAgMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQ2xpZW50IENo
YXJhY3RlcmlzdGljIENvbmZpZ3VyYXRpb24KW05FV10gUHJpbWFyeSBTZXJ2aWNlIChIYW5kbGUg
MHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vy
dmljZTAwNzAKICAgICAgICAwMDAwZmVlMS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAg
ICAgICBBbmh1aSBIdWFtaSBJbmZvcm1hdGlvbiBUZWNobm9sb2d5IENvLiwgTHRkLgpbTkVXXSBD
aGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2
X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDcwL2NoYXIwMDcxCiAgICAgICAgMDAwMDAwMDkt
MDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljCltORVdd
IERlc2NyaXB0b3IgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9D
RF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA3MC9jaGFyMDA3MS9kZXNjMDA3MwogICAgICAgIDAw
MDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0
ZXJpc3RpYyBDb25maWd1cmF0aW9uCltORVddIENoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAw
KQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAw
NzAvY2hhcjAwNzQKICAgICAgICAwMDAwZmVkZC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIK
ICAgICAgICBKYXdib25lCltORVddIENoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAg
ICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNzAvY2hh
cjAwNzYKICAgICAgICAwMDAwZmVkZS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAg
ICBDb2luLCBJbmMuCltORVddIENoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAg
IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNzAvY2hhcjAw
NzgKICAgICAgICAwMDAwZmVkZi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBE
ZXNpZ24gU0hJRlQKW05FV10gQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAg
L29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA3MC9jaGFyMDA3
YQogICAgICAgIDAwMDBmZWQwLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIEFw
cGxlLCBJbmMuCltORVddIENoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9v
cmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNzAvY2hhcjAwN2MK
ICAgICAgICAwMDAwZmVkMS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBBcHBs
ZSwgSW5jLgpbTkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3Jn
L2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDcwL2NoYXIwMDdlCiAg
ICAgICAgMDAwMGZlZDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQXBwbGUs
IEluYy4KW05FV10gQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9i
bHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA3MC9jaGFyMDA4MAogICAg
ICAgIDAwMDBmZWQzLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIEFwcGxlLCBJ
bmMuCltORVddIFByaW1hcnkgU2VydmljZSAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2Js
dWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDg0CiAgICAgICAgMDAwMDE4
MGQtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgSGVhcnQgUmF0ZQpbTkVXXSBD
aGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2
X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDg0L2NoYXIwMDg1CiAgICAgICAgMDAwMDJhMzct
MDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgSGVhcnQgUmF0ZSBNZWFzdXJlbWVu
dApbTkVXXSBEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwODQvY2hhcjAwODUvZGVzYzAwODcKICAg
ICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQg
Q2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpbTkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFuZGxl
IDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3Nl
cnZpY2UwMDg0L2NoYXIwMDg4CiAgICAgICAgMDAwMDJhMzktMDAwMC0xMDAwLTgwMDAtMDA4MDVm
OWIzNGZiCiAgICAgICAgSGVhcnQgUmF0ZSBDb250cm9sIFBvaW50CltORVddIFByaW1hcnkgU2Vy
dmljZSAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0Mz
Xzk0XzVCXzc3L3NlcnZpY2UwMDhjCiAgICAgICAgMDAwMDE4MTEtMDAwMC0xMDAwLTgwMDAtMDA4
MDVmOWIzNGZiCiAgICAgICAgQWxlcnQgTm90aWZpY2F0aW9uIFNlcnZpY2UKW05FV10gQ2hhcmFj
dGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8x
Ql9DM185NF81Ql83Ny9zZXJ2aWNlMDA4Yy9jaGFyMDA4ZAogICAgICAgIDAwMDAyYTQ2LTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIE5ldyBBbGVydApbTkVXXSBDaGFyYWN0ZXJp
c3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0Mz
Xzk0XzVCXzc3L3NlcnZpY2UwMDhjL2NoYXIwMDhmCiAgICAgICAgMDAwMDJhNDQtMDAwMC0xMDAw
LTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQWxlcnQgTm90aWZpY2F0aW9uIENvbnRyb2wgUG9p
bnQKW05FV10gRGVzY3JpcHRvciAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hj
aTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDhjL2NoYXIwMDhmL2Rlc2MwMDkxCiAg
ICAgICAgMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQ2xpZW50
IENoYXJhY3RlcmlzdGljIENvbmZpZ3VyYXRpb24KW05FV10gUHJpbWFyeSBTZXJ2aWNlIChIYW5k
bGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcv
c2VydmljZTAwOTQKICAgICAgICAwMDAwMTgwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIK
ICAgICAgICBJbW1lZGlhdGUgQWxlcnQKW05FV10gQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAw
MDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNl
MDA5NC9jaGFyMDA5NQogICAgICAgIDAwMDAyYTA2LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRm
YgogICAgICAgIEFsZXJ0IExldmVsCltORVddIFByaW1hcnkgU2VydmljZSAoSGFuZGxlIDB4MDAw
MCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2Uw
MDk5CiAgICAgICAgMDAwMDM4MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAg
VW5rbm93bgpbTkVXXSBDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3Jn
L2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDk5L2NoYXIwMDlhCiAg
ICAgICAgMDAwMDRhMDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgVW5rbm93
bgpbTkVXXSBEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwOTkvY2hhcjAwOWEvZGVzYzAwOWMKICAg
ICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQg
Q2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpbQ0hHXSBEZXZpY2UgQ0Q6MUI6QzM6OTQ6NUI6
NzcgU2VydmljZXNSZXNvbHZlZDogeWVzCltDSEddIERldmljZSBDRDoxQjpDMzo5NDo1Qjo3NyBQ
YWlyZWQ6IHllcwpbQ0hHXSBEZXZpY2UgQ0Q6MUI6QzM6OTQ6NUI6NzcgU2VydmljZXNSZXNvbHZl
ZDogbm8KW0NIR10gRGV2aWNlIENEOjFCOkMzOjk0OjVCOjc3IENvbm5lY3RlZDogbm8KW0NIR10g
Q29udHJvbGxlciBEQzo1Mzo2MDo1MTowMDpDNiBQb3dlcmVkOiBubwpbQ0hHXSBDb250cm9sbGVy
IERDOjUzOjYwOjUxOjAwOkM2IERpc2NvdmVyaW5nOiBubwpBZ2VudCB1bnJlZ2lzdGVyZWQKCgoK
Ci0tLS0tLS0tLS0KCkJ0bW9uOgoKcGlnZ3pAYWRhbS1sYXB0b3AgfiAkIHN1ZG8gYnRtb24KQmx1
ZXRvb3RoIG1vbml0b3IgdmVyIDUuNjMKPSBOb3RlOiBMaW51eCB2ZXJzaW9uIDUuMTYuMTUtMS1k
ZWZhdWx0ICh4ODZfNjQpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMC4wNzE5MDkKPSBOb3RlOiBCbHVldG9v
dGggc3Vic3lzdGVtIHZlcnNpb24gMi4yMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMC4wNzE5
MTcKPSBOZXcgSW5kZXg6IERDOjUzOjYwOjUxOjAwOkM2IChQcmltYXJ5LFVTQixoY2kwKSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBbaGNpMF0gMC4wNzE5MTkKPSBPcGVuIEluZGV4OiBEQzo1Mzo2MDo1MTowMDpDNiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMC4wNzE5MjAKPSBJbmRleCBJbmZvOiBEQzo1
Mzo2MDo1MTowMDpDNiAoSW50ZWwgQ29ycC4pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMC4wNzE5MjIK
QCBNR01UIE9wZW46IGJsdWV0b290aGQgKHByaXZpbGVnZWQpIHZlcnNpb24gMS4yMSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ezB4MDAwMX0gMC4wNzE5MjQKPCBIQ0kgQ29tbWFuZDogTEUgU2V0IFNjYW4gUGFyYW1ldGVycyAo
MHgwOHwweDAwMGIpIHBsZW4gNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAjMSBbaGNpMF0gNS41NTQ5NTYKICAgICAgICBUeXBlOiBQYXNzaXZl
ICgweDAwKQogICAgICAgIEludGVydmFsOiA2MC4wMDAgbXNlYyAoMHgwMDYwKQogICAgICAgIFdp
bmRvdzogNjAuMDAwIG1zZWMgKDB4MDA2MCkKICAgICAgICBPd24gYWRkcmVzcyB0eXBlOiBQdWJs
aWMgKDB4MDApCiAgICAgICAgRmlsdGVyIHBvbGljeTogQWNjZXB0IGFsbCBhZHZlcnRpc2VtZW50
ICgweDAwKQo+IEhDSSBFdmVudDogQ29tbWFuZCBDb21wbGV0ZSAoMHgwZSkgcGxlbiA0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICMyIFtoY2kwXSA1LjY3Mjk1NwogICAgICBMRSBTZXQgU2NhbiBQYXJhbWV0ZXJzICgw
eDA4fDB4MDAwYikgbmNtZCAxCiAgICAgICAgU3RhdHVzOiBTdWNjZXNzICgweDAwKQo8IEhDSSBD
b21tYW5kOiBMRSBTZXQgU2NhbiBFbmFibGUgKDB4MDh8MHgwMDBjKSBwbGVuIDIgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMzIFtoY2kw
XSA1LjY3MzAzMQogICAgICAgIFNjYW5uaW5nOiBFbmFibGVkICgweDAxKQogICAgICAgIEZpbHRl
ciBkdXBsaWNhdGVzOiBFbmFibGVkICgweDAxKQo+IEhDSSBFdmVudDogQ29tbWFuZCBDb21wbGV0
ZSAoMHgwZSkgcGxlbiA0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICM0IFtoY2kwXSA1LjY3Mzk0MwogICAgICBMRSBT
ZXQgU2NhbiBFbmFibGUgKDB4MDh8MHgwMDBjKSBuY21kIDIKICAgICAgICBTdGF0dXM6IFN1Y2Nl
c3MgKDB4MDApCj4gSENJIEV2ZW50OiBMRSBNZXRhIEV2ZW50ICgweDNlKSBwbGVuIDQwICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIzUgW2hjaTBdIDUuODIzOTg5CiAgICAgIExFIEFkdmVydGlzaW5nIFJlcG9ydCAo
MHgwMikKICAgICAgICBOdW0gcmVwb3J0czogMQogICAgICAgIEV2ZW50IHR5cGU6IFNjYW5uYWJs
ZSB1bmRpcmVjdGVkIC0gQURWX1NDQU5fSU5EICgweDAyKQogICAgICAgIEFkZHJlc3MgdHlwZTog
UmFuZG9tICgweDAxKQogICAgICAgIEFkZHJlc3M6IDczOkJDOkJCOkMyOkMxOjExIChSZXNvbHZh
YmxlKQogICAgICAgIERhdGEgbGVuZ3RoOiAyOAogICAgICAgIDE2LWJpdCBTZXJ2aWNlIFVVSURz
IChjb21wbGV0ZSk6IDEgZW50cnkKICAgICAgICAgIEdvb2dsZSAoMHhmZTlmKQogICAgICAgIFNl
cnZpY2UgRGF0YSAoVVVJRCAweGZlOWYpOiAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwCiAgICAgICAgUlNTSTogLTc5IGRCbSAoMHhiMSkKPiBIQ0kgRXZlbnQ6IExFIE1l
dGEgRXZlbnQgKDB4M2UpIHBsZW4gNDMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNiBbaGNpMF0gNi4zOTMwMDEK
ICAgICAgTEUgQWR2ZXJ0aXNpbmcgUmVwb3J0ICgweDAyKQogICAgICAgIE51bSByZXBvcnRzOiAx
CiAgICAgICAgRXZlbnQgdHlwZTogQ29ubmVjdGFibGUgdW5kaXJlY3RlZCAtIEFEVl9JTkQgKDB4
MDApCiAgICAgICAgQWRkcmVzcyB0eXBlOiBSYW5kb20gKDB4MDEpCiAgICAgICAgQWRkcmVzczog
Q0Q6MUI6QzM6OTQ6NUI6NzcgKFN0YXRpYykKICAgICAgICBEYXRhIGxlbmd0aDogMzEKICAgICAg
ICBGbGFnczogMHgwMgogICAgICAgICAgTEUgR2VuZXJhbCBEaXNjb3ZlcmFibGUgTW9kZQogICAg
ICAgIENvbXBhbnk6IEFuaHVpIEh1YW1pIEluZm9ybWF0aW9uIFRlY2hub2xvZ3kgQ28uLCBMdGQu
ICgzNDMpCiAgICAgICAgICBEYXRhOiAwMmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
MDNjZDFiYzM5NDViNzcKICAgICAgICBSU1NJOiAtNTkgZEJtICgweGM1KQo8IEhDSSBDb21tYW5k
OiBMRSBTZXQgU2NhbiBFbmFibGUgKDB4MDh8MHgwMDBjKSBwbGVuIDIgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM3IFtoY2kwXSA2LjM5
MzEwOQogICAgICAgIFNjYW5uaW5nOiBEaXNhYmxlZCAoMHgwMCkKICAgICAgICBGaWx0ZXIgZHVw
bGljYXRlczogRGlzYWJsZWQgKDB4MDApCj4gSENJIEV2ZW50OiBMRSBNZXRhIEV2ZW50ICgweDNl
KSBwbGVuIDIwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIzggW2hjaTBdIDYuNDAzMDQxCiAgICAgIExFIEFkdmVy
dGlzaW5nIFJlcG9ydCAoMHgwMikKICAgICAgICBOdW0gcmVwb3J0czogMQogICAgICAgIEV2ZW50
IHR5cGU6IE5vbiBjb25uZWN0YWJsZSB1bmRpcmVjdGVkIC0gQURWX05PTkNPTk5fSU5EICgweDAz
KQogICAgICAgIEFkZHJlc3MgdHlwZTogUmFuZG9tICgweDAxKQogICAgICAgIEFkZHJlc3M6IEM1
OjEwOjY0OjBEOjUwOjRBIChTdGF0aWMpCiAgICAgICAgRGF0YSBsZW5ndGg6IDgKICAgICAgICBD
b21wYW55OiBBcHBsZSwgSW5jLiAoNzYpCiAgICAgICAgICBUeXBlOiBVbmtub3duICgxOCkKICAg
ICAgICAgIERhdGE6IDAwMDEKICAgICAgICBSU1NJOiAtNzEgZEJtICgweGI5KQo+IEhDSSBFdmVu
dDogQ29tbWFuZCBDb21wbGV0ZSAoMHgwZSkgcGxlbiA0ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM5IFtoY2kwXSA2
LjQwMzk1MwogICAgICBMRSBTZXQgU2NhbiBFbmFibGUgKDB4MDh8MHgwMDBjKSBuY21kIDIKICAg
ICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApCjwgSENJIENvbW1hbmQ6IExFIENyZWF0ZSBDb25u
ZWN0aW9uICgweDA4fDB4MDAwZCkgcGxlbiAyNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAjMTAgW2hjaTBdIDYuNDA0MDM5CiAgICAgICAgU2Nh
biBpbnRlcnZhbDogNjAuMDAwIG1zZWMgKDB4MDA2MCkKICAgICAgICBTY2FuIHdpbmRvdzogNjAu
MDAwIG1zZWMgKDB4MDA2MCkKICAgICAgICBGaWx0ZXIgcG9saWN5OiBBY2NlcHQgbGlzdCBpcyBu
b3QgdXNlZCAoMHgwMCkKICAgICAgICBQZWVyIGFkZHJlc3MgdHlwZTogUmFuZG9tICgweDAxKQog
ICAgICAgIFBlZXIgYWRkcmVzczogQ0Q6MUI6QzM6OTQ6NUI6NzcgKFN0YXRpYykKICAgICAgICBP
d24gYWRkcmVzcyB0eXBlOiBQdWJsaWMgKDB4MDApCiAgICAgICAgTWluIGNvbm5lY3Rpb24gaW50
ZXJ2YWw6IDMwLjAwIG1zZWMgKDB4MDAxOCkKICAgICAgICBNYXggY29ubmVjdGlvbiBpbnRlcnZh
bDogNTAuMDAgbXNlYyAoMHgwMDI4KQogICAgICAgIENvbm5lY3Rpb24gbGF0ZW5jeTogMCAoMHgw
MDAwKQogICAgICAgIFN1cGVydmlzaW9uIHRpbWVvdXQ6IDQyMCBtc2VjICgweDAwMmEpCiAgICAg
ICAgTWluIGNvbm5lY3Rpb24gbGVuZ3RoOiAwLjAwMCBtc2VjICgweDAwMDApCiAgICAgICAgTWF4
IGNvbm5lY3Rpb24gbGVuZ3RoOiAwLjAwMCBtc2VjICgweDAwMDApCj4gSENJIEV2ZW50OiBDb21t
YW5kIFN0YXR1cyAoMHgwZikgcGxlbiA0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMTEgW2hjaTBdIDYuNDA0OTU5
CiAgICAgIExFIENyZWF0ZSBDb25uZWN0aW9uICgweDA4fDB4MDAwZCkgbmNtZCAyCiAgICAgICAg
U3RhdHVzOiBTdWNjZXNzICgweDAwKQo+IEhDSSBFdmVudDogTEUgTWV0YSBFdmVudCAoMHgzZSkg
cGxlbiAxOSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIzEyIFtoY2kwXSA3LjI0NjAxNgogICAgICBMRSBDb25uZWN0
aW9uIENvbXBsZXRlICgweDAxKQogICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkKICAgICAg
ICBIYW5kbGU6IDM1ODUKICAgICAgICBSb2xlOiBDZW50cmFsICgweDAwKQogICAgICAgIFBlZXIg
YWRkcmVzcyB0eXBlOiBSYW5kb20gKDB4MDEpCiAgICAgICAgUGVlciBhZGRyZXNzOiBDRDoxQjpD
Mzo5NDo1Qjo3NyAoU3RhdGljKQogICAgICAgIENvbm5lY3Rpb24gaW50ZXJ2YWw6IDUwLjAwIG1z
ZWMgKDB4MDAyOCkKICAgICAgICBDb25uZWN0aW9uIGxhdGVuY3k6IDAgKDB4MDAwMCkKICAgICAg
ICBTdXBlcnZpc2lvbiB0aW1lb3V0OiA0MjAgbXNlYyAoMHgwMDJhKQogICAgICAgIENlbnRyYWwg
Y2xvY2sgYWNjdXJhY3k6IDB4MDAKQCBNR01UIEV2ZW50OiBEZXZpY2UgQ29ubmVjdGVkICgweDAw
MGIpIHBsZW4gNDQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB7MHgwMDAxfSBbaGNpMF0gNy4yNDYxMjQKICAgICAgICBMRSBBZGRyZXNz
OiBDRDoxQjpDMzo5NDo1Qjo3NyAoU3RhdGljKQogICAgICAgIEZsYWdzOiAweDAwMDAwMDA4CiAg
ICAgICAgICBDb25uZWN0aW9uIExvY2FsbHkgSW5pdGlhdGVkCiAgICAgICAgRGF0YSBsZW5ndGg6
IDMxCiAgICAgICAgRmxhZ3M6IDB4MDIKICAgICAgICAgIExFIEdlbmVyYWwgRGlzY292ZXJhYmxl
IE1vZGUKICAgICAgICBDb21wYW55OiBBbmh1aSBIdWFtaSBJbmZvcm1hdGlvbiBUZWNobm9sb2d5
IENvLiwgTHRkLiAoMzQzKQogICAgICAgICAgRGF0YTogMDJmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZjAzY2QxYmMzOTQ1Yjc3CjwgSENJIENvbW1hbmQ6IExFIFJlYWQgUmVtb3RlIFVz
ZWQgRmVhdHVyZXMgKDB4MDh8MHgwMDE2KSBwbGVuIDIgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjMTMgW2hjaTBdIDcuMjQ2MzIxCiAgICAgICAgSGFuZGxl
OiAzNTg1Cj4gSENJIEV2ZW50OiBDb21tYW5kIFN0YXR1cyAoMHgwZikgcGxlbiA0ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAjMTQgW2hjaTBdIDcuMjQ2OTM5CiAgICAgIExFIFJlYWQgUmVtb3RlIFVzZWQgRmVhdHVy
ZXMgKDB4MDh8MHgwMDE2KSBuY21kIDEKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApCj4g
SENJIEV2ZW50OiBMRSBNZXRhIEV2ZW50ICgweDNlKSBwbGVuIDEyICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMTUg
W2hjaTBdIDcuMjU2OTY3CiAgICAgIExFIFJlYWQgUmVtb3RlIFVzZWQgRmVhdHVyZXMgKDB4MDQp
CiAgICAgICAgU3RhdHVzOiBTdWNjZXNzICgweDAwKQogICAgICAgIEhhbmRsZTogMzU4NQogICAg
ICAgIEZlYXR1cmVzOiAweDAxIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAKICAg
ICAgICAgIExFIEVuY3J5cHRpb24KPCBIQ0kgQ29tbWFuZDogTEUgU3RhcnQgRW5jcnlwdGlvbiAo
MHgwOHwweDAwMTkpIHBsZW4gMjggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICMxNiBbaGNpMF0gNy4yNTcwNzgKICAgICAgICBIYW5kbGU6IDM1
ODUKICAgICAgICBSYW5kb20gbnVtYmVyOiAweGRiOWU0YTFkOTk3NjMyNTQKICAgICAgICBFbmNy
eXB0ZWQgZGl2ZXJzaWZpZXI6IDB4ZTc4MwogICAgICAgIExvbmcgdGVybSBrZXk6IGM1YjIxMDg3
NzVhYTNlYTQwMjE5ZmZmZWQxMTcyZjU5Cj4gSENJIEV2ZW50OiBDb21tYW5kIFN0YXR1cyAoMHgw
ZikgcGxlbiA0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjMTcgW2hjaTBdIDcuMjU3OTUwCiAgICAgIExFIFN0YXJ0
IEVuY3J5cHRpb24gKDB4MDh8MHgwMDE5KSBuY21kIDEKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3Mg
KDB4MDApCj4gSENJIEV2ZW50OiBFbmNyeXB0aW9uIENoYW5nZSAoMHgwOCkgcGxlbiA0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAjMTggW2hjaTBdIDcuNzA2MDE0CiAgICAgICAgU3RhdHVzOiBTdWNjZXNzICgweDAwKQog
ICAgICAgIEhhbmRsZTogMzU4NQogICAgICAgIEVuY3J5cHRpb246IEVuYWJsZWQgd2l0aCBBRVMt
Q0NNICgweDAxKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAwIGRsZW4gNyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIzE5IFtoY2kwXSA3LjczNzM3MwogICAgICBBVFQ6IEV4Y2hhbmdlIE1UVSBSZXF1
ZXN0ICgweDAyKSBsZW4gMgogICAgICAgIENsaWVudCBSWCBNVFU6IDUxNwo+IEFDTCBEYXRhIFJY
OiBIYW5kbGUgMzU4NSBmbGFncyAweDAyIGRsZW4gNyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzIwIFtoY2kwXSA3Ljc1
NTcxNgogICAgICBBVFQ6IEV4Y2hhbmdlIE1UVSBSZXF1ZXN0ICgweDAyKSBsZW4gMgogICAgICAg
IENsaWVudCBSWCBNVFU6IDI0Nwo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAw
IGRsZW4gNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIzIxIFtoY2kwXSA3Ljc1NjQyMgogICAgICBBVFQ6IEV4Y2hhbmdl
IE1UVSBSZXNwb25zZSAoMHgwMykgbGVuIDIKICAgICAgICBTZXJ2ZXIgUlggTVRVOiAyNDcKPiBI
Q0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyMiBb
aGNpMF0gNy43NTY5MzYKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4
NQogICAgICAgIENvdW50OiAxCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tl
dHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAjMjMgW2hjaTBdIDcuODA2OTcyCiAgICAgICAgTnVtIGhhbmRsZXM6
IDEKICAgICAgICBIYW5kbGU6IDM1ODUKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJYOiBI
YW5kbGUgMzU4NSBmbGFncyAweDAyIGRsZW4gNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzI0IFtoY2kwXSA3Ljg1NTc4
NAogICAgICBBVFQ6IEV4Y2hhbmdlIE1UVSBSZXNwb25zZSAoMHgwMykgbGVuIDIKICAgICAgICBT
ZXJ2ZXIgUlggTVRVOiAyNTIKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMCBk
bGVuIDcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICMyNSBbaGNpMF0gNy44NTY0NTQKICAgICAgQVRUOiBSZWFkIFJlcXVl
c3QgKDB4MGEpIGxlbiAyCiAgICAgICAgSGFuZGxlOiAweDAwMzIKPiBIQ0kgRXZlbnQ6IE51bWJl
ciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyNiBbaGNpMF0gNy45MDYxMzYK
ICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAgIENvdW50
OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIgZGxlbiAxMiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAjMjcgW2hjaTBdIDcuOTU1ODQwCiAgICAgIEFUVDogUmVhZCBSZXNwb25zZSAoMHgwYikgbGVu
IDcKICAgICAgICBWYWx1ZTogMDE1NzAxNDAwMDAxMDEKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1
ODUgZmxhZ3MgMHgwMCBkbGVuIDcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyOCBbaGNpMF0gNy45NTYzMDEKICAgICAg
QVRUOiBSZWFkIFJlcXVlc3QgKDB4MGEpIGxlbiAyCiAgICAgICAgSGFuZGxlOiAweDAwMTYKPiBI
Q0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyOSBb
aGNpMF0gOC4wMDYwMjkKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4
NQogICAgICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIg
ZGxlbiAxOSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAjMzAgW2hjaTBdIDguMDU1ODAyCiAgICAgIEFUVDogUmVhZCBSZXNw
b25zZSAoMHgwYikgbGVuIDE0CiAgICAgICAgVmFsdWU6IDQxNmQ2MTdhNjY2OTc0MjA0NzU0NTIy
MDMyMDAKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMCBkbGVuIDExICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICMzMSBbaGNpMF0gOC4wNTY2MjcKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAo
MHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAwMS0weGZmZmYKICAgICAgICBB
dHRyaWJ1dGUgdHlwZTogU2VydmVyIFN1cHBvcnRlZCBGZWF0dXJlcyAoMHgyYjNhKQo+IEhDSSBF
dmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzMyIFtoY2kw
XSA4LjEwNTk2OQogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiAzNTg1CiAg
ICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMiBkbGVu
IDkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICMzMyBbaGNpMF0gOC4xNTU3OTYKICAgICAgQVRUOiBFcnJvciBSZXNwb25z
ZSAoMHgwMSkgbGVuIDQKICAgICAgICBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkKICAgICAg
ICBIYW5kbGU6IDB4MDAwMQogICAgICAgIEVycm9yOiBBdHRyaWJ1dGUgTm90IEZvdW5kICgweDBh
KQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAwIGRsZW4gMTEgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IzM0IFtoY2kwXSA4LjE1NjE1MgogICAgICBBVFQ6IFJlYWQgQnkgR3JvdXAgVHlwZSBSZXF1ZXN0
ICgweDEwKSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDAxLTB4ZmZmZgogICAgICAg
IEF0dHJpYnV0ZSBncm91cCB0eXBlOiBQcmltYXJ5IFNlcnZpY2UgKDB4MjgwMCkKPiBIQ0kgRXZl
bnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMzNSBbaGNpMF0g
OC4yMDYxODkKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAg
ICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIgZGxlbiAy
NCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAjMzYgW2hjaTBdIDguMjU1Nzc0CiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBU
eXBlIFJlc3BvbnNlICgweDExKSBsZW4gMTkKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6
IDYKICAgICAgICBBdHRyaWJ1dGUgZ3JvdXAgbGlzdDogMyBlbnRyaWVzCiAgICAgICAgSGFuZGxl
IHJhbmdlOiAweDAwMDEtMHgwMDA0CiAgICAgICAgVVVJRDogR2VuZXJpYyBBdHRyaWJ1dGUgUHJv
ZmlsZSAoMHgxODAxKQogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDE0LTB4MDAxOAogICAgICAg
IFVVSUQ6IEdlbmVyaWMgQWNjZXNzIFByb2ZpbGUgKDB4MTgwMCkKICAgICAgICBIYW5kbGUgcmFu
Z2U6IDB4MDAyOC0weDAwMzUKICAgICAgICBVVUlEOiBEZXZpY2UgSW5mb3JtYXRpb24gKDB4MTgw
YSkKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMCBkbGVuIDExICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICMzNyBbaGNpMF0gOC4yNTYxMzYKICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVxdWVz
dCAoMHgxMCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAzNi0weGZmZmYKICAgICAg
ICBBdHRyaWJ1dGUgZ3JvdXAgdHlwZTogUHJpbWFyeSBTZXJ2aWNlICgweDI4MDApCj4gSENJIEV2
ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMzggW2hjaTBd
IDguMzA2MTU5CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDM1ODUKICAg
ICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAyIGRsZW4g
MjYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIzM5IFtoY2kwXSA4LjM1NTk5MgogICAgICBBVFQ6IFJlYWQgQnkgR3JvdXAg
VHlwZSBSZXNwb25zZSAoMHgxMSkgbGVuIDIxCiAgICAgICAgQXR0cmlidXRlIGRhdGEgbGVuZ3Ro
OiAyMAogICAgICAgIEF0dHJpYnV0ZSBncm91cCBsaXN0OiAxIGVudHJ5CiAgICAgICAgSGFuZGxl
IHJhbmdlOiAweDAwMzgtMHgwMDNkCiAgICAgICAgVVVJRDogVmVuZG9yIHNwZWNpZmljICgwMDAw
MTUzMC0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDApCjwgQUNMIERhdGEgVFg6IEhhbmRsZSAz
NTg1IGZsYWdzIDB4MDAgZGxlbiAxMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNDAgW2hjaTBdIDguMzU2NDI0CiAgICAg
IEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVlc3QgKDB4MTApIGxlbiA2CiAgICAgICAgSGFu
ZGxlIHJhbmdlOiAweDAwM2UtMHhmZmZmCiAgICAgICAgQXR0cmlidXRlIGdyb3VwIHR5cGU6IFBy
aW1hcnkgU2VydmljZSAoMHgyODAwKQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQ
YWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIzQxIFtoY2kwXSA4LjQwNTk0MgogICAgICAgIE51bSBoYW5k
bGVzOiAxCiAgICAgICAgSGFuZGxlOiAzNTg1CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBS
WDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMiBkbGVuIDI3ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM0MiBbaGNpMF0gOC40
NTU4MjUKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMSBkbGVuIDE1ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICM0MyBbaGNpMF0gOC40NTY2NzEKICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVz
cG9uc2UgKDB4MTEpIGxlbiAzNwogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxlbmd0aDogNgogICAg
ICAgIEF0dHJpYnV0ZSBncm91cCBsaXN0OiA2IGVudHJpZXMKICAgICAgICBIYW5kbGUgcmFuZ2U6
IDB4MDA0MC0weDAwNmQKICAgICAgICBVVUlEOiBBbmh1aSBIdWFtaSBJbmZvcm1hdGlvbiBUZWNo
bm9sb2d5IENvLiwgTHRkLiAgKDB4ZmVlMCkKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDA3MC0w
eDAwODEKICAgICAgICBVVUlEOiBBbmh1aSBIdWFtaSBJbmZvcm1hdGlvbiBUZWNobm9sb2d5IENv
LiwgTHRkLiAgKDB4ZmVlMSkKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDA4NC0weDAwODkKICAg
ICAgICBVVUlEOiBIZWFydCBSYXRlICgweDE4MGQpCiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAw
OGMtMHgwMDkxCiAgICAgICAgVVVJRDogQWxlcnQgTm90aWZpY2F0aW9uIFNlcnZpY2UgKDB4MTgx
MSkKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDA5NC0weDAwOTYKICAgICAgICBVVUlEOiBJbW1l
ZGlhdGUgQWxlcnQgKDB4MTgwMikKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDA5OS0weDAwOWMK
ICAgICAgICBVVUlEOiBVbmtub3duICgweDM4MDIpCjwgQUNMIERhdGEgVFg6IEhhbmRsZSAzNTg1
IGZsYWdzIDB4MDAgZGxlbiAxMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNDQgW2hjaTBdIDguNDU2OTM2CiAgICAgIEFU
VDogUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVlc3QgKDB4MTApIGxlbiA2CiAgICAgICAgSGFuZGxl
IHJhbmdlOiAweDAwOWQtMHhmZmZmCiAgICAgICAgQXR0cmlidXRlIGdyb3VwIHR5cGU6IFByaW1h
cnkgU2VydmljZSAoMHgyODAwKQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNr
ZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIzQ1IFtoY2kwXSA4LjUwNjAzMgogICAgICAgIE51bSBoYW5kbGVz
OiAxCiAgICAgICAgSGFuZGxlOiAzNTg1CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDog
SGFuZGxlIDM1ODUgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM0NiBbaGNpMF0gOC41NTU2
NjcKICAgICAgQVRUOiBFcnJvciBSZXNwb25zZSAoMHgwMSkgbGVuIDQKICAgICAgICBSZWFkIEJ5
IEdyb3VwIFR5cGUgUmVxdWVzdCAoMHgxMCkKICAgICAgICBIYW5kbGU6IDB4MDA5ZAogICAgICAg
IEVycm9yOiBBdHRyaWJ1dGUgTm90IEZvdW5kICgweDBhKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUg
MzU4NSBmbGFncyAweDAwIGRsZW4gOSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzQ3IFtoY2kwXSA4LjU5NzU5MgogICAg
ICBBVFQ6IFdyaXRlIFJlcXVlc3QgKDB4MTIpIGxlbiA0CiAgICAgICAgSGFuZGxlOiAweDAwMDQK
ICAgICAgICAgIERhdGE6IDAyMDAKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFj
a2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICM0OCBbaGNpMF0gOC42MDU5MzIKICAgICAgICBOdW0gaGFuZGxl
czogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6
IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIgZGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNDkgW2hjaTBdIDguNjU1
NTYzCiAgICAgIEFUVDogV3JpdGUgUmVzcG9uc2UgKDB4MTMpIGxlbiAwCj4gQUNMIERhdGEgUlg6
IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM1MCBbaGNpMF0gMTEuMjg3
NTE2CiAgICAgIEFUVDogUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAgICAg
SGFuZGxlIHJhbmdlOiAweDAwMDEtMHhmZmZmCiAgICAgICAgQXR0cmlidXRlIHR5cGU6IENoYXJh
Y3RlcmlzdGljICgweDI4MDMpCjwgQUNMIERhdGEgVFg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDAg
ZGxlbiAyNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICM1MSBbaGNpMF0gMTEuMjg4MzUyCjwgQUNMIERhdGEgVFg6IEhhbmRs
ZSAzNTg1IGZsYWdzIDB4MDEgZGxlbiAyNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM1MiBbaGNpMF0gMTEuMjg4MzgzCjwg
QUNMIERhdGEgVFg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDEgZGxlbiA4ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM1MyBb
aGNpMF0gMTEuMjg4MzkzCiAgICAgIEFUVDogUmVhZCBCeSBUeXBlIFJlc3BvbnNlICgweDA5KSBs
ZW4gNTcKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6IDcKICAgICAgICBBdHRyaWJ1dGUg
ZGF0YSBsaXN0OiA4IGVudHJpZXMKICAgICAgICBIYW5kbGU6IDB4MDAwMgogICAgICAgIFZhbHVl
OiAwMjAzMDAwMDJhCiAgICAgICAgSGFuZGxlOiAweDAwMDQKICAgICAgICBWYWx1ZTogMDIwNTAw
MDEyYQogICAgICAgIEhhbmRsZTogMHgwMDA2CiAgICAgICAgVmFsdWU6IDAyMDcwMGE2MmEKICAg
ICAgICBIYW5kbGU6IDB4MDAwOQogICAgICAgIFZhbHVlOiAyMDBhMDAwNTJhCiAgICAgICAgSGFu
ZGxlOiAweDAwMGMKICAgICAgICBWYWx1ZTogMGEwZDAwMjkyYgogICAgICAgIEhhbmRsZTogMHgw
MDBlCiAgICAgICAgVmFsdWU6IDAyMGYwMDJhMmIKICAgICAgICBIYW5kbGU6IDB4MDAxMAogICAg
ICAgIFZhbHVlOiAwMjExMDAzYTJiCiAgICAgICAgSGFuZGxlOiAweDAwMTMKICAgICAgICBWYWx1
ZTogMDIxNDAwNTAyYQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgw
eDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAjNTQgW2hjaTBdIDExLjMwNTk0OAogICAgICAgIE51bSBoYW5kbGVzOiAxCiAg
ICAgICAgSGFuZGxlOiAzNTg1CiAgICAgICAgQ291bnQ6IDEKPiBIQ0kgRXZlbnQ6IE51bWJlciBv
ZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzU1IFtoY2kwXSAxMS4zMDY5NDIKICAg
ICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAgIENvdW50OiAx
Cj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM1
NiBbaGNpMF0gMTEuMzA3OTM1CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6
IDM1ODUKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgMzU4NSBmbGFncyAw
eDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAjNTcgW2hjaTBdIDExLjM1NTgzOAogICAgICBBVFQ6IFJlYWQg
QnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDE0
LTB4ZmZmZgogICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAoMHgyODAzKQo8
IEFDTCBEYXRhIFRYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAwIGRsZW4gOSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNTgg
W2hjaTBdIDExLjM1NjY2MwogICAgICBBVFQ6IEVycm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAog
ICAgICAgIFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KQogICAgICAgIEhhbmRsZTogMHgwMDE0
CiAgICAgICAgRXJyb3I6IEF0dHJpYnV0ZSBOb3QgRm91bmQgKDB4MGEpCj4gSENJIEV2ZW50OiBO
dW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM1OSBbaGNpMF0gMTEuNDA2
MTU2CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDM1ODUKICAgICAgICBD
b3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAyIGRsZW4gMTEgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAjNjAgW2hjaTBdIDExLjQ1NTc3NQogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0
ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDAxLTB4ZmZmZgogICAgICAg
IEF0dHJpYnV0ZSB0eXBlOiBEZXZpY2UgTmFtZSAoMHgyYTAwKQo8IEFDTCBEYXRhIFRYOiBIYW5k
bGUgMzU4NSBmbGFncyAweDAwIGRsZW4gMTggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNjEgW2hjaTBdIDExLjQ1NjUxNAog
ICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXNwb25zZSAoMHgwOSkgbGVuIDEzCiAgICAgICAgQXR0
cmlidXRlIGRhdGEgbGVuZ3RoOiAxMgogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxpc3Q6IDEgZW50
cnkKICAgICAgICBIYW5kbGU6IDB4MDAwMwogICAgICAgIFZhbHVlOiA0MjZjNzU2NTVhMjAzNTJl
MzYzMwo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVu
IDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAjNjIgW2hjaTBdIDExLjUwNTk1MwogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFu
ZGxlOiAzNTg1CiAgICAgICAgQ291bnQ6IDEKCgoKCgoKLS0tLS0tLS0tLQoKQmx1ZXRvb3RoZDoK
CmJsdWV0b290aGRbODgwOV06IHNyYy9hZ2VudC5jOmFnZW50X3JlZigpIDB4NTVmNjNlZjkyZTMw
OiByZWY9MQpibHVldG9vdGhkWzg4MDldOiBzcmMvYWdlbnQuYzpyZWdpc3Rlcl9hZ2VudCgpIGFn
ZW50IDoxLjM3ODkKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmRldmljZV9jb25uZWN0
X2xlKCkgQ29ubmVjdGlvbiBhdHRlbXB0IHRvOiBDRDoxQjpDMzo5NDo1Qjo3NwpibHVldG9vdGhk
Wzg4MDldOiBzcmMvYWRhcHRlci5jOmNvbm5lY3RlZF9jYWxsYmFjaygpIGhjaTAgZGV2aWNlIENE
OjFCOkMzOjk0OjVCOjc3IGNvbm5lY3RlZCBlaXJfbGVuIDMxCmJsdWV0b290aGRbODgwOV06IGF0
dHJpYi9nYXR0cmliLmM6Z19hdHRyaWJfcmVmKCkgMHg1NWY2M2VmOTE2MjA6IGdfYXR0cmliX3Jl
Zj0xCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2dhdHRfZGIoKSBSZXN0b3Jp
bmcgQ0Q6MUI6QzM6OTQ6NUI6NzcgZ2F0dCBkYXRhYmFzZSBmcm9tIGZpbGUKYmx1ZXRvb3RoZFs4
ODA5XTogc3JjL2RldmljZS5jOmxvYWRfc2VydmljZSgpIGxvYWRpbmcgc2VydmljZTogMHgwMDAx
LCBlbmQ6IDB4MDAwNCwgdXVpZDogMDAwMDE4MDEtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZi
CmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNl
cnZpY2U6IDB4MDAxNCwgZW5kOiAweDAwMTgsIHV1aWQ6IDAwMDAxODAwLTAwMDAtMTAwMC04MDAw
LTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9zZXJ2aWNl
KCkgbG9hZGluZyBzZXJ2aWNlOiAweDAwMjgsIGVuZDogMHgwMDM1LCB1dWlkOiAwMDAwMTgwYS0w
MDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5j
OmxvYWRfc2VydmljZSgpIGxvYWRpbmcgc2VydmljZTogMHgwMDM4LCBlbmQ6IDB4MDAzZCwgdXVp
ZDogMDAwMDE1MzAtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbODgwOV06
IHNyYy9kZXZpY2UuYzpsb2FkX3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDA0MCwgZW5k
OiAweDAwNmQsIHV1aWQ6IDAwMDBmZWUwLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVl
dG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9zZXJ2aWNlKCkgbG9hZGluZyBzZXJ2aWNl
OiAweDAwNzAsIGVuZDogMHgwMDgxLCB1dWlkOiAwMDAwZmVlMS0wMDAwLTEwMDAtODAwMC0wMDgw
NWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRfc2VydmljZSgpIGxv
YWRpbmcgc2VydmljZTogMHgwMDg0LCBlbmQ6IDB4MDA4OSwgdXVpZDogMDAwMDE4MGQtMDAwMC0x
MDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2Fk
X3NlcnZpY2UoKSBsb2FkaW5nIHNlcnZpY2U6IDB4MDA4YywgZW5kOiAweDAwOTEsIHV1aWQ6IDAw
MDAxODExLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMv
ZGV2aWNlLmM6bG9hZF9zZXJ2aWNlKCkgbG9hZGluZyBzZXJ2aWNlOiAweDAwOTQsIGVuZDogMHgw
MDk2LCB1dWlkOiAwMDAwMTgwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3Ro
ZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRfc2VydmljZSgpIGxvYWRpbmcgc2VydmljZTogMHgw
MDk5LCBlbmQ6IDB4MDA5YywgdXVpZDogMDAwMDM4MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIz
NGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNo
YXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDAyLCB2YWx1ZSBoYW5kbGU6IDB4MDAwMywgcHJvcGVy
dGllcyAweDAwMjIgdmFsdWU6ICB1dWlkOiAwMDAwMmEwNS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcg
ZGVzY3JpcHRvciBoYW5kbGU6IDB4MDAwNCwgdmFsdWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAw
MDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9k
ZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDE1
LCB2YWx1ZSBoYW5kbGU6IDB4MDAxNiwgcHJvcGVydGllcyAweDAwMDIgdmFsdWU6ICB1dWlkOiAw
MDAwMmEwMC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3Jj
L2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAw
MTcsIHZhbHVlIGhhbmRsZTogMHgwMDE4LCBwcm9wZXJ0aWVzIDB4MDAwMiB2YWx1ZTogIHV1aWQ6
IDAwMDAyYTAxLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBz
cmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4
MDAyOSwgdmFsdWUgaGFuZGxlOiAweDAwMmEsIHByb3BlcnRpZXMgMHgwMDAyIHZhbHVlOiAgdXVp
ZDogMDAwMDJhMjUtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06
IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTog
MHgwMDJiLCB2YWx1ZSBoYW5kbGU6IDB4MDAyYywgcHJvcGVydGllcyAweDAwMDIgdmFsdWU6ICB1
dWlkOiAwMDAwMmEyNy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5
XTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxl
OiAweDAwMmQsIHZhbHVlIGhhbmRsZTogMHgwMDJlLCBwcm9wZXJ0aWVzIDB4MDAwMiB2YWx1ZTog
IHV1aWQ6IDAwMDAyYTI4LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4
MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5k
bGU6IDB4MDAyZiwgdmFsdWUgaGFuZGxlOiAweDAwMzAsIHByb3BlcnRpZXMgMHgwMDAyIHZhbHVl
OiAgdXVpZDogMDAwMDJhMjMtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRb
ODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhh
bmRsZTogMHgwMDMxLCB2YWx1ZSBoYW5kbGU6IDB4MDAzMiwgcHJvcGVydGllcyAweDAwMDIgdmFs
dWU6ICB1dWlkOiAwMDAwMmE1MC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3Ro
ZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMg
aGFuZGxlOiAweDAwMzMsIHZhbHVlIGhhbmRsZTogMHgwMDM0LCBwcm9wZXJ0aWVzIDB4MDAxNCB2
YWx1ZTogIHV1aWQ6IDAwMDAwMDE0LTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMApibHVldG9v
dGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhh
bmRsZTogMHgwMDM1LCB2YWx1ZTogMHgwMDAwLCB2YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEw
MDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRf
Y2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAwMzksIHZhbHVlIGhhbmRs
ZTogMHgwMDNhLCBwcm9wZXJ0aWVzIDB4MDAxOCB2YWx1ZTogIHV1aWQ6IDAwMDAxNTMxLTAwMDAt
MzUxMi0yMTE4LTAwMDlhZjEwMDcwMApibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9h
ZF9kZXNjKCkgbG9hZGluZyBkZXNjcmlwdG9yIGhhbmRsZTogMHgwMDNiLCB2YWx1ZTogMHgwMDAw
LCB2YWx1ZSB1dWlkOiAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRv
b3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0
aWMgaGFuZGxlOiAweDAwM2MsIHZhbHVlIGhhbmRsZTogMHgwMDNkLCBwcm9wZXJ0aWVzIDB4MDAw
NCB2YWx1ZTogIHV1aWQ6IDAwMDAxNTMyLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMApibHVl
dG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJp
c3RpYyBoYW5kbGU6IDB4MDA0MSwgdmFsdWUgaGFuZGxlOiAweDAwNDIsIHByb3BlcnRpZXMgMHgw
MDFhIHZhbHVlOiAgdXVpZDogMDAwMDJhMmItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJs
dWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0
b3IgaGFuZGxlOiAweDAwNDMsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6
bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA0NCwgdmFsdWUg
aGFuZGxlOiAweDAwNDUsIHByb3BlcnRpZXMgMHgwMDFhIHZhbHVlOiAgdXVpZDogMDAwMDJhMDQt
MDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2Uu
Yzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNDYsIHZhbHVlOiAw
eDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpi
bHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0
ZXJpc3RpYyBoYW5kbGU6IDB4MDA0NywgdmFsdWUgaGFuZGxlOiAweDAwNDgsIHByb3BlcnRpZXMg
MHgwMDE0IHZhbHVlOiAgdXVpZDogMDAwMDAwMDEtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAw
CmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2Ny
aXB0b3IgaGFuZGxlOiAweDAwNDksIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAy
LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNl
LmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA0YSwgdmFs
dWUgaGFuZGxlOiAweDAwNGIsIHByb3BlcnRpZXMgMHgwMDEwIHZhbHVlOiAgdXVpZDogMDAwMDAw
MDItMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZp
Y2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNGMsIHZhbHVl
OiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRm
YgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFy
YWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA0ZCwgdmFsdWUgaGFuZGxlOiAweDAwNGUsIHByb3BlcnRp
ZXMgMHgwMDE0IHZhbHVlOiAgdXVpZDogMDAwMDAwMDMtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAw
NzAwCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRl
c2NyaXB0b3IgaGFuZGxlOiAweDAwNGYsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAy
OTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2
aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA1MCwg
dmFsdWUgaGFuZGxlOiAweDAwNTEsIHByb3BlcnRpZXMgMHgwMDE0IHZhbHVlOiAgdXVpZDogMDAw
MDAwMDQtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbODgwOV06IHNyYy9k
ZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNTIsIHZh
bHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1Zjli
MzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBj
aGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA1MywgdmFsdWUgaGFuZGxlOiAweDAwNTQsIHByb3Bl
cnRpZXMgMHgwMDEwIHZhbHVlOiAgdXVpZDogMDAwMDAwMDUtMDAwMC0zNTEyLTIxMTgtMDAwOWFm
MTAwNzAwCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5n
IGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNTUsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAw
MDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMv
ZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA1
NiwgdmFsdWUgaGFuZGxlOiAweDAwNTcsIHByb3BlcnRpZXMgMHgwMDEyIHZhbHVlOiAgdXVpZDog
MDAwMDAwMDYtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbODgwOV06IHNy
Yy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNTgs
IHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1
ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGlu
ZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA1OSwgdmFsdWUgaGFuZGxlOiAweDAwNWEsIHBy
b3BlcnRpZXMgMHgwMDEyIHZhbHVlOiAgdXVpZDogMDAwMDAwMDctMDAwMC0zNTEyLTIxMTgtMDAw
OWFmMTAwNzAwCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2Fk
aW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNWIsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6
IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBz
cmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4
MDA1ZiwgdmFsdWUgaGFuZGxlOiAweDAwNjAsIHByb3BlcnRpZXMgMHgwMDEwIHZhbHVlOiAgdXVp
ZDogMDAwMDAwMTAtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbODgwOV06
IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAw
NjEsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAw
ODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9h
ZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA2MiwgdmFsdWUgaGFuZGxlOiAweDAwNjMs
IHByb3BlcnRpZXMgMHgwMDA4IHZhbHVlOiAgdXVpZDogMDAwMDAwMGUtMDAwMC0zNTEyLTIxMTgt
MDAwOWFmMTAwNzAwCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBs
b2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNjQsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1
aWQ6IDAwMDAyOTAxLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDld
OiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6
IDB4MDA2NSwgdmFsdWUgaGFuZGxlOiAweDAwNjYsIHByb3BlcnRpZXMgMHgwMDE2IHZhbHVlOiAg
dXVpZDogMDAwMDAwMjAtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbODgw
OV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAw
eDAwNjcsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAw
LTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkg
bG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA2OCwgdmFsdWUgaGFuZGxlOiAweDAw
NjksIHByb3BlcnRpZXMgMHgwMDE0IHZhbHVlOiAgdXVpZDogMDAwMDAwMTYtMDAwMC0zNTEyLTIx
MTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2Mo
KSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNmEsIHZhbHVlOiAweDAwMDAsIHZhbHVl
IHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4
MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5k
bGU6IDB4MDA2YiwgdmFsdWUgaGFuZGxlOiAweDAwNmMsIHByb3BlcnRpZXMgMHgwMDE0IHZhbHVl
OiAgdXVpZDogMDAwMDAwMTctMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRb
ODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxl
OiAweDAwNmQsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04
MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJj
KCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA3MSwgdmFsdWUgaGFuZGxlOiAw
eDAwNzIsIHByb3BlcnRpZXMgMHgwMDE2IHZhbHVlOiAgdXVpZDogMDAwMDAwMDktMDAwMC0zNTEy
LTIxMTgtMDAwOWFmMTAwNzAwCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2Rl
c2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAwNzMsIHZhbHVlOiAweDAwMDAsIHZh
bHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhk
Wzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBo
YW5kbGU6IDB4MDA3NCwgdmFsdWUgaGFuZGxlOiAweDAwNzUsIHByb3BlcnRpZXMgMHgwMDA4IHZh
bHVlOiAgdXVpZDogMDAwMGZlZGQtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290
aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGlj
IGhhbmRsZTogMHgwMDc2LCB2YWx1ZSBoYW5kbGU6IDB4MDA3NywgcHJvcGVydGllcyAweDAwMDIg
dmFsdWU6ICB1dWlkOiAwMDAwZmVkZS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRv
b3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0
aWMgaGFuZGxlOiAweDAwNzgsIHZhbHVlIGhhbmRsZTogMHgwMDc5LCBwcm9wZXJ0aWVzIDB4MDAw
MiB2YWx1ZTogIHV1aWQ6IDAwMDBmZWRmLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVl
dG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJp
c3RpYyBoYW5kbGU6IDB4MDA3YSwgdmFsdWUgaGFuZGxlOiAweDAwN2IsIHByb3BlcnRpZXMgMHgw
MDBhIHZhbHVlOiAgdXVpZDogMDAwMGZlZDAtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJs
dWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3Rl
cmlzdGljIGhhbmRsZTogMHgwMDdjLCB2YWx1ZSBoYW5kbGU6IDB4MDA3ZCwgcHJvcGVydGllcyAw
eDAwMGEgdmFsdWU6ICB1dWlkOiAwMDAwZmVkMS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIK
Ymx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFj
dGVyaXN0aWMgaGFuZGxlOiAweDAwN2UsIHZhbHVlIGhhbmRsZTogMHgwMDdmLCBwcm9wZXJ0aWVz
IDB4MDAwMiB2YWx1ZTogIHV1aWQ6IDAwMDBmZWQyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRm
YgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFy
YWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA4MCwgdmFsdWUgaGFuZGxlOiAweDAwODEsIHByb3BlcnRp
ZXMgMHgwMDBhIHZhbHVlOiAgdXVpZDogMDAwMGZlZDMtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIz
NGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNo
YXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDg1LCB2YWx1ZSBoYW5kbGU6IDB4MDA4NiwgcHJvcGVy
dGllcyAweDAwMTAgdmFsdWU6ICB1dWlkOiAwMDAwMmEzNy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRfZGVzYygpIGxvYWRpbmcg
ZGVzY3JpcHRvciBoYW5kbGU6IDB4MDA4NywgdmFsdWU6IDB4MDAwMCwgdmFsdWUgdXVpZDogMDAw
MDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9k
ZXZpY2UuYzpsb2FkX2NocmMoKSBsb2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDg4
LCB2YWx1ZSBoYW5kbGU6IDB4MDA4OSwgcHJvcGVydGllcyAweDAwMGEgdmFsdWU6ICB1dWlkOiAw
MDAwMmEzOS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3Jj
L2RldmljZS5jOmxvYWRfY2hyYygpIGxvYWRpbmcgY2hhcmFjdGVyaXN0aWMgaGFuZGxlOiAweDAw
OGQsIHZhbHVlIGhhbmRsZTogMHgwMDhlLCBwcm9wZXJ0aWVzIDB4MDAwYSB2YWx1ZTogIHV1aWQ6
IDAwMDAyYTQ2LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBz
cmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9hZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4
MDA4ZiwgdmFsdWUgaGFuZGxlOiAweDAwOTAsIHByb3BlcnRpZXMgMHgwMDFhIHZhbHVlOiAgdXVp
ZDogMDAwMDJhNDQtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06
IHNyYy9kZXZpY2UuYzpsb2FkX2Rlc2MoKSBsb2FkaW5nIGRlc2NyaXB0b3IgaGFuZGxlOiAweDAw
OTEsIHZhbHVlOiAweDAwMDAsIHZhbHVlIHV1aWQ6IDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAw
ODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6bG9hZF9jaHJjKCkgbG9h
ZGluZyBjaGFyYWN0ZXJpc3RpYyBoYW5kbGU6IDB4MDA5NSwgdmFsdWUgaGFuZGxlOiAweDAwOTYs
IHByb3BlcnRpZXMgMHgwMDA0IHZhbHVlOiAgdXVpZDogMDAwMDJhMDYtMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpsb2FkX2NocmMoKSBs
b2FkaW5nIGNoYXJhY3RlcmlzdGljIGhhbmRsZTogMHgwMDlhLCB2YWx1ZSBoYW5kbGU6IDB4MDA5
YiwgcHJvcGVydGllcyAweDAwMWEgdmFsdWU6ICB1dWlkOiAwMDAwNGEwMi0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmxvYWRfZGVzYygp
IGxvYWRpbmcgZGVzY3JpcHRvciBoYW5kbGU6IDB4MDA5YywgdmFsdWU6IDB4MDAwMCwgdmFsdWUg
dXVpZDogMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgw
OV06IHByb2ZpbGVzL2RldmljZWluZm8vZGV2aWNlaW5mby5jOmRldmljZWluZm9fYWNjZXB0KCkg
ZGV2aWNlaW5mbyBwcm9maWxlIGFjY2VwdCAoQ0Q6MUI6QzM6OTQ6NUI6NzcpCmJsdWV0b290aGRb
ODgwOV06IHByb2ZpbGVzL2RldmljZWluZm8vZGV2aWNlaW5mby5jOmhhbmRsZV9jaGFyYWN0ZXJp
c3RpYygpIFVuc3VwcG9ydGVkIGNoYXJhY3RlcmlzdGljOiAwMDAwMmEyNS0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogcHJvZmlsZXMvZGV2aWNlaW5mby9kZXZp
Y2VpbmZvLmM6aGFuZGxlX2NoYXJhY3RlcmlzdGljKCkgVW5zdXBwb3J0ZWQgY2hhcmFjdGVyaXN0
aWM6IDAwMDAyYTI3LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDld
OiBwcm9maWxlcy9kZXZpY2VpbmZvL2RldmljZWluZm8uYzpoYW5kbGVfY2hhcmFjdGVyaXN0aWMo
KSBVbnN1cHBvcnRlZCBjaGFyYWN0ZXJpc3RpYzogMDAwMDJhMjgtMDAwMC0xMDAwLTgwMDAtMDA4
MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06IHByb2ZpbGVzL2RldmljZWluZm8vZGV2aWNlaW5m
by5jOmhhbmRsZV9jaGFyYWN0ZXJpc3RpYygpIFVuc3VwcG9ydGVkIGNoYXJhY3RlcmlzdGljOiAw
MDAwMmEyMy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogcHJv
ZmlsZXMvZGV2aWNlaW5mby9kZXZpY2VpbmZvLmM6aGFuZGxlX2NoYXJhY3RlcmlzdGljKCkgVW5z
dXBwb3J0ZWQgY2hhcmFjdGVyaXN0aWM6IDAwMDAwMDE0LTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEw
MDcwMApibHVldG9vdGhkWzg4MDldOiBzcmMvc2VydmljZS5jOmNoYW5nZV9zdGF0ZSgpIDB4NTVm
NjNlZjY2MjgwOiBkZXZpY2UgQ0Q6MUI6QzM6OTQ6NUI6NzcgcHJvZmlsZSBkZXZpY2VpbmZvIHN0
YXRlIGNoYW5nZWQ6IGRpc2Nvbm5lY3RlZCAtPiBjb25uZWN0ZWQgKDApCmJsdWV0b290aGRbODgw
OV06IHByb2ZpbGVzL2dhcC9nYXMuYzpnYXBfYWNjZXB0KCkgR0FQIHByb2ZpbGUgYWNjZXB0IChD
RDoxQjpDMzo5NDo1Qjo3NykKYmx1ZXRvb3RoZFs4ODA5XTogcHJvZmlsZXMvZ2FwL2dhcy5jOmhh
bmRsZV9hcHBlYXJhbmNlKCkgRmFpbGVkIHRvIHNlbmQgcmVxdWVzdCB0byByZWFkIGFwcGVhcmFu
Y2UKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL3NlcnZpY2UuYzpjaGFuZ2Vfc3RhdGUoKSAweDU1ZjYz
ZWY2OTNkMDogZGV2aWNlIENEOjFCOkMzOjk0OjVCOjc3IHByb2ZpbGUgZ2FwLXByb2ZpbGUgc3Rh
dGUgY2hhbmdlZDogZGlzY29ubmVjdGVkIC0+IGNvbm5lY3RlZCAoMCkKYmx1ZXRvb3RoZFs4ODA5
XTogc3JjL2dhdHQtY2xpZW50LmM6YnRkX2dhdHRfY2xpZW50X2Nvbm5lY3RlZCgpIERldmljZSBj
b25uZWN0ZWQuCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgKGNo
YW4gMHg1NWY2M2VmNzcwYzApIEFUVCBQRFUgcmVjZWl2ZWQ6IDB4MDIKYmx1ZXRvb3RoZFs4ODA5
XTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSBNVFUgZXhjaGFuZ2UgY29tcGxldGUsIHdpdGgg
TVRVOiAyNDcKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSBNVFUg
ZXhjaGFuZ2UgY29tcGxldGUsIHdpdGggTVRVOiAyNTIKYmx1ZXRvb3RoZFs4ODA5XTogcHJvZmls
ZXMvZ2FwL2dhcy5jOnJlYWRfZGV2aWNlX25hbWVfY2IoKSBHQVAgRGV2aWNlIE5hbWU6IEFtYXpm
aXQgR1RSIDIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSBQcmlt
YXJ5IHNlcnZpY2VzIGZvdW5kOiAxMApibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6Z2F0
dF9kZWJ1ZygpIHN0YXJ0OiAweDAwMDEsIGVuZDogMHgwMDA0LCB1dWlkOiAwMDAwMTgwMS0wMDAw
LTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmdh
dHRfZGVidWcoKSBzdGFydDogMHgwMDE0LCBlbmQ6IDB4MDAxOCwgdXVpZDogMDAwMDE4MDAtMDAw
MC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2UuYzpn
YXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDAyOCwgZW5kOiAweDAwMzUsIHV1aWQ6IDAwMDAxODBhLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6
Z2F0dF9kZWJ1ZygpIHN0YXJ0OiAweDAwMzgsIGVuZDogMHgwMDNkLCB1dWlkOiAwMDAwMTUzMC0w
MDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5j
OmdhdHRfZGVidWcoKSBzdGFydDogMHgwMDQwLCBlbmQ6IDB4MDA2ZCwgdXVpZDogMDAwMGZlZTAt
MDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZpY2Uu
YzpnYXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDA3MCwgZW5kOiAweDAwODEsIHV1aWQ6IDAwMDBmZWUx
LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNl
LmM6Z2F0dF9kZWJ1ZygpIHN0YXJ0OiAweDAwODQsIGVuZDogMHgwMDg5LCB1dWlkOiAwMDAwMTgw
ZC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2Rldmlj
ZS5jOmdhdHRfZGVidWcoKSBzdGFydDogMHgwMDhjLCBlbmQ6IDB4MDA5MSwgdXVpZDogMDAwMDE4
MTEtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCmJsdWV0b290aGRbODgwOV06IHNyYy9kZXZp
Y2UuYzpnYXR0X2RlYnVnKCkgc3RhcnQ6IDB4MDA5NCwgZW5kOiAweDAwOTYsIHV1aWQ6IDAwMDAx
ODAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2
aWNlLmM6Z2F0dF9kZWJ1ZygpIHN0YXJ0OiAweDAwOTksIGVuZDogMHgwMDljLCB1dWlkOiAwMDAw
MzgwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2Rl
dmljZS5jOmdhdHRfY2xpZW50X3JlYWR5X2NiKCkgc3RhdHVzOiBzdWNjZXNzLCBlcnJvcjogMTAK
Ymx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6YnRkX2dhdHRfY2xpZW50X3JlYWR5
KCkgR0FUVCBjbGllbnQgcmVhZHkKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6
Y3JlYXRlX3NlcnZpY2VzKCkgRXhwb3J0aW5nIG9iamVjdHMgZm9yIEdBVFQgc2VydmljZXM6IENE
OjFCOkMzOjk0OjVCOjc3CmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZp
Y2VfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBzZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NE
XzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDAxCmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNs
aWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0
aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMDEvY2hh
cjAwMDIKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6ZGVzY3JpcHRvcl9jcmVh
dGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljIGRlc2NyaXB0b3I6IC9vcmcvYmx1ZXov
aGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMDEvY2hhcjAwMDIvZGVzYzAwMDQK
Ymx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6c2VydmljZV9jcmVhdGUoKSBFeHBv
cnRlZCBHQVRUIHNlcnZpY2U6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcv
c2VydmljZTAwMjgKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVy
aXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9o
Y2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAyOC9jaGFyMDAyOQpibHVldG9vdGhk
Wzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRl
ZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVC
Xzc3L3NlcnZpY2UwMDI4L2NoYXIwMDJiCmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVu
dC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6
IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMjgvY2hhcjAw
MmQKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3Jl
YXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9D
RF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAyOC9jaGFyMDAyZgpibHVldG9vdGhkWzg4MDldOiBz
cmMvZ2F0dC1jbGllbnQuYzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNo
YXJhY3RlcmlzdGljOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDI4L2NoYXIwMDMxCmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJh
Y3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1
ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMjgvY2hhcjAwMzMKYmx1ZXRv
b3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6ZGVzY3JpcHRvcl9jcmVhdGUoKSBFeHBvcnRl
ZCBHQVRUIGNoYXJhY3RlcmlzdGljIGRlc2NyaXB0b3I6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0Rf
MUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMjgvY2hhcjAwMzMvZGVzYzAwMzUKYmx1ZXRvb3RoZFs4
ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6c2VydmljZV9jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIHNl
cnZpY2U6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMzgK
Ymx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRl
KCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8x
Ql9DM185NF81Ql83Ny9zZXJ2aWNlMDAzOC9jaGFyMDAzOQpibHVldG9vdGhkWzg4MDldOiBzcmMv
Z2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVy
aXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9z
ZXJ2aWNlMDAzOC9jaGFyMDAzOS9kZXNjMDAzYgpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1j
bGllbnQuYzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3Rlcmlz
dGljOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDM4L2No
YXIwMDNjCmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZpY2VfY3JlYXRl
KCkgRXhwb3J0ZWQgR0FUVCBzZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0
XzVCXzc3L3NlcnZpY2UwMDQwCmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmNo
YXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcv
Ymx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNDEKYmx1
ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6ZGVzY3JpcHRvcl9jcmVhdGUoKSBFeHBv
cnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljIGRlc2NyaXB0b3I6IC9vcmcvYmx1ZXovaGNpMC9kZXZf
Q0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNDEvZGVzYzAwNDMKYmx1ZXRvb3Ro
ZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0
ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81
Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0NApibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGll
bnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVz
Y3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0
MC9jaGFyMDA0NC9kZXNjMDA0NgpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpj
aGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAvb3Jn
L2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDQ3CmJs
dWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmRlc2NyaXB0b3JfY3JlYXRlKCkgRXhw
b3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYyBkZXNjcmlwdG9yOiAvb3JnL2JsdWV6L2hjaTAvZGV2
X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDQ3L2Rlc2MwMDQ5CmJsdWV0b290
aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9y
dGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRf
NUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNGEKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xp
ZW50LmM6ZGVzY3JpcHRvcl9jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljIGRl
c2NyaXB0b3I6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAw
NDAvY2hhcjAwNGEvZGVzYzAwNGMKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6
Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29y
Zy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0ZApi
bHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4
cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rl
dl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0ZC9kZXNjMDA0ZgpibHVldG9v
dGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBv
cnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0
XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDUwCmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNs
aWVudC5jOmRlc2NyaXB0b3JfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYyBk
ZXNjcmlwdG9yOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2Uw
MDQwL2NoYXIwMDUwL2Rlc2MwMDUyCmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5j
OmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9v
cmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNTMK
Ymx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6ZGVzY3JpcHRvcl9jcmVhdGUoKSBF
eHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljIGRlc2NyaXB0b3I6IC9vcmcvYmx1ZXovaGNpMC9k
ZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNTMvZGVzYzAwNTUKYmx1ZXRv
b3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhw
b3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185
NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA1NgpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1j
bGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMg
ZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNl
MDA0MC9jaGFyMDA1Ni9kZXNjMDA1OApibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQu
YzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAv
b3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDU5
CmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmRlc2NyaXB0b3JfY3JlYXRlKCkg
RXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYyBkZXNjcmlwdG9yOiAvb3JnL2JsdWV6L2hjaTAv
ZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDU5L2Rlc2MwMDViCmJsdWV0
b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4
cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNWYKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQt
Y2xpZW50LmM6ZGVzY3JpcHRvcl9jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGlj
IGRlc2NyaXB0b3I6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vydmlj
ZTAwNDAvY2hhcjAwNWYvZGVzYzAwNjEKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50
LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzog
L29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2
MgpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgp
IEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kw
L2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2Mi9kZXNjMDA2NApibHVl
dG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBF
eHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0Mz
Xzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDY1CmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0
LWNsaWVudC5jOmRlc2NyaXB0b3JfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3Rp
YyBkZXNjcmlwdG9yOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDQwL2NoYXIwMDY1L2Rlc2MwMDY3CmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVu
dC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6
IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAw
NjgKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6ZGVzY3JpcHRvcl9jcmVhdGUo
KSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljIGRlc2NyaXB0b3I6IC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNjgvZGVzYzAwNmEKYmx1
ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkg
RXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9D
M185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2YgpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0
dC1jbGllbnQuYzpkZXNjcmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0
aWMgZGVzY3JpcHRvcjogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2
aWNlMDA0MC9jaGFyMDA2Yi9kZXNjMDA2ZApibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGll
bnQuYzpzZXJ2aWNlX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgc2VydmljZTogL29yZy9ibHVlei9o
Y2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA3MApibHVldG9vdGhkWzg4MDldOiBz
cmMvZ2F0dC1jbGllbnQuYzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNo
YXJhY3RlcmlzdGljOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDcwL2NoYXIwMDcxCmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmRlc2Ny
aXB0b3JfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFyYWN0ZXJpc3RpYyBkZXNjcmlwdG9yOiAv
b3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDcwL2NoYXIwMDcx
L2Rlc2MwMDczCmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3Rlcmlz
dGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNzAvY2hhcjAwNzQKYmx1ZXRvb3RoZFs4
ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQg
R0FUVCBjaGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83
Ny9zZXJ2aWNlMDA3MC9jaGFyMDA3NgpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQu
YzpjaGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAv
b3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDcwL2NoYXIwMDc4
CmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0
ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0Rf
MUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNzAvY2hhcjAwN2EKYmx1ZXRvb3RoZFs4ODA5XTogc3Jj
L2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFy
YWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNl
MDA3MC9jaGFyMDA3YwpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpjaGFyYWN0
ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAvb3JnL2JsdWV6
L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDcwL2NoYXIwMDdlCmJsdWV0b290
aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0ZSgpIEV4cG9y
dGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRf
NUJfNzcvc2VydmljZTAwNzAvY2hhcjAwODAKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2dhdHQtY2xp
ZW50LmM6c2VydmljZV9jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIHNlcnZpY2U6IC9vcmcvYmx1ZXov
aGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwODQKYmx1ZXRvb3RoZFs4ODA5XTog
c3JjL2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBj
aGFyYWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2
aWNlMDA4NC9jaGFyMDA4NQpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNj
cmlwdG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjog
L29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA4NC9jaGFyMDA4
NS9kZXNjMDA4NwpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpjaGFyYWN0ZXJp
c3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAvb3JnL2JsdWV6L2hj
aTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDg0L2NoYXIwMDg4CmJsdWV0b290aGRb
ODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZpY2VfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBz
ZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDhj
CmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3RlcmlzdGljX2NyZWF0
ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0Rf
MUJfQzNfOTRfNUJfNzcvc2VydmljZTAwOGMvY2hhcjAwOGQKYmx1ZXRvb3RoZFs4ODA5XTogc3Jj
L2dhdHQtY2xpZW50LmM6Y2hhcmFjdGVyaXN0aWNfY3JlYXRlKCkgRXhwb3J0ZWQgR0FUVCBjaGFy
YWN0ZXJpc3RpYzogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNl
MDA4Yy9jaGFyMDA4ZgpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpkZXNjcmlw
dG9yX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWMgZGVzY3JpcHRvcjogL29y
Zy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA4Yy9jaGFyMDA4Zi9k
ZXNjMDA5MQpibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpzZXJ2aWNlX2NyZWF0
ZSgpIEV4cG9ydGVkIEdBVFQgc2VydmljZTogL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185
NF81Ql83Ny9zZXJ2aWNlMDA5NApibHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpj
aGFyYWN0ZXJpc3RpY19jcmVhdGUoKSBFeHBvcnRlZCBHQVRUIGNoYXJhY3RlcmlzdGljOiAvb3Jn
L2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDk0L2NoYXIwMDk1CmJs
dWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOnNlcnZpY2VfY3JlYXRlKCkgRXhwb3J0
ZWQgR0FUVCBzZXJ2aWNlOiAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3Nl
cnZpY2UwMDk5CmJsdWV0b290aGRbODgwOV06IHNyYy9nYXR0LWNsaWVudC5jOmNoYXJhY3Rlcmlz
dGljX2NyZWF0ZSgpIEV4cG9ydGVkIEdBVFQgY2hhcmFjdGVyaXN0aWM6IC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwOTkvY2hhcjAwOWEKYmx1ZXRvb3RoZFs4
ODA5XTogc3JjL2dhdHQtY2xpZW50LmM6ZGVzY3JpcHRvcl9jcmVhdGUoKSBFeHBvcnRlZCBHQVRU
IGNoYXJhY3RlcmlzdGljIGRlc2NyaXB0b3I6IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwOTkvY2hhcjAwOWEvZGVzYzAwOWMKYmx1ZXRvb3RoZFs4ODA5XTog
c3JjL2dhdHQtY2xpZW50LmM6YnRkX2dhdHRfY2xpZW50X3JlYWR5KCkgRmVhdHVyZXMgMHgwMApi
bHVldG9vdGhkWzg4MDldOiBzcmMvZ2F0dC1jbGllbnQuYzpidGRfZ2F0dF9jbGllbnRfcmVhZHko
KSBVcGRhdGUgRmVhdHVyZXMgMHgwMApibHVldG9vdGhkWzg4MDldOiBzcmMvZGV2aWNlLmM6ZGV2
aWNlX3N2Y19yZXNvbHZlZCgpIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcg
ZXJyIDAKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSBSZWdpc3Rl
cmVkIGhhbmRsZXIgZm9yICJTZXJ2aWNlIENoYW5nZWQiOiAxCmJsdWV0b290aGRbODgwOV06IHNy
Yy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgKGNoYW4gMHg1NWY2M2VmNzcwYzApIEFUVCBQRFUgcmVj
ZWl2ZWQ6IDB4MDgKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmdhdHRfZGVidWcoKSBS
ZWFkIEJ5IFR5cGUgLSBzdGFydDogMHgwMDAxIGVuZDogMHhmZmZmCmJsdWV0b290aGRbODgwOV06
IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgKGNoYW4gMHg1NWY2M2VmNzcwYzApIEFUVCBQRFUg
cmVjZWl2ZWQ6IDB4MDgKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmdhdHRfZGVidWco
KSBSZWFkIEJ5IFR5cGUgLSBzdGFydDogMHgwMDE0IGVuZDogMHhmZmZmCmJsdWV0b290aGRbODgw
OV06IHNyYy9kZXZpY2UuYzpnYXR0X2RlYnVnKCkgKGNoYW4gMHg1NWY2M2VmNzcwYzApIEFUVCBQ
RFUgcmVjZWl2ZWQ6IDB4MDgKYmx1ZXRvb3RoZFs4ODA5XTogc3JjL2RldmljZS5jOmdhdHRfZGVi
dWcoKSBSZWFkIEJ5IFR5cGUgLSBzdGFydDogMHgwMDAxIGVuZDogMHhmZmZmCmJsdWV0b290aGRb
ODgwOV06IHNyYy9nYXR0LWRhdGFiYXNlLmM6Z2FwX2RldmljZV9uYW1lX3JlYWRfY2IoKSBHQVAg
RGV2aWNlIE5hbWUgcmVhZCByZXF1ZXN0CgoKCgotLS0tLS0tLS0tCgpsaXN0LWF0dHJpYnV0ZXMK
CltBbWF6Zml0IEdUUiAyXSMgbGlzdC1hdHRyaWJ1dGVzClByaW1hcnkgU2VydmljZSAoSGFuZGxl
IDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3Nl
cnZpY2UwMDAxCiAgICAgICAgMDAwMDE4MDEtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAg
ICAgICAgR2VuZXJpYyBBdHRyaWJ1dGUgUHJvZmlsZQpDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4
MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZp
Y2UwMDAxL2NoYXIwMDAyCiAgICAgICAgMDAwMDJhMDUtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIz
NGZiCiAgICAgICAgU2VydmljZSBDaGFuZ2VkCkRlc2NyaXB0b3IgKEhhbmRsZSAweDAwMDApCiAg
ICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDAwMS9j
aGFyMDAwMi9kZXNjMDAwNAogICAgICAgIDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1Zjli
MzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0ZXJpc3RpYyBDb25maWd1cmF0aW9uClByaW1hcnkg
U2VydmljZSAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFC
X0MzXzk0XzVCXzc3L3NlcnZpY2UwMDI4CiAgICAgICAgMDAwMDE4MGEtMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiCiAgICAgICAgRGV2aWNlIEluZm9ybWF0aW9uCkNoYXJhY3RlcmlzdGljIChI
YW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJf
Nzcvc2VydmljZTAwMjgvY2hhcjAwMjkKICAgICAgICAwMDAwMmEyNS0wMDAwLTEwMDAtODAwMC0w
MDgwNWY5YjM0ZmIKICAgICAgICBTZXJpYWwgTnVtYmVyIFN0cmluZwpDaGFyYWN0ZXJpc3RpYyAo
SGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVC
Xzc3L3NlcnZpY2UwMDI4L2NoYXIwMDJiCiAgICAgICAgMDAwMDJhMjctMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiCiAgICAgICAgSGFyZHdhcmUgUmV2aXNpb24gU3RyaW5nCkNoYXJhY3Rlcmlz
dGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwMjgvY2hhcjAwMmQKICAgICAgICAwMDAwMmEyOC0wMDAwLTEwMDAt
ODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBTb2Z0d2FyZSBSZXZpc2lvbiBTdHJpbmcKQ2hhcmFj
dGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8x
Ql9DM185NF81Ql83Ny9zZXJ2aWNlMDAyOC9jaGFyMDAyZgogICAgICAgIDAwMDAyYTIzLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIFN5c3RlbSBJRApDaGFyYWN0ZXJpc3RpYyAo
SGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVC
Xzc3L3NlcnZpY2UwMDI4L2NoYXIwMDMxCiAgICAgICAgMDAwMDJhNTAtMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiCiAgICAgICAgUG5QIElECkNoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAw
KQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAw
MjgvY2hhcjAwMzMKICAgICAgICAwMDAwMDAxNC0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAK
ICAgICAgICBWZW5kb3Igc3BlY2lmaWMKRGVzY3JpcHRvciAoSGFuZGxlIDB4MDAwMCkKICAgICAg
ICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDI4L2NoYXIw
MDMzL2Rlc2MwMDM1CiAgICAgICAgMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZi
CiAgICAgICAgQ2xpZW50IENoYXJhY3RlcmlzdGljIENvbmZpZ3VyYXRpb24KUHJpbWFyeSBTZXJ2
aWNlIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwMzgKICAgICAgICAwMDAwMTUzMC0wMDAwLTM1MTItMjExOC0wMDA5
YWYxMDA3MDAKICAgICAgICBWZW5kb3Igc3BlY2lmaWMKQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAw
eDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2
aWNlMDAzOC9jaGFyMDAzOQogICAgICAgIDAwMDAxNTMxLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEw
MDcwMAogICAgICAgIFZlbmRvciBzcGVjaWZpYwpEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQog
ICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwMzgv
Y2hhcjAwMzkvZGVzYzAwM2IKICAgICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIKICAgICAgICBDbGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpDaGFyYWN0
ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFC
X0MzXzk0XzVCXzc3L3NlcnZpY2UwMDM4L2NoYXIwMDNjCiAgICAgICAgMDAwMDE1MzItMDAwMC0z
NTEyLTIxMTgtMDAwOWFmMTAwNzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljClByaW1hcnkgU2Vy
dmljZSAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0Mz
Xzk0XzVCXzc3L3NlcnZpY2UwMDQwCiAgICAgICAgMDAwMGZlZTAtMDAwMC0xMDAwLTgwMDAtMDA4
MDVmOWIzNGZiCiAgICAgICAgQW5odWkgSHVhbWkgSW5mb3JtYXRpb24gVGVjaG5vbG9neSBDby4s
IEx0ZC4KQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9o
Y2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0MQogICAgICAgIDAw
MDAyYTJiLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIEN1cnJlbnQgVGltZQpE
ZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0Rf
MUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNDEvZGVzYzAwNDMKICAgICAgICAwMDAw
MjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQgQ2hhcmFjdGVy
aXN0aWMgQ29uZmlndXJhdGlvbgpDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAg
ICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIw
MDQ0CiAgICAgICAgMDAwMDJhMDQtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAg
UGVyaXBoZXJhbCBQcmVmZXJyZWQgQ29ubmVjdGlvbiBQYXJhbWV0ZXJzCkRlc2NyaXB0b3IgKEhh
bmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83
Ny9zZXJ2aWNlMDA0MC9jaGFyMDA0NC9kZXNjMDA0NgogICAgICAgIDAwMDAyOTAyLTAwMDAtMTAw
MC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0ZXJpc3RpYyBDb25maWd1
cmF0aW9uCkNoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXov
aGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNDcKICAgICAgICAw
MDAwMDAwMS0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKICAgICAgICBWZW5kb3Igc3BlY2lm
aWMKRGVzY3JpcHRvciAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2
X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDQ3L2Rlc2MwMDQ5CiAgICAgICAg
MDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQ2xpZW50IENoYXJh
Y3RlcmlzdGljIENvbmZpZ3VyYXRpb24KQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAg
ICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9j
aGFyMDA0YQogICAgICAgIDAwMDAwMDAyLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMAogICAg
ICAgIFZlbmRvciBzcGVjaWZpYwpEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9v
cmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNGEv
ZGVzYzAwNGMKICAgICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAg
ICAgICBDbGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpDaGFyYWN0ZXJpc3RpYyAo
SGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVC
Xzc3L3NlcnZpY2UwMDQwL2NoYXIwMDRkCiAgICAgICAgMDAwMDAwMDMtMDAwMC0zNTEyLTIxMTgt
MDAwOWFmMTAwNzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljCkRlc2NyaXB0b3IgKEhhbmRsZSAw
eDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2
aWNlMDA0MC9jaGFyMDA0ZC9kZXNjMDA0ZgogICAgICAgIDAwMDAyOTAyLTAwMDAtMTAwMC04MDAw
LTAwODA1ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0ZXJpc3RpYyBDb25maWd1cmF0aW9u
CkNoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9k
ZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNTAKICAgICAgICAwMDAwMDAw
NC0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKICAgICAgICBWZW5kb3Igc3BlY2lmaWMKRGVz
Y3JpcHRvciAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFC
X0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDUwL2Rlc2MwMDUyCiAgICAgICAgMDAwMDI5
MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQ2xpZW50IENoYXJhY3Rlcmlz
dGljIENvbmZpZ3VyYXRpb24KQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAg
L29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA1
MwogICAgICAgIDAwMDAwMDA1LTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMAogICAgICAgIFZl
bmRvciBzcGVjaWZpYwpEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1
ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNTMvZGVzYzAw
NTUKICAgICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBD
bGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpDaGFyYWN0ZXJpc3RpYyAoSGFuZGxl
IDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3Nl
cnZpY2UwMDQwL2NoYXIwMDU2CiAgICAgICAgMDAwMDAwMDYtMDAwMC0zNTEyLTIxMTgtMDAwOWFm
MTAwNzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljCkRlc2NyaXB0b3IgKEhhbmRsZSAweDAwMDAp
CiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0
MC9jaGFyMDA1Ni9kZXNjMDA1OAogICAgICAgIDAwMDAyOTAyLTAwMDAtMTAwMC04MDAwLTAwODA1
ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0ZXJpc3RpYyBDb25maWd1cmF0aW9uCkNoYXJh
Y3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0Rf
MUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNTkKICAgICAgICAwMDAwMDAwNy0wMDAw
LTM1MTItMjExOC0wMDA5YWYxMDA3MDAKICAgICAgICBWZW5kb3Igc3BlY2lmaWMKRGVzY3JpcHRv
ciAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0
XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDU5L2Rlc2MwMDViCiAgICAgICAgMDAwMDI5MDItMDAw
MC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQ2xpZW50IENoYXJhY3RlcmlzdGljIENv
bmZpZ3VyYXRpb24KQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9i
bHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA1ZgogICAg
ICAgIDAwMDAwMDEwLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMAogICAgICAgIFZlbmRvciBz
cGVjaWZpYwpEZXNjcmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNp
MC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAwNWYvZGVzYzAwNjEKICAg
ICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQg
Q2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbgpDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAw
MCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2Uw
MDQwL2NoYXIwMDYyCiAgICAgICAgMDAwMDAwMGUtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAw
CiAgICAgICAgVmVuZG9yIHNwZWNpZmljCkRlc2NyaXB0b3IgKEhhbmRsZSAweDAwMDApCiAgICAg
ICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFy
MDA2Mi9kZXNjMDA2NAogICAgICAgIDAwMDAyOTAxLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRm
YgogICAgICAgIENoYXJhY3RlcmlzdGljIFVzZXIgRGVzY3JpcHRpb24KQ2hhcmFjdGVyaXN0aWMg
KEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81
Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2NQogICAgICAgIDAwMDAwMDIwLTAwMDAtMzUxMi0yMTE4
LTAwMDlhZjEwMDcwMAogICAgICAgIFZlbmRvciBzcGVjaWZpYwpEZXNjcmlwdG9yIChIYW5kbGUg
MHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vy
dmljZTAwNDAvY2hhcjAwNjUvZGVzYzAwNjcKICAgICAgICAwMDAwMjkwMi0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlv
bgpDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAv
ZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDY4CiAgICAgICAgMDAwMDAw
MTYtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljCkRl
c2NyaXB0b3IgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8x
Ql9DM185NF81Ql83Ny9zZXJ2aWNlMDA0MC9jaGFyMDA2OC9kZXNjMDA2YQogICAgICAgIDAwMDAy
OTAyLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0ZXJp
c3RpYyBDb25maWd1cmF0aW9uCkNoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAg
IC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNDAvY2hhcjAw
NmIKICAgICAgICAwMDAwMDAxNy0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAKICAgICAgICBW
ZW5kb3Igc3BlY2lmaWMKRGVzY3JpcHRvciAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2Js
dWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDQwL2NoYXIwMDZiL2Rlc2Mw
MDZkCiAgICAgICAgMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAg
Q2xpZW50IENoYXJhY3RlcmlzdGljIENvbmZpZ3VyYXRpb24KUHJpbWFyeSBTZXJ2aWNlIChIYW5k
bGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcv
c2VydmljZTAwNzAKICAgICAgICAwMDAwZmVlMS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIK
ICAgICAgICBBbmh1aSBIdWFtaSBJbmZvcm1hdGlvbiBUZWNobm9sb2d5IENvLiwgTHRkLgpDaGFy
YWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NE
XzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDcwL2NoYXIwMDcxCiAgICAgICAgMDAwMDAwMDktMDAw
MC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCiAgICAgICAgVmVuZG9yIHNwZWNpZmljCkRlc2NyaXB0
b3IgKEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185
NF81Ql83Ny9zZXJ2aWNlMDA3MC9jaGFyMDA3MS9kZXNjMDA3MwogICAgICAgIDAwMDAyOTAyLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIENsaWVudCBDaGFyYWN0ZXJpc3RpYyBD
b25maWd1cmF0aW9uCkNoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcv
Ymx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNzAvY2hhcjAwNzQKICAg
ICAgICAwMDAwZmVkZC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBKYXdib25l
CkNoYXJhY3RlcmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9k
ZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2VydmljZTAwNzAvY2hhcjAwNzYKICAgICAgICAwMDAwZmVk
ZS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDb2luLCBJbmMuCkNoYXJhY3Rl
cmlzdGljIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJf
QzNfOTRfNUJfNzcvc2VydmljZTAwNzAvY2hhcjAwNzgKICAgICAgICAwMDAwZmVkZi0wMDAwLTEw
MDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBEZXNpZ24gU0hJRlQKQ2hhcmFjdGVyaXN0aWMg
KEhhbmRsZSAweDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81
Ql83Ny9zZXJ2aWNlMDA3MC9jaGFyMDA3YQogICAgICAgIDAwMDBmZWQwLTAwMDAtMTAwMC04MDAw
LTAwODA1ZjliMzRmYgogICAgICAgIEFwcGxlLCBJbmMuCkNoYXJhY3RlcmlzdGljIChIYW5kbGUg
MHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNfOTRfNUJfNzcvc2Vy
dmljZTAwNzAvY2hhcjAwN2MKICAgICAgICAwMDAwZmVkMS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIKICAgICAgICBBcHBsZSwgSW5jLgpDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkK
ICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDcw
L2NoYXIwMDdlCiAgICAgICAgMDAwMGZlZDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAg
ICAgICAgQXBwbGUsIEluYy4KQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAgICAg
L29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA3MC9jaGFyMDA4
MAogICAgICAgIDAwMDBmZWQzLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAgIEFw
cGxlLCBJbmMuClByaW1hcnkgU2VydmljZSAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2Js
dWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDg0CiAgICAgICAgMDAwMDE4
MGQtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgSGVhcnQgUmF0ZQpDaGFyYWN0
ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFC
X0MzXzk0XzVCXzc3L3NlcnZpY2UwMDg0L2NoYXIwMDg1CiAgICAgICAgMDAwMDJhMzctMDAwMC0x
MDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgSGVhcnQgUmF0ZSBNZWFzdXJlbWVudApEZXNj
cmlwdG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJf
QzNfOTRfNUJfNzcvc2VydmljZTAwODQvY2hhcjAwODUvZGVzYzAwODcKICAgICAgICAwMDAwMjkw
Mi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQgQ2hhcmFjdGVyaXN0
aWMgQ29uZmlndXJhdGlvbgpDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAv
b3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDg0L2NoYXIwMDg4
CiAgICAgICAgMDAwMDJhMzktMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgSGVh
cnQgUmF0ZSBDb250cm9sIFBvaW50ClByaW1hcnkgU2VydmljZSAoSGFuZGxlIDB4MDAwMCkKICAg
ICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDhjCiAg
ICAgICAgMDAwMDE4MTEtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQWxlcnQg
Tm90aWZpY2F0aW9uIFNlcnZpY2UKQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAweDAwMDApCiAgICAg
ICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2aWNlMDA4Yy9jaGFy
MDA4ZAogICAgICAgIDAwMDAyYTQ2LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYgogICAgICAg
IE5ldyBBbGVydApDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2Js
dWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDhjL2NoYXIwMDhmCiAgICAg
ICAgMDAwMDJhNDQtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgQWxlcnQgTm90
aWZpY2F0aW9uIENvbnRyb2wgUG9pbnQKRGVzY3JpcHRvciAoSGFuZGxlIDB4MDAwMCkKICAgICAg
ICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDhjL2NoYXIw
MDhmL2Rlc2MwMDkxCiAgICAgICAgMDAwMDI5MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZi
CiAgICAgICAgQ2xpZW50IENoYXJhY3RlcmlzdGljIENvbmZpZ3VyYXRpb24KUHJpbWFyeSBTZXJ2
aWNlIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwOTQKICAgICAgICAwMDAwMTgwMi0wMDAwLTEwMDAtODAwMC0wMDgw
NWY5YjM0ZmIKICAgICAgICBJbW1lZGlhdGUgQWxlcnQKQ2hhcmFjdGVyaXN0aWMgKEhhbmRsZSAw
eDAwMDApCiAgICAgICAgL29yZy9ibHVlei9oY2kwL2Rldl9DRF8xQl9DM185NF81Ql83Ny9zZXJ2
aWNlMDA5NC9jaGFyMDA5NQogICAgICAgIDAwMDAyYTA2LTAwMDAtMTAwMC04MDAwLTAwODA1Zjli
MzRmYgogICAgICAgIEFsZXJ0IExldmVsClByaW1hcnkgU2VydmljZSAoSGFuZGxlIDB4MDAwMCkK
ICAgICAgICAvb3JnL2JsdWV6L2hjaTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDk5
CiAgICAgICAgMDAwMDM4MDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgVW5r
bm93bgpDaGFyYWN0ZXJpc3RpYyAoSGFuZGxlIDB4MDAwMCkKICAgICAgICAvb3JnL2JsdWV6L2hj
aTAvZGV2X0NEXzFCX0MzXzk0XzVCXzc3L3NlcnZpY2UwMDk5L2NoYXIwMDlhCiAgICAgICAgMDAw
MDRhMDItMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiCiAgICAgICAgVW5rbm93bgpEZXNjcmlw
dG9yIChIYW5kbGUgMHgwMDAwKQogICAgICAgIC9vcmcvYmx1ZXovaGNpMC9kZXZfQ0RfMUJfQzNf
OTRfNUJfNzcvc2VydmljZTAwOTkvY2hhcjAwOWEvZGVzYzAwOWMKICAgICAgICAwMDAwMjkwMi0w
MDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIKICAgICAgICBDbGllbnQgQ2hhcmFjdGVyaXN0aWMg
Q29uZmlndXJhdGlvbgoK
--0000000000005af7c205dba7a622--
