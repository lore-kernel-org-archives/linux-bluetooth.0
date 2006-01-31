Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth with Latitude X1
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200601310012.39402.arthur.breitman@gmail.com>
References: <200601310012.39402.arthur.breitman@gmail.com>
Content-Type: text/plain
Message-Id: <1138731692.3968.5.camel@localhost.localdomain>
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
Date: Tue, 31 Jan 2006 19:21:32 +0100

Hi Arthur,

> I already asked questions about this, without any success. I am retrying.
> Here are the informations.
> I have a Dell Latitude X1 Notebook. Bluetooth works flawlessly on windows and 
> is reported to work fine on this notebook on the internet.
> I believe I have installed and loaded all the necessary modules.
> 
> if I set my mobile phone in discovery mode and starts a scan on the laptop:
> 
> arthurb@coin:~$ sudo hcidump  -V -X
> HCI sniffer - Bluetooth packet analyzer ver 1.28
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>     lap 0x9e8b33 len 8 num 0
> > HCI Event: Command Status (0x0f) plen 4
>     Inquiry (0x01|0x0001) status 0x00 ncmd 1
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00

since this is a CSR chip, call "hcidump -X -V -m 10" and see what it
tells you when you scan again.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
