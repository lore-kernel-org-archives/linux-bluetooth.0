Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: Re: [Bluez-users] repairing required after each dialup
From: Marcel Holtmann <marcel@holtmann.org>
To: "Karl H. Beckers" <karl.h.beckers@gmx.net>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1136566815.17866.2.camel@localhost.localdomain>
References: <1136566815.17866.2.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1136576435.17973.1.camel@localhost>
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
Date: Fri, 06 Jan 2006 20:40:35 +0100

Hi Karl,

> attached you'll find the dumps of:
> 1) me doing "ifdown ppp0" which for some reason also quits rfcomm
> (hcidump-drop-conn.txt)
> 2) me trying "rfcomm connect 0" again and getting "Connection refused"
> (hcidump-conn-refused.txt)
> 3) same thing this time after deleting the laptop from the phone's list
> before trying the connect
> (hcidump-conn-repaired.txt)

this really looks like a bug in the phone for me. You might wanna ask
them for a firmware update.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
