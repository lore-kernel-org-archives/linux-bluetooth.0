Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030424153831.1040bb30@unixmail.qualcomm.com>
Date: Thu, 24 Apr 2003 15:42:44 -0700
To: David Woodhouse <dwmw2@infradead.org>, Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-users] Re: [Bluez-devel] DB aliases (wishlist)
Cc: Paul Hedderly <bulkpaul@mjr.org>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1049874960.31462.20.camel@passion.cambridge.redhat.com>
References: <1049751844.11258.31.camel@pegasus.local>
	<20030404072437.GD8317@wacka.mjr.org>
	<1049751844.11258.31.camel@pegasus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 12:56 AM 4/9/2003, David Woodhouse wrote:
>On Mon, 2003-04-07 at 22:43, Marcel Holtmann wrote:
>> So this is a basic request to all of you. What do you want to see in the
>> next version of the BlueZ utils?
>
>Link key management.
>
>hcitool lk list [<dev>|<bdaddr>] [<bdaddr>]
>hcitool lk remove [<dev>|<bdaddr>] <bdaddr>...
>hcitool lk add [<dev>|<bdaddr>] <bdaddr> <key>
>hcitool lk merge <filename>
>
>See xauth :)
>
>I'm tired of manually copying link keys from /etc/bluetooth/link_key
>from one machine to another when I move the CF Bluetooth card. I want to
>be able to 'hcitool lk list | ssh ipaq hcitool lk merge -' ;)
>
>OK, so buying another card would also help, but even so we do need at
>least the 'hcitool lk remove' functionality and 'lk list' would be very
>useful too.
>
>As previously discussed, it would be nice if non-root users could see
>the results of 'lk list' without the actual keys -- basically just a
>list of devices with which we're paired.
Yep. I had something similar in mind.

>/etc/bluetooth/paired_devices and /etc/bluetooth/paired_devices.shadow, anyone? :)
        /etc/bluetooth/
                neighbours (world readable) - <bdaddr>, <name>, <last seen>, etc
                security                    - <bdaddr>, <pin code>, <link key>


Max
 
