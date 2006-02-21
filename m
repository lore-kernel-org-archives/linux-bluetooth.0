Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Agustin Jose Fusaro <afusaro@apexar.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200512021834.19314.mgorbach@yahoo.com>
References: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>
	 <200512021834.19314.mgorbach@yahoo.com>
Content-Type: text/plain
Message-Id: <1140559259.11852.4.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Connection attempt timeout
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
Date: Tue, 21 Feb 2006 19:00:59 -0300

Hi everybody,

I'm developing an application using the bluetooth libraries provided by
Marcel. I'm working with rfcomm connections. After looking at the
function cmd_connect (in the file 'main.c',in the rfcomm directory of
the bluez-utils-2.25) I realized that (using this function) there's no
way to set the connection attempt timeout (the time the connection
attempt will last if the remote device is, for example, turned off).

My question is, Is there a way to set this time? (maybe using the
properties of the sockets involved in this connection)

If anyone knows this answer, it'd be great!

Thanks very much!

Agustin Fusaro - Apexar Technologies



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
