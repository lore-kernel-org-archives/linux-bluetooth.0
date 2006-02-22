Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Heba Khamis <Heba.Khamis@csiro.au>
Message-ID: <loom.20060222T230912-699@post.gmane.org>
References: <loom.20060216T015926-491@post.gmane.org> <1140070087.29234.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Belkin USB Adaptors and Failing =?utf-8?b?aGNpX2lucXVpcnk=?=
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
Date: Wed, 22 Feb 2006 22:37:16 +0000 (UTC)

Hey Marcel,

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Heba,
> 
>>I am developing an application for automatic network discovery using 
>>bluetooth
>>i.e. Running the application will result in connections to any other 
>>computers
>>running the same application:
>>- Each application is running a server which accepts connections 
>>  (once a connection is made, the connection is maintained until a 
>>  transmission error occcurs or the socket is closed by either party);
>>- and a client which repeatedly queries for bluetooth devices to 
>>  connect to.
>> 
>>So in total an application makes and
>>maintains 2*(#other applications) connections.
>>         
>>This causes no problems when using the Belkin F8T003 Bluetooth USB Adaptor
>>(this is a bluetooth v1.1 compliant device).
>>         
>>However, when using the Belkin F8T009 Bluetooth USB Adaptor
>>(this is a bluetooth v1.2 compliant device)
>>"Device or Resource Busy" errors are observed
>>when the application tries to query
>>when there are 3 or more connections maintained by it.
>>     
>>I have installed all the latest versions:
>>  - Bluez-lib
>>  - Bluez-hcidump
>>I am running Fedora core 4 with the latest available updates of the kernel.
>> 
>>I've used hcidump to try and figure it out, but all it tells me is:
>>   HCI Command: Inquiry (0x01|0x0001) plen 5
>>     lap 0x9e8b33 len 8 num 255
>>   HCI Event: Command Status (0x0f) plen 4
>>    Inquiry (0x01|0x0001) status 0x0c ncmd 1
>>     Error: Command Disallowed
>> 
>>This really doesn't help me to understand why this is happening.
>>The status of that particular bluetooth device 
>>(a Belkin F8T003 Bluetooth USB bluetooth v1.1 compliant Adaptor) 
>>when the error occurs is as follows:
>> a local server socket is listening for connections
>> two remote clients are connected to the device
>> a local client thread is attempting to query other devices 
<< using hci_inquiry
>> 
> 
>send in the "hciconfig -a" output for both devices.
> 
>Regards
> 
>Marcel
>

I did hciconfig -a and realised that some of the machines said:
   UP RUNNING PSCAN ISCAN
while some machines said:
   UP RUNNING (only!)
so I made sure that "service bluetooth start" was called before running the 
app,
however I still get "Device or Resource Busy" when some of the machines are
querying.

I have four machines 
   Linux-01 (with USB v1.2 Bluetooth adaptor)
   Linux-02 (with USB v1.2 Bluetooth adaptor)
   Linux-03 (with USB v1.2 Bluetooth adaptor)
   Linux-oldDongle (with USB v1.1 Bluetooth adaptor)

Before starting hciconfig -a output is as follows:

Linux-01:
hci0: Type: USB
      BD Address: 00:0A:3A:62:E5:A5 ACL MTU: 377:10 SCO MTU: 16:0
      UP RUNNING PSCAN ISCAN
      RX bytes:420 acl:0 sco:0 events:23 errors:0
      TX bytes:585 acl:0 sco:0 commands:23 errors:0
      Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
      Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
      Link policy: RSWITCH HOLD SNIFF PARK
      Link mode: SLAVE ACCEPT
      Name: 'Computer-04'
      Class: 0x120104
      Service Classes: Networking
      Device Class: Computer, Desktop workstation
      HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
      Manufacturer: Broadcom Corporation (15)

Linux-02:
hci0: Type: USB
      BD Address: 00:0A:3A:62:E5:A9 ACL MTU: 377:10 SCO MTU: 16:0
      UP RUNNING PSCAN ISCAN
      RX bytes:372 acl:7 sco:0 events:27 errors:0
      TX bytes:437 acl:7 sco:0 commands:17 errors:0
      Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
      Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
      Link policy: RSWITCH HOLD SNIFF PARK
      Link mode: SLAVE ACCEPT
      Name: 'Computer-01-0'
      Class: 0x120104
      Service Classes: Networking
      Device Class: Computer, Desktop workstation
      HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
      Manufacturer: Broadcom Corporation (15)

Linux-03:
hci0: Type: USB
      BD Address: 00:0A:3A:62:E3:17 ACL MTU: 377:10 SCO MTU: 16:0
      UP RUNNING PSCAN ISCAN
      RX bytes:372 acl:0 sco:0 events:15 errors:0
      TX bytes:55 acl:0 sco:0 commands:15 errors:0
      Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
      Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
      Link policy: RSWITCH HOLD SNIFF PARK
      Link mode: SLAVE ACCEPT
      Name: 'Broadcom BCM2035'
      Class: 0x000000
      Service Classes: Unspecified
      Device Class: Miscellaneous,
      HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
      Manufacturer: Broadcom Corporation (15)

Linux-oldDongle:
hci0: Type: USB
      BD Address: 00:0A:3A:62:81:FA ACL MTU: 192:8 SCO MTU: 64:8
      UP RUNNING PSCAN ISCAN
      RX bytes:936 acl:19 sco:0 events:51 errors:0
      TX bytes:438 acl:20 sco:0 commands:21 errors:0
      Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
      Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
      Link policy: RSWITCH HOLD SNIFF PARK
      Link mode: SLAVE ACCEPT
      Name: 'Heba'
      Class: 0x020104
      Service Classes: Networking
      Device Class: Computer, Desktop workstation
      HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
      Manufacturer: Cambridge silicon radio (10)


The connections status at the time of failure to query is as follows:
Linux-01 is connected to all other machines
Linux-02 is connected to Linux-01 and Linux-oldDongle
Linux-03 is connected to all other machines
Linux-oldDongle is connected to all other machines

Linux-02 and Linux-03 are failing to query: "Device or Resource Busy"
and Linux-01 and Linux-oldDongle are querying, 
however they are only finding 1 machine each. 
All machines have maintained all their connections even if failing
to query.

Any insights you can give would be greatly appreciated.

Thanks,
Heba.








-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
