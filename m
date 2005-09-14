Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] How 'respond' in BlueZ to a PIN request ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <becc9d2c050914054534d59263@mail.gmail.com>
References: <becc9d2c050914054534d59263@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1126703130.16166.23.camel@station6.example.com>
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
Date: Wed, 14 Sep 2005 15:05:30 +0200

Hi Andrea,

> if i set my usb dongle in authentication mode
> (hciconfig hci0 auth) and connect to my bluetooth phone, 
> (hcitool cc BTADDR)  the phone  ask me for the pin of my pc, 
> and after i ve entered correctly, the connection i created.
> 
> My question is: how can i control the same thing on my
> bluez pc ? If i do the same (hcitool cc BTADDR) to connect
> another pc instead of my phone no PIN is requested and
> create connection fails! 
> 
> I need to know this beacause i need to write a simple program
> that listen for l2cap connection on a socket, GIVE THE PIN, and
> allows the connection to be estabilished.

if you talk about L2CAP then you don't use security mode 3, which is
activated after "hciconfig hci0 auth". You should only do this when you
really know what you are doing. The same applies to "hcitool cc ...",
because this is a testing and should not be used at all.

The L2CAP has options to require authentication and encryption. You
should look at the l2test code for an example.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
