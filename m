Return-Path: <SRS0=fB+o=WI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE7CC31E40
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Aug 2019 11:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2062085A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Aug 2019 11:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3ahcffI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfHLLf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:35:58 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:32889 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbfHLLf6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Aug 2019 07:35:58 -0400
Received: by mail-lj1-f171.google.com with SMTP id z17so9527755ljz.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2019 04:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6jQFUeteLx4sFRLSI4BFT2BDsEuIQWwmjbB94UBZN4=;
        b=U3ahcffIVvrX8lRw8sw4RRk3BYuWeP4cFfLvAgMWKua3MUBAPQG4OQZGfWs4u0q4zj
         JmOWVz6/GY+Jf1fH7Y7E+DjeM4YAA+otdiXHQQChw+JGGOBI4321fc0/wUC6Bj0R1Xp1
         cr8HBL5U7eTv6b5l0SOyTmIvbsfKaorM3QqwF8I8MeTSnDOtunIuKGUUcMMkvCOKRw6D
         iB+MGQuT8zkXnSCqozZJUV7ftZ9kni+yMGm+h6MdRaKt9oHHakXhji8exvQvt5rYleo9
         r3JQiJZh750dVsLp+m6Ay+0wpYMR1SOXSdRKQ3X/BcjqZzPe8vxoIBOcLgqD0GJpoE35
         b87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6jQFUeteLx4sFRLSI4BFT2BDsEuIQWwmjbB94UBZN4=;
        b=WPLkRaSt+c6LCwGtO6Q2QVw0xOlxCMwbT+Q1ZBopujSdFi+OJh/htjjkJfiga3jNSC
         lrEcftHjJSj7Wu916S6JF2YVBujV4JY6DPezqTyRLXCPKoxCxpVyx88fglfFTyIXjHmE
         BdBr9zU15WYxSmzs4IcwFbmMkO25XiPcvy8aFegTS7TqWlIyFsmdom1SzlE0wT0ZO2AR
         vm4CFgduhfM6IAubfw75S+ANKxIA/XwO2x2mzc6b0X/e4LOk6y6Zfh/d914Z6qIic1ZC
         iUUFwikqJBNJJdJ8vs+2UWCeSX9gJHce1DAYDMUCwZNcMZeLdag7nyRISORMC59lDE/7
         8L7A==
X-Gm-Message-State: APjAAAWlyBv0P1Yzy2fjxki0BH0FfhRf9BP9MBn+PzQ/8Hmg2lKBgvd8
        3SBm6tJuhLWX8PywcXhIMD6ykJBx9mzK/s5D2HU=
X-Google-Smtp-Source: APXvYqwKdNvBhu24YcWT/IWi36bMphfRDbF9Zw6KkxclDKTCpjY3MFpiH8LBKMwmDpTLC9HhZNtDrEKZD7BjnOu3fG8=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr13258883ljo.69.1565609753319;
 Mon, 12 Aug 2019 04:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzhej0YJ6b+=nFXHiiZPJnSdOm=F_OaXR5kWFjvbw2107X94Q@mail.gmail.com>
 <CABBYNZL-0mXtoQ1vUs=SWcBywET1y6A_xfd4KjTVLoE5gyp8vA@mail.gmail.com>
In-Reply-To: <CABBYNZL-0mXtoQ1vUs=SWcBywET1y6A_xfd4KjTVLoE5gyp8vA@mail.gmail.com>
From:   Mathias Baert <mathiasrobaert@gmail.com>
Date:   Mon, 12 Aug 2019 13:35:43 +0200
Message-ID: <CAEzhej3+iFPShG-KUKFgGs2LCrdbOMz7pVSSN+Pkz=EqFXkHtQ@mail.gmail.com>
Subject: Re: BlueZ Central to Peripheral latency issue
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        subhoshankar.basu@ugent.be, Jeroen.Hoebeke@ugent.be
Content-Type: multipart/mixed; boundary="000000000000346c78058fe9ed9f"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--000000000000346c78058fe9ed9f
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

Thank you for your reply. Apologies for my late reply back to you, I
was on holiday.

