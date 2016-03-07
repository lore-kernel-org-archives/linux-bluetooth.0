Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <56DDD109.5040701@prudentl.com>
Date: Mon, 07 Mar 2016 14:05:45 -0500
From: Ron Harding <ron@prudentl.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez LE: Unable to get readings from LE devices
In-Reply-To: CABBYNZJ=smBb3mjvidmx+0FNqx6OLHpt-jzOcCKuO91hxdg-VQ@mail.gmail.com
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> 'No bonding' is used when the device is performing a
> Secure Simple Pairing procedure, but does not intend to retain the link key
> after the physical link is disconnected.
>
> I would keep the policy of not redoing the pairing automatically in
> case of missing link key error but perhaps the agent shall be called
> in such case and then depending on the response start a new pairing,
> so we keep this policy in the agent. Nevertheless it is still a good
> idea to set the "No bonding' value in case you want to avoid this
> extra steps while reconnecting.

Your explanation of how the "PIN or Key Missing" status could arise matches what I thought might be happening.

But I'm having trouble figuring out how to implement your suggested fix.  I know "No Bonding" is one of the values
that can be specified in the AuthReq field of a pairing request.  But I don't see how I, as a user of BlueZ, can
tell it to do so.  There doesn't seem to be anything in either org.bluez.Device1 or org.bluez.Agent1 for it.

I think maybe you're suggesting that the LE device it should be specifying "No Bonding".  If it's not going to
store the Link Key, then indeed it probably should.  But unfortunately we can't change that: we don't make the device.

- Ron

