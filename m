Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOCEGICAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <HCEOIFALKKLBLJPENPNOKEGHCAAA.khaled@ipbill.com>
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
Date: Wed, 7 Dec 2005 15:30:03 -0000

Hi Brad, Steven,

Further information:

I have just checked hcidump again: when in an active call there is no output
on hcidump -X -V, the last trace is:

> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 33 2c 33 0d  i....+CIEV:
3,3.
      0010: 0a 3e                                             .>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 31 2c 31 0d  i....+CIEV:
1,1.
      0010: 0a 3e                                             .>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 33 2c 30 0d  i....+CIEV:
3,0.
      0010: 0a 3e

The trace holds on this for as long as the call is active, then once the
destination (dialled phone) is hung up, still nothing happens untill about 5
seconds later when the call on the mobile phone dissappears, at which point
the next line in the trace (ERROR) appears:

> ACL data: handle 40 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 0]
      0000: 69 ef 13 0d 0a 45 52 52  4f 52 0d 0a 3e           i....ERROR..>
> ACL data: handle 40 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 0]
      0000: 69 ef 1d 0d 0a 2b 43 49  45 56 3a 20 31 2c 30 0d  i....+CIEV:
1,0.
      0010: 0a 3e                                             .>
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 0]
      0000: 6b ef 05 0d 0a e4                                 k.....
< ACL data: handle 40 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 0]
      0000: 6b ef 0f 41 54 2b 43 48  55 50 e4                 k..AT+CHUP.
< ACL data: handle 40 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 0]
      0000: 6b ef 05 0d 0a e4

Regards

Khaled



> -----Original Message-----
> From: bluez-users-admin@lists.sourceforge.net
> [mailto:bluez-users-admin@lists.sourceforge.net]On Behalf Of Khaled
> Sent: 07 December 2005 15:06
> To: bluez-users@lists.sourceforge.net
> Subject: RE: [Bluez-users] Bluetooth Voice Setting
>
>
> Hi Brad,
>
> > Run "hciconfig hci0 revision" as root and show us the output.
> >
> > Also see http://bluetooth-alsa.sourceforge.net/index.html#help
> >
>
> Some more information:
>
> **bluez packages were downloaded from the website
>
>
> **[root@mdk10-voipgsm root]# hcitool info 00:0e:6d:34:bd:b1
> Requesting information ...
>         BD Address:  00:0e:6d:34:bd:b1
>         Device Name: Nokia6310i
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x23b
>         Manufacturer: Nokia Mobile Phones (1)
>         Features: 0xbf 0x28 0x21 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption>
> <slot offset>
>                 <timing accuracy> <role switch> <sniff mode> <SCO link>
>                 <HV3 packets> <CVSD> <flow control (MB)
>
> **[root@mdk10-voipgsm root]# uname -r
> 2.6.3-7mdk (Mandrake 10)
>
> **
>
> [root@mdk10-voipgsm root]# hcitool con
> Connections:
>         < ACL 00:0E:6D:7A:B1:FA handle 40 state 1 lm MASTER
> 	#When asterisk
> is started and 6310i is initialised
> [root@mdk10-voipgsm root]# hcitool con
> Connections:
>         > SCO 00:0E:6D:34:BD:B1 handle 46 state 1 lm SLAVE
> 	#When a call is
> made from the soft phone
>         < ACL 00:0E:6D:34:BD:B1 handle 43 state 1 lm MASTER ENCRYPT
> [root@mdk10-voipgsm root]# hcitool con
> Connections:
>         < ACL 00:0E:6D:34:BD:B1 handle 43 state 1 lm MASTER
> ENCRYPT	#After
> hangup of soft phone
>
>
>
> Kind Regards
>
> Khaled
>
>
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep
> through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
