Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: How to emulate slave serial ports ?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20041110T091344-899@post.gmane.org>
References: <4190FB84.1040000@eidosspa.it>
	 <1100023997.6866.16.camel@pegasus>
	 <loom.20041110T091344-899@post.gmane.org>
Content-Type: text/plain
Message-Id: <1100078284.25879.61.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Nov 2004 10:18:04 +0100

Hi Davide,

> On the linux machine now I have a program that opens the serial device (and
> keeps it opened), periodically polls it for incoming requests, and eventually
> responds to the requests.

I don't understand this. Show me that program.

> I wish to substitute this physical RS232 line with a bluetooth connection,
> without changing the Windows software on the PC (and the software on the
> target), except for the device names. Is it possible ?

It is possible, but I still don't know what you really wanna do. Replace
some serial port is not a detailed description.

> Which bluez tools should I run on the init script ?

Besides hcid and sdpd, nothing more. But you must write a program that
accepts connections on RFCOMM and that also registers a service record
for your serial port.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
