Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] About Ipaq and Nokia phone
From: Marcel Holtmann <marcel@holtmann.org>
To: Lan Zhang <Lan.Zhang@Zoran.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E65CD2CAB74C80498703D6EF7624BB4C4ACABC@zmaex.zma.zoran.com>
References: <E65CD2CAB74C80498703D6EF7624BB4C4ACABC@zmaex.zma.zoran.com>
Content-Type: text/plain; charset=iso-8859-13
Message-Id: <1080687489.2773.41.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 31 Mar 2004 00:58:09 +0200

Hi Lan,

> I have an ipaq and Nokia 3650 phone; I try to use both of them with my
> linux box. I download bluez packet and obex packet, before I make any
> connect or pair, both of them can find my linux, and each of them can
> setup a connection with the linux Bluetooth. But they cannot work
> together. The problem is the Nokia phone cannot find the Bluetooth
> device after the ipaq connected to LAN access point. Before the ipaq
> connect to LAN access over ppp, the phone can find my linux Bluetooth
> device, and it can use the sdp service which provided. But after the
> ipaq connected to the linux; the phone will not able to look this
> Bluetooth device anymore. I didn=FFt try to pair these two; I just try
> to search the Bluetooth around the phone. And if I disconnect the
> ipaq, then the phone can find it again. So dose it support multiple
> connections?=20

what does "hciconfig -a" say?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
