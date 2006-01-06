Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Karl H. Beckers" <karl.h.beckers@gmx.net>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1136542299.20156.12.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] repairing required after each dialup
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
Date: Fri, 06 Jan 2006 11:11:39 +0100

Hi all,

is there somebody around who uses a SE k700i for dialup?

I have this effect where I can only dial if I do:

- remove computer from list in mobile phone
- rfcomm connect /dev/rfcomm0 .... 1
	(repairing here)
- ifup ppp0

After every disconnect (pppd drops the connection of I press CTRL-C with
rfcomm) I need to repeat this or else will get "Connection refused" from
rfcomm connect (and it took me a while to find this workaround).

Can anybody comment on whether this is a known issue with either rfcomm
or the k700i, if so with which, and whether there's a fix (fw upgrade
perhaps).

Or are there any other things I should look at?

TIA,

Karl.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
