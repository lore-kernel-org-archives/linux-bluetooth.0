Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Re: Lifetech BlueConnect DOES NOT work with
	bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000e01c4cd7d$f2c02020$2c00a8c0@DISCO17G>
References: <000e01c4cd7d$f2c02020$2c00a8c0@DISCO17G>
Content-Type: text/plain
Message-Id: <1103127746.8717.11.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 15 Dec 2004 17:22:26 +0100

Hi Carlos,

for what is the blue background good? This is a mailing list and not a
beauty contest ;)

> No, this dongle has a SiliconWave chipset. This chipset implements the
> 1.2 spec, but Bluez implements 1.1 only. Specifically, on the 1.2 spec
> the Add SCO Connection is deprecated and indicated as 'not to be
> used'. The Bluez code (net/bluetooth/hci_conn.c) uses that command to
> start a SCO voice connection to a headset. I'm suspecting that the
> dongle doesn't implement the Add SCO command properly and causes my
> problems. But nevertheless a 1.2 spec device is not required (and is
> even discoraged) to implement it.

Now we are talking about SCO support? You complained that your dongle is
not working at all.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
