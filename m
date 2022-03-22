Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6FCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 23:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240552AbiCVXhQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 19:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiCVXhO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 19:37:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCB061A1D
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:35:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g138so16098209ybf.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsI/3HZ1Xfnrpn7b1EPEFd8A1Uz6ODmENqXcJR1D4UY=;
        b=LQWRKCfH1UoPw/1SMbhUIErXWHFoDkdrwwI2/yHDB+Tomp1Y7G/RumwGpGS4VCdqOn
         0rs4eCJ10JR4wbUDNlk7cmAZbGFSflFoPEbG3HBdwLrovkqhWdoL1yZ2rUf5GHzOWEdV
         ggV1JSqn67VoiBdB5hCs5zq26gunp5QBPjfFV93aGDqE91EaK6NKfkWoadU51LO9sH72
         IStpJHjQwEDNNt3JcIT5P1o09Bzetb8kxeS+Kt0yBiecArrdyByyZQuqGQZHGAh/pd23
         IaTownZVt58p7cYmluBE77ofOTm4wSsteDh1Tba9ADqp/ZDHGzDOJPxWtqlks2vlAboH
         lV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsI/3HZ1Xfnrpn7b1EPEFd8A1Uz6ODmENqXcJR1D4UY=;
        b=6nyVN+StF1Pw9w1oivMF5FFiWapdiaVe6L90rCUVgmsflf7i2ZMddmQeMVhO/TmO7n
         bF4sZHZvBLLkoYiM52F7PLf6I6Ewy41o5kBJNQMJAoEbArw/a+AC9OYIBFWiCu3dSEpN
         sUbFpGguHtd12TRTrpQHC2/bSYoBcDVNO0SOvJ01OHLXTnWOsgB/CCc/OwRRwU19Ig+h
         i9mVntApXr5l41pFAVFxx5hgnaFj81hMR4/b7uJYPPxKm9zOYabV9z4AJvo5ey1IymEF
         SIx00HkjA7x4eHgSHldWyFJZyVTUNJrcG8nCSRxTMEu4+vpnjHEhBI4pu8/HFLpt/28R
         DV3w==
X-Gm-Message-State: AOAM533QFsX0/D1Ts+FtAm9NcoHiEinGyfTqfQEb73qrDS+pEXsaNrVa
        5mPhWkmFGZyyDD5rWSCG9nZCI3K9zwla8/Lfa/550it5cGE=
X-Google-Smtp-Source: ABdhPJx+n0Aw9OlE0pLIJs651amWWwe4jHFNC3TsVbwgWbteY4nnKQpnUtm2xAkUq2S50zXEifTW1oORgI19zy1iPlo=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr27938058ybn.259.1647992144773; Tue, 22
 Mar 2022 16:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <CANFkB1ydGuwKRjusy3U0HCQo8E88XbZTh_UdPZ8wujt7P5KKnQ@mail.gmail.com>
 <CABBYNZLjV3PQ7Hm3PJZcTcs64aLzWLBNfooSYuZmSywv0RJG0g@mail.gmail.com>
 <CANFkB1yr3N_Twac=ocxBRst79-gmdu8=6VTD6oPgdGT0rb_HaQ@mail.gmail.com>
 <CANFkB1xEesP1cMmK4VGi5cH-v80ho00wT24q=+4QQSdyPegPQQ@mail.gmail.com>
 <CABBYNZKSsyqfiWYjpuZNYtKAZb4C2q73YwOj=KoUFq71gLs7Hg@mail.gmail.com> <CANFkB1zHTZF3Mcgn5GPBA0km+BNyL3bb9=MJFuSNFe6x5zgimQ@mail.gmail.com>
In-Reply-To: <CANFkB1zHTZF3Mcgn5GPBA0km+BNyL3bb9=MJFuSNFe6x5zgimQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Mar 2022 16:35:33 -0700
Message-ID: <CABBYNZLWN3+51F-sNJ5yPc2bw+x4Ep6rCwcFLn0bfrwArL=Hyw@mail.gmail.com>
Subject: Re: GATT issue, possible bluez bug?
To:     Adam Pigg <adam@piggz.co.uk>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Adam,

