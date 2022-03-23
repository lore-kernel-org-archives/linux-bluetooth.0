Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE15C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 13:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbiCWNij (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiCWNig (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 09:38:36 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E57DAA3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 06:37:03 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id h11so1866190ljb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 06:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9kyMgWw5gA1lm1B6XseoXTmMQxMCedtlRGYkbHKPd0=;
        b=He6loWBxUXFcLmx8DLh5B4sbHqhGRSdLsCMXOyWMldFL3sIT+NR6mFfrz/j4VcTq3j
         qeZ8sApHAuSTW8XqyhaScodNldueUEgvo+Lg+cHUiPjtD8TAczipHIGqqiczYM64FM5j
         w+/ixvmF9mpMKWE7WgoyGGdDjJrkn9RsTPRjTYtRpr6jjRq1CFf9cPxTCsBmjd1s5hAL
         oMVizvt5EioC6JyoCA98TvjRNuY8iZHWjzAvvX1dGtKJeDbQ5Ws7pgbUvQcVtRW/BfnT
         gL59V0clrefXR2A3hI65yoAmcSXPGZ5TQ76WC0MLSdYRCymBqVu/n3/XPNut4iaFYpRL
         aOBA==
X-Gm-Message-State: AOAM530G/l47MO0pbbsPzY8PoPooUXvBUQ/7zryTuU+YFER5cTkoGdRe
        rCKd1oRICS/fGw1iSOEEfq8KlVPUjb1YQq4z7sl6YF+8O/fooQ==
X-Google-Smtp-Source: ABdhPJxK2cvmtwxRvHbIaSrOAfdXZZ7uh6nFLrXpmPtohcH+eUlv/R7cIEfaqxRaZuyLptJAOJNdhnHl+y1raNvko2k=
X-Received: by 2002:a2e:9794:0:b0:249:8488:7dbd with SMTP id
 y20-20020a2e9794000000b0024984887dbdmr51727lji.176.1648042621440; Wed, 23 Mar
 2022 06:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
 <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
 <CANFkB1yr3N_Twac=ocxBRst79-gmdu8=6VTD6oPgdGT0rb_HaQ@mail.gmail.com>
 <CANFkB1xEesP1cMmK4VGi5cH-v80ho00wT24q=+4QQSdyPegPQQ@mail.gmail.com>
 <CABBYNZKSsyqfiWYjpuZNYtKAZb4C2q73YwOj=KoUFq71gLs7Hg@mail.gmail.com>
 <CANFkB1zHTZF3Mcgn5GPBA0km+BNyL3bb9=MJFuSNFe6x5zgimQ@mail.gmail.com>
 <CABBYNZLWN3+51F-sNJ5yPc2bw+x4Ep6rCwcFLn0bfrwArL=Hyw@mail.gmail.com>
 <CABBYNZL-fjTd8JdmRRM5Y26d41KwDxvvuaED+j2+yPT-RBpMtw@mail.gmail.com> <CANFkB1w2UUq7W0EqEdskebhKcEtkZ-33q-Co5VF_WKf7dHsJtg@mail.gmail.com>
In-Reply-To: <CANFkB1w2UUq7W0EqEdskebhKcEtkZ-33q-Co5VF_WKf7dHsJtg@mail.gmail.com>
From:   Adam Pigg <adam@piggz.co.uk>
Date:   Wed, 23 Mar 2022 13:36:49 +0000
Message-ID: <CANFkB1zMOYTD8ZsDHczHqce9ipgyu9-fEeXEZqTzuf=T4UufLQ@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000006da4505dae2d38b"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--00000000000006da4505dae2d38b
Content-Type: text/plain; charset="UTF-8"

Hi Luiz

On Wed, 23 Mar 2022 at 09:11, Adam Pigg <adam@piggz.co.uk> wrote:
>
> Hi Luiz
>
> Good that you clearly know more about this than me!...
>
> On Tue, 22 Mar 2022 at 23:44, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Adam,
> >
> > On Tue, Mar 22, 2022 at 4:35 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On Tue, Mar 22, 2022 at 4:09 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > >
> > > > Thanks Luiz
> > > >
> > > > On Tue, 22 Mar 2022 at 21:35, Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Adam,
> > > > >
> > > > > On Tue, Mar 22, 2022 at 3:40 AM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > >
> > > > > > Hi Luiz
> > > > > >
> > > > > >
> > > > > > On Tue, 22 Mar 2022 at 07:55, Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > >
> > > > > > > Hi Luiz
> > > > > > >
> > > > > > > On Tue, 22 Mar 2022 at 00:44, Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Adam,
> > > > > > > >
> > > > > > > > On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > > > > >
> > > > > > > > > Hi
> > > > > > > > >
> > > > > > > > > A bit of background, I write a linux desktop/mobile app called
> > > > > > > > > Amazfish which interfaces with several watches over BLE using their
> > > > > > > > > GATT services.  To do this, I use the bluez dbus api (technically a
> > > > > > > > > thin wrapper around it I wrote called qble
> > > > > > > > > https://github.com/piggz/qble)
> > > > > > > > >
> > > > > > > > > All has been good so far, I support several generations of
> > > > > > > > > Huami/Amazfit watches, as well as the open source Pinetime and
> > > > > > > > > Bangle.js.  For the Amazfit watches, i have implementations for older
> > > > > > > > > devies such as the Bip, and newer ones such as the GTS.
> > > > > > > > >
> > > > > > > > > Much of the reverse engineering comes from the Android Gadget Bridge
> > > > > > > > > project, which supports many more devices.
> > > > > > > > >
> > > > > > > > > My community of users donated to buy me a newer device called a GTR2,
> > > > > > > > > which, according to the GB devs uses the same protocol as the slightly
> > > > > > > > > older GTS, and the packet captures I have from Android would support
> > > > > > > > > this.
> > > > > > > > >
> > > > > > > > > But this is where my trouble starts with Bluez, my existing
> > > > > > > > > implementation doesnt work at all.  Normally, after a connection, I
> > > > > > > > > would wait for the ServicesResolved signal, which happens pretty fast
> > > > > > > > > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > > > > > > > > which time, the watch has disconnected. (i get a disconnected signal
> > > > > > > > > immediately after the ServicesResolved signal)
> > > > > > > > >
> > > > > > > > > To rule out my code, I have tried several things:
> > > > > > > > > Gatttool
> > > > > > > > > With gattool, i can connect, get the services, enable a notification,
> > > > > > > > > write a value and get the expected results seemingly fine
> > > > > > > > >
> > > > > > > > > Python-gatt (using the bluez dbus api)
> > > > > > > > > Im unable to iterate the services, like my app, it takes 30 seconds to
> > > > > > > > > get the signal and then swiftly disconnects
> > > > > > > > >
> > > > > > > > > Gattlib (https://github.com/labapart/gattlib)
> > > > > > > > > Gattlib is interesting as it appears to have "borrowed" much of its
> > > > > > > > > code directly from bluez.  When built against the system bluez, if the
> > > > > > > > > version is > 5.42, it will use the dbus api.  When I do this, again im
> > > > > > > > > unable to list services on the watch.  However, if I edit the build to
> > > > > > > > > force it to use its internal gatt implementation, which appears to be
> > > > > > > > > the same one used by gatttool, then, it IS able to interrogate the
> > > > > > > > > watch.
> > > > > > > > >
> > > > > > > > > I have attached 3 files
> > > > > > > > > 1. test python program which should print services, and associated btmon
> > > > > > > > > 2. btmon output while using gatttool
> > > > > > > > > 3. btmon output running gattlib discover example
> > > > > > > > >
> > > > > > > > > Note, other than discovery, I havnt been able to get gattlib to
> > > > > > > > > read/write/notify!
> > > > > > > > >
> > > > > > > > > It seems as though I may be triggering a bug in the bluez dbus api?
> > > > > > > > > Can anyone suggest anything?
> > > > > > > >
> > > > > > > > What version are you using? I would first try with the latest to see
> > > > > > > > if that something already fixed.
> > > > > > > >
> > > > > > > >
> > > > > > > Im using 5.63 already, which is the latest tag (on opensuse tumbleweed)
> > > > > > >
> > > > > > > I'll also try bluetoothctl and attach logs using that, though I
> > > > > > > suspect it will behave the same as the python library and my own
> > > > > > > library.
> > > > > > >
> > > > > >
> > > > > > Attached is the output of btmon while using bluetoothctl
> > > > > >
> > > > > > bluetoothctl behaves the same as my lib and python, it is unable to
> > > > > > list services, and after a while, emits the ServicesResolved and
> > > > > > disconnected messages at the same time.  Im sure it should be able to
> > > > > > list the services immediately after connect just like gatttool can.
> > > > >
> > > > > Looks like there is multiple rounds of MTU Exchange, not sure if that
> > > > > is actually a problem but the spec does say it shall only be sent once
> > > > > per client:
> > > > >
> > > > > BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> > > > > page 1424:
> > > > >
> > > > > This request shall only be sent once during a connection by the client.
> > > > >
> > > > > There is also no response to frame #30:
> > > > > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> > > > >
> > > > >                            #30 [hci0] 26.641557
> > > > >       ATT: Read Request (0x0a) len 2
> > > > >         Handle: 0x0018
> > > > >
> > > > > So after 30 seconds (ATT timeout) without receiving any response it disconnects:
> > > > >
> > > >
> > > > So, the verdict is that the watch isnt acting to spec right?
> > > >
> > > > Why does gatttool work ok, is it a completely different implementation?
> > > >
> > > > I understand if wouldnt be to spec, but would it be possible to make
> > > > bluez more resilient to devices not acting to spec?  Android and iOS
> > > > work just fine in this regard, so could bluez handle mis-behaving
> > > > devices more flexibly?
> > >
> > > That I can't really explain, perhaps it is timing related, something
> > > with Exchange MTU since it appears to stop the device from responding
> > > when it happens a second time.
> > >
> > > > Do you have any suggestions for things I could try? I looked for
> > > > similar lines in the working gatttool log, and it doesnt have anything
> > > > like that, seems to send flags 0x00 dlen 9 (instead of 7?)  ... how is
> > > > it behaving differently?
> > >
> > > Not sure really, does Android/iOS Exchange the MTU? Maybe we need a
> > > timer to start it later or perhaps the problem first response to
> > > exchange MTU does actually use the final_mtu which makes the watch to
> > > trigger yet another exchange to have both rx and tx MTU the same so
> > > try with the following change:
> > >
> > > diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> > > index 2adb4afbf..d326782bf 100644
> > > --- a/src/shared/gatt-server.c
> > > +++ b/src/shared/gatt-server.c
> > > @@ -1499,7 +1499,7 @@ static void exchange_mtu_cb(struct bt_att_chan
> > > *chan, uint8_t opcode,
> > >         final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
> > >
> > >         /* Respond with the server MTU */
> > > -       put_le16(server->mtu, rsp_pdu);
> > > +       put_le16(final_mtu, rsp_pdu);
> > >         bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
> > >
> > >         /* Set MTU to be the minimum */
> >
> > Hmm Im not sure if this will work since the peripheral seems to
> > respond different values 252 vs 247, also the spec does say that:
> >
> > 'The Server Rx MTU parameter shall be set to the *maximum size* of the
> > Attribute protocol PDU that the server can receive.
> > The server and client shall set ATT_MTU to the *minimum of the Client Rx MTU
> > and the Server Rx MTU*. The size is the same to ensure that a client can
> > correctly detect the final packet of a long attribute read.'
> >
> > So my interpretation is that the minimum is calculated after the
> > Exchange is complete so it doesn't require the Server MTU to be
> > limited by the Client MTU, anyway if Android and iOS does apply the
> > minimum logic before responding we can do the same.
> >
>
> Maybe it will help if I attach an android packet capture....
>
> The attachedhttps://marc.info/?l=linux-bluetooth&m=164799909020040&w=2
> log can be opened in Wireshark, and to my untrained eye, it looks like
> the MTU negotiation is at packets 451 and 452, and 247 is used?
>
> Ill try and get the proposed patch built and see how it behaves

Attached if the btmon and bluetoothctl.  It doesnt seem to be there quite yet.

There was one point before i applied the patch where bluetoothctl
seemed to list the attributes quickly, but i havnt been able to
reproduce that again with or without the patch.

Thanks


>
> Thanks
>
> > >
> > > >
> > > > > < HCI Command: Disconnect (0x01|0x0006) plen 3
> > > > >
> > > > >                            #48 [hci0] 58.673128
> > > > >         Handle: 3585
> > > > >         Reason: Remote User Terminated Connection (0x13)
> > > > >
> > > > > > Thanks
> > > > > >
> > > > > >
> > > > > > > > --
> > > > > > > > Luiz Augusto von Dentz
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz

--00000000000006da4505dae2d38b
Content-Type: text/plain; charset="US-ASCII"; name="btmon_new_bluez_bluetoothctl.txt"
Content-Disposition: attachment; filename="btmon_new_bluez_bluetoothctl.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_l13m0kyq0>
X-Attachment-Id: f_l13m0kyq0

W2JsdWV0b290aF0jIGNvbm5lY3QgRjg6QzM6RDE6QjA6NUE6M0EKQXR0ZW1wdGluZyB0byBjb25u
ZWN0IHRvIEY4OkMzOkQxOkIwOjVBOjNBCltDSEddIERldmljZSBGODpDMzpEMTpCMDo1QTozQSBD
b25uZWN0ZWQ6IHllcwpDb25uZWN0aW9uIHN1Y2Nlc3NmdWwKW0FtYXpmaXQgR1RSIDJdIyBtZW51
IGdhdHQKTWVudSBnYXR0OgpBdmFpbGFibGUgY29tbWFuZHM6Ci0tLS0tLS0tLS0tLS0tLS0tLS0K
bGlzdC1hdHRyaWJ1dGVzIFtkZXYvbG9jYWxdICAgICAgICAgICAgICAgICAgICAgICBMaXN0IGF0
dHJpYnV0ZXMKc2VsZWN0LWF0dHJpYnV0ZSA8YXR0cmlidXRlL1VVSUQ+ICAgICAgICAgICAgICAg
ICBTZWxlY3QgYXR0cmlidXRlCmF0dHJpYnV0ZS1pbmZvIFthdHRyaWJ1dGUvVVVJRF0gICAgICAg
ICAgICAgICAgICAgU2VsZWN0IGF0dHJpYnV0ZQpyZWFkIFtvZmZzZXRdICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFJlYWQgYXR0cmlidXRlIHZhbHVlCndyaXRlIDxkYXRhPXh4
IHh4IC4uLj4gW29mZnNldF0gW3R5cGVdICAgICAgICAgICAgV3JpdGUgYXR0cmlidXRlIHZhbHVl
CmFjcXVpcmUtd3JpdGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQWNxdWly
ZSBXcml0ZSBmaWxlIGRlc2NyaXB0b3IKcmVsZWFzZS13cml0ZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBSZWxlYXNlIFdyaXRlIGZpbGUgZGVzY3JpcHRvcgphY3F1aXJlLW5v
dGlmeSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFjcXVpcmUgTm90aWZ5IGZp
bGUgZGVzY3JpcHRvcgpyZWxlYXNlLW5vdGlmeSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFJlbGVhc2UgTm90aWZ5IGZpbGUgZGVzY3JpcHRvcgpub3RpZnkgPG9uL29mZj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5vdGlmeSBhdHRyaWJ1dGUgdmFsdWUKY2xv
bmUgW2Rldi9hdHRyaWJ1dGUvVVVJRF0gICAgICAgICAgICAgICAgICAgICAgICBDbG9uZSBhIGRl
dmljZSBvciBhdHRyaWJ1dGUKcmVnaXN0ZXItYXBwbGljYXRpb24gW1VVSUQgLi4uXSAgICAgICAg
ICAgICAgICAgICBSZWdpc3RlciBwcm9maWxlIHRvIGNvbm5lY3QKdW5yZWdpc3Rlci1hcHBsaWNh
dGlvbiAgICAgICAgICAgICAgICAgICAgICAgICAgICBVbnJlZ2lzdGVyIHByb2ZpbGUKcmVnaXN0
ZXItc2VydmljZSA8VVVJRD4gW2hhbmRsZV0gICAgICAgICAgICAgICAgICBSZWdpc3RlciBhcHBs
aWNhdGlvbiBzZXJ2aWNlLgp1bnJlZ2lzdGVyLXNlcnZpY2UgPFVVSUQvb2JqZWN0PiAgICAgICAg
ICAgICAgICAgIFVucmVnaXN0ZXIgYXBwbGljYXRpb24gc2VydmljZQpyZWdpc3Rlci1pbmNsdWRl
cyA8VVVJRD4gW2hhbmRsZV0gICAgICAgICAgICAgICAgIFJlZ2lzdGVyIGFzIEluY2x1ZGVkIHNl
cnZpY2UgaW4uCnVucmVnaXN0ZXItaW5jbHVkZXMgPFNlcnZpY2UtVVVJRD48SW5jLVVVSUQ+ICAg
ICAgVW5yZWdpc3RlciBJbmNsdWRlZCBzZXJ2aWNlLgpyZWdpc3Rlci1jaGFyYWN0ZXJpc3RpYyA8
VVVJRD4gPEZsYWdzPXJlYWQsd3JpdGUsbm90aWZ5Li4uPiBbaGFuZGxlXSBSZWdpc3RlciBhcHBs
aWNhdGlvbiBjaGFyYWN0ZXJpc3RpYwp1bnJlZ2lzdGVyLWNoYXJhY3RlcmlzdGljIDxVVUlEL29i
amVjdD4gICAgICAgICAgIFVucmVnaXN0ZXIgYXBwbGljYXRpb24gY2hhcmFjdGVyaXN0aWMKcmVn
aXN0ZXItZGVzY3JpcHRvciA8VVVJRD4gPEZsYWdzPXJlYWQsd3JpdGUuLi4+IFtoYW5kbGVdIFJl
Z2lzdGVyIGFwcGxpY2F0aW9uIGRlc2NyaXB0b3IKdW5yZWdpc3Rlci1kZXNjcmlwdG9yIDxVVUlE
L29iamVjdD4gICAgICAgICAgICAgICBVbnJlZ2lzdGVyIGFwcGxpY2F0aW9uIGRlc2NyaXB0b3IK
YmFjayAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXR1cm4g
dG8gbWFpbiBtZW51CnZlcnNpb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRGlzcGxheSB2ZXJzaW9uCnF1aXQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUXVpdCBwcm9ncmFtCmV4aXQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgUXVpdCBwcm9ncmFtCmhlbHAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRGlzcGxheSBoZWxwIGFib3V0IHRoaXMgcHJvZ3Jh
bQpleHBvcnQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFByaW50
IGVudmlyb25tZW50IHZhcmlhYmxlcwpbQW1hemZpdCBHVFIgMl0jIHNlbGVjdC1hdHRyaWJ1dGUg
MDAwMDAwMDktMDAwMC0zNTEyLTIxMTgtMDAwOWFmMTAwNzAwCltBbWF6Zml0IEdUUiAyXSMgbm90
aWZ5IG9uCk5vIGF0dHJpYnV0ZSBzZWxlY3RlZApbQ0hHXSBEZXZpY2UgRjg6QzM6RDE6QjA6NUE6
M0EgU2VydmljZXNSZXNvbHZlZDogeWVzCltDSEddIERldmljZSBGODpDMzpEMTpCMDo1QTozQSBQ
YWlyZWQ6IHllcwpbQ0hHXSBEZXZpY2UgRjg6QzM6RDE6QjA6NUE6M0EgU2VydmljZXNSZXNvbHZl
ZDogbm8KW0NIR10gRGV2aWNlIEY4OkMzOkQxOkIwOjVBOjNBIENvbm5lY3RlZDogbm8KCgoKLS0t
LS0tLS0tLQoKCmJ0bW9uOgoKcGlnZ3pAYWRhbS1sYXB0b3AgfiAkIHN1ZG8gYnRtb24KQmx1ZXRv
b3RoIG1vbml0b3IgdmVyIDUuNjMKPSBOb3RlOiBMaW51eCB2ZXJzaW9uIDUuMTYuMTQtMS1kZWZh
dWx0ICh4ODZfNjQpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAuNTM3NzI1Cj0gTm90ZTogQmx1ZXRvb3Ro
IHN1YnN5c3RlbSB2ZXJzaW9uIDIuMjIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLjUzNzcy
OQo9IE5ldyBJbmRleDogREM6NTM6NjA6NTE6MDA6QzYgKFByaW1hcnksVVNCLGhjaTApICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBbaGNpMF0gMC41Mzc3MzAKPSBPcGVuIEluZGV4OiBEQzo1Mzo2MDo1MTowMDpDNiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDAuNTM3NzMwCj0gSW5kZXggSW5mbzogREM6
NTM6NjA6NTE6MDA6QzYgKEludGVsIENvcnAuKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAwLjUzNzcz
MQpAIE1HTVQgT3BlbjogYmx1ZXRvb3RoZCAocHJpdmlsZWdlZCkgdmVyc2lvbiAxLjIxICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgezB4MDAwMX0gMC41Mzc3MzIKPCBIQ0kgQ29tbWFuZDogTEUgU2V0IFNjYW4gUGFyYW1ldGVy
cyAoMHgwOHwweDAwMGIpIHBsZW4gNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIzEgW2hjaTBdIDkuNzE5NjcyCiAgICAgICAgVHlwZTogUGFz
c2l2ZSAoMHgwMCkKICAgICAgICBJbnRlcnZhbDogNjAuMDAwIG1zZWMgKDB4MDA2MCkKICAgICAg
ICBXaW5kb3c6IDYwLjAwMCBtc2VjICgweDAwNjApCiAgICAgICAgT3duIGFkZHJlc3MgdHlwZTog
UHVibGljICgweDAwKQogICAgICAgIEZpbHRlciBwb2xpY3k6IEFjY2VwdCBhbGwgYWR2ZXJ0aXNl
bWVudCAoMHgwMCkKPiBIQ0kgRXZlbnQ6IENvbW1hbmQgQ29tcGxldGUgKDB4MGUpIHBsZW4gNCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIzIgW2hjaTBdIDkuODMzNzQ0CiAgICAgIExFIFNldCBTY2FuIFBhcmFtZXRl
cnMgKDB4MDh8MHgwMDBiKSBuY21kIDEKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApCjwg
SENJIENvbW1hbmQ6IExFIFNldCBTY2FuIEVuYWJsZSAoMHgwOHwweDAwMGMpIHBsZW4gMiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMz
IFtoY2kwXSA5LjgzMzc2OAogICAgICAgIFNjYW5uaW5nOiBFbmFibGVkICgweDAxKQogICAgICAg
IEZpbHRlciBkdXBsaWNhdGVzOiBFbmFibGVkICgweDAxKQo+IEhDSSBFdmVudDogQ29tbWFuZCBD
b21wbGV0ZSAoMHgwZSkgcGxlbiA0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNCBbaGNpMF0gOS44MzQ3NDUKICAg
ICAgTEUgU2V0IFNjYW4gRW5hYmxlICgweDA4fDB4MDAwYykgbmNtZCAyCiAgICAgICAgU3RhdHVz
OiBTdWNjZXNzICgweDAwKQo+IEhDSSBFdmVudDogTEUgTWV0YSBFdmVudCAoMHgzZSkgcGxlbiAy
OSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAjNSBbaGNpMF0gOS44OTM4MDgKICAgICAgTEUgQWR2ZXJ0aXNpbmcg
UmVwb3J0ICgweDAyKQogICAgICAgIE51bSByZXBvcnRzOiAxCiAgICAgICAgRXZlbnQgdHlwZTog
Q29ubmVjdGFibGUgdW5kaXJlY3RlZCAtIEFEVl9JTkQgKDB4MDApCiAgICAgICAgQWRkcmVzcyB0
eXBlOiBSYW5kb20gKDB4MDEpCiAgICAgICAgQWRkcmVzczogNEU6NEE6Q0M6MEM6Nzg6NDYgKFJl
c29sdmFibGUpCiAgICAgICAgRGF0YSBsZW5ndGg6IDE3CiAgICAgICAgRmxhZ3M6IDB4MWEKICAg
ICAgICAgIExFIEdlbmVyYWwgRGlzY292ZXJhYmxlIE1vZGUKICAgICAgICAgIFNpbXVsdGFuZW91
cyBMRSBhbmQgQlIvRURSIChDb250cm9sbGVyKQogICAgICAgICAgU2ltdWx0YW5lb3VzIExFIGFu
ZCBCUi9FRFIgKEhvc3QpCiAgICAgICAgVFggcG93ZXI6IDEyIGRCbQogICAgICAgIENvbXBhbnk6
IEFwcGxlLCBJbmMuICg3NikKICAgICAgICAgIFR5cGU6IFVua25vd24gKDE2KQogICAgICAgICAg
RGF0YTogNTAxY2Y1MmU4OQogICAgICAgIFJTU0k6IC03OSBkQm0gKDB4YjEpCj4gSENJIEV2ZW50
OiBMRSBNZXRhIEV2ZW50ICgweDNlKSBwbGVuIDI4ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzYgW2hjaTBdIDEw
LjAxOTc5OQogICAgICBMRSBBZHZlcnRpc2luZyBSZXBvcnQgKDB4MDIpCiAgICAgICAgTnVtIHJl
cG9ydHM6IDEKICAgICAgICBFdmVudCB0eXBlOiBDb25uZWN0YWJsZSB1bmRpcmVjdGVkIC0gQURW
X0lORCAoMHgwMCkKICAgICAgICBBZGRyZXNzIHR5cGU6IFJhbmRvbSAoMHgwMSkKICAgICAgICBB
ZGRyZXNzOiA1ODo2NjpFOTpBNToyRDpEQiAoUmVzb2x2YWJsZSkKICAgICAgICBEYXRhIGxlbmd0
aDogMTYKICAgICAgICBGbGFnczogMHgwNgogICAgICAgICAgTEUgR2VuZXJhbCBEaXNjb3ZlcmFi
bGUgTW9kZQogICAgICAgICAgQlIvRURSIE5vdCBTdXBwb3J0ZWQKICAgICAgICBTZXJ2aWNlIERh
dGEgKFVVSUQgMHhmZTJjKTogMDAwMAogICAgICAgIFRYIHBvd2VyOiAtMTAgZEJtCiAgICAgICAg
U2VydmljZSBEYXRhIChVVUlEIDB4ZmUwMyk6CiAgICAgICAgUlNTSTogLTgyIGRCbSAoMHhhZSkK
PiBIQ0kgRXZlbnQ6IExFIE1ldGEgRXZlbnQgKDB4M2UpIHBsZW4gNDMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAj
NyBbaGNpMF0gMTAuMDU4ODA2CiAgICAgIExFIEFkdmVydGlzaW5nIFJlcG9ydCAoMHgwMikKICAg
ICAgICBOdW0gcmVwb3J0czogMQogICAgICAgIEV2ZW50IHR5cGU6IENvbm5lY3RhYmxlIHVuZGly
ZWN0ZWQgLSBBRFZfSU5EICgweDAwKQogICAgICAgIEFkZHJlc3MgdHlwZTogUmFuZG9tICgweDAx
KQogICAgICAgIEFkZHJlc3M6IEVGOjUxOkNEOjNDOjdFOjhGIChTdGF0aWMpCiAgICAgICAgRGF0
YSBsZW5ndGg6IDMxCiAgICAgICAgRmxhZ3M6IDB4MDYKICAgICAgICAgIExFIEdlbmVyYWwgRGlz
Y292ZXJhYmxlIE1vZGUKICAgICAgICAgIEJSL0VEUiBOb3QgU3VwcG9ydGVkCiAgICAgICAgQ29t
cGFueTogQW5odWkgSHVhbWkgSW5mb3JtYXRpb24gVGVjaG5vbG9neSBDby4sIEx0ZC4gKDM0MykK
ICAgICAgICAgIERhdGE6IDAyZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmYwM2VmNTFj
ZDNjN2U4ZgogICAgICAgIFJTU0k6IC03MiBkQm0gKDB4YjgpCj4gSENJIEV2ZW50OiBMRSBNZXRh
IEV2ZW50ICgweDNlKSBwbGVuIDQwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzggW2hjaTBdIDEwLjA3OTgxMgog
ICAgICBMRSBBZHZlcnRpc2luZyBSZXBvcnQgKDB4MDIpCiAgICAgICAgTnVtIHJlcG9ydHM6IDEK
ICAgICAgICBFdmVudCB0eXBlOiBTY2FubmFibGUgdW5kaXJlY3RlZCAtIEFEVl9TQ0FOX0lORCAo
MHgwMikKICAgICAgICBBZGRyZXNzIHR5cGU6IFJhbmRvbSAoMHgwMSkKICAgICAgICBBZGRyZXNz
OiA3OTpGOTpGOTo4Nzo1NDpEQSAoUmVzb2x2YWJsZSkKICAgICAgICBEYXRhIGxlbmd0aDogMjgK
ICAgICAgICAxNi1iaXQgU2VydmljZSBVVUlEcyAoY29tcGxldGUpOiAxIGVudHJ5CiAgICAgICAg
ICBHb29nbGUgKDB4ZmU5ZikKICAgICAgICBTZXJ2aWNlIERhdGEgKFVVSUQgMHhmZTlmKTogMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMAogICAgICAgIFJTU0k6IC03OSBk
Qm0gKDB4YjEpCj4gSENJIEV2ZW50OiBMRSBNZXRhIEV2ZW50ICgweDNlKSBwbGVuIDIwICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIzkgW2hjaTBdIDEwLjQ4MDgxMgogICAgICBMRSBBZHZlcnRpc2luZyBSZXBvcnQg
KDB4MDIpCiAgICAgICAgTnVtIHJlcG9ydHM6IDEKICAgICAgICBFdmVudCB0eXBlOiBOb24gY29u
bmVjdGFibGUgdW5kaXJlY3RlZCAtIEFEVl9OT05DT05OX0lORCAoMHgwMykKICAgICAgICBBZGRy
ZXNzIHR5cGU6IFJhbmRvbSAoMHgwMSkKICAgICAgICBBZGRyZXNzOiBDODozODozQTpGMDo1QTo3
RiAoU3RhdGljKQogICAgICAgIERhdGEgbGVuZ3RoOiA4CiAgICAgICAgQ29tcGFueTogQXBwbGUs
IEluYy4gKDc2KQogICAgICAgICAgVHlwZTogVW5rbm93biAoMTgpCiAgICAgICAgICBEYXRhOiAw
MDAxCiAgICAgICAgUlNTSTogLTg3IGRCbSAoMHhhOSkKPiBIQ0kgRXZlbnQ6IExFIE1ldGEgRXZl
bnQgKDB4M2UpIHBsZW4gNDMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMxMCBbaGNpMF0gMTEuMjA1ODU4CiAgICAg
IExFIEFkdmVydGlzaW5nIFJlcG9ydCAoMHgwMikKICAgICAgICBOdW0gcmVwb3J0czogMQogICAg
ICAgIEV2ZW50IHR5cGU6IENvbm5lY3RhYmxlIHVuZGlyZWN0ZWQgLSBBRFZfSU5EICgweDAwKQog
ICAgICAgIEFkZHJlc3MgdHlwZTogUmFuZG9tICgweDAxKQogICAgICAgIEFkZHJlc3M6IEY4OkMz
OkQxOkIwOjVBOjNBIChTdGF0aWMpCiAgICAgICAgRGF0YSBsZW5ndGg6IDMxCiAgICAgICAgRmxh
Z3M6IDB4MDIKICAgICAgICAgIExFIEdlbmVyYWwgRGlzY292ZXJhYmxlIE1vZGUKICAgICAgICBD
b21wYW55OiBBbmh1aSBIdWFtaSBJbmZvcm1hdGlvbiBUZWNobm9sb2d5IENvLiwgTHRkLiAoMzQz
KQogICAgICAgICAgRGF0YTogMDJmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZjAzZjhj
M2QxYjA1YTNhCiAgICAgICAgUlNTSTogLTU3IGRCbSAoMHhjNykKPCBIQ0kgQ29tbWFuZDogTEUg
U2V0IFNjYW4gRW5hYmxlICgweDA4fDB4MDAwYykgcGxlbiAyICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMxMSBbaGNpMF0gMTEuMjA1OTU3
CiAgICAgICAgU2Nhbm5pbmc6IERpc2FibGVkICgweDAwKQogICAgICAgIEZpbHRlciBkdXBsaWNh
dGVzOiBEaXNhYmxlZCAoMHgwMCkKPiBIQ0kgRXZlbnQ6IENvbW1hbmQgQ29tcGxldGUgKDB4MGUp
IHBsZW4gNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICMxMiBbaGNpMF0gMTEuMjU4ODEzCiAgICAgIExFIFNldCBTY2Fu
IEVuYWJsZSAoMHgwOHwweDAwMGMpIG5jbWQgMgogICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgw
MCkKPCBIQ0kgQ29tbWFuZDogTEUgQ3JlYXRlIENvbm5lY3Rpb24gKDB4MDh8MHgwMDBkKSBwbGVu
IDI1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICMxMyBbaGNpMF0gMTEuMjU4ODg0CiAgICAgICAgU2NhbiBpbnRlcnZhbDogNjAuMDAwIG1zZWMg
KDB4MDA2MCkKICAgICAgICBTY2FuIHdpbmRvdzogNjAuMDAwIG1zZWMgKDB4MDA2MCkKICAgICAg
ICBGaWx0ZXIgcG9saWN5OiBBY2NlcHQgbGlzdCBpcyBub3QgdXNlZCAoMHgwMCkKICAgICAgICBQ
ZWVyIGFkZHJlc3MgdHlwZTogUmFuZG9tICgweDAxKQogICAgICAgIFBlZXIgYWRkcmVzczogRjg6
QzM6RDE6QjA6NUE6M0EgKFN0YXRpYykKICAgICAgICBPd24gYWRkcmVzcyB0eXBlOiBQdWJsaWMg
KDB4MDApCiAgICAgICAgTWluIGNvbm5lY3Rpb24gaW50ZXJ2YWw6IDMwLjAwIG1zZWMgKDB4MDAx
OCkKICAgICAgICBNYXggY29ubmVjdGlvbiBpbnRlcnZhbDogNTAuMDAgbXNlYyAoMHgwMDI4KQog
ICAgICAgIENvbm5lY3Rpb24gbGF0ZW5jeTogMCAoMHgwMDAwKQogICAgICAgIFN1cGVydmlzaW9u
IHRpbWVvdXQ6IDQyMCBtc2VjICgweDAwMmEpCiAgICAgICAgTWluIGNvbm5lY3Rpb24gbGVuZ3Ro
OiAwLjAwMCBtc2VjICgweDAwMDApCiAgICAgICAgTWF4IGNvbm5lY3Rpb24gbGVuZ3RoOiAwLjAw
MCBtc2VjICgweDAwMDApCj4gSENJIEV2ZW50OiBDb21tYW5kIFN0YXR1cyAoMHgwZikgcGxlbiA0
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAjMTQgW2hjaTBdIDExLjI1OTgxMgogICAgICBMRSBDcmVhdGUgQ29ubmVj
dGlvbiAoMHgwOHwweDAwMGQpIG5jbWQgMgogICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkK
PiBIQ0kgRXZlbnQ6IExFIE1ldGEgRXZlbnQgKDB4M2UpIHBsZW4gMTkgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMx
NSBbaGNpMF0gMTIuMDYwODc0CiAgICAgIExFIENvbm5lY3Rpb24gQ29tcGxldGUgKDB4MDEpCiAg
ICAgICAgU3RhdHVzOiBTdWNjZXNzICgweDAwKQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAg
IFJvbGU6IENlbnRyYWwgKDB4MDApCiAgICAgICAgUGVlciBhZGRyZXNzIHR5cGU6IFJhbmRvbSAo
MHgwMSkKICAgICAgICBQZWVyIGFkZHJlc3M6IEY4OkMzOkQxOkIwOjVBOjNBIChTdGF0aWMpCiAg
ICAgICAgQ29ubmVjdGlvbiBpbnRlcnZhbDogNTAuMDAgbXNlYyAoMHgwMDI4KQogICAgICAgIENv
bm5lY3Rpb24gbGF0ZW5jeTogMCAoMHgwMDAwKQogICAgICAgIFN1cGVydmlzaW9uIHRpbWVvdXQ6
IDQyMCBtc2VjICgweDAwMmEpCiAgICAgICAgQ2VudHJhbCBjbG9jayBhY2N1cmFjeTogMHgwMApA
IE1HTVQgRXZlbnQ6IERldmljZSBDb25uZWN0ZWQgKDB4MDAwYikgcGxlbiA0NCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHsweDAwMDF9
IFtoY2kwXSAxMi4wNjA5NDEKICAgICAgICBMRSBBZGRyZXNzOiBGODpDMzpEMTpCMDo1QTozQSAo
U3RhdGljKQogICAgICAgIEZsYWdzOiAweDAwMDAwMDA4CiAgICAgICAgICBDb25uZWN0aW9uIExv
Y2FsbHkgSW5pdGlhdGVkCiAgICAgICAgRGF0YSBsZW5ndGg6IDMxCiAgICAgICAgRmxhZ3M6IDB4
MDIKICAgICAgICAgIExFIEdlbmVyYWwgRGlzY292ZXJhYmxlIE1vZGUKICAgICAgICBDb21wYW55
OiBBbmh1aSBIdWFtaSBJbmZvcm1hdGlvbiBUZWNobm9sb2d5IENvLiwgTHRkLiAoMzQzKQogICAg
ICAgICAgRGF0YTogMDJmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZjAzZjhjM2QxYjA1
YTNhCjwgSENJIENvbW1hbmQ6IExFIFJlYWQgUmVtb3RlIFVzZWQgRmVhdHVyZXMgKDB4MDh8MHgw
MDE2KSBwbGVuIDIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAjMTYgW2hjaTBdIDEyLjA2MTE3MAogICAgICAgIEhhbmRsZTogMzU4NQo+IEhDSSBFdmVudDog
Q29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzE3IFtoY2kwXSAxMi4w
NjE4NjkKICAgICAgTEUgUmVhZCBSZW1vdGUgVXNlZCBGZWF0dXJlcyAoMHgwOHwweDAwMTYpIG5j
bWQgMQogICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkKPiBIQ0kgRXZlbnQ6IExFIE1ldGEg
RXZlbnQgKDB4M2UpIHBsZW4gMTIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMxOCBbaGNpMF0gMTIuMTA3ODgzCiAg
ICAgIExFIFJlYWQgUmVtb3RlIFVzZWQgRmVhdHVyZXMgKDB4MDQpCiAgICAgICAgU3RhdHVzOiBT
dWNjZXNzICgweDAwKQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAgIEZlYXR1cmVzOiAweDAx
IDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAKICAgICAgICAgIExFIEVuY3J5cHRp
b24KPCBIQ0kgQ29tbWFuZDogTEUgU3RhcnQgRW5jcnlwdGlvbiAoMHgwOHwweDAwMTkpIHBsZW4g
MjggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICMxOSBbaGNpMF0gMTIuMTA3OTc3CiAgICAgICAgSGFuZGxlOiAzNTg1CiAgICAgICAgUmFuZG9t
IG51bWJlcjogMHgyMDBlOGU3ODYxYjY1NmZhCiAgICAgICAgRW5jcnlwdGVkIGRpdmVyc2lmaWVy
OiAweGEzMTMKICAgICAgICBMb25nIHRlcm0ga2V5OiA3MGZmODc3ODRlNGE0Mzk0YWY3MDIxNGJl
ZGYzM2ExZAo+IEhDSSBFdmVudDogQ29tbWFuZCBTdGF0dXMgKDB4MGYpIHBsZW4gNCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIzIwIFtoY2kwXSAxMi4xMDg4NjgKICAgICAgTEUgU3RhcnQgRW5jcnlwdGlvbiAoMHgw
OHwweDAwMTkpIG5jbWQgMQogICAgICAgIFN0YXR1czogU3VjY2VzcyAoMHgwMCkKPiBIQ0kgRXZl
bnQ6IEVuY3J5cHRpb24gQ2hhbmdlICgweDA4KSBwbGVuIDQgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyMSBbaGNpMF0g
MTIuNTA2OTQ3CiAgICAgICAgU3RhdHVzOiBTdWNjZXNzICgweDAwKQogICAgICAgIEhhbmRsZTog
MzU4NQogICAgICAgIEVuY3J5cHRpb246IEVuYWJsZWQgd2l0aCBBRVMtQ0NNICgweDAxKQo8IEFD
TCBEYXRhIFRYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAwIGRsZW4gNyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzIyIFto
Y2kwXSAxMi41MDc3MzAKICAgICAgQVRUOiBFeGNoYW5nZSBNVFUgUmVxdWVzdCAoMHgwMikgbGVu
IDIKICAgICAgICBDbGllbnQgUlggTVRVOiA1MTcKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDM1ODUg
ZmxhZ3MgMHgwMiBkbGVuIDcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyMyBbaGNpMF0gMTIuNTU2MDgxCiAgICAgIEFU
VDogRXhjaGFuZ2UgTVRVIFJlcXVlc3QgKDB4MDIpIGxlbiAyCiAgICAgICAgQ2xpZW50IFJYIE1U
VTogMjQ3CjwgQUNMIERhdGEgVFg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDAgZGxlbiA3ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAjMjQgW2hjaTBdIDEyLjU1NjI1NgogICAgICBBVFQ6IEV4Y2hhbmdlIE1UVSBSZXNwb25z
ZSAoMHgwMykgbGVuIDIKICAgICAgICBTZXJ2ZXIgUlggTVRVOiAyNDcKPiBIQ0kgRXZlbnQ6IE51
bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyNSBbaGNpMF0gMTIuNTU3
ODY5CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDM1ODUKICAgICAgICBD
b3VudDogMQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBw
bGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIzI2IFtoY2kwXSAxMi42MDY4NzAKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAg
IEhhbmRsZTogMzU4NQogICAgICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSAzNTg1
IGZsYWdzIDB4MDIgZGxlbiA3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMjcgW2hjaTBdIDEyLjY1NTk3MgogICAgICBB
VFQ6IEV4Y2hhbmdlIE1UVSBSZXNwb25zZSAoMHgwMykgbGVuIDIKICAgICAgICBTZXJ2ZXIgUlgg
TVRVOiAyNTIKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMCBkbGVuIDcgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICMyOCBbaGNpMF0gMTIuNjU2MjM1CiAgICAgIEFUVDogUmVhZCBSZXF1ZXN0ICgweDBh
KSBsZW4gMgogICAgICAgIEhhbmRsZTogMHgwMDMyCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29t
cGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMjkgW2hjaTBdIDEyLjcwNTg3MAogICAgICAg
IE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiAzNTg1CiAgICAgICAgQ291bnQ6IDEKPiBB
Q0wgRGF0YSBSWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMiBkbGVuIDEyICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMzMCBb
aGNpMF0gMTIuNzU1OTM2CiAgICAgIEFUVDogUmVhZCBSZXNwb25zZSAoMHgwYikgbGVuIDcKICAg
ICAgICBWYWx1ZTogMDE1NzAxNDAwMDAxMDEKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxh
Z3MgMHgwMCBkbGVuIDcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICMzMSBbaGNpMF0gMTIuNzU2MDQ1CiAgICAgIEFUVDog
UmVhZCBSZXF1ZXN0ICgweDBhKSBsZW4gMgogICAgICAgIEhhbmRsZTogMHgwMDE2Cj4gSENJIEV2
ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMzIgW2hjaTBd
IDEyLjgwNTkwMAogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiAzNTg1CiAg
ICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMiBkbGVu
IDE5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICMzMyBbaGNpMF0gMTIuODU2MDU4CiAgICAgIEFUVDogUmVhZCBSZXNwb25z
ZSAoMHgwYikgbGVuIDE0CiAgICAgICAgVmFsdWU6IDQxNmQ2MTdhNjY2OTc0MjA0NzU0NTIyMDMy
MDAKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMCBkbGVuIDcgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICMzNCBbaGNpMF0gMTIuODU2NDAwCiAgICAgIEFUVDogUmVhZCBSZXF1ZXN0ICgweDBhKSBsZW4g
MgogICAgICAgIEhhbmRsZTogMHgwMDE4Cj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVk
IFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjMzUgW2hjaTBdIDEyLjkwNTg5MAogICAgICAgIE51bSBo
YW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiAzNTg1CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0
YSBSWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMiBkbGVuIDcgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMzNiBbaGNpMF0g
MTUuMjU2MTEwCiAgICAgIEFUVDogRXhjaGFuZ2UgTVRVIFJlcXVlc3QgKDB4MDIpIGxlbiAyCiAg
ICAgICAgQ2xpZW50IFJYIE1UVTogMjQ3CjwgQUNMIERhdGEgVFg6IEhhbmRsZSAzNTg1IGZsYWdz
IDB4MDAgZGxlbiA3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjMzcgW2hjaTBdIDE1LjI1NjM0NgogICAgICBBVFQ6IEV4
Y2hhbmdlIE1UVSBSZXNwb25zZSAoMHgwMykgbGVuIDIKICAgICAgICBTZXJ2ZXIgUlggTVRVOiAy
NDcKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICMzOCBbaGNpMF0gMTUuMzA2OTk4CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5k
bGU6IDM1ODUKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgMzU4NSBmbGFn
cyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIzM5IFtoY2kwXSAxNi4wMDYxMTcKICAgICAgQVRUOiBS
ZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4
MDAwMS0weGZmZmYKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogQ2hhcmFjdGVyaXN0aWMgKDB4Mjgw
MykKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMCBkbGVuIDI3ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICM0MCBbaGNpMF0gMTYuMDA2MzM1CjwgQUNMIERhdGEgVFg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4
MDEgZGxlbiAyNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAjNDEgW2hjaTBdIDE2LjAwNjM0Nwo8IEFDTCBEYXRhIFRYOiBI
YW5kbGUgMzU4NSBmbGFncyAweDAxIGRsZW4gOCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzQyIFtoY2kwXSAxNi4wMDYz
NTEKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVzcG9uc2UgKDB4MDkpIGxlbiA1NwogICAgICAg
IEF0dHJpYnV0ZSBkYXRhIGxlbmd0aDogNwogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxpc3Q6IDgg
ZW50cmllcwogICAgICAgIEhhbmRsZTogMHgwMDAyCiAgICAgICAgVmFsdWU6IDAyMDMwMDAwMmEK
ICAgICAgICBIYW5kbGU6IDB4MDAwNAogICAgICAgIFZhbHVlOiAwMjA1MDAwMTJhCiAgICAgICAg
SGFuZGxlOiAweDAwMDYKICAgICAgICBWYWx1ZTogMDIwNzAwYTYyYQogICAgICAgIEhhbmRsZTog
MHgwMDA5CiAgICAgICAgVmFsdWU6IDIwMGEwMDA1MmEKICAgICAgICBIYW5kbGU6IDB4MDAwYwog
ICAgICAgIFZhbHVlOiAwYTBkMDAyOTJiCiAgICAgICAgSGFuZGxlOiAweDAwMGUKICAgICAgICBW
YWx1ZTogMDIwZjAwMmEyYgogICAgICAgIEhhbmRsZTogMHgwMDEwCiAgICAgICAgVmFsdWU6IDAy
MTEwMDNhMmIKICAgICAgICBIYW5kbGU6IDB4MDAxMwogICAgICAgIFZhbHVlOiAwMjE0MDA1MDJh
Cj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAj
NDMgW2hjaTBdIDE2LjA1NzA1NQogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxl
OiAzNTg1CiAgICAgICAgQ291bnQ6IDEKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQg
UGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICM0NCBbaGNpMF0gMTYuMDU4MDM3CiAgICAgICAgTnVtIGhh
bmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDM1ODUKICAgICAgICBDb3VudDogMQo+IEhDSSBFdmVu
dDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzQ1IFtoY2kwXSAx
Ni4wNTkwMzIKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAg
ICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIgZGxlbiAx
MSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAjNDYgW2hjaTBdIDE2LjEwNjEwOAogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBS
ZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDE0LTB4ZmZmZgog
ICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAoMHgyODAzKQo8IEFDTCBEYXRh
IFRYOiBIYW5kbGUgMzU4NSBmbGFncyAweDAwIGRsZW4gOSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzQ3IFtoY2kwXSAx
Ni4xMDYzNjUKICAgICAgQVRUOiBFcnJvciBSZXNwb25zZSAoMHgwMSkgbGVuIDQKICAgICAgICBS
ZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkKICAgICAgICBIYW5kbGU6IDB4MDAxNAogICAgICAg
IEVycm9yOiBBdHRyaWJ1dGUgTm90IEZvdW5kICgweDBhKQo+IEhDSSBFdmVudDogTnVtYmVyIG9m
IENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzQ4IFtoY2kwXSAxNi4xNTcxMDMKICAg
ICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAgIENvdW50OiAx
Cj4gQUNMIERhdGEgUlg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAj
NDkgW2hjaTBdIDE2LjIwNjE0MAogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4
KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDAxLTB4ZmZmZgogICAgICAgIEF0dHJp
YnV0ZSB0eXBlOiBEZXZpY2UgTmFtZSAoMHgyYTAwKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgMzU4
NSBmbGFncyAweDAwIGRsZW4gMTggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzUwIFtoY2kwXSAxNi4yMDY3MzcKICAgICAg
QVRUOiBSZWFkIEJ5IFR5cGUgUmVzcG9uc2UgKDB4MDkpIGxlbiAxMwogICAgICAgIEF0dHJpYnV0
ZSBkYXRhIGxlbmd0aDogMTIKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsaXN0OiAxIGVudHJ5CiAg
ICAgICAgSGFuZGxlOiAweDAwMDMKICAgICAgICBWYWx1ZTogNDI2Yzc1NjU1YTIwMzUyZTM2MzMK
PiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM1
MSBbaGNpMF0gMTYuMjU3MDgyCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6
IDM1ODUKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgMzU4NSBmbGFncyAw
eDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIzUyIFtoY2kwXSAxOS40MzgwMzAKICAgICAgQVRUOiBSZWFk
IEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAw
MS0weGZmZmYKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogQ2hhcmFjdGVyaXN0aWMgKDB4MjgwMykK
PCBBQ0wgRGF0YSBUWDogSGFuZGxlIDM1ODUgZmxhZ3MgMHgwMCBkbGVuIDI3ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM1
MyBbaGNpMF0gMTkuNDM4MjM5CjwgQUNMIERhdGEgVFg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDEg
ZGxlbiAyNyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAjNTQgW2hjaTBdIDE5LjQzODI1NQo8IEFDTCBEYXRhIFRYOiBIYW5k
bGUgMzU4NSBmbGFncyAweDAxIGRsZW4gOCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzU1IFtoY2kwXSAxOS40MzgyNjAK
ICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVzcG9uc2UgKDB4MDkpIGxlbiA1NwogICAgICAgIEF0
dHJpYnV0ZSBkYXRhIGxlbmd0aDogNwogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxpc3Q6IDggZW50
cmllcwogICAgICAgIEhhbmRsZTogMHgwMDAyCiAgICAgICAgVmFsdWU6IDAyMDMwMDAwMmEKICAg
ICAgICBIYW5kbGU6IDB4MDAwNAogICAgICAgIFZhbHVlOiAwMjA1MDAwMTJhCiAgICAgICAgSGFu
ZGxlOiAweDAwMDYKICAgICAgICBWYWx1ZTogMDIwNzAwYTYyYQogICAgICAgIEhhbmRsZTogMHgw
MDA5CiAgICAgICAgVmFsdWU6IDIwMGEwMDA1MmEKICAgICAgICBIYW5kbGU6IDB4MDAwYwogICAg
ICAgIFZhbHVlOiAwYTBkMDAyOTJiCiAgICAgICAgSGFuZGxlOiAweDAwMGUKICAgICAgICBWYWx1
ZTogMDIwZjAwMmEyYgogICAgICAgIEhhbmRsZTogMHgwMDEwCiAgICAgICAgVmFsdWU6IDAyMTEw
MDNhMmIKICAgICAgICBIYW5kbGU6IDB4MDAxMwogICAgICAgIFZhbHVlOiAwMjE0MDA1MDJhCj4g
SENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNTYg
W2hjaTBdIDE5LjQ1NzE2OQogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiAz
NTg1CiAgICAgICAgQ291bnQ6IDEKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFj
a2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICM1NyBbaGNpMF0gMTkuNDU4MjI5CiAgICAgICAgTnVtIGhhbmRs
ZXM6IDEKICAgICAgICBIYW5kbGU6IDM1ODUKICAgICAgICBDb3VudDogMQo+IEhDSSBFdmVudDog
TnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzU4IFtoY2kwXSAxOS40
NTkyNTIKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAg
IENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIgZGxlbiAxMSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAjNTkgW2hjaTBdIDE5LjUwNjI4NwogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1
ZXN0ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDE0LTB4ZmZmZgogICAg
ICAgIEF0dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAoMHgyODAzKQo8IEFDTCBEYXRhIFRY
OiBIYW5kbGUgMzU4NSBmbGFncyAweDAwIGRsZW4gOSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzYwIFtoY2kwXSAxOS41
MDYzODgKICAgICAgQVRUOiBFcnJvciBSZXNwb25zZSAoMHgwMSkgbGVuIDQKICAgICAgICBSZWFk
IEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkKICAgICAgICBIYW5kbGU6IDB4MDAxNAogICAgICAgIEVy
cm9yOiBBdHRyaWJ1dGUgTm90IEZvdW5kICgweDBhKQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENv
bXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzYxIFtoY2kwXSAxOS41NTcyNDUKICAgICAg
ICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogMzU4NQogICAgICAgIENvdW50OiAxCj4g
QUNMIERhdGEgUlg6IEhhbmRsZSAzNTg1IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNjIg
W2hjaTBdIDE5LjYwNjMyMQogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBs
ZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDAxLTB4ZmZmZgogICAgICAgIEF0dHJpYnV0
ZSB0eXBlOiBEZXZpY2UgTmFtZSAoMHgyYTAwKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgMzU4NSBm
bGFncyAweDAwIGRsZW4gMTggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIzYzIFtoY2kwXSAxOS42MDY3MjYKICAgICAgQVRU
OiBSZWFkIEJ5IFR5cGUgUmVzcG9uc2UgKDB4MDkpIGxlbiAxMwogICAgICAgIEF0dHJpYnV0ZSBk
YXRhIGxlbmd0aDogMTIKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsaXN0OiAxIGVudHJ5CiAgICAg
ICAgSGFuZGxlOiAweDAwMDMKICAgICAgICBWYWx1ZTogNDI2Yzc1NjU1YTIwMzUyZTM2MzMKPiBI
Q0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICM2NCBb
aGNpMF0gMTkuNjU3MjEwCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDM1
ODUKICAgICAgICBDb3VudDogMQoKCgoKCgoKPCBIQ0kgQ29tbWFuZDogRGlzY29ubmVjdCAoMHgw
MXwweDAwMDYpIHBsZW4gMyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICM2NSBbaGNpMF0gNDQuODg1MTk0CiAgICAgICAgSGFu
ZGxlOiAzNTg1CiAgICAgICAgUmVhc29uOiBSZW1vdGUgVXNlciBUZXJtaW5hdGVkIENvbm5lY3Rp
b24gKDB4MTMpCj4gSENJIEV2ZW50OiBDb21tYW5kIFN0YXR1cyAoMHgwZikgcGxlbiA0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAjNjYgW2hjaTBdIDQ1LjAwNjMxNQogICAgICBEaXNjb25uZWN0ICgweDAxfDB4MDAw
NikgbmNtZCAxCiAgICAgICAgU3RhdHVzOiBTdWNjZXNzICgweDAwKQo+IEhDSSBFdmVudDogRGlz
Y29ubmVjdCBDb21wbGV0ZSAoMHgwNSkgcGxlbiA0ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzY3IFtoY2kwXSA0NS4wMDgy
NTgKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApCiAgICAgICAgSGFuZGxlOiAzNTg1CiAg
ICAgICAgUmVhc29uOiBDb25uZWN0aW9uIFRlcm1pbmF0ZWQgQnkgTG9jYWwgSG9zdCAoMHgxNikK
QCBNR01UIEV2ZW50OiBEZXZpY2UgRGlzY29ubmVjdGVkICgweDAwMGMpIHBsZW4gOCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7MHgwMDAx
fSBbaGNpMF0gNDUuMDA4MzExCiAgICAgICAgTEUgQWRkcmVzczogRjg6QzM6RDE6QjA6NUE6M0Eg
KFN0YXRpYykKICAgICAgICBSZWFzb246IENvbm5lY3Rpb24gdGVybWluYXRlZCBieSBsb2NhbCBo
b3N0ICgweDAyKQo=
--00000000000006da4505dae2d38b--
