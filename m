Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with MS mouse and keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Gareth Reakes <gareth@apache.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031126131925.M25686@minotaur.apache.org>
References: <20031105093947.J63252@minotaur.apache.org>
	 <1068072643.1284.106.camel@pegasus>
	 <20031105150230.T694@minotaur.apache.org>
	 <20031122040102.E53230@minotaur.apache.org>
	 <1069532556.16350.82.camel@pegasus>
	 <20031122124825.T53230@minotaur.apache.org>
	 <20031126131925.M25686@minotaur.apache.org>
Content-Type: text/plain
Message-Id: <1069882659.9032.54.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 26 Nov 2003 22:37:40 +0100

Hi Gareth,

> I was really hoping it was not going to work. Unfortunately it does :( I
> would really appreciate any help in sorting this out. I have rebuilt and
> installed the bluez modules against my patched 2.4.22 kernel and all is
> the same. The output from the 0.8 bthid is:
> 
> Nov 26 21:05:34 zebedee bthid[1747]: Serving Bluetooth HID at BD
> 00:50:F2:E2:EB:E6
> Nov 26 21:06:26 zebedee bthid[1753]: Bluetooth HID daemon by Peter
> Klausler <pmk@cray.com>
> Nov 26 21:06:26 zebedee bthid[1754]: attempting connection to BD
> 00:50:F2:E2:EB:E6
> Nov 26 21:06:27 zebedee bthid[1754]: L2CAP socket 5 connected to BD
> 00:50:F2:E2:EB:E6 PSM 1
> Nov 26 21:06:28 zebedee bthid[1754]: L2CAP socket 6 connected to BD
> 00:50:F2:E2:EB:E6 PSM 17
> Nov 26 21:06:28 zebedee bthid[1754]: L2CAP socket 7 connected to BD
> 00:50:F2:E2:EB:E6 PSM 19
> Nov 26 21:06:28 zebedee bthid[1754]: Serving Bluetooth HID at BD
> 00:50:F2:E2:EB:E6
> Nov 26 21:06:28 zebedee bthid[1754]: device: Wireless IntelliMouse
> Explorer for Bluetooth
> Nov 26 21:06:28 zebedee bthid[1754]: made by Microsoft
> Nov 26 21:06:28 zebedee bthid[1754]: device version 1.0
> Nov 26 21:06:28 zebedee bthid[1754]: is virtually cabled
> Nov 26 21:06:28 zebedee bthid[1754]: will initiate reconnections
> Nov 26 21:06:28 zebedee bthid[1754]: is battery-powered
> Nov 26 21:07:15 zebedee bthid[1754]: vendor HID usage 0xff00fe01 value 0x1
> Nov 26 21:07:15 zebedee bthid[1754]: adequate battery on Wireless
> IntelliMouse Explorer for Bluetooth
> Nov 26 21:17:40 zebedee bthid[1754]: EOF on Interrupt channel
> 
> 
> After the EOF on interrupt channel it will not reconnect. If there is a
> bthid -l listening then 100% of the CPU is consumed. I have cvs checked
> out and am happy to put debug in etc to find out the problem and
> hopefuly get this working.

this is the implementation from Peter and I can't help you with it. I
have only used it once.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
