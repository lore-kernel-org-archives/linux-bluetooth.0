Return-Path: <emoreno@dim.uchile.cl>
Date: Thu, 10 Jun 2004 15:34:42 +0200 (CEST)
From: Eduardo Moreno A <emoreno@dim.uchile.cl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci_acldata_packet error in a Palm connection.
In-Reply-To: <1086873349.7930.2.camel@pegasus>
Message-ID: <Pine.LNX.4.60.0406101528420.10156@cain.borelian.dns2go.com>
References: <40C85761.4060201@dim.uchile.cl> <1086873349.7930.2.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>



On Thu, 10 Jun 2004, Marcel Holtmann wrote:

> Hi Eduardo,
>
>> I'm starting in the bluetooth world, and i'm trying to connect my Palm
>> Tungsten T2 with my Kernel 2.6.6 + usb dongle.
>>
>> I followed all the clasical howtos of Palm+BlueZ (of course, using the
>> 2.6.6 modules).
>>
>> I start hcid, sdpd, without problem, the communication with the palm
>> works great, I can also l2ping the palm device.
>>
>> But when I try a ppp connection (using dund) I receive the following
>> message in /var/log/messages:
>>
>> kernel: hci_acldata_packet: hci0 ACL packet for unknown connection handle 1
>>
>> Searching "ACL packet for unknown connection handle 1" in google, I
>> found 3 very old messages (2001) of this mailing list speaking about a
>> bug.....
>
> what kind of dongle are you using (hciconfig -a)? Maybe you need a
> firmware update for your Palm or you have to buy yourself another
> dongle.
>
> Regards
>
> Marcel
>
>
>
I have a "freeControl" usb dongle using chipset Broadcom (it's supported 
in http://www.holtmann.org/linux/bluetooth/devices.html using 
hci_usb+bluefw). I tried using bluefw and bcm203x module but I don't know 
if the firmware was loaded (there is  no message in any log, how can I 
see if it was loaded or not?), and if it  was loaded, I still have the 
same problem.

My hciconfig -a:

hci0:   Type: USB
         BD Address: 00:0A:9A:00:68:AC ACL MTU: 339:4  SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:3203 acl:69 sco:0 events:171 errors:0
         TX bytes:2658 acl:65 sco:0 commands:56 errors:0
         Features: 0xff 0xff 0x3d 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: ACCEPT MASTER
         Name: 'BlueZ (0)'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x8a LMP Ver: 1.1 (0x1) LMP Subver: 
0x8a
         Manufacturer: Transilica, Inc. (24)

Thanks.
