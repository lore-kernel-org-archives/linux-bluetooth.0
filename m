Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42172665.9080909@debiancolombia.org>
From: "Fredy P." <digitalfredy@debiancolombia.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Trouble pairing with new phone... (FIXED!)
References: <20050217140257.16874.qmail@web60903.mail.yahoo.com>
In-Reply-To: <20050217140257.16874.qmail@web60903.mail.yahoo.com>
Content-Type: text/plain;
	charset=Big5
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
Date: Sat, 19 Feb 2005 06:43:33 -0500

Hi Ka Kin and Jay and Marcel!
first sorry my bad english ;)
Ka Kin Cheung escribio':
> Hi Jay!
>     Sorry to interrupt. In order that SE T610 can search and add PC int=
o=20
> "My device list", you should do like this:
> # Authentication and Encryption
> # auth enable;
> # encrypt enable
and change
pin_helper /sbin/pintest
for
pin_helper /sbin/pintest;
>     Or you can never let your T610 to search for and add your PC into=20
> the list.

Problem for send files from the t610 to pc:
I can pair mi pc with the t610 (with rfcomm connect 0 <address>), and
i can't pair it's if try from the t610 (bluetooth -> my devices -> new de=
vice)
becouse return bluetooth conection  error.

I can send but no recive archives (in the t610 show that my pc not have s=
ervices)
from the pc to the t610 with obexftp and i think to i have a bluetooth co=
nfiguration
problem.
tanks for your time.
#################################begin rfcom.conf########################=
#########
 rfcomm0 {
  bind yes;
	device 00:0A:D9:78:ED:5E;
	channel	1;
	comment "Example Bluetooth device";
	}
#################################end rfcom.conf##########################=
#######

#################################begin hci.conf##########################=
#######
options {
        autoinit yes;
        security auto; #
        pairing multi;
        pin_helper /usr/bin/bluez-pin;
	}
device {
        name "%h-%d";
        class 0x100;
        iscan enable; pscan enable;
        lm accept,master;
	lp rswitch,hold,sniff,park;
	}
#################################end hci.conf############################=
#####

#################################begin hcidump -X########################=
#########
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  0000: 5e ed 78 d9 0a 00 04 02  52 01                    ^.x.....R.
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 5e ed 78 d9 0a 00 00                              ^.x....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 1a 29 00 5e ed 78 d9 0a  00 01 00                 .).^.x.....
#################################end hcidump -X##########################=
#######

--=20
Suerte and F.S.Fv.

ATT: Fredy P.
___________________________________________________
F.S.Fv. es acro'nimo de Free Software Forever
http://www.fsf.org/philosophy/free-sw.es.html

Normas ba'sicas de comportamiento en el ciberespacio
http://www.netiqueta.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