Actually, I'm using Nordic Semiconductor's implementation of IPv6 over
BLE for the 6LoWPAN peripheral node. More specifically, a custom
modified version of the UDP client example
(https://infocenter.nordicsemi.com/topic/com.nordic.infocenter.sdk5.v15.3.0/iot_sdk_app_ipv6_stack_udp_client.html?cp=5_1_4_2_4_10_0_0).
I started from this example, added serial SLIP based communication to
it in order to interact with the BLE application from outside the
board (send/receive payloads, update BLE connection status, etc.) and
allowed the BLE application to send and receive COAP packets by
preconfiguring the correct port and IP address to send to.

The Zephyr example can also suffice to reproduce our problem and so I
adapted the setup to the figure below, to be consistent with the
example (which preconfigures the IP address 2001:db8::1) but also with
what we are trying to achieve in our initial setup. In our initial
setup, we want to make the 6LoWPAN peripheral node part of an existing
IPv6 network, as shown by the figure in the attachment. Therefore, the
6LoWPAN border router acts as a neighbor proxy for the 6LoWPAN
peripheral node towards the existing network. Ultimately, any
application server within the existing network, is capable of sending
and receiving packets to/from the 6LoWPAN peripheral node.

Some configuration steps are required on the gateway/neighbor proxy to
setup the network shown in the figure:
          # Some preconfiguration
sysctl -w net.ipv6.conf.all.forwarding=1 # Enable forwarding
sysctl -w net.ipv6.conf.all.proxy_ndp=1 # Enable as neighbor proxy
modprobe bluetooth_6lowpan # Enable changing of 6lowpan config files
echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable # Enable 6lowpan
on this gateway

echo 6 > /sys/kernel/debug/bluetooth/hci0/conn_min_interval
echo 6 > /sys/kernel/debug/bluetooth/hci0/conn_max_interval

ip addr add 2001:db8::2/64 dev eth0

# Setting up the connection
echo "connect MAC 2" > /sys/kernel/debug/bluetooth/6lowpan_control #
change MAC with actual BLE MAC address

# Add route & neighbor proxy entry
ip -6 neigh add proxy 2001:db8::1 dev eth0  # To enable this gateway
to answer Neighbor Solicitation messages for the 6LoWPAN node
ip -6 neigh add proxy 2001:db8::3 dev bt0 # Normally this is
unnecessary as in our regular setup we use stateless autoconfiguration
to give the peripheral a public IPv6 address and do the exchange with
on-link flag to 0, ensuring that the peripheral
                                                            #  will
always send his packets to his default gateway (the 6LoWPAN gateway)
without performing any Neighbor Discovery. However, using the Zephyr
example with static address, this line is necessary to
                                                            # allow
Neighbor Discovery from the 6LoWPAN peripheral node.
ip route add 2001:db8::1 dev bt0

On the application server, the address should also be configured:
ip addr add 2001:db8::3/64 dev eth0

Unfortunately, I'm not able to configure this setup myself. When
following the steps described here
(https://docs.zephyrproject.org/latest/samples/bluetooth/ipsp/README.html)
to verify if the IPv6 over BLE connection was successfully
established, I'm not able to ping the device. The bt0 interface is
established and the BLE connection is there (checked via hcitool con)
but when pinging the all local-link nodes address on the bt0 interface
(ping6 -I bt0 ff02::1), only the bt0 interface link-local address is
reachable...

Should the setup have been successful, we would have tested the
latency of the connection in the same way as we tested it in our
initial setup: via nping (https://linux.die.net/man/1/nping). Using
the echo server (using port 4242) present on the Zephyr example, we
think this should also work, using this command:
nping -c 1 --delay 500ms -g 1884 -p 4242 2001:db8::1 --udp --data test

This command shows the RTT after completion. In our initial setup,
several runs give very fluctuating values... We could then see were
the fluctuation came from by running the application server &
peripheral on the same device, emulating the setup but getting the
advantage of a shared system time. By looking at the tcpdumps, we
could see that the peripheral to central side is quite stable but the
central to peripheral side is fluctuating. We expect that the same
fluctuation will occur in the simpler setup with Zephyr depicted in
the figure.

So my questions are:
Are you able to setup a working connection with the Zephyr example?
And which BlueZ version do you use for that? We used two different
5.xx versions but no luck. We also tried it with two different boards
(nRF52840 & nRF52832) but no luck either.

If you are able to replicate the setup shown in the figure, do you
also see the fluctuating RTT values when running nping? If yes, is
this something you have encountered before?

Thank you very much for your time.

Kind regards,

Mathias

On Tue, Jul 2, 2019 at 9:22 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Mathias,
>
> On Tue, Jul 2, 2019 at 3:33 PM Mathias Baert <mathiasrobaert@gmail.com> wrote:
> >
> > Hi,
> >
> > We are using the BlueZ 5.48 version on a Raspberry PI with Raspbian Stretch 9.1.
> >
> > The setup is this PI connected with a Nordic Semiconductor nRF52840
> > device, via an IPv6 over BLE connection. The connection is using a
> > connection interval of 7.5 ms. Via throughput measurements with iperf,
> > both ways (central to peripheral and peripheral to central), we are
> > able to achieve maximally ~ 100 kbps (using the 1 Mbps PHY).
> >
> > However, when looking into individual packet exchanges, we notice a
> > significant delay (up to 1 sec) in the RTT when pinging from the
> > peripheral to the BlueZ central and back. We also see a huge
> > fluctuation in this value and it also depends on the intervals at
> > which the pings are fired (lower throughput gives a much higher
> > average individual latency). When firing ping packets at a 1 sec
> > interval, it is definitely visible.
> >
> > When looking into this, we found that the latency between the
> > peripheral and the central is quite stable and low enough. But the
> > latency between the central and peripheral is fluctuating a lot and is
> > generally quite high. Is this something you have noticed before? We
> > think that it could be a scheduling issue on the kernel, where higher
> > throughput gives more priority to Bluetooth communication?
>
> So I assume this is using the experimental IPSP support with Zephyr as
> peripheral? Usually, the Linux side is quite a bit more complex so it
> is not surprising it can take more time but not 1 sec. so it got to be
> something that is causing the extra lag, perhaps you can paste the
> actual commands you are using to ping one another.
>
> --
> Luiz Augusto von Dentz

--000000000000346c78058fe9ed9f
Content-Type: image/png; name="Zephyr_setup.png"
Content-Disposition: attachment; filename="Zephyr_setup.png"
Content-Transfer-Encoding: base64
Content-ID: <f_jz8bkpqx0>
X-Attachment-Id: f_jz8bkpqx0

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
Qhxqtf8PRtDxbN/XBAYAAAAASUVORK5CYII=
--000000000000346c78058fe9ed9f--
