Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT test mode operation
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de46576041124081140dc74b7@mail.gmail.com>
References: <2de46576041124081140dc74b7@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1101314675.27351.126.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 24 Nov 2004 17:44:35 +0100

Hi Manjunath,

> can i configure my bt dongles to operate in test mode....and then
> conduct the loopback or transmitter tests. This is indicated in the
> HCI part of the specification....so is it possible to run these tests
> just with BT devices connected to host PC's,  and not using a BT
> protocol analyser.

you can set your devices into test mode with the correct HCI command. I
think you need to use "hcitool cmd ..." for that, because I never tried
or implemented support for it.

What has this to do with a protocol analyzer?

> If i buy a BT tester, then wouldn't my BT dongle be the DUT....
> Also, if i buy a CATC-tracer/trainer, should I again buy a BT tester????

Actually what do you mean by BT Tester?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
