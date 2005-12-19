Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] encrypt problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <9c68c0a70512182353u6028f3abw@mail.gmail.com>
References: <9c68c0a70512182353u6028f3abw@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134986709.24233.10.camel@localhost>
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
Date: Mon, 19 Dec 2005 11:05:09 +0100

Hi,

> I install bluez on my arm board(super2410). And I want my Nokia 6670
> to
> connect to my arm-linux with a bluetooth adaptor. Since the gnubox on
> Nokia 6670 need encrypt option, my command should have encrypt option:
> 
> "dund --encrypt --listen -n"
> 
> but there is an error:
> 
> "Failed to set link mode. Protocol not available(92)."
> 
> If I do not use the "--encrypt" option it works well. The kernel I
> used is 2.4.18 and 
> I have used the patch downloaded on www.bluez.org.
> Here is my kernel option:
> 
> <*> Bluetooth subsystem support
> <*> L2CAP protocol support
> <  > SCO links support
> <*> RFCOMM protocol support
>  [*]       RFCOMM TTY support
> <*> BNEP protocol support
>  [*]       Multicast filter support
>  [*]       Protocol filter support
> <  > HIDP protocol support
> 
> 
> <*> HCI USB driver
>  [  ]        SCO (voice) support
> <*> HCI UART driver
>  [*]         UART (H4) protocol support
>  [*]         BCSP protocol support
>  [  ]         TRansmit CRC with every BCSP packet
> <*> HCI BlueFRITZ! USB driver
> <*> HCI VHCI (Virtual HCI device) driver
> 
> How can I make the --encrypt option workable?

update to a decent 2.6 kernel, because the 2.4.18 is not supported
anymore and you have to pay me a lot of money to backport the encrypt
support for it.

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
