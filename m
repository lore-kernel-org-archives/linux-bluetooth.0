Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C94C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 16:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E67E206B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdHjFmRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfAJQsF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:48:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46683 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbfAJQsE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 11:48:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12122930wrt.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jan 2019 08:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pbYepxF85BmhMFRdCpMczn8lfgb5k2x1NOD6HAWWBlo=;
        b=mdHjFmRl2b56tMq2MleMh0POq2wA1vXuPHYxRQlmfvXrQ1JW4tJ0MbVSLXsHNX9gM2
         Ecfp1LBm6TQ34CknYaUL/JWGSlfjCEZ+WwzhUmZhASB/A5HszzcPgOeKH9hfzt5q2cNH
         dNPx3++LuouBlicYrqOYVEfluHYLBnAn4Xsf+I2eRQ4sVIIKavzoEYEA2VRVnBaB1IO4
         yHrD4yZM/pvLn5aVl2MDOLqWQPu1x7nM+v/x1lQtz03X+xSyp7fbdeZ2ZADkX1lk8MbX
         NCnKVlnFfRca+i77ZBaz+2il2INP3w+PHBD+hNfBlQahLB4SQoxR1yZyyOUBg0kOxtsH
         CsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbYepxF85BmhMFRdCpMczn8lfgb5k2x1NOD6HAWWBlo=;
        b=cXO3BddEpAn+NdsXXkr9siI7SNyzhpGMCKzv8MnxnOu/w2g2DzXF6aFozmg6WtrGAh
         V/897WlZbcADzT33agzyWWI4D7oFcq02629o22qlN7gk6zn0+R1SYagNK8Ea0OCgHliO
         QqBloXEJ2LSSVxjgh041bovgn3+G4gOm9UTaSItxkC4upYczcebaYRd9tCuNhJ8bQ17+
         Fv/nAOVWQCqyShi+yWvowwECRw65Q5mXZrs28yr6A7E5Ecb9f00wwvO4JlVLc73gKGP2
         XbwJHCyVrtaWs/eoiHNGNlivDf8nO68XAAZoqY9J+CJZql3tFU57wYK8q1oln4o4eQtX
         B+0A==
X-Gm-Message-State: AJcUukcoOQ9k/WIzAXXTu+nKJ/rWSoEzCbazdq43j7IZ+nDbR+uAK5IH
        OAt8k4MR1swnuHi9PcqA4n347BEV
X-Google-Smtp-Source: ALg8bN7aPGCtcexVouXatJZ4SSK57hWw1BHZ0OErA3xOQ1R0mVsAE7raz2ggiSKSABsVjhnMfXeZ8g==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr10616411wrr.39.1547138881309;
        Thu, 10 Jan 2019 08:48:01 -0800 (PST)
Received: from [192.168.2.164] (p5B08A983.dip0.t-ipconnect.de. [91.8.169.131])
        by smtp.gmail.com with ESMTPSA id 3sm19176456wmw.46.2019.01.10.08.48.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 08:48:00 -0800 (PST)
Subject: Re: Multiple peers with bluetooth_6lowpan
References: <b0665aa8-4bfb-4ec8-3f7f-deb2bf5ea61a@gmail.com>
To:     linux-bluetooth@vger.kernel.org
From:   Josua Mayer <josua.mayer97@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=josua.mayer97@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d36c145a-02a2-a9b2-a4b0-68e275d74958@gmail.com>
Date:   Thu, 10 Jan 2019 17:48:00 +0100
MIME-Version: 1.0
In-Reply-To: <b0665aa8-4bfb-4ec8-3f7f-deb2bf5ea61a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Good day once more,

I have now identified a chain of calls leading up to the described
issue, along with a work-around:

The first step was discovering fishy debug messages in dmesg:
[  235.505517] Connecting to first module while both are powered
[  237.394085] ifindex 5 peer bdaddr 00:b1:fc:8c:6e:47 type 1 my addr
a4:d5:78:11:cf:6f type 1
[  241.872089] dest IP fe80::b1:fcff:fe8c:6e47
[  241.872104] peers 1 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  241.872124] xmit bt0 to 00:b1:fc:8c:6e:47 type 1 IP 6800::600 chan
(ptrval)
[  242.356387] Connecting to second module
[  244.073592] dest IP fe80::b1:fcff:fe8c:6e47
[  244.073603] peers 2 addr fe80::b1:fcff:fe8c:6e47 rt   (null)
[  244.073607] no such peer

We can see here how the first module is connected, and packets to its
link-local address are being transmitted.
Then the second module is connected and the number of peers updates to 2.
Now we have another packet for the first modules link-local address. We
know there are 2 peers, but for some reason we get a message saying "no
such peer"!

Luckily this message was easy to trace:
See net/bluetooth/6lowpan.c:setup_header
This message is a direct result of a previous call to peer_lookup_dst
returning null.
Now while reviewing peer_lookup_dst, keep in mind that we are looking
for a difference in behaviour when there is one, and when tehre are at
least two peers.
Let me just quote here:
if (count == 1) {
peer = list_first_or_null_rcu(&dev->peers, struct lowpan_peer, list);
return peer;
}

If there is only one peer, no checks are performed at all, it is simply
assumed that this peer mist be the one to receive packets for the given
address.
So this is the one peers, or one module connected case - which works
just fine.

