Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4017D6E9.6030700@3WT.com.br>
From: Rafael Vidal Aroca <rafael@3WT.com.br>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci0 problem after timeout
References: <40170986.70105@3WT.com.br> <1075276651.12766.52.camel@pegasus>
In-Reply-To: <1075276651.12766.52.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 28 Jan 2004 13:36:09 -0200

Marcel Holtmann wrote:

>Hi Rafael,
>
>  
>
>>	Hi guys, i made a bluetooth network from my linux box to my ipaq  box, 
>>but i'm having some problems. Both systems runs linux and bluez.
>>
>>	In PC side i use the folowing commands:
>>
>>	pand --listen --role GN
>>	hciconfig hci0 -lm master,accept
>>
>>	Then on iPaq:
>>
>>	hcitool inq
>>    	pand --connect 00:80....
>>   	ifconfig bnep0 192.168.2.2 netmask 255.255.255.0
>>
>>	Back to PC:
>>
>>    	ifconfig bnep0 192.168.2.1 netmask 255.255.255.0
>>
>>	
>>	Doing that i can ping and ssh to my ipaq pocket pc and can also use 
>>internet through pc. But just for 30 seconds!!!!
>>
>>	After about 30 seconds the conection fails and pc's dmesg shows 
>>nothing. I just get and error when trying to restart hci0:
>>
>>
>>	root@gemini:~# hciconfig hci0 down	
>>	root@gemini:~# hciconfig hci0 up
>>	Can't init device hci0. Connection timed out(110)
>>
>>
>>	I really think the problem is in the pc side, and i'm having trouble 
>>putting this D-Link DBT-120 usb bluetooth dongle to work since last 
>>year. Can anyone help or point solutions?
>>
>>	Distro: Debian Woody
>>	Kernel: 2.4.22 (no from distro, i compiled)
>>	hotplug: 2004_01_05 (latest)
>>	bluefw: 1.0
>>	
>>	Hope i gave enough info. Thanks in advance.
>>    
>>
>
>give us the output of "hciconfig -a" for your devices. What kind of USB
>host controller do you have (lspci)? What USB host driver do you use?
>  
>

    Ok:

    Before starting hotplug system:

    hciconfig -a show nothing
    root@gemini:~# lsusb
Bus 002 Device 001: ID 0000:0000 
Bus 002 Device 002: ID 0a5c:2033 Broadcom Corp. BCM2033 Bluetooth
Bus 001 Device 001: ID 0000:0000 

After starting hotplug:

root@gemini:~# /etc/init.d/hotplug start
** can't synthesize input events - /proc/bus/input/devices missing
** can't synthesize pci hotplug events
bluefw[1140]: Loading firmware to usb device 0a5c:2033
bluefw[1140]: FW loaded

root@gemini:~# lsusb
Bus 002 Device 001: ID 0000:0000 
Bus 002 Device 003: ID 0a5c:2001 Broadcom Corp.
Bus 001 Device 001: ID 0000:0000 

root@gemini:~# hciconfig -a
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0
        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1
        Link policy:
        Link mode: SLAVE ACCEPT

root@gemini:~# hciconfig hci0 up

root@gemini:~# hciconfig -a    
hci0:   Type: USB
        BD Address: 00:80:C8:50:F2:D5 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:63 acl:0 sco:0 events:7 errors:0
        TX bytes:27 acl:0 sco:0 commands:7 errors:0
        Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2033'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2 LMP Ver: 1.1 (0x1) LMP Subver: 
0x1007
        Manufacturer: Broadcom Corporation (15)

root@gemini:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
AC97 Audio Controller (rev 50)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 02)
00:0f.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 
Model 64/Model 64 Pro] (rev 15)

root@gemini:~# lsmod
Module                  Size  Used by    Tainted: PF
NVdriver              722784  14  (autoclean)
vmnet                  19600   4
parport_pc             13476   0  (unused)
parport                14304   0  [parport_pc]
vmmon                  23036   0  (unused)
vfat                   10604   0  (autoclean)
fat                    32152   0  (autoclean) [vfat]
tuner                  10760   0  (unused)
i2c-core               13540   0  [tuner]
usbnet                 15142   0  (unused)
hci_usb                 6712   1                                 
mii                     2464   0  [usbnet]
bluez                  32100   1  [hci_usb]
rtc                     7048   0  (autoclean)

    I use UHCI USB system.


    Well, now after the timeout problem:

    root@gemini:~# hciconfig -a
hci0:   Type: USB
        BD Address: 00:80:C8:50:F2:D5 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:7650 acl:84 sco:0 events:75 errors:0
        TX bytes:4558 acl:65 sco:0 commands:15 errors:0
        Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2033'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2 LMP Ver: 1.1 (0x1) LMP Subver: 
0x1007
        Manufacturer: Broadcom Corporation (15)

    After this, if i try:

    root@gemini:~# hciconfig hci0 down

    root@gemini:~# hciconfig hci0 up 
    Can't init device hci0. Connection timed out(110)

root@gemini:~# hciconfig -a
hci0:   Type: USB
        BD Address: 00:80:C8:50:F2:D5 ACL MTU: 377:10  SCO MTU: 16:0
        DOWN
        RX bytes:8005 acl:84 sco:0 events:90 errors:0
        TX bytes:7389 acl:86 sco:0 commands:25 errors:0
        Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
   

       I updated my kernel to 2.4.24 also yesterday, and the problem 
persists. So, i have 2 problems: The conn that fails after some seconds 
and the hci0 that does not come back after that.

Thanks again.

[]s Rafael.



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
