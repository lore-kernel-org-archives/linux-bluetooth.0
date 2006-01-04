Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Trouble with Logitech BT mini-receiver
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0601041405030.11165@office.4L>
References: <Pine.LNX.4.64.0601041405030.11165@office.4L>
Content-Type: text/plain
Message-Id: <1136384925.24203.6.camel@localhost>
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
Date: Wed, 04 Jan 2006 15:28:45 +0100

Hi Ronan,

> Apologies in advance if this an FAQ - I've had a look at the FAQ and the
> list archives, but can't find anything relevent.
> 
> I've got a new "Logitech Cordless Desktop / MX5000 Laser" keyboard / mouse
> bundle which comes with a device that identifies itself as a 'Logitech BT
> mini-receiver):
> 
>  Bus 002 Device 004: ID 046d:c70a Logitech, Inc.
>  Bus 002 Device 003: ID 046d:c70e Logitech, Inc.
>  Bus 002 Device 002: ID 046d:0b02 Logitech, Inc.
> 
>  T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 3
>  D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
>  P:  Vendor=046d ProdID=0b02 Rev=40.01
>  S:  Manufacturer=Logitech
>  S:  Product=Logitech BT Mini-Receiver
>  C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
>  I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
>  E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
> 
>  T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
>  D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
>  P:  Vendor=046d ProdID=c70e Rev=40.01
>  S:  Manufacturer=Logitech
>  S:  Product=Logitech BT Mini-Receiver
>  S:  SerialNumber=000761421928
>  C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 98mA
>  I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
>  E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> 
>  T:  Bus=02 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
>  D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
>  P:  Vendor=046d ProdID=c70a Rev=40.01
>  S:  Manufacturer=Logitech
>  S:  Product=Logitech BT Mini-Receiver
>  S:  SerialNumber=000761421928
>  C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 98mA
>  I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
>  E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=5ms
> 
> I'm running a gentoo box with 2.6.14-mh2 and bluez-(utils|libs)-2.22.
> 
> I'm unable to get the bluez tools to identify the BT dongle - hid2hci
> reports "Switching device 046d:0b02 to HCI mode was successful", but
> hciconfig is unable to find anything.
> 
> I'd like to able to use the BT dongle for other bluetooth devices (ideally
> a headset).  Is this device supported at present?  If so, does anybody
> have any suggestions as to what I'd doing wrong?  If not, does anybody
> have any recommendations for a BT dongle to replace it?

I only have the previous model and I think they might changed the
switching command. I remember a similar discussion on the mailing list
some time ago. Use VMware and usbmon or USBsnoppy to sniff what commands
they used.

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
