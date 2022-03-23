Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79136C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 14:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiCWOs0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244923AbiCWOry (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 10:47:54 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6992B81658
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 07:46:22 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id a26so3070890lfg.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 07:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aiVHJkKRImYlNpJVBoc2xdrxhCIuZ2qCdLCpqlOmZ0=;
        b=SEJ6NfjWtpzZ1OSiPpAteGBemCqxNqtOz/gobLEH1IeFzTebiw0WqM8r5jNlfSwIun
         tlwJDOJb5rIubS9eHGuKA0I45uRe6N/ToM+5pODnn0ddBX38M4KaRWQemd0cPeYCi37D
         ePqJtThLGhPJzbSbVFAUWQfGj8+EnWWEn2Nv8c64gCtzXTik2s25x5YuZZerl+5FM/Cg
         PfxPV5mDAWl3/bga7AIlVsu0TA7AGZIJ47oKK/8Zyy6PYWzCPvYN8nvKu5J7TE0SS4YS
         ++XXFWgeIbIotv5+ISImyf8+dJJi2nwWCf2PePG3Wp9OdRUdLla1s0LA5F4jetikStYK
         Fn0Q==
X-Gm-Message-State: AOAM530uMKcAKQlXrqBXNzVC0G8qBlishTNFwuaC3UItpLWolMOGY3s8
        hm1utsvlveFwUVJHT89OHyQVXyx2LUnwxofSqkNSiDz2EoGTHw==
X-Google-Smtp-Source: ABdhPJxchJh1vZ4Tqa7h6oD7go0oW0NbpOwhyJ5kCQr69XaEx8rZHK75/6+7o4zzNhzhsThG1KUGFW573+F0o/cGZuk=
X-Received: by 2002:ac2:5fc1:0:b0:448:2915:3306 with SMTP id
 q1-20020ac25fc1000000b0044829153306mr159621lfg.109.1648046779307; Wed, 23 Mar
 2022 07:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
 <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
 <CANFkB1yr3N_Twac=ocxBRst79-gmdu8=6VTD6oPgdGT0rb_HaQ@mail.gmail.com>
 <CANFkB1xEesP1cMmK4VGi5cH-v80ho00wT24q=+4QQSdyPegPQQ@mail.gmail.com>
 <CABBYNZKSsyqfiWYjpuZNYtKAZb4C2q73YwOj=KoUFq71gLs7Hg@mail.gmail.com>
 <CANFkB1zHTZF3Mcgn5GPBA0km+BNyL3bb9=MJFuSNFe6x5zgimQ@mail.gmail.com>
 <CABBYNZLWN3+51F-sNJ5yPc2bw+x4Ep6rCwcFLn0bfrwArL=Hyw@mail.gmail.com>
 <CABBYNZL-fjTd8JdmRRM5Y26d41KwDxvvuaED+j2+yPT-RBpMtw@mail.gmail.com>
 <CANFkB1w2UUq7W0EqEdskebhKcEtkZ-33q-Co5VF_WKf7dHsJtg@mail.gmail.com> <CANFkB1zMOYTD8ZsDHczHqce9ipgyu9-fEeXEZqTzuf=T4UufLQ@mail.gmail.com>
In-Reply-To: <CANFkB1zMOYTD8ZsDHczHqce9ipgyu9-fEeXEZqTzuf=T4UufLQ@mail.gmail.com>
From:   Adam Pigg <adam@piggz.co.uk>
Date:   Wed, 23 Mar 2022 14:46:07 +0000
Message-ID: <CANFkB1yOadrpibp4ZNE8e0E+-Wy4z_FV3LC=B7HZzUjGAh3DVA@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000dabe0405dae3cab1"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--000000000000dabe0405dae3cab1
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Mar 2022 at 13:36, Adam Pigg <adam@piggz.co.uk> wrote:
>
> Hi Luiz
>
> On Wed, 23 Mar 2022 at 09:11, Adam Pigg <adam@piggz.co.uk> wrote:
> >
> > Hi Luiz
> >
> > Good that you clearly know more about this than me!...
> >
> > On Tue, 22 Mar 2022 at 23:44, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Tue, Mar 22, 2022 at 4:35 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Adam,
> > > >
> > > > On Tue, Mar 22, 2022 at 4:09 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > >
> > > > > Thanks Luiz
> > > > >
> > > > > On Tue, 22 Mar 2022 at 21:35, Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > > >
> > > > > > Hi Adam,
> > > > > >
> > > > > > On Tue, Mar 22, 2022 at 3:40 AM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > >
> > > > > > > Hi Luiz
> > > > > > >
> > > > > > >
> > > > > > > On Tue, 22 Mar 2022 at 07:55, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > >
> > > > > > > > Hi Luiz
> > > > > > > >
> > > > > > > > On Tue, 22 Mar 2022 at 00:44, Luiz Augusto von Dentz
> > > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Adam,
> > > > > > > > >
> > > > > > > > > On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi
> > > > > > > > > >
> > > > > > > > > > A bit of background, I write a linux desktop/mobile app called
> > > > > > > > > > Amazfish which interfaces with several watches over BLE using their
> > > > > > > > > > GATT services.  To do this, I use the bluez dbus api (technically a
> > > > > > > > > > thin wrapper around it I wrote called qble
> > > > > > > > > > https://github.com/piggz/qble)
> > > > > > > > > >
> > > > > > > > > > All has been good so far, I support several generations of
> > > > > > > > > > Huami/Amazfit watches, as well as the open source Pinetime and
> > > > > > > > > > Bangle.js.  For the Amazfit watches, i have implementations for older
> > > > > > > > > > devies such as the Bip, and newer ones such as the GTS.
> > > > > > > > > >
> > > > > > > > > > Much of the reverse engineering comes from the Android Gadget Bridge
> > > > > > > > > > project, which supports many more devices.
> > > > > > > > > >
> > > > > > > > > > My community of users donated to buy me a newer device called a GTR2,
> > > > > > > > > > which, according to the GB devs uses the same protocol as the slightly
> > > > > > > > > > older GTS, and the packet captures I have from Android would support
> > > > > > > > > > this.
> > > > > > > > > >
> > > > > > > > > > But this is where my trouble starts with Bluez, my existing
> > > > > > > > > > implementation doesnt work at all.  Normally, after a connection, I
> > > > > > > > > > would wait for the ServicesResolved signal, which happens pretty fast
> > > > > > > > > > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > > > > > > > > > which time, the watch has disconnected. (i get a disconnected signal
> > > > > > > > > > immediately after the ServicesResolved signal)
> > > > > > > > > >
> > > > > > > > > > To rule out my code, I have tried several things:
> > > > > > > > > > Gatttool
> > > > > > > > > > With gattool, i can connect, get the services, enable a notification,
> > > > > > > > > > write a value and get the expected results seemingly fine
> > > > > > > > > >
> > > > > > > > > > Python-gatt (using the bluez dbus api)
> > > > > > > > > > Im unable to iterate the services, like my app, it takes 30 seconds to
> > > > > > > > > > get the signal and then swiftly disconnects
> > > > > > > > > >
> > > > > > > > > > Gattlib (https://github.com/labapart/gattlib)
> > > > > > > > > > Gattlib is interesting as it appears to have "borrowed" much of its
> > > > > > > > > > code directly from bluez.  When built against the system bluez, if the
> > > > > > > > > > version is > 5.42, it will use the dbus api.  When I do this, again im
> > > > > > > > > > unable to list services on the watch.  However, if I edit the build to
> > > > > > > > > > force it to use its internal gatt implementation, which appears to be
> > > > > > > > > > the same one used by gatttool, then, it IS able to interrogate the
> > > > > > > > > > watch.
> > > > > > > > > >
> > > > > > > > > > I have attached 3 files
> > > > > > > > > > 1. test python program which should print services, and associated btmon
> > > > > > > > > > 2. btmon output while using gatttool
> > > > > > > > > > 3. btmon output running gattlib discover example
> > > > > > > > > >
> > > > > > > > > > Note, other than discovery, I havnt been able to get gattlib to
> > > > > > > > > > read/write/notify!
> > > > > > > > > >
> > > > > > > > > > It seems as though I may be triggering a bug in the bluez dbus api?
> > > > > > > > > > Can anyone suggest anything?
> > > > > > > > >
> > > > > > > > > What version are you using? I would first try with the latest to see
> > > > > > > > > if that something already fixed.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > Im using 5.63 already, which is the latest tag (on opensuse tumbleweed)
> > > > > > > >
> > > > > > > > I'll also try bluetoothctl and attach logs using that, though I
> > > > > > > > suspect it will behave the same as the python library and my own
> > > > > > > > library.
> > > > > > > >
> > > > > > >
> > > > > > > Attached is the output of btmon while using bluetoothctl
> > > > > > >
> > > > > > > bluetoothctl behaves the same as my lib and python, it is unable to
> > > > > > > list services, and after a while, emits the ServicesResolved and
> > > > > > > disconnected messages at the same time.  Im sure it should be able to
> > > > > > > list the services immediately after connect just like gatttool can.
> > > > > >
> > > > > > Looks like there is multiple rounds of MTU Exchange, not sure if that
> > > > > > is actually a problem but the spec does say it shall only be sent once
> > > > > > per client:
> > > > > >
> > > > > > BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> > > > > > page 1424:
> > > > > >
> > > > > > This request shall only be sent once during a connection by the client.
> > > > > >
> > > > > > There is also no response to frame #30:
> > > > > > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> > > > > >
> > > > > >                            #30 [hci0] 26.641557
> > > > > >       ATT: Read Request (0x0a) len 2
> > > > > >         Handle: 0x0018
> > > > > >
> > > > > > So after 30 seconds (ATT timeout) without receiving any response it disconnects:
> > > > > >
> > > > >
> > > > > So, the verdict is that the watch isnt acting to spec right?
> > > > >
> > > > > Why does gatttool work ok, is it a completely different implementation?
> > > > >
> > > > > I understand if wouldnt be to spec, but would it be possible to make
> > > > > bluez more resilient to devices not acting to spec?  Android and iOS
> > > > > work just fine in this regard, so could bluez handle mis-behaving
> > > > > devices more flexibly?
> > > >
> > > > That I can't really explain, perhaps it is timing related, something
> > > > with Exchange MTU since it appears to stop the device from responding
> > > > when it happens a second time.
> > > >
> > > > > Do you have any suggestions for things I could try? I looked for
> > > > > similar lines in the working gatttool log, and it doesnt have anything
> > > > > like that, seems to send flags 0x00 dlen 9 (instead of 7?)  ... how is
> > > > > it behaving differently?
> > > >
> > > > Not sure really, does Android/iOS Exchange the MTU? Maybe we need a
> > > > timer to start it later or perhaps the problem first response to
> > > > exchange MTU does actually use the final_mtu which makes the watch to
> > > > trigger yet another exchange to have both rx and tx MTU the same so
> > > > try with the following change:
> > > >
> > > > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > > > index 2adb4afbf..d326782bf 100644
> > > > --- a/src/shared/gatt-server.c
> > > > +++ b/src/shared/gatt-server.c
> > > > @@ -1499,7 +1499,7 @@ static void exchange_mtu_cb(struct bt_att_chan
> > > > *chan, uint8_t opcode,
> > > >         final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
> > > >
> > > >         /* Respond with the server MTU */
> > > > -       put_le16(server->mtu, rsp_pdu);
> > > > +       put_le16(final_mtu, rsp_pdu);
> > > >         bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
> > > >
> > > >         /* Set MTU to be the minimum */
> > >
> > > Hmm Im not sure if this will work since the peripheral seems to
> > > respond different values 252 vs 247, also the spec does say that:
> > >
> > > 'The Server Rx MTU parameter shall be set to the *maximum size* of the
> > > Attribute protocol PDU that the server can receive.
> > > The server and client shall set ATT_MTU to the *minimum of the Client Rx MTU
> > > and the Server Rx MTU*. The size is the same to ensure that a client can
> > > correctly detect the final packet of a long attribute read.'
> > >
> > > So my interpretation is that the minimum is calculated after the
> > > Exchange is complete so it doesn't require the Server MTU to be
> > > limited by the Client MTU, anyway if Android and iOS does apply the
> > > minimum logic before responding we can do the same.
> > >
> >
> > Maybe it will help if I attach an android packet capture....
> >
> > The attachedhttps://marc.info/?l=linux-bluetooth&m=164799909020040&w=2
> > log can be opened in Wireshark, and to my untrained eye, it looks like
> > the MTU negotiation is at packets 451 and 452, and 247 is used?
> >
> > Ill try and get the proposed patch built and see how it behaves
>
> Attached if the btmon and bluetoothctl.  It doesnt seem to be there quite yet.
>
> There was one point before i applied the patch where bluetoothctl
> seemed to list the attributes quickly, but i havnt been able to
> reproduce that again with or without the patch.
>

For completeness, also attached the output of my program and btmon

My program should connect, wait for resolved signal, then read a char,
enable some notifications, and do a write.  You can see the 30 second
wait between connect, resolved, and quickly followed by a disconnect.


> Thanks
>
>
> >
> > Thanks
> >
> > > >
> > > > >
> > > > > > < HCI Command: Disconnect (0x01|0x0006) plen 3
> > > > > >
> > > > > >                            #48 [hci0] 58.673128
> > > > > >         Handle: 3585
> > > > > >         Reason: Remote User Terminated Connection (0x13)
> > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > >
> > > > > > > > > --
> > > > > > > > > Luiz Augusto von Dentz
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Luiz Augusto von Dentz
> > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz

--000000000000dabe0405dae3cab1
Content-Type: text/plain; charset="US-ASCII"; name="btmon_new_bluez_amazfish.txt"
Content-Disposition: attachment; filename="btmon_new_bluez_amazfish.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_l13ohov30>
X-Attachment-Id: f_l13ohov30

QW1hemZpc2g6CgpwaWdnekBhZGFtLWxhcHRvcCB+L3Byb2plY3RzL2J1aWxkLWhhcmJvdXItYW1h
emZpc2gtRGVza3RvcC1EZWJ1ZyAkIC4vZGFlbW9uL2hhcmJvdXItYW1hemZpc2hkCjIwMjItMDMt
MjMgMTQ6Mzk6MjguOTIzIDogU3RhcnRpbmcgYW1hemZpc2ggZGFlbW9uCjIwMjItMDMtMjMgMTQ6
Mzk6MjguOTMyIDogU3RhcnRpbmcgbm90aWZpY2F0aW9uIG1vbml0b3IKMjAyMi0wMy0yMyAxNDoz
OToyOC45NjEgOiB2b2lkIE5hdmlnYXRpb25JbnRlcmZhY2U6OmNvbm5lY3REYWVtb24oKQoyMDIy
LTAzLTIzIDE0OjM5OjI4Ljk2MiA6IEludGVyZmFjZSBpcyBub3QgdmFsaWQKMjAyMi0wMy0yMyAx
NDozOToyOC45NjIgOiBSZWdpc3RlcmluZyBzZXJ2aWNlIG9uIGRidXMgdWsuY28ucGlnZ3ouYW1h
emZpc2gKMjAyMi0wMy0yMyAxNDozOToyOC45NjMgOiBhbWF6ZmlzaC1kYWVtb246IHN1Y2Nlc2Z1
bGx5IHJlZ2lzdGVyZWQgdG8gZGJ1cyBzZXNzaW9uQnVzCjIwMjItMDMtMjMgMTQ6Mzk6MjguOTY0
IDogRGV2aWNlRmFjdG9yeTo6Y3JlYXRlRGV2aWNlOiByZXF1ZXN0ZWQgZGV2aWNlIG9mIHR5cGU6
ICJBbWF6Zml0IEdUUiAyIgoyMDIyLTAzLTIzIDE0OjM5OjI4Ljk2NCA6IENyZWF0aW5nIEdUUyBE
ZXZpY2UKMjAyMi0wMy0yMyAxNDozOToyOC45NjQgOiBHdHJEZXZpY2U6Okd0ckRldmljZShjb25z
dCBRU3RyaW5nJiwgUU9iamVjdCopCjIwMjItMDMtMjMgMTQ6Mzk6MjguOTY0IDogQ3JlYXRpbmcg
REJVUyBIUk0KMjAyMi0wMy0yMyAxNDozOToyOC45NjggOiBEUklWRVJTOiAgKCJvcmcua2RlLmtk
Yi5teXNxbCIsICJvcmcua2RlLmtkYi5zcWxpdGUiKQoyMDIyLTAzLTIzIDE0OjM5OjI4Ljk2OSA6
IERhdGFiYXNlIGlzOiAgIi9ob21lL3BpZ2d6Ly5sb2NhbC9zaGFyZS9oYXJib3VyLWFtYXpmaXNo
L2hhcmJvdXItYW1hemZpc2gvYW1hemZpc2gua2V4aSIKMjAyMi0wMy0yMyAxNDozOToyOC45Njkg
OiBLRGJDb25uZWN0aW9uIG9iamVjdCBjcmVhdGVkLgoyMDIyLTAzLTIzIDE0OjM5OjI4Ljk2OSA6
IEtEYkNvbm5lY3Rpb246OmNvbm5lY3QoKSBPSy4KMjAyMi0wMy0yMyAxNDozOToyOC45NzEgOiAo
Im1pX2JhbmRfYWN0aXZpdHkiLCAic3BvcnRzX2RhdGEiLCAic3BvcnRzX21ldGEiKQoyMDIyLTAz
LTIzIDE0OjM5OjI4Ljk3MSA6IERldmljZUludGVyZmFjZTo6Y29ubmVjdFRvRGV2aWNlOiAiL29y
Zy9ibHVlei9oY2kwL2Rldl9GOF9DM19EMV9CMF81QV8zQSIKMjAyMi0wMy0yMyAxNDozOToyOC45
NzEgOiBRQkxFRGV2aWNlOjpzZXREZXZpY2VQYXRoCjIwMjItMDMtMjMgMTQ6Mzk6MjguOTczIDog
dHJ1ZQoyMDIyLTAzLTIzIDE0OjM5OjI4Ljk3NCA6IEFic3RyYWN0RGV2aWNlOjpjb25uZWN0VG9E
ZXZpY2UKMjAyMi0wMy0yMyAxNDozOToyOC45NzQgOiBRQkxFRGV2aWNlOjpkaXNjb25uZWN0RnJv
bURldmljZQoyMDIyLTAzLTIzIDE0OjM5OjI4Ljk3NSA6IERldmljZUludGVyZmFjZTo6b25Db25u
ZWN0aW9uU3RhdGVDaGFuZ2VkICJjb25uZWN0aW5nIgoyMDIyLTAzLTIzIDE0OjM5OjI4Ljk3NSA6
IFFCTEVEZXZpY2U6OmNvbm5lY3RUb0RldmljZQoyMDIyLTAzLTIzIDE0OjM5OjMxLjA3MCA6IHZp
cnR1YWwgdm9pZCBHdHJEZXZpY2U6Om9uUHJvcGVydGllc0NoYW5nZWQoUVN0cmluZywgUVZhcmlh
bnRNYXAsIFFTdHJpbmdMaXN0KSAib3JnLmJsdWV6LkRldmljZTEiIFFNYXAoKCJDb25uZWN0ZWQi
LCBRVmFyaWFudChib29sLCB0cnVlKSkpICgpCjIwMjItMDMtMjMgMTQ6Mzk6MzEuMDcxIDogRGV2
aWNlSW50ZXJmYWNlOjpvbkNvbm5lY3Rpb25TdGF0ZUNoYW5nZWQgImNvbm5lY3RlZCIKMjAyMi0w
My0yMyAxNDo0MDowMS4zNTYgOiB2aXJ0dWFsIHZvaWQgR3RyRGV2aWNlOjpvblByb3BlcnRpZXND
aGFuZ2VkKFFTdHJpbmcsIFFWYXJpYW50TWFwLCBRU3RyaW5nTGlzdCkgIm9yZy5ibHVlei5EZXZp
Y2UxIiBRTWFwKCgiU2VydmljZXNSZXNvbHZlZCIsIFFWYXJpYW50KGJvb2wsIHRydWUpKSkgKCkK
MjAyMi0wMy0yMyAxNDo0MDowMS4zODcgOiB2aXJ0dWFsIHZvaWQgR3RyRGV2aWNlOjppbml0aWFs
aXNlKCkKMjAyMi0wMy0yMyAxNDo0MDowMS4zODggOiB2aXJ0dWFsIHZvaWQgR3RyRGV2aWNlOjpw
YXJzZVNlcnZpY2VzKCkKMjAyMi0wMy0yMyAxNDo0MDowMS4zOTEgOiBSZXNvbHZlZCBzZXJ2aWNl
cy4uLgoyMDIyLTAzLTIzIDE0OjQwOjAxLjM5MSA6IDwhRE9DVFlQRSBub2RlIFBVQkxJQyAiLS8v
ZnJlZWRlc2t0b3AvL0RURCBELUJVUyBPYmplY3QgSW50cm9zcGVjdGlvbiAxLjAvL0VOIgoiaHR0
cDovL3d3dy5mcmVlZGVza3RvcC5vcmcvc3RhbmRhcmRzL2RidXMvMS4wL2ludHJvc3BlY3QuZHRk
Ij4KPG5vZGU+PGludGVyZmFjZSBuYW1lPSJvcmcuZnJlZWRlc2t0b3AuREJ1cy5JbnRyb3NwZWN0
YWJsZSI+PG1ldGhvZCBuYW1lPSJJbnRyb3NwZWN0Ij48YXJnIG5hbWU9InhtbCIgdHlwZT0icyIg
ZGlyZWN0aW9uPSJvdXQiLz4KPC9tZXRob2Q+PC9pbnRlcmZhY2U+PGludGVyZmFjZSBuYW1lPSJv
cmcuYmx1ZXouRGV2aWNlMSI+PG1ldGhvZCBuYW1lPSJEaXNjb25uZWN0Ij48L21ldGhvZD48bWV0
aG9kIG5hbWU9IkNvbm5lY3QiPjwvbWV0aG9kPjxtZXRob2QgbmFtZT0iQ29ubmVjdFByb2ZpbGUi
PjxhcmcgbmFtZT0iVVVJRCIgdHlwZT0icyIgZGlyZWN0aW9uPSJpbiIvPgo8L21ldGhvZD48bWV0
aG9kIG5hbWU9IkRpc2Nvbm5lY3RQcm9maWxlIj48YXJnIG5hbWU9IlVVSUQiIHR5cGU9InMiIGRp
cmVjdGlvbj0iaW4iLz4KPC9tZXRob2Q+PG1ldGhvZCBuYW1lPSJQYWlyIj48L21ldGhvZD48bWV0
aG9kIG5hbWU9IkNhbmNlbFBhaXJpbmciPjwvbWV0aG9kPjxwcm9wZXJ0eSBuYW1lPSJBZGRyZXNz
IiB0eXBlPSJzIiBhY2Nlc3M9InJlYWQiPjwvcHJvcGVydHk+PHByb3BlcnR5IG5hbWU9IkFkZHJl
c3NUeXBlIiB0eXBlPSJzIiBhY2Nlc3M9InJlYWQiPjwvcHJvcGVydHk+PHByb3BlcnR5IG5hbWU9
Ik5hbWUiIHR5cGU9InMiIGFjY2Vzcz0icmVhZCI+PC9wcm9wZXJ0eT48cHJvcGVydHkgbmFtZT0i
QWxpYXMiIHR5cGU9InMiIGFjY2Vzcz0icmVhZHdyaXRlIj48L3Byb3BlcnR5Pjxwcm9wZXJ0eSBu
YW1lPSJDbGFzcyIgdHlwZT0idSIgYWNjZXNzPSJyZWFkIj48L3Byb3BlcnR5Pjxwcm9wZXJ0eSBu
YW1lPSJBcHBlYXJhbmNlIiB0eXBlPSJxIiBhY2Nlc3M9InJlYWQiPjwvcHJvcGVydHk+PHByb3Bl
cnR5IG5hbWU9Ikljb24iIHR5cGU9InMiIGFjY2Vzcz0icmVhZCI+PC9wcm9wZXJ0eT48cHJvcGVy
dHkgbmFtZT0iUGFpcmVkIiB0eXBlPSJiIiBhY2Nlc3M9InJlYWQiPjwvcHJvcGVydHk+PHByb3Bl
cnR5IG5hbWU9IlRydXN0ZWQiIHR5cGU9ImIiIGFjY2Vzcz0icmVhZHdyaXRlIj48L3Byb3BlcnR5
Pjxwcm9wZXJ0eSBuYW1lPSJCbG9ja2VkIiB0eXBlPSJiIiBhY2Nlc3M9InJlYWR3cml0ZSI+PC9w
cm9wZXJ0eT48cHJvcGVydHkgbmFtZT0iTGVnYWN5UGFpcmluZyIgdHlwZT0iYiIgYWNjZXNzPSJy
ZWFkIj48L3Byb3BlcnR5Pjxwcm9wZXJ0eSBuYW1lPSJSU1NJIiB0eXBlPSJuIiBhY2Nlc3M9InJl
YWQiPjwvcHJvcGVydHk+PHByb3BlcnR5IG5hbWU9IkNvbm5lY3RlZCIgdHlwZT0iYiIgYWNjZXNz
PSJyZWFkIj48L3Byb3BlcnR5Pjxwcm9wZXJ0eSBuYW1lPSJVVUlEcyIgdHlwZT0iYXMiIGFjY2Vz
cz0icmVhZCI+PC9wcm9wZXJ0eT48cHJvcGVydHkgbmFtZT0iTW9kYWxpYXMiIHR5cGU9InMiIGFj
Y2Vzcz0icmVhZCI+PC9wcm9wZXJ0eT48cHJvcGVydHkgbmFtZT0iQWRhcHRlciIgdHlwZT0ibyIg
YWNjZXNzPSJyZWFkIj48L3Byb3BlcnR5Pjxwcm9wZXJ0eSBuYW1lPSJNYW51ZmFjdHVyZXJEYXRh
IiB0eXBlPSJhe3F2fSIgYWNjZXNzPSJyZWFkIj48L3Byb3BlcnR5Pjxwcm9wZXJ0eSBuYW1lPSJT
ZXJ2aWNlRGF0YSIgdHlwZT0iYXtzdn0iIGFjY2Vzcz0icmVhZCI+PC9wcm9wZXJ0eT48cHJvcGVy
dHkgbmFtZT0iVHhQb3dlciIgdHlwZT0ibiIgYWNjZXNzPSJyZWFkIj48L3Byb3BlcnR5Pjxwcm9w
ZXJ0eSBuYW1lPSJTZXJ2aWNlc1Jlc29sdmVkIiB0eXBlPSJiIiBhY2Nlc3M9InJlYWQiPjwvcHJv
cGVydHk+PHByb3BlcnR5IG5hbWU9Ildha2VBbGxvd2VkIiB0eXBlPSJiIiBhY2Nlc3M9InJlYWR3
cml0ZSI+PC9wcm9wZXJ0eT48L2ludGVyZmFjZT48aW50ZXJmYWNlIG5hbWU9Im9yZy5mcmVlZGVz
a3RvcC5EQnVzLlByb3BlcnRpZXMiPjxtZXRob2QgbmFtZT0iR2V0Ij48YXJnIG5hbWU9ImludGVy
ZmFjZSIgdHlwZT0icyIgZGlyZWN0aW9uPSJpbiIvPgo8YXJnIG5hbWU9Im5hbWUiIHR5cGU9InMi
IGRpcmVjdGlvbj0iaW4iLz4KPGFyZyBuYW1lPSJ2YWx1ZSIgdHlwZT0idiIgZGlyZWN0aW9uPSJv
dXQiLz4KPC9tZXRob2Q+PG1ldGhvZCBuYW1lPSJTZXQiPjxhcmcgbmFtZT0iaW50ZXJmYWNlIiB0
eXBlPSJzIiBkaXJlY3Rpb249ImluIi8+CjxhcmcgbmFtZT0ibmFtZSIgdHlwZT0icyIgZGlyZWN0
aW9uPSJpbiIvPgo8YXJnIG5hbWU9InZhbHVlIiB0eXBlPSJ2IiBkaXJlY3Rpb249ImluIi8+Cjwv
bWV0aG9kPjxtZXRob2QgbmFtZT0iR2V0QWxsIj48YXJnIG5hbWU9ImludGVyZmFjZSIgdHlwZT0i
cyIgZGlyZWN0aW9uPSJpbiIvPgo8YXJnIG5hbWU9InByb3BlcnRpZXMiIHR5cGU9ImF7c3Z9IiBk
aXJlY3Rpb249Im91dCIvPgo8L21ldGhvZD48c2lnbmFsIG5hbWU9IlByb3BlcnRpZXNDaGFuZ2Vk
Ij48YXJnIG5hbWU9ImludGVyZmFjZSIgdHlwZT0icyIvPgo8YXJnIG5hbWU9ImNoYW5nZWRfcHJv
cGVydGllcyIgdHlwZT0iYXtzdn0iLz4KPGFyZyBuYW1lPSJpbnZhbGlkYXRlZF9wcm9wZXJ0aWVz
IiB0eXBlPSJhcyIvPgo8L3NpZ25hbD4KPC9pbnRlcmZhY2U+PGludGVyZmFjZSBuYW1lPSJvcmcu
Ymx1ZXouQWRtaW5Qb2xpY3lTdGF0dXMxIj48cHJvcGVydHkgbmFtZT0iQWZmZWN0ZWRCeVBvbGlj
eSIgdHlwZT0iYiIgYWNjZXNzPSJyZWFkIj48L3Byb3BlcnR5PjwvaW50ZXJmYWNlPjxub2RlIG5h
bWU9InNlcnZpY2UwMDAxIi8+PG5vZGUgbmFtZT0ic2VydmljZTAwMjgiLz48bm9kZSBuYW1lPSJz
ZXJ2aWNlMDAzOCIvPjxub2RlIG5hbWU9InNlcnZpY2UwMDQwIi8+PG5vZGUgbmFtZT0ic2Vydmlj
ZTAwNzAiLz48bm9kZSBuYW1lPSJzZXJ2aWNlMDA4NCIvPjxub2RlIG5hbWU9InNlcnZpY2UwMDhj
Ii8+PG5vZGUgbmFtZT0ic2VydmljZTAwOTQiLz48bm9kZSBuYW1lPSJzZXJ2aWNlMDA5OSIvPjwv
bm9kZT4KMjAyMi0wMy0yMyAxNDo0MDowMS4zOTQgOiAxMCBub2RlcwoyMDIyLTAzLTIzIDE0OjQw
OjAxLjQwMCA6IENyZWF0aW5nIHNlcnZpY2UgZm9yOiAgIjAwMDAxODAxLTAwMDAtMTAwMC04MDAw
LTAwODA1ZjliMzRmYiIKMjAyMi0wMy0yMyAxNDo0MDowMS40MDMgOiAyIG5vZGVzCjIwMjItMDMt
MjMgMTQ6NDA6MDEuNDExIDogSW50cm9zcGVjdDpjaGFyYWN0ZXJpc3RpY3M6ICgiMDAwMDJhMDUt
MDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIikKMjAyMi0wMy0yMyAxNDo0MDowMS40MTMgOiBD
cmVhdGluZyBzZXJ2aWNlIGZvcjogICIwMDAwMTgwYS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0
ZmIiCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDE1IDogNyBub2RlcwoyMDIyLTAzLTIzIDE0OjQwOjAx
LjQyOCA6IEludHJvc3BlY3Q6Y2hhcmFjdGVyaXN0aWNzOiAoIjAwMDAwMDE0LTAwMDAtMzUxMi0y
MTE4LTAwMDlhZjEwMDcwMCIsICIwMDAwMmEyMy0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIi
LCAiMDAwMDJhMjUtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIiwgIjAwMDAyYTI3LTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYiIsICIwMDAwMmEyOC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5
YjM0ZmIiLCAiMDAwMDJhNTAtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIikKMjAyMi0wMy0y
MyAxNDo0MDowMS40MjggOiBCaXBJbmZvU2VydmljZTo6QmlwSW5mb1NlcnZpY2UKMjAyMi0wMy0y
MyAxNDo0MDowMS40MjggOiBDcmVhdGluZyBzZXJ2aWNlIGZvcjogICIwMDAwMTUzMC0wMDAwLTM1
MTItMjExOC0wMDA5YWYxMDA3MDAiCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDI5IDogMyBub2Rlcwoy
MDIyLTAzLTIzIDE0OjQwOjAxLjQzMyA6IEludHJvc3BlY3Q6Y2hhcmFjdGVyaXN0aWNzOiAoIjAw
MDAxNTMxLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMCIsICIwMDAwMTUzMi0wMDAwLTM1MTIt
MjExOC0wMDA5YWYxMDA3MDAiKQoyMDIyLTAzLTIzIDE0OjQwOjAxLjQzNCA6IEJpcEZpcm13YXJl
U2VydmljZTo6QmlwRmlybXdhcmVTZXJ2aWNlCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDM0IDogQ3Jl
YXRpbmcgc2VydmljZSBmb3I6ICAiMDAwMGZlZTAtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZi
IgoyMDIyLTAzLTIzIDE0OjQwOjAxLjQzNSA6IDE1IG5vZGVzCjIwMjItMDMtMjMgMTQ6NDA6MDEu
NDUzIDogSW50cm9zcGVjdDpjaGFyYWN0ZXJpc3RpY3M6ICgiMDAwMDAwMDEtMDAwMC0zNTEyLTIx
MTgtMDAwOWFmMTAwNzAwIiwgIjAwMDAwMDAyLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMCIs
ICIwMDAwMDAwMy0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAiLCAiMDAwMDAwMDQtMDAwMC0z
NTEyLTIxMTgtMDAwOWFmMTAwNzAwIiwgIjAwMDAwMDA1LTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEw
MDcwMCIsICIwMDAwMDAwNi0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAiLCAiMDAwMDAwMDct
MDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwIiwgIjAwMDAwMDBlLTAwMDAtMzUxMi0yMTE4LTAw
MDlhZjEwMDcwMCIsICIwMDAwMDAxMC0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAiLCAiMDAw
MDAwMTYtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwIiwgIjAwMDAwMDE3LTAwMDAtMzUxMi0y
MTE4LTAwMDlhZjEwMDcwMCIsICIwMDAwMDAyMC0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAi
LCAiMDAwMDJhMDQtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIiwgIjAwMDAyYTJiLTAwMDAt
MTAwMC04MDAwLTAwODA1ZjliMzRmYiIpCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDUzIDogTWlCYW5k
U2VydmljZTo6TWlCYW5kU2VydmljZQoyMDIyLTAzLTIzIDE0OjQwOjAxLjQ1NCA6IENyZWF0aW5n
IHNlcnZpY2UgZm9yOiAgIjAwMDBmZWUxLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiIKMjAy
Mi0wMy0yMyAxNDo0MDowMS40NTUgOiA5IG5vZGVzCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDYzIDog
SW50cm9zcGVjdDpjaGFyYWN0ZXJpc3RpY3M6ICgiMDAwMDAwMDktMDAwMC0zNTEyLTIxMTgtMDAw
OWFmMTAwNzAwIiwgIjAwMDBmZWQwLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiIsICIwMDAw
ZmVkMS0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIiLCAiMDAwMGZlZDItMDAwMC0xMDAwLTgw
MDAtMDA4MDVmOWIzNGZiIiwgIjAwMDBmZWQzLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiIs
ICIwMDAwZmVkZC0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIiLCAiMDAwMGZlZGUtMDAwMC0x
MDAwLTgwMDAtMDA4MDVmOWIzNGZiIiwgIjAwMDBmZWRmLTAwMDAtMTAwMC04MDAwLTAwODA1Zjli
MzRmYiIpCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDYzIDogTWlCYW5kMlNlcnZpY2U6Ok1pQmFuZDJT
ZXJ2aWNlCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDYzIDogYXV0aDogMCBjcnlwdDogMTI4IHJlcTog
dHJ1ZQoyMDIyLTAzLTIzIDE0OjQwOjAxLjQ2NCA6IENyZWF0aW5nIHNlcnZpY2UgZm9yOiAgIjAw
MDAxODBkLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiIKMjAyMi0wMy0yMyAxNDo0MDowMS40
NjUgOiAzIG5vZGVzCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDY4IDogSW50cm9zcGVjdDpjaGFyYWN0
ZXJpc3RpY3M6ICgiMDAwMDJhMzctMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIiwgIjAwMDAy
YTM5LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiIpCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDY4
IDogSFJNU2VydmljZTo6SFJNU2VydmljZQoyMDIyLTAzLTIzIDE0OjQwOjAxLjQ2OCA6IENyZWF0
aW5nIHNlcnZpY2UgZm9yOiAgIjAwMDAxODExLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiIK
MjAyMi0wMy0yMyAxNDo0MDowMS40NjkgOiAzIG5vZGVzCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDcx
IDogSW50cm9zcGVjdDpjaGFyYWN0ZXJpc3RpY3M6ICgiMDAwMDJhNDQtMDAwMC0xMDAwLTgwMDAt
MDA4MDVmOWIzNGZiIiwgIjAwMDAyYTQ2LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiIpCjIw
MjItMDMtMjMgMTQ6NDA6MDEuNDcxIDogQWxlcnROb3RpZmljYXRpb25TZXJ2aWNlOjpBbGVydE5v
dGlmaWNhdGlvblNlcnZpY2UoY29uc3QgUVN0cmluZyYsIFFPYmplY3QqLCB1aW50OF90KQoyMDIy
LTAzLTIzIDE0OjQwOjAxLjQ3MSA6IENyZWF0aW5nIHNlcnZpY2UgZm9yOiAgIjAwMDAxODAyLTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiIKMjAyMi0wMy0yMyAxNDo0MDowMS40NzIgOiAyIG5v
ZGVzCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDczIDogSW50cm9zcGVjdDpjaGFyYWN0ZXJpc3RpY3M6
ICgiMDAwMDJhMDYtMDAwMC0xMDAwLTgwMDAtMDA4MDVmOWIzNGZiIikKMjAyMi0wMy0yMyAxNDo0
MDowMS40NzMgOiBDcmVhdGluZyBzZXJ2aWNlIGZvcjogICIwMDAwMzgwMi0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIiCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDc0IDogMiBub2RlcwoyMDIyLTAz
LTIzIDE0OjQwOjAxLjQ3NSA6IEludHJvc3BlY3Q6Y2hhcmFjdGVyaXN0aWNzOiAoIjAwMDA0YTAy
LTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiIpCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDc1IDog
UmVhZCBmaXJzdAoyMDIyLTAzLTIzIDE0OjQwOjAxLjQ3NSA6IFJlYWRpbmcgZnJvbSAgIjAwMDAw
MDIwLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEwMDcwMCIKMjAyMi0wMy0yMyAxNDo0MDowMS40NzYg
OiAiIgoyMDIyLTAzLTIzIDE0OjQwOjAxLjQ3NiA6IFN0YXJ0aW5nIG5vdGlmeSBmb3IgICIwMDAw
MDAxNy0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAiCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDc2
IDogU3RhcnRpbmcgbm90aWZ5IGZvciAgIjAwMDAwMDIwLTAwMDAtMzUxMi0yMTE4LTAwMDlhZjEw
MDcwMCIKMjAyMi0wMy0yMyAxNDo0MDowMS40NzcgOiBTdGFydGluZyBub3RpZnkgZm9yICAiMDAw
MDAwMTYtMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwIgoyMDIyLTAzLTIzIDE0OjQwOjAxLjQ3
NyA6IFdyaXRlIHNvbWV0aGluZwoyMDIyLTAzLTIzIDE0OjQwOjAxLjQ3NyA6IFdyaXRpbmcgdG8g
ICIwMDAwMDAxNi0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3MDAiIDogIjAxIgoyMDIyLTAzLTIz
IDE0OjQwOjAxLjQ3NyA6IEdvdCBtaTIgc2VydmljZQoyMDIyLTAzLTIzIDE0OjQwOjAxLjQ3NyA6
IFN0YXJ0aW5nIG5vdGlmeSBmb3IgICIwMDAwMDAwOS0wMDAwLTM1MTItMjExOC0wMDA5YWYxMDA3
MDAiCjIwMjItMDMtMjMgMTQ6NDA6MDEuNDc3IDogV3JpdGluZyByZXF1ZXN0IGZvciBhdXRoIG51
bWJlcgoyMDIyLTAzLTIzIDE0OjQwOjAxLjQ3OCA6IFdyaXRpbmcgdG8gICIwMDAwMDAwOS0wMDAw
LTM1MTItMjExOC0wMDA5YWYxMDA3MDAiIDogIjAxMDAiCjIwMjItMDMtMjMgMTQ6NDA6MDMuNTIw
IDogdmlydHVhbCB2b2lkIEd0ckRldmljZTo6b25Qcm9wZXJ0aWVzQ2hhbmdlZChRU3RyaW5nLCBR
VmFyaWFudE1hcCwgUVN0cmluZ0xpc3QpICJvcmcuYmx1ZXouRGV2aWNlMSIgUU1hcCgoIkNvbm5l
Y3RlZCIsIFFWYXJpYW50KGJvb2wsIGZhbHNlKSkoIlNlcnZpY2VzUmVzb2x2ZWQiLCBRVmFyaWFu
dChib29sLCBmYWxzZSkpKSAoKQoyMDIyLTAzLTIzIDE0OjQwOjAzLjUyMiA6IERpc0Nvbm5lY3Rl
ZCEKMjAyMi0wMy0yMyAxNDo0MDowMy41MjIgOiBEZXZpY2VJbnRlcmZhY2U6Om9uQ29ubmVjdGlv
blN0YXRlQ2hhbmdlZCAiZGlzY29ubmVjdGVkIgpeQwoKCgoKLS0tLS0tLS0tLQoKCmJ0bW9uCgpw
aWdnekBhZGFtLWxhcHRvcCB+ICQgc3VkbyBidG1vbgpCbHVldG9vdGggbW9uaXRvciB2ZXIgNS42
Mwo9IE5vdGU6IExpbnV4IHZlcnNpb24gNS4xNi4xNC0xLWRlZmF1bHQgKHg4Nl82NCkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMC43MjYxMzEKPSBOb3RlOiBCbHVldG9vdGggc3Vic3lzdGVtIHZlcnNpb24g
Mi4yMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAuNzI2MTM2Cj0gTmV3IEluZGV4OiBEQzo1
Mzo2MDo1MTowMDpDNiAoUHJpbWFyeSxVU0IsaGNpMCkgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAwLjcyNjEz
OAo9IE9wZW4gSW5kZXg6IERDOjUzOjYwOjUxOjAwOkM2ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBbaGNpMF0gMC43MjYxMzkKPSBJbmRleCBJbmZvOiBEQzo1Mzo2MDo1MTowMDpDNiAoSW50
ZWwgQ29ycC4pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDAuNzI2MTM5CkAgTUdNVCBPcGVuOiBibHVl
dG9vdGhkIChwcml2aWxlZ2VkKSB2ZXJzaW9uIDEuMjEgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7MHgwMDAxfSAwLjcyNjE0
MQo8IEhDSSBDb21tYW5kOiBMRSBTZXQgU2NhbiBQYXJhbWV0ZXJzICgweDA4fDB4MDAwYikgcGxl
biA3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAjMSBbaGNpMF0gNC45NzYyMjkKICAgICAgICBUeXBlOiBQYXNzaXZlICgweDAwKQogICAgICAg
IEludGVydmFsOiA2MC4wMDAgbXNlYyAoMHgwMDYwKQogICAgICAgIFdpbmRvdzogNjAuMDAwIG1z
ZWMgKDB4MDA2MCkKICAgICAgICBPd24gYWRkcmVzcyB0eXBlOiBQdWJsaWMgKDB4MDApCiAgICAg
ICAgRmlsdGVyIHBvbGljeTogQWNjZXB0IGFsbCBhZHZlcnRpc2VtZW50ICgweDAwKQo+IEhDSSBF
dmVudDogQ29tbWFuZCBDb21wbGV0ZSAoMHgwZSkgcGxlbiA0ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMiBbaGNp
MF0gNS4wODk5NDkKICAgICAgTEUgU2V0IFNjYW4gUGFyYW1ldGVycyAoMHgwOHwweDAwMGIpIG5j
bWQgMQogICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkKPCBIQ0kgQ29tbWFuZDogTEUgU2V0
IFNjYW4gRW5hYmxlICgweDA4fDB4MDAwYykgcGxlbiAyICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzMgW2hjaTBdIDUuMDg5OTY2CiAg
ICAgICAgU2Nhbm5pbmc6IEVuYWJsZWQgKDB4MDEpCiAgICAgICAgRmlsdGVyIGR1cGxpY2F0ZXM6
IEVuYWJsZWQgKDB4MDEpCj4gSENJIEV2ZW50OiBDb21tYW5kIENvbXBsZXRlICgweDBlKSBwbGVu
IDQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICM0IFtoY2kwXSA1LjA5MDk0OAogICAgICBMRSBTZXQgU2NhbiBFbmFi
bGUgKDB4MDh8MHgwMDBjKSBuY21kIDIKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApCj4g
SENJIEV2ZW50OiBMRSBNZXRhIEV2ZW50ICgweDNlKSBwbGVuIDI5ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM1
IFtoY2kwXSA1LjA5OTk3OQogICAgICBMRSBBZHZlcnRpc2luZyBSZXBvcnQgKDB4MDIpCiAgICAg
ICAgTnVtIHJlcG9ydHM6IDEKICAgICAgICBFdmVudCB0eXBlOiBDb25uZWN0YWJsZSB1bmRpcmVj
dGVkIC0gQURWX0lORCAoMHgwMCkKICAgICAgICBBZGRyZXNzIHR5cGU6IFJhbmRvbSAoMHgwMSkK
ICAgICAgICBBZGRyZXNzOiA3Rjo0MjoyQjoxNzo5NDpENiAoUmVzb2x2YWJsZSkKICAgICAgICBE
YXRhIGxlbmd0aDogMTcKICAgICAgICBGbGFnczogMHgxYQogICAgICAgICAgTEUgR2VuZXJhbCBE
aXNjb3ZlcmFibGUgTW9kZQogICAgICAgICAgU2ltdWx0YW5lb3VzIExFIGFuZCBCUi9FRFIgKENv
bnRyb2xsZXIpCiAgICAgICAgICBTaW11bHRhbmVvdXMgTEUgYW5kIEJSL0VEUiAoSG9zdCkKICAg
ICAgICBUWCBwb3dlcjogMTIgZEJtCiAgICAgICAgQ29tcGFueTogQXBwbGUsIEluYy4gKDc2KQog
ICAgICAgICAgVHlwZTogVW5rbm93biAoMTYpCiAgICAgICAgICBEYXRhOiA1YzFjYWQ1ZDNmCiAg
ICAgICAgUlNTSTogLTgzIGRCbSAoMHhhZCkKPiBIQ0kgRXZlbnQ6IExFIE1ldGEgRXZlbnQgKDB4
M2UpIHBsZW4gNDMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIzYgW2hjaTBdIDUuMjMyOTgwCiAgICAgIExFIEFk
dmVydGlzaW5nIFJlcG9ydCAoMHgwMikKICAgICAgICBOdW0gcmVwb3J0czogMQogICAgICAgIEV2
ZW50IHR5cGU6IENvbm5lY3RhYmxlIHVuZGlyZWN0ZWQgLSBBRFZfSU5EICgweDAwKQogICAgICAg
IEFkZHJlc3MgdHlwZTogUmFuZG9tICgweDAxKQogICAgICAgIEFkZHJlc3M6IEVGOjUxOkNEOjND
OjdFOjhGIChTdGF0aWMpCiAgICAgICAgRGF0YSBsZW5ndGg6IDMxCiAgICAgICAgRmxhZ3M6IDB4
MDYKICAgICAgICAgIExFIEdlbmVyYWwgRGlzY292ZXJhYmxlIE1vZGUKICAgICAgICAgIEJSL0VE
UiBOb3QgU3VwcG9ydGVkCiAgICAgICAgQ29tcGFueTogQW5odWkgSHVhbWkgSW5mb3JtYXRpb24g
VGVjaG5vbG9neSBDby4sIEx0ZC4gKDM0MykKICAgICAgICAgIERhdGE6IDAyZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmYwM2VmNTFjZDNjN2U4ZgogICAgICAgIFJTU0k6IC03MiBkQm0g
KDB4YjgpCj4gSENJIEV2ZW50OiBMRSBNZXRhIEV2ZW50ICgweDNlKSBwbGVuIDQwICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICM3IFtoY2kwXSA1LjUxMjk4OQogICAgICBMRSBBZHZlcnRpc2luZyBSZXBvcnQgKDB4
MDIpCiAgICAgICAgTnVtIHJlcG9ydHM6IDEKICAgICAgICBFdmVudCB0eXBlOiBTY2FubmFibGUg
dW5kaXJlY3RlZCAtIEFEVl9TQ0FOX0lORCAoMHgwMikKICAgICAgICBBZGRyZXNzIHR5cGU6IFJh
bmRvbSAoMHgwMSkKICAgICAgICBBZGRyZXNzOiA3OTpGOTpGOTo4Nzo1NDpEQSAoUmVzb2x2YWJs
ZSkKICAgICAgICBEYXRhIGxlbmd0aDogMjgKICAgICAgICAxNi1iaXQgU2VydmljZSBVVUlEcyAo
Y29tcGxldGUpOiAxIGVudHJ5CiAgICAgICAgICBHb29nbGUgKDB4ZmU5ZikKICAgICAgICBTZXJ2
aWNlIERhdGEgKFVVSUQgMHhmZTlmKTogMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMAogICAgICAgIFJTU0k6IC03OSBkQm0gKDB4YjEpCj4gSENJIEV2ZW50OiBMRSBNZXRh
IEV2ZW50ICgweDNlKSBwbGVuIDQzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM4IFtoY2kwXSA1Ljc2MDk5OAog
ICAgICBMRSBBZHZlcnRpc2luZyBSZXBvcnQgKDB4MDIpCiAgICAgICAgTnVtIHJlcG9ydHM6IDEK
ICAgICAgICBFdmVudCB0eXBlOiBDb25uZWN0YWJsZSB1bmRpcmVjdGVkIC0gQURWX0lORCAoMHgw
MCkKICAgICAgICBBZGRyZXNzIHR5cGU6IFJhbmRvbSAoMHgwMSkKICAgICAgICBBZGRyZXNzOiBG
ODpDMzpEMTpCMDo1QTozQSAoU3RhdGljKQogICAgICAgIERhdGEgbGVuZ3RoOiAzMQogICAgICAg
IEZsYWdzOiAweDAyCiAgICAgICAgICBMRSBHZW5lcmFsIERpc2NvdmVyYWJsZSBNb2RlCiAgICAg
ICAgQ29tcGFueTogQW5odWkgSHVhbWkgSW5mb3JtYXRpb24gVGVjaG5vbG9neSBDby4sIEx0ZC4g
KDM0MykKICAgICAgICAgIERhdGE6IDAyZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmYw
M2Y4YzNkMWIwNWEzYQogICAgICAgIFJTU0k6IC02MyBkQm0gKDB4YzEpCjwgSENJIENvbW1hbmQ6
IExFIFNldCBTY2FuIEVuYWJsZSAoMHgwOHwweDAwMGMpIHBsZW4gMiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM5IFtoY2kwXSA1Ljc2
MTA4NgogICAgICAgIFNjYW5uaW5nOiBEaXNhYmxlZCAoMHgwMCkKICAgICAgICBGaWx0ZXIgZHVw
bGljYXRlczogRGlzYWJsZWQgKDB4MDApCj4gSENJIEV2ZW50OiBDb21tYW5kIENvbXBsZXRlICgw
eDBlKSBwbGVuIDQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIzEwIFtoY2kwXSA1Ljc2Njk3MgogICAgICBMRSBTZXQg
U2NhbiBFbmFibGUgKDB4MDh8MHgwMDBjKSBuY21kIDIKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3Mg
KDB4MDApCjwgSENJIENvbW1hbmQ6IExFIENyZWF0ZSBDb25uZWN0aW9uICgweDA4fDB4MDAwZCkg
cGxlbiAyNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIzExIFtoY2kwXSA1Ljc2NzAzNwogICAgICAgIFNjYW4gaW50ZXJ2YWw6IDYwLjAwMCBt
c2VjICgweDAwNjApCiAgICAgICAgU2NhbiB3aW5kb3c6IDYwLjAwMCBtc2VjICgweDAwNjApCiAg
ICAgICAgRmlsdGVyIHBvbGljeTogQWNjZXB0IGxpc3QgaXMgbm90IHVzZWQgKDB4MDApCiAgICAg
ICAgUGVlciBhZGRyZXNzIHR5cGU6IFJhbmRvbSAoMHgwMSkKICAgICAgICBQZWVyIGFkZHJlc3M6
IEY4OkMzOkQxOkIwOjVBOjNBIChTdGF0aWMpCiAgICAgICAgT3duIGFkZHJlc3MgdHlwZTogUHVi
bGljICgweDAwKQogICAgICAgIE1pbiBjb25uZWN0aW9uIGludGVydmFsOiAzMC4wMCBtc2VjICgw
eDAwMTgpCiAgICAgICAgTWF4IGNvbm5lY3Rpb24gaW50ZXJ2YWw6IDUwLjAwIG1zZWMgKDB4MDAy
OCkKICAgICAgICBDb25uZWN0aW9uIGxhdGVuY3k6IDAgKDB4MDAwMCkKICAgICAgICBTdXBlcnZp
c2lvbiB0aW1lb3V0OiA0MjAgbXNlYyAoMHgwMDJhKQogICAgICAgIE1pbiBjb25uZWN0aW9uIGxl
bmd0aDogMC4wMDAgbXNlYyAoMHgwMDAwKQogICAgICAgIE1heCBjb25uZWN0aW9uIGxlbmd0aDog
MC4wMDAgbXNlYyAoMHgwMDAwKQo+IEhDSSBFdmVudDogQ29tbWFuZCBTdGF0dXMgKDB4MGYpIHBs
ZW4gNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICMxMiBbaGNpMF0gNS43Njc5ODQKICAgICAgTEUgQ3JlYXRlIENv
bm5lY3Rpb24gKDB4MDh8MHgwMDBkKSBuY21kIDIKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4
MDApCj4gSENJIEV2ZW50OiBMRSBNZXRhIEV2ZW50ICgweDNlKSBwbGVuIDE5ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIzEzIFtoY2kwXSA2LjYxNzk2NwogICAgICBMRSBDb25uZWN0aW9uIENvbXBsZXRlICgweDAx
KQogICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkKICAgICAgICBIYW5kbGU6IDM1ODUKICAg
ICAgICBSb2xlOiBDZW50cmFsICgweDAwKQogICAgICAgIFBlZXIgYWRkcmVzcyB0eXBlOiBSYW5k
b20gKDB4MDEpCiAgICAgICAgUGVlciBhZGRyZXNzOiBGODpDMzpEMTpCMDo1QTozQSAoU3RhdGlj
KQogICAgICAgIENvbm5lY3Rpb24gaW50ZXJ2YWw6IDUwLjAwIG1zZWMgKDB4MDAyOCkKICAgICAg
ICBDb25uZWN0aW9uIGxhdGVuY3k6IDAgKDB4MDAwMCkKICAgICAgICBTdXBlcnZpc2lvbiB0aW1l
b3V0OiA0MjAgbXNlYyAoMHgwMDJhKQogICAgICAgIENlbnRyYWwgY2xvY2sgYWNjdXJhY3k6IDB4
MDAKQCBNR01UIEV2ZW50OiBEZXZpY2UgQ29ubmVjdGVkICgweDAwMGIpIHBsZW4gNDQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgezB4
MDAwMX0gW2hjaTBdIDYuNjE4MDA0CiAgICAgICAgTEUgQWRkcmVzczogRjg6QzM6RDE6QjA6NUE6
M0EgKFN0YXRpYykKICAgICAgICBGbGFnczogMHgwMDAwMDAwOAogICAgICAgICAgQ29ubmVjdGlv
biBMb2NhbGx5IEluaXRpYXRlZAogICAgICAgIERhdGEgbGVuZ3RoOiAzMQogICAgICAgIEZsYWdz
OiAweDAyCiAgICAgICAgICBMRSBHZW5lcmFsIERpc2NvdmVyYWJsZSBNb2RlCiAgICAgICAgQ29t
cGFueTogQW5odWkgSHVhbWkgSW5mb3JtYXRpb24gVGVjaG5vbG9neSBDby4sIEx0ZC4gKDM0MykK
ICAgICAgICAgIERhdGE6IDAyZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmYwM2Y4YzNk
MWIwNWEzYQo8IEhDSSBDb21tYW5kOiBMRSBSZWFkIFJlbW90ZSBVc2VkIEZlYXR1cmVzICgweDA4
fDB4MDAxNikgcGxlbiAyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICMxNCBbaGNpMF0gNi42MTgwNTcKICAgICAgICBIYW5kbGU6IDM1ODUKPiBIQ0kgRXZl
bnQ6IENvbW1hbmQgU3RhdHVzICgweDBmKSBwbGVuIDQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMTUgW2hjaTBd
IDYuNjE4OTU2CiAgICAgIExFIFJlYWQgUmVtb3RlIFVzZWQgRmVhdHVyZXMgKDB4MDh8MHgwMDE2
KSBuY21kIDEKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApCj4gSENJIEV2ZW50OiBMRSBN
ZXRhIEV2ZW50ICgweDNlKSBwbGVuIDEyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzE2IFtoY2kwXSA2LjY2OTk2
MwogICAgICBMRSBSZWFkIFJlbW90ZSBVc2VkIEZlYXR1cmVzICgweDA0KQogICAgICAgIFN0YXR1
czogU3VjY2VzcyAoMHgwMCkKICAgICAgICBIYW5kbGU6IDM1ODUKICAgICAgICBGZWF0dXJlczog
MHgwMSAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwCiAgICAgICAgICBMRSBFbmNy
eXB0aW9uCjwgSENJIENvbW1hbmQ6IExFIFN0YXJ0IEVuY3J5cHRpb24gKDB4MDh8MHgwMDE5KSBw
bGVuIDI4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIzE3IFtoY2kwXSA2LjY2OTk5OAogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAgIFJh
bmRvbSBudW1iZXI6IDB4M2M5ZGFjNGQwNDk3OGMyYwogICAgICAgIEVuY3J5cHRlZCBkaXZlcnNp
ZmllcjogMHhlZDJiCiAgICAgICAgTG9uZyB0ZXJtIGtleTogY2Y3ZjM1OWY2YTI3NWNmOGU0YjYz
M2JkOTNhZTljNmMKPiBIQ0kgRXZlbnQ6IENvbW1hbmQgU3RhdHVzICgweDBmKSBwbGVuIDQgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAjMTggW2hjaTBdIDYuNjcwOTYzCiAgICAgIExFIFN0YXJ0IEVuY3J5cHRpb24g
KDB4MDh8MHgwMDE5KSBuY21kIDEKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApCj4gSENJ
IEV2ZW50OiBFbmNyeXB0aW9uIENoYW5nZSAoMHgwOCkgcGxlbiA0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzE5IFto
Y2kwXSA3LjA2ODk2MwogICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkKICAgICAgICBIYW5k
bGU6IDM1ODUKICAgICAgICBFbmNyeXB0aW9uOiBFbmFibGVkIHdpdGggQUVTLUNDTSAoMHgwMSkK
PCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMCBkbGVuIDcgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAj
MjAgW2hjaTBdIDcuMDY5MzU0CiAgICAgIEFUVDogRXhjaGFuZ2UgTVRVIFJlcXVlc3QgKDB4MDIp
IGxlbiAyCiAgICAgICAgQ2xpZW50IFJYIE1UVTogNTE3Cj4gQUNMIERhdGEgUlg6IEhhbmRsZSAz
NTg1IGZsYWdzIDB4MDIgZGxlbiA3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzIxIFtoY2kwXSA3LjExODY3OQogICAg
ICBBVFQ6IEV4Y2hhbmdlIE1UVSBSZXF1ZXN0ICgweDAyKSBsZW4gMgogICAgICAgIENsaWVudCBS
WCBNVFU6IDI0Nwo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAwIGRsZW4gNyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICMyMiBbaGNpMF0gNy4xMTg4OTAKICAgICAgQVRUOiBFeGNoYW5nZSBNVFUgUmVz
cG9uc2UgKDB4MDMpIGxlbiAyCiAgICAgICAgU2VydmVyIFJYIE1UVTogMjQ3Cj4gSENJIEV2ZW50
OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzIzIFtoY2kwXSA3
LjExOTk5NgogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiAzNTg1CiAgICAg
ICAgQ291bnQ6IDEKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgx
MykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAjMjQgW2hjaTBdIDcuMTY5OTY2CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAg
ICAgICBIYW5kbGU6IDM1ODUKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUg
MzU4NSBmbGFncyAweDAyIGRsZW4gNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyNSBbaGNpMF0gNy4yMTg3MDEKICAg
ICAgQVRUOiBFeGNoYW5nZSBNVFUgUmVzcG9uc2UgKDB4MDMpIGxlbiAyCiAgICAgICAgU2VydmVy
IFJYIE1UVTogMjUyCjwgQUNMIERhdGEgVFg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDAgZGxlbiA3
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIzI2IFtoY2kwXSA3LjIxODk2MQogICAgICBBVFQ6IFJlYWQgUmVxdWVzdCAo
MHgwYSkgbGVuIDIKICAgICAgICBIYW5kbGU6IDB4MDAxNgo+IEhDSSBFdmVudDogTnVtYmVyIG9m
IENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyNyBbaGNpMF0gNy4yNjkwMzUKICAg
ICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAgIENvdW50OiAx
Cj4gQUNMIERhdGEgUlg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIgZGxlbiAxOSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IzI4IFtoY2kwXSA3LjMxODY5OQogICAgICBBVFQ6IFJlYWQgUmVzcG9uc2UgKDB4MGIpIGxlbiAx
NAogICAgICAgIFZhbHVlOiA0MTZkNjE3YTY2Njk3NDIwNDc1NDUyMjAzMjAwCjwgQUNMIERhdGEg
VFg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDAgZGxlbiA3ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzI5IFtoY2kwXSA3
LjMxODg4MAogICAgICBBVFQ6IFJlYWQgUmVxdWVzdCAoMHgwYSkgbGVuIDIKICAgICAgICBIYW5k
bGU6IDB4MDAxOAo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEz
KSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICMzMCBbaGNpMF0gNy40MTg5NzQKICAgICAgICBOdW0gaGFuZGxlczogMQogICAg
ICAgIEhhbmRsZTogMzU4NQogICAgICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSAz
NTg1IGZsYWdzIDB4MDIgZGxlbiA3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzMxIFtoY2kwXSA5LjgxODU4MAogICAg
ICBBVFQ6IEV4Y2hhbmdlIE1UVSBSZXF1ZXN0ICgweDAyKSBsZW4gMgogICAgICAgIENsaWVudCBS
WCBNVFU6IDI0Nwo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAwIGRsZW4gNyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICMzMiBbaGNpMF0gOS44MTg5MDkKICAgICAgQVRUOiBFeGNoYW5nZSBNVFUgUmVz
cG9uc2UgKDB4MDMpIGxlbiAyCiAgICAgICAgU2VydmVyIFJYIE1UVTogMjQ3Cj4gSENJIEV2ZW50
OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzMzIFtoY2kwXSA5
Ljg2ODk4NwogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiAzNTg1CiAgICAg
ICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMiBkbGVuIDEx
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICMzNCBbaGNpMF0gMTAuNTY4NjY3CiAgICAgIEFUVDogUmVhZCBCeSBUeXBlIFJl
cXVlc3QgKDB4MDgpIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMDEtMHhmZmZmCiAg
ICAgICAgQXR0cmlidXRlIHR5cGU6IENoYXJhY3RlcmlzdGljICgweDI4MDMpCjwgQUNMIERhdGEg
VFg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDAgZGxlbiAyNyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMzUgW2hjaTBdIDEw
LjU2ODgzMgo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAxIGRsZW4gMjcgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIzM2IFtoY2kwXSAxMC41Njg4NDgKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxh
Z3MgMHgwMSBkbGVuIDggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICMzNyBbaGNpMF0gMTAuNTY4ODUzCiAgICAgIEFUVDog
UmVhZCBCeSBUeXBlIFJlc3BvbnNlICgweDA5KSBsZW4gNTcKICAgICAgICBBdHRyaWJ1dGUgZGF0
YSBsZW5ndGg6IDcKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsaXN0OiA4IGVudHJpZXMKICAgICAg
ICBIYW5kbGU6IDB4MDAwMgogICAgICAgIFZhbHVlOiAwMjAzMDAwMDJhCiAgICAgICAgSGFuZGxl
OiAweDAwMDQKICAgICAgICBWYWx1ZTogMDIwNTAwMDEyYQogICAgICAgIEhhbmRsZTogMHgwMDA2
CiAgICAgICAgVmFsdWU6IDAyMDcwMGE2MmEKICAgICAgICBIYW5kbGU6IDB4MDAwOQogICAgICAg
IFZhbHVlOiAyMDBhMDAwNTJhCiAgICAgICAgSGFuZGxlOiAweDAwMGMKICAgICAgICBWYWx1ZTog
MGEwZDAwMjkyYgogICAgICAgIEhhbmRsZTogMHgwMDBlCiAgICAgICAgVmFsdWU6IDAyMGYwMDJh
MmIKICAgICAgICBIYW5kbGU6IDB4MDAxMAogICAgICAgIFZhbHVlOiAwMjExMDAzYTJiCiAgICAg
ICAgSGFuZGxlOiAweDAwMTMKICAgICAgICBWYWx1ZTogMDIxNDAwNTAyYQo+IEhDSSBFdmVudDog
TnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzM4IFtoY2kwXSAxMC42
MTkwMzEKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAg
IENvdW50OiAxCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMp
IHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAjMzkgW2hjaTBdIDEwLjYyMDAxNAogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAg
ICAgSGFuZGxlOiAzNTg1CiAgICAgICAgQ291bnQ6IDEKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBD
b21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM0MCBbaGNpMF0gMTAuNjIwOTY4CiAgICAg
ICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDM1ODUKICAgICAgICBDb3VudDogMQo+
IEFDTCBEYXRhIFJYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzQx
IFtoY2kwXSAxMC42Njg2ODkKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkg
bGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAxNC0weGZmZmYKICAgICAgICBBdHRyaWJ1
dGUgdHlwZTogQ2hhcmFjdGVyaXN0aWMgKDB4MjgwMykKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1
ODUgZmxhZ3MgMHgwMCBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM0MiBbaGNpMF0gMTAuNjY5MTA4CiAgICAg
IEFUVDogRXJyb3IgUmVzcG9uc2UgKDB4MDEpIGxlbiA0CiAgICAgICAgUmVhZCBCeSBUeXBlIFJl
cXVlc3QgKDB4MDgpCiAgICAgICAgSGFuZGxlOiAweDAwMTQKICAgICAgICBFcnJvcjogQXR0cmli
dXRlIE5vdCBGb3VuZCAoMHgwYSkKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFj
a2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICM0MyBbaGNpMF0gMTAuNzE4OTg0CiAgICAgICAgTnVtIGhhbmRs
ZXM6IDEKICAgICAgICBIYW5kbGU6IDM1ODUKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJY
OiBIYW5kbGUgMzU4NSBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzQ0IFtoY2kwXSAxMC43
Njg2MjYKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAg
ICBIYW5kbGUgcmFuZ2U6IDB4MDAwMS0weGZmZmYKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogRGV2
aWNlIE5hbWUgKDB4MmEwMCkKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMCBk
bGVuIDE4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICM0NSBbaGNpMF0gMTAuNzY4ODI2CiAgICAgIEFUVDogUmVhZCBCeSBU
eXBlIFJlc3BvbnNlICgweDA5KSBsZW4gMTMKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6
IDEyCiAgICAgICAgQXR0cmlidXRlIGRhdGEgbGlzdDogMSBlbnRyeQogICAgICAgIEhhbmRsZTog
MHgwMDAzCiAgICAgICAgVmFsdWU6IDQyNmM3NTY1NWEyMDM1MmUzNjMzCj4gSENJIEV2ZW50OiBO
dW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNDYgW2hjaTBdIDEwLjgx
OTAzNgogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiAzNTg1CiAgICAgICAg
Q291bnQ6IDEKPSBibHVldG9vdGhkOiBwcm9maWxlcy9kZXZpY2VpbmZvL2RldmljZWluZm8uYzpy
ZWFkX3BucGlkX2NiKCkgRXJyb3IgcmVhZGluZyBQTlBfSUQgdmFsdWU6IFJlcXVlc3QgYXR0cmli
dXRlIGhhcyBlbmNvdW50ZXJlZCBhbiB1bmxpa2VseSBlcnJvciAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgMzcuMzQ1OTQ0CjwgSENJIENvbW1hbmQ6IERpc2Nvbm5lY3QgKDB4
MDF8MHgwMDA2KSBwbGVuIDMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAjNDcgW2hjaTBdIDM5LjM3MzA4MQogICAgICAgIEhh
bmRsZTogMzU4NQogICAgICAgIFJlYXNvbjogUmVtb3RlIFVzZXIgVGVybWluYXRlZCBDb25uZWN0
aW9uICgweDEzKQo+IEhDSSBFdmVudDogQ29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIzQ4IFtoY2kwXSAzOS40OTEwNjEKICAgICAgRGlzY29ubmVjdCAoMHgwMXwweDAw
MDYpIG5jbWQgMQogICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkKPiBIQ0kgRXZlbnQ6IERp
c2Nvbm5lY3QgQ29tcGxldGUgKDB4MDUpIHBsZW4gNCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM0OSBbaGNpMF0gMzkuNTE5
MDE2CiAgICAgICAgU3RhdHVzOiBTdWNjZXNzICgweDAwKQogICAgICAgIEhhbmRsZTogMzU4NQog
ICAgICAgIFJlYXNvbjogQ29ubmVjdGlvbiBUZXJtaW5hdGVkIEJ5IExvY2FsIEhvc3QgKDB4MTYp
CkAgTUdNVCBFdmVudDogRGV2aWNlIERpc2Nvbm5lY3RlZCAoMHgwMDBjKSBwbGVuIDggICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgezB4MDAw
MX0gW2hjaTBdIDM5LjUxOTA1MAogICAgICAgIExFIEFkZHJlc3M6IEY4OkMzOkQxOkIwOjVBOjNB
IChTdGF0aWMpCiAgICAgICAgUmVhc29uOiBDb25uZWN0aW9uIHRlcm1pbmF0ZWQgYnkgbG9jYWwg
aG9zdCAoMHgwMikK
--000000000000dabe0405dae3cab1--
