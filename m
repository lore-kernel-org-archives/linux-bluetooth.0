Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <447105B1.3060908@killesreiter.de>
From: Gerhard Killesreiter <gerhard@killesreiter.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: broadcom in disguise... (was: [Bluez-devel] SCO for non-CSR based
 devices?)
References: <4461A33F.1060702@killesreiter.de> <44634846.3000006@xmission.com> <Pine.LNX.4.63.0605111727560.7379@redbean.intranet.gw-instruments.de> <4461FE7D.3050108@killesreiter.de>
In-Reply-To: <4461FE7D.3050108@killesreiter.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 22 May 2006 02:28:33 +0200

Gerhard Killesreiter wrote:
> Peter Wippich wrote:
>
>
>> I'm sorry to tell you that with the Sphinx card SCO is not supported 
>> at all. It uses one of the first available Ericson BT Moduls and this 
>> modul does not support SCO over H4.
>>   
>
> Too bad, but thanks for the info! Guess I'll just buy a CSR USB-stick, 
> then.

I went to town and did just that. I ended up buying a Typhoon bluetooth 
usb adapter (http://www.typhoon.de/de/art.php?p=838&pv=3). I had the 
clerk check out the webpage for me and there we found "Functions: Main 
chip - CSR BlueCore ". That's why I bought it and didn't check out th 
other available devices (only one).

Today I tried to get it to work...

theo-dhcp-42:/usr/src/linux# hciconfig -a       
hci0:   Type: USB
        BD Address: 00:10:60:AD:C2:C1 ACL MTU: 377:10 SCO MTU: 64:8

I already applied the MTU patch.

        UP RUNNING PSCAN ISCAN
        RX bytes:2697 acl:88 sco:0 events:144 errors:0
        TX bytes:2211 acl:86 sco:0 commands:46 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'theo-dhcp-42-0'
        Class: 0x100100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)
                                  ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^

Maybe they changed the internals of the device in the revision I bought...


Setting volume and connection does work just fine, but no sound only 
some white noise. Now I can try to bring it back (might be difficult 
since the package is opened) or try to get it to work. I've looked 
through the archives and it doesn't look too good. Are there any news on 
this?


There is a pecularity I'd like to understand: When I use alsamixer to 
set the sound level, there are four settings: Master, Mic, AGC, 
Loopback. I can modify the first two, btu the other ones are disabled. 
What are they? Are they related to the problem?

When I use aplay to try to play a sound, it hangs after writing out the 
version info. Strace gives:

write(2, "  stop_threshold   : 8001\n", 26  stop_threshold   : 8001
) = 26
write(2, "  silence_threshold: 0\n", 23  silence_threshold: 0
) = 23
write(2, "  silence_size : 0\n", 19  silence_size : 0
)    = 19
write(2, "  boundary     : 2097414144\n", 28  boundary     : 2097414144
) = 28
read(3, "\0\0\377\377\2\0\375\377\10\0\361\377\n\0\310\377\17\0"..., 
22048) = 22048
read(3, "=\374E\375u\374\253\374\325\374\177\374\17\375\371\374"..., 
22048) = 22048
read(3, "\213\376\316\375\236\376\234\376\211\376\315\377,\376I"..., 
22048) = 22048
read(3, "\320\374!\375\34\3762\375\303\376\231\374L\375\333\372"..., 
22048) = 22048
ioctl(4, 0x4142, 0xb7f02b90)            = 0
read(3, "\v\376l\367\227\374\327\366\372\373\356\365\333\373\26"..., 
22048) = 22048
ioctl(4, 0x4122, 0xb7f02b90)            = 0
poll(


And there it sits doing nothing.


Cheers,
    Gerhard


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
