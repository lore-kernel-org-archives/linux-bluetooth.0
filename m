Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth 2.0 EDR new SCO and ACL packets
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050209123431.60154.qmail@web41110.mail.yahoo.com>
References: <20050209123431.60154.qmail@web41110.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1107953404.13863.22.camel@pegasus>
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
Date: Wed, 09 Feb 2005 13:50:04 +0100

Hi Sean,

> I am intending to write applications to take advantage
> of the new Bluetooth 2.0 EDR throughput. I have got a
> couple of questions that I can't seem to find through
> the mailing list.
> 
> 1. Since there are new packets with the new Bluetooth
> spec, will we just have to type in the command through
> hcitool to use the new packets (eg. hcitool -i hci0
> -cpt <Target Bluetooth Address> <New ACL packet
> acronym>?

that is wrong and actually you should re-read that part of the EDR
specification. Setting the new packet types disable them.

The EDR stuff works out of the box. I already verfied that.

> 2. I seem a bit confused about the usage of the 'PAN'
> profile with the new Bluetooth spec. How does the
> BlueZ 'PAN' take advantage of the new throughputs?
> Will we just have to modify the packets like 'question
> 1' via hcitool and immediately all IP applications
> over Bluetooth will take advantage of the new
> throughputs? Or does the BlueZ 'pan' itself behave
> differently upon Bluetooth 2.0 EDR?

You don't have to do anything. Simply use two EDR capable devices.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
