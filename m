Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FD462C.8090001@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] "hcitool dev" shows no devices
References: <41FD3E26.1000401@gmx.ch> <1107116116.8384.4.camel@pegasus>
In-Reply-To: <1107116116.8384.4.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 30 Jan 2005 21:40:12 +0100

Hello Marcel

I found out why they aren't recognized.
hcid needs to be running in order to start them (HCI dev X up)...
stupid me... I thought that this isn't necessary.

thanks a lot!


But another question arised starting hcid:
The location of etc/bluetooth/pin. Is it hardcoded?
I crosscompiled the bluez libs/utils and hcid now tells me on start:
Can't open PIN file /usr/local/arm/2.95.3/arm-linux/etc/bluetooth/pin. No 
such file or directory(2)

Can I change the location of the pin-file? maybee in the hcid.conf?

kind regards
Marco


Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>I've a 2.4.26 kernel. I patched it using the "patch-2.4.26-mh2.gz" from the 
>>bluez homepage. *
>>Then, in "make menuconfig" I selected this points:
>># Bluetooth support -> Bluetooth subsystem support
>>#                      L2CAP protocol support (NEW)
>>#                      RFCOMM protocol support
>>#                        RFCOMM TTY support (NEW)
>># Bluetooth support -> Bluetooth device drivers -> HCI USB driver (new)
>>
>>Then I compiled and installed the new kernel.
>>After that I compiled and installed the bluez-libs and bluez-utils.
>>
>>Everything works well...
>>Now I try "hcitool dev" but no devices are showed (I have two D-Link DBT120 
>>connected to usb ports).
>>
>>Any Ideas why they aren't recognized?
>>Did I miss to add a feature to the kernel?
> 
> 
> what does "hciconfig -a" say? What is in /proc/bus/usb/devices?

hci0:   Type: USB
         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
         DOWN
         RX bytes:0 acl:0 sco:0 events:0 errors:0
         TX bytes:0 acl:0 sco:0 commands:0 errors:0
         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DH1 HV1
         Link policy:
         Link mode: SLAVE ACCEPT

hci1:   Type: USB
         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
         DOWN
         RX bytes:0 acl:0 sco:0 events:0 errors:0
         TX bytes:0 acl:0 sco:0 commands:0 errors:0
         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DH1 HV1
         Link policy:
         Link mode: SLAVE ACCEPT

>>* Something gets rejected during the patch (It doesn't seem important to 
>>me, but maybee it is):
>>
>>Makefile.rej:
>>***************
>>*** 1,7 ****
>>   VERSION = 2
>>   PATCHLEVEL = 4
>>   SUBLEVEL = 26
>>- EXTRAVERSION =
>>
>>   KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
>>
>>--- 1,7 ----
>>   VERSION = 2
>>   PATCHLEVEL = 4
>>   SUBLEVEL = 26
>>+ EXTRAVERSION = -mh2
>>
>>   KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> 
> 
> You can ignore this one. It will almost fail if you don't use a vanilla
> base.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
