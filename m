Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dick@mrns.nl>
Date: Mon, 27 Aug 2007 19:54:22 +0000 (UTC)
Message-ID: <loom.20070827T214917-305@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-users] stale connections with input service (bluez-libs-3.15
	/ linux 2.6.22)
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

Hi,

An update on the stale connections with the new input service.

Linux 2.6.23 didn't help much, it seemed even less stable. I still have the
"stale" connections but it seems I can work around it be calling hciconfig hci0
reset until hcitool con gives me:

'Connections:
'        > ACL 00:07:61:68:XX:XX handle 49 state 1 lm MASTER AUTH ENCRYPT 
'        > ACL 00:07:61:69:XX:XX handle 46 state 1 lm MASTER 

Sometimes the connection is:
'        > ACL 00:07:61:69:XX:XX handle ?? state ? lm SLAVE

Which gives me a working mice but the dinovo won't connect.

When I do a hciconfig hci0 reset (again) the connections come back OK.

I hope this will give someone a clue to write a fix :)

Dick


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
