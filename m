Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MSDUN failed. Connection timed out(110)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <532f6c3c0512121211j3f1fa779r@mail.gmail.com>
References: <532f6c3c0512121211j3f1fa779r@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134418604.429.9.camel@blade>
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
Date: Mon, 12 Dec 2005 21:16:44 +0100

Hi,

> I am trying to connect my PocketPC 2003 to the internet via bluetooth.
> 
> i have all needed modules
> 
> -------------------
> rfcomm                 34972  3
> l2cap                  22404  5 rfcomm
> hci_usb                13192  2
> bluetooth              43012  7 rfcomm,l2cap,hci_usb
> --------------------------------
> 
> and deamons ( HCID, SDPD, DUND) loaded (i think ;)

what version of bluez-utils is installed?

> dun-mda-bt peer file is:
> 
> -------------------
> root@pajonk:/etc/ppp/peers # cat /etc/ppp/peers/dun-mda-bt
> 115200
> local
> noipdefault
> connect "/etc/ppp/at-cmd.pl -v"
> noauth
> nodefaultroute
> 192.168.1.1:192.168.1.10
> ms-dns 192.168.1.1
> ------------------
> 
> /etc/ppp/at-cmd.pl is a perl script that "do talking":

I don't think that this is needed. The magic is done by the --msdun
switch.

> DUN profile is registered by /usr/local/bin/sdptool add DUN

No need for that, because dund will do that for you if not told
otherwise.

> Device can be seen:
> 
> ---------------------------------
> root@pajonk:/etc/ppp/peers # /usr/local/bin/hcitool scan
> Scanning ...
>         00:09:2D:4D:62:FE       MDAcompact
> ---------------------------------

This is unimportant.

> Now i am trying to connect. Here is the log:
> 
> ==> /var/log/syslog <==
> Dec 12 21:00:16 pajonk hcid[1952]: link_key_request
> (sba=00:08:F4:00:70:D3, dba=00:09:2D:4D:62:FE)
> Dec 12 21:00:26 pajonk dund[2035]: MSDUN failed. Connection timed out(110)
> 
> I have no idea what's wrong.

Run "hcidump -X -V" in another terminal to see what happens.

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
