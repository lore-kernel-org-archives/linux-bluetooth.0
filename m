Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Royaltek BlueGPS
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050504051342.27003.qmail@web52402.mail.yahoo.com>
References: <20050504051342.27003.qmail@web52402.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1115191263.8496.71.camel@pegasus>
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
Date: Wed, 04 May 2005 09:21:02 +0200

Hi Jose,

> Anyone worked/working with Royaltek BlueGPS (Bluetooth
> GPS Receiver).
> 
> I want to know, how to connect the BlueGPS,from Linux,
> through serial port, and get the data. 

run "sdptool search --bdaddr <bdaddr> sp" to find the RFCOMM channel
that is used by the BlueGPS unit. I expect that it will be channel one.
Then call "rfcomm bind 0 <bdaddr> 1" and after that point your GPS
software to /dev/rfcomm0 and you are ready to go.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
