Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613FC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 18:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A902064C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 18:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNQPW77j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfAJSBm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:01:42 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40922 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfAJSBm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 13:01:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so10717942oth.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jan 2019 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7klHygjDHQXDG/vgcNOOCpfxpGiJ7NDEiQJQwK9HIMA=;
        b=ZNQPW77jRe2W1rKgjkII46YSlwwgKVU/JPTS+zzEQb4OPlEI32PsnrgzH+Ve05zC5L
         nqYdTeGuC4lGTbz/zhQQnneqx2L3zr7y761wlmQBzeYKVIwYM3AAdL+G66xQF7poksMg
         joILDmGBF/D2wNTJmbtSJZK8rzXWjHwO3kE7qLjgFQgJ5rJ9bAGEHfW62qDdfIH+qbK7
         zRt1Sf6fvoXIefZJmFzujg/LfLst/UisKQq3PKdDS15zZUa+56yb+jjg7Zmf7qebweaH
         tZAfuuiQRmkClvUIkHVdQfgwypp1vdFh3cbNX9O82hH8CmuTTaMmpnFS2VszomqXj+2m
         1rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7klHygjDHQXDG/vgcNOOCpfxpGiJ7NDEiQJQwK9HIMA=;
        b=uf+KCAKtMZzN0QJMobsF9eVO7InqYkoOO8c5sBRoPpnL/ZqIKT8CT/iJwaeQJOIiSu
         7DpXMPGHouzw+XLj4/bReDyubDsI3VmFHXWQ1JtEduQXmEucZ7O9AC7pQL1Aa2FQx08j
         72DaBIxwVP1SeiEgimwW82JpyU9awh/tFPQXKGd6x+akzrM/1OPCPxOLGK1a8eCJQIP1
         wNqUEXTeAezbIFvVh/0nlJmfyBmLXbD+L8xeoOZjgqPPiHJhJ/rYG5WDsic7cScnZaea
         AVa+YY7t3EmyIVDoWRs+kklgcwj3ue0ScaDzDpHSatTLanWyg37+yWW056KvZu0hnaow
         ng/g==
X-Gm-Message-State: AJcUukcSCxTIzdKm27Zk/kC0sZPtBvPV0NHai5tVbfRwj8SE4K/ZxWuK
        YAFsPkPrikcByjTLavh2tRz6QZV8h10B76/d2J49gbwq
X-Google-Smtp-Source: ALg8bN7J/Vwf0BCShyaGmCE4gnSV6C8CPtq2Ebtgt8ofgRV/ob/PGTxhZ5vzeeYI/7b/lbjBRioRROod7N5oEPW+JQs=
X-Received: by 2002:a9d:d73:: with SMTP id 106mr7261601oti.291.1547143299622;
 Thu, 10 Jan 2019 10:01:39 -0800 (PST)
MIME-Version: 1.0
References: <b0665aa8-4bfb-4ec8-3f7f-deb2bf5ea61a@gmail.com> <d36c145a-02a2-a9b2-a4b0-68e275d74958@gmail.com>
In-Reply-To: <d36c145a-02a2-a9b2-a4b0-68e275d74958@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Jan 2019 15:01:28 -0300
Message-ID: <CABBYNZKiNmUxsOou+dLx3ipj7c76opfde3-jrZxQYsQK1H2_Fg@mail.gmail.com>
Subject: Re: Multiple peers with bluetooth_6lowpan
To:     Josua Mayer <josua.mayer97@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Josua,

On Thu, Jan 10, 2019 at 1:49 PM Josua Mayer <josua.mayer97@gmail.com> wrote:
>
> Good day once more,
>
> I have now identified a chain of calls leading up to the described
> issue, along with a work-around:
>
> The first step was discovering fishy debug messages in dmesg:
> [  235.505517] Connecting to first module while both are powered
> [  237.394085] ifindex 5 peer bdaddr 00:b1:fc:8c:6e:47 type 1 my addr
> a4:d5:78:11:cf:6f type 1
> [  241.872089] dest IP fe80::b1:fcff:fe8c:6e47
> [  241.872104] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
> [  241.872124] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan
> (ptrval)
> [  242.356387] Connecting to second module
> [  244.073592] dest IP fe80::b1:fcff:fe8c:6e47
> [  244.073603] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
> [  244.073607] no such peer
>
> We can see here how the first module is connected, and packets to its
> link-local address are being transmitted.
> Then the second module is connected and the number of peers updates to 2.
> Now we have another packet for the first modules link-local address. We
> know there are 2 peers, but for some reason we get a message saying "no
> such peer"!
>
> Luckily this message was easy to trace:
> See net/bluetooth/6lowpan.c:setup_header
> This message is a direct result of a previous call to peer_lookup_dst
> returning null.
> Now while reviewing peer_lookup_dst, keep in mind that we are looking
> for a difference in behaviour when there is one, and when tehre are at
> least two peers.
> Let me just quote here:
> if (count == 1) {
> peer = list_first_or_null_rcu(&dev->peers, struct lowpan_peer, list);
> return peer;
> }
>
> If there is only one peer, no checks are performed at all, it is simply
> assumed that this peer mist be the one to receive packets for the given
> address.
> So this is the one peers, or one module connected case - which works
> just fine.
>
> Then follows a curious case that I do not fully understand:
> if no route is known, and no gateway was specified in packet data, do
> not even search for the right peer, simply return 0:
> if (!rt) {
> nexthop = &lowpan_cb(skb)->gw;
>
> if (ipv6_addr_any(nexthop))
> return NULL;
> }
> ^^ I believe this decision is wrong.
> There might be neither route nor gateway, if the destination is a peer.
>
> I have come up with the following work-around:
> -               nexthop = &lowpan_cb(skb)->gw;
> -
> -               if (ipv6_addr_any(nexthop))
> -                       return NULL;
> +               if (ipv6_addr_any(&lowpan_cb(skb)->gw)) {
> +                       /* There is neither route nor gateway,
> +                        * probably the destination is a direct peer.
> +                        */
> +                       nexthop = daddr;
> +               } else {
> +                       /* There is a known gateway
> +                        */
> +                       nexthop = &lowpan_cb(skb)->gw;
> +               }
> I am submitting this patch as separately as:
> [RFC] bluetooth_6lowpan: search for destination address in all peers
> It is by no means finished and meant to illustrate the core issue, and
> allow for a discussion around the control logic, and purpose of
> Please comment if I have understood the purpose of the peer_lookup_dst
> function.
> I might even suggest removing the special handling of one peer ... .

