Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: How to emulate slave serial ports ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20041110T131444-132@post.gmane.org>
References: <4190FB84.1040000@eidosspa.it>
	 <1100023997.6866.16.camel@pegasus>
	 <loom.20041110T091344-899@post.gmane.org>
	 <1100078284.25879.61.camel@pegasus>
	 <loom.20041110T103214-10@post.gmane.org>
	 <1100080758.25879.66.camel@pegasus>
	 <loom.20041110T131444-132@post.gmane.org>
Content-Type: text/plain
Message-Id: <1100094365.10067.2.camel@notepaq>
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
Date: Wed, 10 Nov 2004 14:46:05 +0100

Hi Davide,

> I solved (almost) all problems !
> 
> The correct solution is:
> 
> hciconfig hci0 up
> hcid
> sdpd &
> sdptool add SP
> rfcomm listen /dev/rfcomm0 &
> 
> ... and now the program on the target can use /dev/rfcomm0 exactly like
> before it worked with /dev/TTYSACx !

no it is not. This is only a workaround. Change your program to use a
socket descriptor instead of a TTY descriptor and handle the incoming
connection request and the SDP service registration by yourself.

> The only problem is that rfcomm exits when windows closes the connection,
> so I need to run it again to be ready to listen for the next connection.
> But this is a minor problem, I'll investigate in the rfcomm code to get the
> parts I need, so I'll be able also to understand if the connection is on or
> not.

As I said, it is only a workaround.

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
