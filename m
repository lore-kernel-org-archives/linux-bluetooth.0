Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050201062510.46102.qmail@web60904.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107182296.7902.11.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Subject: [Bluez-users] rfcomm question 3
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
Date: Tue, 1 Feb 2005 14:25:10 +0800 (CST)

Hi all users!
    I thank Marcel here for help on initializing
connection from mobile to PC. Now, before I can do
that, I initialize the rfcomm connection from PC to
mobile, and then run my project program. The syntax is
as follows:
snprintf (tmp, sizeof (tmp), "t68_remote_v2 (%s)",
modemname);
tmp[sizeof (tmp) - 1] = 0;
openlogfile (tmp, logfile, LOG_DAEMON, loglevel);
set_alarmhandler (alarmhandler, alarmlevel,
modemname);
openmodem ();
setmodemparams ();
But now, when I initialize the connection from mobile
to PC, once I run the program, "/dev/rfcomm0: No such
device" is shown. So, I wish to know how can I modify
the program by changing some syntax from that I post
here? Or is there any program that I can include in my
main program? Thank you very much.
Michael

_______________________________________________________________________
新年願望第一位 : 找到友緣人
http://personals.yahoo.com.hk


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
