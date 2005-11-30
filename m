Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2 Successive OBEX Connect Request
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051130064037.90802.qmail@web32412.mail.mud.yahoo.com>
References: <20051130064037.90802.qmail@web32412.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1133332988.18079.1.camel@blade>
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
Date: Wed, 30 Nov 2005 07:43:08 +0100

Hi Arch,

> I would like to ask the implications on BlueZ whenever a Bluetooth
> device issues 2 Successive OBEX Connect Requests. This was done
> without any OBEX Disconnect Request after the first Connect Request.
> This is how the new Samsung D600 phone is doing a Bluetooth
> transaction when you're doing a Bluetooth printing.

include "hcidump -X -V" to show what's going on there.

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
