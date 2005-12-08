Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC IVT USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43983410.5010701@rambler.ru>
References: <43982224.6020208@rambler.ru> <1134044091.3752.87.camel@blade>
	 <43982BAC.2030508@rambler.ru> <1134047622.3752.89.camel@blade>
	 <43983410.5010701@rambler.ru>
Content-Type: text/plain
Message-Id: <1134049860.3752.96.camel@blade>
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
Date: Thu, 08 Dec 2005 14:51:00 +0100

Hi Pavel,

> > Check what "hciconfig -a" says and if hcid is running.
> 
>   It reported that hci0 is in DOWN state. After hciconfig hci0 up everything worked fine! Thank you 
> very much!
>   In fact you saved my work. Windoze implementation doesn't work with RFCOMM. Just doesn't, noone 
> knows why. Of course i expect Linux to work pretty well.

please post the output of "hciconfig -a" and "lsusb".

>   BTW, how to set up my system then to bring up hci0 automatically?

Make sure that hcid is running. Normally this is done by an init script.

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