On Tue, Mar 22, 2022 at 4:09 PM Adam Pigg <adam@piggz.co.uk> wrote:
>
> Thanks Luiz
>
> On Tue, 22 Mar 2022 at 21:35, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Adam,
> >
> > On Tue, Mar 22, 2022 at 3:40 AM Adam Pigg <adam@piggz.co.uk> wrote:
> > >
> > > Hi Luiz
> > >
> > >
> > > On Tue, 22 Mar 2022 at 07:55, Adam Pigg <adam@piggz.co.uk> wrote:
> > > >
> > > > Hi Luiz
> > > >
> > > > On Tue, 22 Mar 2022 at 00:44, Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Adam,
> > > > >
> > > > > On Mon, Mar 21, 2022 at 4:03 PM Adam Pigg <adam@piggz.co.uk> wrote:
> > > > > >
> > > > > > Hi
> > > > > >
> > > > > > A bit of background, I write a linux desktop/mobile app called
> > > > > > Amazfish which interfaces with several watches over BLE using their
> > > > > > GATT services.  To do this, I use the bluez dbus api (technically a
> > > > > > thin wrapper around it I wrote called qble
> > > > > > https://github.com/piggz/qble)
> > > > > >
> > > > > > All has been good so far, I support several generations of
> > > > > > Huami/Amazfit watches, as well as the open source Pinetime and
> > > > > > Bangle.js.  For the Amazfit watches, i have implementations for older
> > > > > > devies such as the Bip, and newer ones such as the GTS.
> > > > > >
> > > > > > Much of the reverse engineering comes from the Android Gadget Bridge
> > > > > > project, which supports many more devices.
> > > > > >
> > > > > > My community of users donated to buy me a newer device called a GTR2,
> > > > > > which, according to the GB devs uses the same protocol as the slightly
> > > > > > older GTS, and the packet captures I have from Android would support
> > > > > > this.
> > > > > >
> > > > > > But this is where my trouble starts with Bluez, my existing
> > > > > > implementation doesnt work at all.  Normally, after a connection, I
> > > > > > would wait for the ServicesResolved signal, which happens pretty fast
> > > > > > on all other devices, but on the GTR2, it takes about 30 seconds, by
> > > > > > which time, the watch has disconnected. (i get a disconnected signal
> > > > > > immediately after the ServicesResolved signal)
> > > > > >
> > > > > > To rule out my code, I have tried several things:
> > > > > > Gatttool
> > > > > > With gattool, i can connect, get the services, enable a notification,
> > > > > > write a value and get the expected results seemingly fine
> > > > > >
> > > > > > Python-gatt (using the bluez dbus api)
> > > > > > Im unable to iterate the services, like my app, it takes 30 seconds to
> > > > > > get the signal and then swiftly disconnects
> > > > > >
> > > > > > Gattlib (https://github.com/labapart/gattlib)
> > > > > > Gattlib is interesting as it appears to have "borrowed" much of its
> > > > > > code directly from bluez.  When built against the system bluez, if the
> > > > > > version is > 5.42, it will use the dbus api.  When I do this, again im
> > > > > > unable to list services on the watch.  However, if I edit the build to
> > > > > > force it to use its internal gatt implementation, which appears to be
> > > > > > the same one used by gatttool, then, it IS able to interrogate the
> > > > > > watch.
> > > > > >
> > > > > > I have attached 3 files
> > > > > > 1. test python program which should print services, and associated btmon
> > > > > > 2. btmon output while using gatttool
> > > > > > 3. btmon output running gattlib discover example
> > > > > >
> > > > > > Note, other than discovery, I havnt been able to get gattlib to
> > > > > > read/write/notify!
> > > > > >
> > > > > > It seems as though I may be triggering a bug in the bluez dbus api?
> > > > > > Can anyone suggest anything?
> > > > >
> > > > > What version are you using? I would first try with the latest to see
> > > > > if that something already fixed.
> > > > >
> > > > >
> > > > Im using 5.63 already, which is the latest tag (on opensuse tumbleweed)
> > > >
> > > > I'll also try bluetoothctl and attach logs using that, though I
> > > > suspect it will behave the same as the python library and my own
> > > > library.
> > > >
> > >
> > > Attached is the output of btmon while using bluetoothctl
> > >
> > > bluetoothctl behaves the same as my lib and python, it is unable to
> > > list services, and after a while, emits the ServicesResolved and
> > > disconnected messages at the same time.  Im sure it should be able to
> > > list the services immediately after connect just like gatttool can.
> >
> > Looks like there is multiple rounds of MTU Exchange, not sure if that
> > is actually a problem but the spec does say it shall only be sent once
> > per client:
> >
> > BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
> > page 1424:
> >
> > This request shall only be sent once during a connection by the client.
> >
> > There is also no response to frame #30:
> > < ACL Data TX: Handle 3585 flags 0x00 dlen 7
> >
> >                            #30 [hci0] 26.641557
> >       ATT: Read Request (0x0a) len 2
> >         Handle: 0x0018
> >
> > So after 30 seconds (ATT timeout) without receiving any response it disconnects:
> >
>
> So, the verdict is that the watch isnt acting to spec right?
>
> Why does gatttool work ok, is it a completely different implementation?
>
> I understand if wouldnt be to spec, but would it be possible to make
> bluez more resilient to devices not acting to spec?  Android and iOS
> work just fine in this regard, so could bluez handle mis-behaving
> devices more flexibly?

That I can't really explain, perhaps it is timing related, something
with Exchange MTU since it appears to stop the device from responding
when it happens a second time.

> Do you have any suggestions for things I could try? I looked for
> similar lines in the working gatttool log, and it doesnt have anything
> like that, seems to send flags 0x00 dlen 9 (instead of 7?)  ... how is
> it behaving differently?

Not sure really, does Android/iOS Exchange the MTU? Maybe we need a
timer to start it later or perhaps the problem first response to
exchange MTU does actually use the final_mtu which makes the watch to
trigger yet another exchange to have both rx and tx MTU the same so
try with the following change:

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 2adb4afbf..d326782bf 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1499,7 +1499,7 @@ static void exchange_mtu_cb(struct bt_att_chan
*chan, uint8_t opcode,
        final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);

        /* Respond with the server MTU */
-       put_le16(server->mtu, rsp_pdu);
+       put_le16(final_mtu, rsp_pdu);
        bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);

        /* Set MTU to be the minimum */


>
> > < HCI Command: Disconnect (0x01|0x0006) plen 3
> >
> >                            #48 [hci0] 58.673128
> >         Handle: 3585
> >         Reason: Remote User Terminated Connection (0x13)
> >
> > > Thanks
> > >
> > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
