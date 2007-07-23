Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <1185197769.46a4aec9d9dee@webmail.epfl.ch>
Date: Mon, 23 Jul 2007 15:36:10 +0200
From: steve.morard@epfl.ch
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Use /dev/ttyS* instead of /dev/rfcomm*
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello !

I would like to know if it is possible to use /dev/ttyS* instead of /dev/rfcomm*
to connect to a bluetooth device.
Indeed I tried :

rfcomm connect /dev/ttyS2 xx:xx:xx:xx:xx:xx

But I get  :

Connected /dev/rfcomm0 to xx:xx:xx:xx:xx:xx on channel 1

Any help would be appreciated

Thanks





-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
