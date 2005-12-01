Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Thomas Keitzl <c3t0@yahoo.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BlueZ on Sony Vaio notebook pcg-z1m
Message-Id: <20051201171752.1cb8ebac.c3t0@yahoo.de>
In-Reply-To: <1133211371.31513.72.camel@blade>
References: <20051128215104.2d3e749a.c3t0@yahoo.de>
	<1133211371.31513.72.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Thu, 1 Dec 2005 17:17:52 +0100

hey,
thx for your answer.
after I loaded bluetooth & hci-usb-module and activated the bluetooth-device (the blue led is now on),
I neither find anything at /var/log/messages 
nor anything at /proc/bus/usb/devices.

nevertheless, here's the output:

>cat /proc/bus/usb/devices
>> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
>> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
>> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
>> P:  Vendor=0000 ProdID=0000 Rev= 2.06
>> S:  Manufacturer=Linux 2.6.9 ehci_hcd
>> S:  Product=Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller
>> S:  SerialNumber=0000:00:1d.7
>> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
>> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
>> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

>dmesg
>> Bluetooth: Core ver 2.6
>> NET: Registered protocol family 31
>> Bluetooth: HCI device and connection manager initialized
>> Bluetooth: HCI socket layer initialized
>> Bluetooth: HCI USB driver ver 2.7
>> usbcore: registered new driver hci_usb

Regards
Thomas

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
