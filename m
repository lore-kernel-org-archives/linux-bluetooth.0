Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] timeout after rfcomm or pan connection
References: <20040309161702.24407.qmail@web40713.mail.yahoo.com>
From: "Christoph Torens" <c.torens@web.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Message-ID: <opr4mgbutyeocfdv@debian>
In-Reply-To: <20040309161702.24407.qmail@web40713.mail.yahoo.com>
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
Date: Wed, 10 Mar 2004 02:12:56 +0100

Hi,

Thanks for the tips, so far

-- comments from Lalith Chakravarthi
> and you should see bluez, usb-uhci, hci_usb, rfcomm, l2cap and bnep
> modules there (doesnt hurt to have extra modules!!)

all running.
I already experienced this stages ;-)
and can say that the error messages were different without loaded  
modules...

> make sure you have connected both the dongles and that they are
> up and running.

Jup, l2ping does work for example.

> then, get the daemons running
> motospin> hcid
> motospin> sdpd

also running on both devices

> then on the server side run the pand
> motospin> pand --listen --role GN
> and on the client side
> motospin2> pand --connect --search 20 (20 is the time out value)

i tried this and get the following:

debian:/# pand -n --listen --role GN
pand[3204]: PAN daemon ver 1.1
pand[3205]: New connection from 00:04:3E:C0:8B:30 bnep0



root@viper root# pand -n --search 20 --service GN
pand[161]: PAN daemon ver 1.1
pand[161]: Inquiring
pand[161]: Searching for GN on 00:04:3E:C0:9D:79
pand[161]: Connecting to 00:04:3E:C0:9D:79

> motospin> ifconfig bnep0 10.0.0.1
> motospin2> ifconfig bnep 10.0.0.2

this time i didn't get till here, because:
debian:~# pand -l
bnep0 00:04:3E:C0:8B:30 GN

but pand -l on viper says nothing!

hm, here it seems the viper can't fully establish the connection
At the moment I can't reproduce this other failure message "ACL Timeout".  
This does really astonish me, cause i got nothing but this failure for  
more than three days, and it was the reason I decided to write to this  
list.


-- comments from Marcel Holtmann

> try to use the latest 2.4 or 2.6 kernel on both machines.

I will upgrade debian to 2.4.25 tomorrow, this can be done with apt-get :-)
the viper kernel needs special patches I think... i'm not sure if / how  
this can be done
I don't think they exist for the newest kernel vversion :-(

> show us "hciconfig -a" before your system "crashes". I think this Acer
> dongles uses the Zeevo chip

debian:/# hciconfig -a
hci0:   Type: USB
         BD Address: 00:04:3E:C0:9D:79 ACL MTU: 1356:5  SCO MTU: 48:1
         UP RUNNING PSCAN ISCAN
         RX bytes:8362 acl:132 sco:0 events:422 errors:0
         TX bytes:6736 acl:148 sco:0 commands:197 errors:0
         Features: 0xff 0x07 0x04 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
         Link policy: HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0) on debian'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x86 LMP Ver: 1.1 (0x1) LMP Subver:  
0x86
         Manufacturer: Telencomm Inc. (18)



root@viper root# hciconfig -a
hci0:   Type: USB
         BD Address: 00:04:3E:C0:8B:30 ACL MTU: 1356:5  SCO MTU: 48:1
         UP RUNNING PSCAN ISCAN
         RX bytes:93 acl:0 sco:0 events:12 errors:0
         TX bytes:296 acl:0 sco:0 commands:12 errors:0
         Features: 0xff 0x07 0x04 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
         Link policy: HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0) on viper'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x86 LMP Ver: 1.1 (0x1) LMP Subver:  
0x86
         Manufacturer: Telencomm Inc. (18)

This output says nothing about Zeevo, but my win driver definitely says  
Zeevo.

> You can write a socket program to communicate over L2CAP, RFCOMM or with
> TCP/IP over BNEP. You have to choose ;)

ehm, i thought writing a programm using bnep would be the same as with a  
normal network... and the others? where can i get some reading stuff/  
tutorials on programming each of the three choices?

-- 
Regards,
Christoph Torens

ps: netiquette question: should i write this mail only to the list,  or to  
the list and the nice people who answered me?
don't know :-)


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
