Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm question 3
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050201062510.46102.qmail@web60904.mail.yahoo.com>
References: <20050201062510.46102.qmail@web60904.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1107245676.8848.27.camel@pegasus>
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
Date: Tue, 01 Feb 2005 09:14:36 +0100

Hi Michael,

>     I thank Marcel here for help on initializing
> connection from mobile to PC. Now, before I can do
> that, I initialize the rfcomm connection from PC to
> mobile, and then run my project program. The syntax is
> as follows:
> snprintf (tmp, sizeof (tmp), "t68_remote_v2 (%s)",
> modemname);
> tmp[sizeof (tmp) - 1] = 0;
> openlogfile (tmp, logfile, LOG_DAEMON, loglevel);
> set_alarmhandler (alarmhandler, alarmlevel,
> modemname);
> openmodem ();
> setmodemparams ();
> But now, when I initialize the connection from mobile
> to PC, once I run the program, "/dev/rfcomm0: No such
> device" is shown. So, I wish to know how can I modify
> the program by changing some syntax from that I post
> here? Or is there any program that I can include in my
> main program? Thank you very much.

if you wanna connect from a mobile phone to a machine running BlueZ you
need to write an application that listens on a RFCOMM channel. This is
about socket programming and you convert this socket later in to a TTY
with a /dev/rfcommX device node, but actually unless you have some
legacy application like pppd this should not be needed. What you need is
to do direct socket programming. It is as easy as using a TTY and I
posted detailed information about how to change a TTY based program into
a socket based program years ago. Check the mailing list archive.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