I like this version better but apparently the patch you have sent is
only matching part of the address, not sure why you had refactored
that. If I recall the reason why peer_lookup_dst exists is that we
need to resolve the channel where to send the packets.

> Yours sincerely
> Josua Mayer
>
>
> Am 08.01.19 um 19:57 schrieb Josua Mayer:
> > Greetings everybody,
> >
> > I want to present to you an issue I am having the 6LoWPAN over BLE
> > facility in the kernel.
> > I have reached the point where I don't know where, what and how to debug
> > the situation and am hoping for some advice here:
> >
> > First an overview of the setup:
> > 1. an SBC with BLE capable Bluetooth chip
> > 2. multiple Nordic nRF52840 modules
> >
> > This is the problem I have observed:
> > 1. One Nordic module is powered - SBC connects to it
> > --> ping6 works flawlessly till the module restarts
> > --> communication with the remote server works as expected
> >
> > 2. Two Nordic modules are powered - SBC connects only to one at a time
> > --> ping6 works flawlessly till the module restarts
> > --> communication with the remote server works as expected
> >
> > 3. Two Nordic modules are powered - SBC connects to both
> > --> ping6 receives no more replies as soon as the second module is connected
> > --> communication to the remote server stops as soon as the second
> > module is connected
> >
> > Test Case:
> > rfkill unblock 0
> > modprobe bluetooth_6lowpan
> > echo -n 'module bluetooth_6lowpan +p' >
> > /sys/kernel/debug/dynamic_debug/control
> >
> > while true; do ping6 -c 1 -I bt0 fe80::b1:fcff:fe8c:6e47 || true; sleep
> > 1; done
> >
> > echo "Connecting to first module while both are powered" > /dev/kmsg
> > echo "connect 00:B1:FC:8C:6E:47 1" >
> > /sys/kernel/debug/bluetooth/6lowpan_control
> > # sit back and watch pings till module restarts
> > echo "Connecting to first module while both are powered" > /dev/kmsg
> > echo "connect 00:B1:FC:8C:6E:47 1" >
> > /sys/kernel/debug/bluetooth/6lowpan_control
> > # wait till first ping goes through
> > echo "Connecting to second module" > /dev/kmsg
> > echo "connect 00:39:D3:29:92:1C 1" >
> > /sys/kernel/debug/bluetooth/6lowpan_control
> > # Expected: ping6 continues to receive replies
> > # Actual result: ping6 times out
> >
> > Please see attached dmesg.log from this test case, with dynamic
> > debugging enabled for module bluetooth_6lowpan.
> >
> > The Nordic modules are programmed to advertise themselves for
> > establishing a connection; Then they start communication with a server
> > on the internet over ipv6. Finally they are rebooted by a watchdog.
> > While a module is connected, it can be pinged by its link-local address
> > which is derived from its MAC address and thereby known.
> >
> > As you may have noticed I just wrote "SBC" above.
> > That is because I have done this experiment with 3 different SBCs:
> > 1. SolidRun HummingBoard with i.MX6 uSOM Revision 1.5
> > features Ti WL18MODGB combined WiFi and Bluetooth module
> > - linux-image-4.20.0-trunk-armmp_4.20-1~exp2_armhf.deb
> > (+BT_HCIUART=m, +BT_HCIUART_LL=y, +DYNAMIC_DEBUG=y)
> > ^^ This system was used to produce the attached dmesg.log
> >
> > 2. RaspberryPi 3B
> > 3. RaspberryPi 3B+
> > - rpi-4.15.y (from their github)
> > - rpi-4.16.y (from their github)
> > - rpi-4.17.y (from their github)
> > - rpi-4.18.y (from their github)
> > - rpi-4.19.y (from their github)
> > - rpi-4.20.y (from their github)
> > bcm2709_defconfig
> > zImage modules dtbs -j12
> > gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf
> >
> > rpi-4.14.y suffers from a busy kworker (Workqueue: hci0 hci_rx_work
> > [bluetooth]) making tests difficult.
> >
> > Supposedly back in 4.4.8-v7 on raspberrypi this issue with multiple
> > peers did not exist, while the busy kworker did pop up after time
> > requring a reboot.
> > I did not verify or test with that rather old version yet.
> > Would it be a good idea to start from that 4.4.8 rpi fork working up to
> > 4.15 to find the place where it broke? I feel like this kind of work is
> > difficult
> > when forks are involved.
> >
> > Are there any components of the kernel in particular that could be verified
> > in order to figure out what is going wrong?
> >
> >
> > Yours sincerely
> > Josua Mayer
> >



-- 
Luiz Augusto von Dentz
