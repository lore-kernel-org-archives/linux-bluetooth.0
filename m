Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Davide Rizzo <rizzo@eidosspa.it>
Message-ID: <loom.20041110T091344-899@post.gmane.org>
References: <4190FB84.1040000@eidosspa.it> <1100023997.6866.16.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: How to emulate slave serial ports ?
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
Date: Wed, 10 Nov 2004 08:28:51 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> the question is what do you wanna do with the serial port on your
> machine? If you know that, then look for a profile that fits and use
> that program or write your own one.
> 
> Regards
> 
> Marcel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> 

Hi Marcel,
On the linux machine now I have a program that opens the serial device (and
keeps it opened), periodically polls it for incoming requests, and eventually
responds to the requests.
I wish to substitute this physical RS232 line with a bluetooth connection,
without changing the Windows software on the PC (and the software on the
target), except for the device names. Is it possible ?
Which bluez tools should I run on the init script ?
Thanks
Davide



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
