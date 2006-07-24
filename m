Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44C4CC37.1060308@infitsrl.com>
Date: Mon, 24 Jul 2006 15:33:43 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44BE5DB3.7090406@gmail.com>	<1153356539.4094.9.camel@aeonflux.holtmann.net>	<2172AACE-61A5-4D43-90E2-059D659D8830@infitsrl.com>
	<20060724103824.1ff98fa6@McGee-XPC>
In-Reply-To: <20060724103824.1ff98fa6@McGee-XPC>
Subject: Re: [Bluez-devel] It's rfcomm connect problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Andy,
I Andy the problem I have is described in following hcidump:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:09:2D:2A:68:20 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:01:E3:25:53:44 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x0c ncmd 1
    Error: Command Disallowed
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:09:2D:2A:68:20 type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4
      MTU 1024
 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0044 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0044 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 4 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 4 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0044 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 4 pf 1 ilen 0 fcs 0x96
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0044 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0044 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0044 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 1 ilen 0 fcs 0x79 credits 33
< ACL data: handle 42 flags 0x02 dlen 25
    L2CAP(d): cid 0x0044 len 21 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 4 pf 0 ilen 17 fcs 0x65
      0000: 80 00 11 10 00 08 00 00  00 00 00 00 00 00 00 00  =

................
      0010: 00                                                .
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 4 pf 1 ilen 0 fcs 0xa3 credits 23

As You can see the second Create Connection fails with a Command =

disallowed.....
In my case I've no see any hci_reset.....

Hi
Fabrizio


Andreas Gaufer ha scritto:
> Hi Fabrizio,
>
> i'm working on a possibly related problem. Could you check the hcidump of
> your situation and look out for apparently unmotivated hci_reset
> commands sent to your device? =

>
> Greetings & TIA
>
> Andy
>
> On Sat, 22 Jul 2006 16:08:08 +0200
> Fabrizio Guglielmino <guglielmino@infitsrl.com> wrote:
>
>   =

>> Hi all,
>> I made some investigation about the BtOBEX_TransportConnect signaled  =

>> to the list and Marcel some days before.
>> Openobex isn't involved in the problem, in my try I've writed from  =

>> scatch a simple obex push client (not using openobex but only
>> socket).
>> In my test I found this : if there are two thread (also two process)  =

>> making something like
>>
>>   ...
>>   ret =3D connect(fd, (struct sockaddr *)dst, sizeof(struct sockaddr_rd)=
);
>>   ...
>>
>> in simultaneous way the second always fail (return -1). I've also  =

>> tryed to "protect" the connect using a mutex and all works
>> but (naturally) second connection result conditioned to the frist  =

>> (syncronous so thread it is not useful).
>>
>> I think there is some solution to this but I don't know if it's using  =

>> some ioctl on socket (nonbloking?) or some hci command to adapter.
>> Please can some one give me some hint?
>>
>> I'm looking at kernel source related to rfcomm (/usr/src/ =

>> linux-2.6.116/net/bluetooth/rfcomm/*.c) but I'm not sure the problem  =

>> reside here...
>>
>>
>> thanks, bye
>> Fabrizio =

>>
>> -------------------------------------------------------------------------
>> Take Surveys. Earn Cash. Influence the Future of IT
>> Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
>> opinions on IT & business topics through brief surveys -- and earn cash
>> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>     =

>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>   =



-- =

______________________________
Fabrizio Guglielmino =

Infit Srl
Software Engineering
Tel. +39 11 7410915
Fax. +39 11 7410915
www.infitsrl.com
C.so Svizzera, 79/8 - Torino
______________________________

Il presente messaggio ed ogni eventuale allegato hanno natura
confidenziale e sono riservati ai destinatari indicati. La diffusione a
terzi e qualsiasi altro uso non autorizzato sono proibiti. I messaggi ed
i relativi allegati possono essere soggetti ad alterazioni. Il mittente
declina ogni responsabilit=E0 per le eventuali alterazioni, modificazioni
o falsificazioni.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
