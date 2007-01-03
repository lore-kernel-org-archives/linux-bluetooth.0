Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <6af20b8d0701022000j32baae52m5a563f4f3ca3e324@mail.gmail.com>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>
	<20070102094414.f7b9cef1.ml133@netpole.com.br>
	<57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>
	<1167743069.30886.54.camel@violet> <459A60A1.80906@glidos.net>
	<1167745840.30886.77.camel@violet> <459AC8B4.7090407@glidos.net>
	<1167772692.30886.117.camel@violet> <459AED37.20008@glidos.net>
	<6af20b8d0701022000j32baae52m5a563f4f3ca3e324@mail.gmail.com>
Date: Wed, 03 Jan 2007 08:18:44 +0100
Message-Id: <1167808724.20568.5.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem in making multiple connections
	using	single bluetooth adapter using bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

>          > HCI Event: Number of Completed Packets (0x13) plen 5
>             handle 42 packets 1
>          > ACL data: handle 42 flags 0x02 dlen 17
>          > ACL data: handle 42 flags 0x01 dlen 1
>             L2CAP(d): cid 0x0041 len 14 [psm 3] 
>               RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>               dlci 4 frame_type 0 credit_flow 15 pri 32 ack_timer 0
>               frame_size 1024 max_retrans 0 credits 7
>         < ACL data: handle 42 flags 0x02 dlen 8 
>             L2CAP(d): cid 0x0203 len 4 [psm 3]
>               RFCOMM(s): DM: cr 1 dlci 4 pf 1 ilen 0 fcs 0xbc
> 
> And why a DM for channel 4 is sent as a response  of  a PN CMD for dlci 0 ? 
> Should this not happen ? There must be some problem of the command that 
> was received. Maybe we've got a corrupted command for dlci 4 and that hcidump
> didn't show it up.

actually that is the wrong interpretation. The PN CMD is sent on the
multiplexer DLCI 0 and it is sent for DLCI 4. This means we try to open
RFCOMM channel 2. The following DM is an indication that no service is
listening on RFCOMM channel 2. Hence my request to check the actual
registered listening sockets via /sys/class/bluetooth/rfcomm.

>          > HCI Event: Number of Completed Packets (0x13) plen 5
>             handle 42 packets 1
>          > ACL data: handle 42 flags 0x02 dlen 12
>             L2CAP(s): Disconn req: dcid 0x0041 scid 0x0203
>         < ACL data: handle 42 flags 0x02 dlen 12 
>             L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0203
>          > HCI Event: Number of Completed Packets (0x13) plen 5
>             handle 42 packets 1
>
> This is really strange. 

No, it is not.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