Then follows a curious case that I do not fully understand:
if no route is known, and no gateway was specified in packet data, do
not even search for the right peer, simply return 0:
if (!rt) {
nexthop = &lowpan_cb(skb)->gw;

if (ipv6_addr_any(nexthop))
return NULL;
}
^^ I believe this decision is wrong.
There might be neither route nor gateway, if the destination is a peer.

I have come up with the following work-around:
-		nexthop = &lowpan_cb(skb)->gw;
-
-		if (ipv6_addr_any(nexthop))
-			return NULL;
+		if (ipv6_addr_any(&lowpan_cb(skb)->gw)) {
+			/* There is neither route nor gateway,
+			 * probably the destination is a direct peer.
+			 */
+			nexthop = daddr;
+		} else {
+			/* There is a known gateway
+			 */
+			nexthop = &lowpan_cb(skb)->gw;
+		}
I am submitting this patch as separately as:
[RFC] bluetooth_6lowpan: search for destination address in all peers
It is by no means finished and meant to illustrate the core issue, and
allow for a discussion around the control logic, and purpose of
Please comment if I have understood the purpose of the peer_lookup_dst
function.
I might even suggest removing the special handling of one peer ... .

Yours sincerely
Josua Mayer


Am 08.01.19 um 19:57 schrieb Josua Mayer:
> Greetings everybody,
> 
> I want to present to you an issue I am having the 6LoWPAN over BLE
> facility in the kernel.
> I have reached the point where I don't know where, what and how to debug
> the situation and am hoping for some advice here:
> 
> First an overview of the setup:
> 1. an SBC with BLE capable Bluetooth chip
> 2. multiple Nordic nRF52840 modules
> 
> This is the problem I have observed:
> 1. One Nordic module is powered - SBC connects to it
> --> ping6 works flawlessly till the module restarts
> --> communication with the remote server works as expected
> 
> 2. Two Nordic modules are powered - SBC connects only to one at a time
> --> ping6 works flawlessly till the module restarts
> --> communication with the remote server works as expected
> 
> 3. Two Nordic modules are powered - SBC connects to both
> --> ping6 receives no more replies as soon as the second module is connected
> --> communication to the remote server stops as soon as the second
> module is connected
> 
> Test Case:
> rfkill unblock 0
> modprobe bluetooth_6lowpan
> echo -n 'module bluetooth_6lowpan +p' >
> /sys/kernel/debug/dynamic_debug/control
> 
> while true; do ping6 -c 1 -I bt0 fe80::b1:fcff:fe8c:6e47 || true; sleep
> 1; done
> 
> echo "Connecting to first module while both are powered" > /dev/kmsg
> echo "connect 00:B1:FC:8C:6E:47 1" >
> /sys/kernel/debug/bluetooth/6lowpan_control
> # sit back and watch pings till module restarts
> echo "Connecting to first module while both are powered" > /dev/kmsg
> echo "connect 00:B1:FC:8C:6E:47 1" >
> /sys/kernel/debug/bluetooth/6lowpan_control
> # wait till first ping goes through
> echo "Connecting to second module" > /dev/kmsg
> echo "connect 00:39:D3:29:92:1C 1" >
> /sys/kernel/debug/bluetooth/6lowpan_control
> # Expected: ping6 continues to receive replies
> # Actual result: ping6 times out
> 
> Please see attached dmesg.log from this test case, with dynamic
> debugging enabled for module bluetooth_6lowpan.
> 
> The Nordic modules are programmed to advertise themselves for
> establishing a connection; Then they start communication with a server
> on the internet over ipv6. Finally they are rebooted by a watchdog.
> While a module is connected, it can be pinged by its link-local address
> which is derived from its MAC address and thereby known.
> 
> As you may have noticed I just wrote "SBC" above.
> That is because I have done this experiment with 3 different SBCs:
> 1. SolidRun HummingBoard with i.MX6 uSOM Revision 1.5
> features Ti WL18MODGB combined WiFi and Bluetooth module
> - linux-image-4.20.0-trunk-armmp_4.20-1~exp2_armhf.deb
> (+BT_HCIUART=m, +BT_HCIUART_LL=y, +DYNAMIC_DEBUG=y)
> ^^ This system was used to produce the attached dmesg.log
> 
> 2. RaspberryPi 3B
> 3. RaspberryPi 3B+
> - rpi-4.15.y (from their github)
> - rpi-4.16.y (from their github)
> - rpi-4.17.y (from their github)
> - rpi-4.18.y (from their github)
> - rpi-4.19.y (from their github)
> - rpi-4.20.y (from their github)
> bcm2709_defconfig
> zImage modules dtbs -j12
> gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf
> 
> rpi-4.14.y suffers from a busy kworker (Workqueue: hci0 hci_rx_work
> [bluetooth]) making tests difficult.
> 
> Supposedly back in 4.4.8-v7 on raspberrypi this issue with multiple
> peers did not exist, while the busy kworker did pop up after time
> requring a reboot.
> I did not verify or test with that rather old version yet.
> Would it be a good idea to start from that 4.4.8 rpi fork working up to
> 4.15 to find the place where it broke? I feel like this kind of work is
> difficult
> when forks are involved.
> 
> Are there any components of the kernel in particular that could be verified
> in order to figure out what is going wrong?
> 
> 
> Yours sincerely
> Josua Mayer
> 
