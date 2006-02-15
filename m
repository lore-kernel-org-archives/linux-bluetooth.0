Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Agustin Jose Fusaro <afusaro@apexar.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200512021834.19314.mgorbach@yahoo.com>
References: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>
	 <200512021834.19314.mgorbach@yahoo.com>
Content-Type: text/plain
Message-Id: <1140037472.3336.5.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Cannot compile bluez-utils-2.25
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
Date: Wed, 15 Feb 2006 18:04:31 -0300

Hi everybody,

I'm having trouble installing the bluez-utils-2.25 package. I've already
installed the bluez-libs-2.25 package without any problem, but now, when
I try to ' make ' the new utils I get an undefined reference to
`dbus_connection_close' error in file dbus.c. It seems not to be defined
in this file.

Has anybody had this problem?

By the way, I've been working with the bluez library and utils (2.22)
for a while and had some strange problems (rfcomm mostly)... so I just
wanted to make sure that I have the latest version before making further
questions.

Thanks a lot!

Agustin Fusaro



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
