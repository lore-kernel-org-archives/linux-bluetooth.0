Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43442E4A.2070509@gmx.de>
From: Rainer Lay <rainer.lay@gmx.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] no route to host
References: <4344185B.1030401@gmx.de> <1128538606.5447.42.camel@localhost.localdomain>
In-Reply-To: <1128538606.5447.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 05 Oct 2005 21:49:30 +0200



Marcel Holtmann wrote:
> Hi Rainer,
> 
>> when trying to access rfcomm devices, I get:
>> minicom: cannot open /dev/rfcomm0: No route to host
>>
>> rfcomm tells me:
>> rfcomm0: 00:20:E0:3A:BC:28 channel 3 clean
>>
>> I am using bluez-utils version 2.19
>> I cannot find any log files, ...
>> I can connect to my handy via bluetooth with e.g. wammu
> 
> run "hcidump -X -V" to see where the problem might be. What is
while running minicom, I get no output.

> "hciconfig -a" telling you?

hci0:   Type: USB
        BD Address: 00:20:E0:3A:BC:28 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:42461 acl:630 sco:0 events:899 errors:0
        TX bytes:16220 acl:497 sco:0 commands:202 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ r51 (0)'
        Class: 0x50010c
        Service Classes:
        Device Class: Computer, Laptop
        HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver:
0x222
        Manufacturer: Cambridge Silicon Radio (10)



???

rgds, Rainer


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
