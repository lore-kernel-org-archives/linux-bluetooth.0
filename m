Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] A blue chamaleon to be
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <op.s1tiptlkxabado@portatilegio>
References: <op.s1tgc9j9xabado@portatilegio>
	 <1134636788.5198.42.camel@localhost>  <op.s1tiptlkxabado@portatilegio>
Content-Type: text/plain
Message-Id: <1134638529.11856.1.camel@localhost>
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
Date: Thu, 15 Dec 2005 10:22:08 +0100

Hi,

> > send in the output of "hcidump -X -V" while you are doing this.
> 
> thank you very much for you asnwering.
> Here it is my output
>
> > HCI Event: Link Key Request (0x17) plen 6
>      bdaddr 00:0A:28:0C:D4:EF
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>      bdaddr 00:0A:28:0C:D4:EF
> > HCI Event: Command Complete (0x0e) plen 10
>      Link Key Request Negative Reply (0x01|0x000c) ncmd 1
>      status 0x00 bdaddr 00:0A:28:0C:D4:EF
> > HCI Event: PIN Code Request (0x16) plen 6
>      bdaddr 00:0A:28:0C:D4:EF
> < HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
>      bdaddr 00:0A:28:0C:D4:EF
> > HCI Event: Command Complete (0x0e) plen 10
>      PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
>      status 0x00 bdaddr 00:0A:28:0C:D4:EF

look like the PIN helper program is not working and so hcid can't input
the PIN code at all. Check your syslog about any errors from hcid.

What version of bluez-utils is installed?

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
