Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4410084C.5050503@yahoo.com>
From: Pedro Monjo Florit <pmonjo2000@yahoo.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <440DB456.3030401@yahoo.com> <1141751166.4258.12.camel@aeonflux.holtmann.net>
In-Reply-To: <1141751166.4258.12.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed;
 boundary="------------060902020404010403050106"
Subject: [Bluez-users] Re: SDP in Motorola phones
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
Date: Thu, 09 Mar 2006 11:49:48 +0100

This is a multi-part message in MIME format.
--------------060902020404010403050106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> I am experiencing problems getting SDP information from some new 
>> Motorola phones (I am dealing with E770). Running "sdptool browse 
>> BDADDR", I get the attached hcidump. As it can be seen, after the SDP 
>> SSA request, the mobile phone does not respond any data and after 20 
>> seconds (the SDP timeout compiled in bluez-libs), sdptool issues an ACL 
>> disconnect. During this time, the phone freezes completely. If I want to 
>> get a specific service (say, OBEX), there are no problems.
>>
>>  From my understanding, the problem is that the Motorola phone does not 
>> deal correctly with the SDP query issued by bluez. I have been trying to 
>> debug sdptool and comparing to other implementations (Symbian seems to 
>> work OK with Motorola) but, as Marcel says, SDP is a horrible protocol.
>>
>> Has anybody experienced any similar problem?
> 
> this problem also exists on the RARZ V3x and I called it ByeByeMoto,
> because it stalls my complete phone. There can't be an easy workaround.
> It is a really serious bug from Motorola and they should provide free
> software upgrades to anyone. However I have no idea how they passed the
> Bluetooth qualification with these devices.

I have been trying to understand what is happening, in order to find a
workaround. I do not know what are the internal structures of the SDP
protocol and I could not follow sdp_service_search_attr_req().

In any case, I have seen that the SDP query created by Symbian works
perfectly on these Motorola phones. I have attached the hcidump's (raw
and decoded), if they could be of any use. The most important difference
is the SDP SSA packet.

Bluez:
< ACL data: handle 41 flags 0x02 dlen 24
      L2CAP(d): cid 0x0040 len 20 [psm 1]
          SDP SSA Req: tid 0x0 len 0xf
            pat uuid-16 0x1002 (PubBrwsGrp)
            max 65535
            aid(s) 0x0000 - 0xffff
            cont 00

Symbian:
  > ACL data: handle 41 flags 0x02 dlen 17
      L2CAP(d): cid 0x0040 len 13 [psm 1]
          SDP SS Req: tid 0x1 len 0x8
            pat uuid-16 0x1002 (PubBrwsGrp)
            max 65535
            cont 00

As it can be seen, tid and len are different and aid(s) is only in Bluez.

I hope that this can be useful.

Cheers,

Pedro


--------------060902020404010403050106
Content-Type: text/plain;
 name="hcidump_R.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump_R.txt"

HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
> 04 04 0A DE DB EA 57 60 00 04 02 50 01 
< 01 09 04 07 DE DB EA 57 60 00 01 
> 04 0F 04 00 01 09 04 
> 04 03 0B 00 29 00 DE DB EA 57 60 00 01 00 
< 01 0D 08 04 29 00 0F 00 
> 04 20 07 DE DB EA 57 60 00 01 
> 04 0E 06 01 0D 08 00 29 00 
< 01 0F 04 04 29 00 18 CC 
> 04 0F 04 00 01 0F 04 
> 04 1D 05 00 29 00 18 CC 
> 02 29 20 0C 00 08 00 01 00 02 01 04 00 01 00 47 00 
< 02 29 20 10 00 0C 00 01 00 03 01 08 00 40 00 47 00 00 00 00 
  00 
> 04 13 05 01 29 00 01 00 
> 04 1B 03 29 00 05 
> 02 29 20 0C 00 08 00 01 00 04 02 04 00 40 00 00 00 
< 02 29 20 0E 00 0A 00 01 00 05 02 06 00 47 00 00 00 00 00 
< 02 29 20 0C 00 08 00 01 00 04 01 04 00 47 00 00 00 
> 04 13 05 01 29 00 01 00 
> 04 13 05 01 29 00 01 00 
> 02 29 20 0E 00 0A 00 01 00 05 01 06 00 40 00 00 00 00 00 
> 02 29 20 11 00 0D 00 40 00 02 00 01 00 08 35 03 19 10 02 FF 
  FF 00 
< 02 29 20 22 00 1E 00 47 00 03 00 01 00 19 00 05 00 05 00 00 
  00 00 00 01 00 00 00 01 00 01 00 01 00 02 00 01 00 03 00 
> 04 13 05 01 29 00 01 00 
> 02 29 20 17 00 13 00 40 00 04 00 02 00 0E 00 00 00 00 04 00 
  35 05 0A 00 00 FF FF 00 
< 02 29 20 9A 00 96 00 47 00 05 00 02 00 91 00 8E 35 8C 09 00 
  00 0A 00 00 00 00 09 00 01 35 03 19 10 00 09 00 03 19 00 01 
  09 00 04 35 0B 35 09 19 01 00 09 00 01 09 00 01 09 00 05 35 
  03 19 10 02 09 00 06 35 09 09 65 6E 09 00 6A 09 01 00 09 01 
  00 25 0A 53 44 50 20 53 65 72 76 65 72 09 01 01 25 22 42 6C 
  75 65 74 6F 6F 74 68 20 73 65 72 76 69 63 65 20 64 69 73 63 
  6F 76 65 72 79 20 73 65 72 76 65 72 09 01 02 25 05 42 6C 75 
  65 5A 09 02 00 35 03 09 01 00 09 02 01 0A 44 0F E3 CF 00 
> 04 13 05 01 29 00 01 00 
> 02 29 20 17 00 13 00 40 00 04 00 03 00 0E 00 01 00 00 04 00 
  35 05 0A 00 00 FF FF 00 
< 02 29 20 7D 00 79 00 47 00 05 00 03 00 74 00 71 35 6F 09 00 
  00 0A 00 01 00 00 09 00 01 35 03 19 10 01 09 00 06 35 09 09 
  65 6E 09 00 6A 09 01 00 09 01 00 25 18 50 75 62 6C 69 63 20 
  42 72 6F 77 73 65 20 47 72 6F 75 70 20 52 6F 6F 74 09 01 01 
  25 1F 52 6F 6F 74 20 6F 66 20 70 75 62 6C 69 63 20 62 72 6F 
  77 73 65 20 68 69 65 72 61 72 63 68 79 09 01 02 25 05 42 6C 
  75 65 5A 09 02 00 19 10 02 00 
> 04 13 05 01 29 00 01 00 
> 02 29 20 17 00 13 00 40 00 04 00 04 00 0E 00 01 00 01 04 00 
  35 05 0A 00 00 FF FF 00 
< 02 29 20 92 00 8E 00 47 00 05 00 04 00 89 00 86 35 84 09 00 
  00 0A 00 01 00 01 09 00 01 35 03 19 11 05 09 00 04 35 11 35 
  03 19 01 00 35 05 19 00 03 08 03 35 03 19 00 08 09 00 05 35 
  03 19 10 02 09 00 09 35 08 35 06 19 11 05 09 01 00 09 01 00 
  25 10 4F 62 65 78 20 50 75 73 68 20 53 65 72 76 65 72 09 01 
  01 25 1C 4B 44 45 20 4F 42 45 58 20 4F 62 6A 65 63 74 20 50 
  75 73 68 20 53 65 72 76 69 63 65 09 03 03 35 0E 08 FF 08 01 
  08 02 08 03 08 04 08 05 08 06 00 
> 04 13 05 01 29 00 01 00 
> 02 29 20 17 00 13 00 40 00 04 00 05 00 0E 00 01 00 02 04 00 
  35 05 0A 00 00 FF FF 00 
< 02 29 20 6F 00 6B 00 47 00 05 00 05 00 66 00 63 35 61 09 00 
  00 0A 00 01 00 02 09 00 01 35 03 19 11 01 09 00 04 35 0C 35 
  03 19 01 00 35 05 19 00 03 08 05 09 00 05 35 03 19 10 02 09 
  01 00 25 0D 4B 42 74 53 65 72 69 61 6C 43 68 61 74 09 01 01 
  25 21 4B 44 45 20 42 6C 75 65 74 6F 6F 74 68 20 53 65 72 69 
  61 6C 20 43 68 61 74 20 53 65 72 76 69 63 65 00 
> 04 13 05 01 29 00 01 00 
> 02 29 20 17 00 13 00 40 00 04 00 06 00 0E 00 01 00 03 04 00 
  35 05 0A 00 00 FF FF 00 
< 02 29 20 85 00 81 00 47 00 05 00 06 00 7C 00 79 35 77 09 00 
  00 0A 00 01 00 03 09 00 01 35 03 19 11 01 09 00 04 35 0C 35 
  03 19 01 00 35 05 19 00 03 08 1B 09 00 05 35 03 19 10 02 09 
  01 00 25 12 4B 44 45 20 42 65 6D 75 73 65 64 20 53 65 72 76 
  65 72 09 01 01 25 32 4B 44 45 20 53 65 72 76 65 72 20 66 6F 
  72 20 74 68 65 20 42 65 6D 75 73 65 64 20 72 65 6D 6F 74 65 
  20 63 6F 6E 74 72 6F 6C 20 70 72 6F 74 6F 63 6F 6C 00 
> 04 13 05 01 29 00 01 00 
> 02 29 20 0C 00 08 00 01 00 06 03 04 00 40 00 47 00 
< 02 29 20 0C 00 08 00 01 00 07 03 04 00 40 00 47 00 
> 04 13 05 01 29 00 01 00 


--------------060902020404010403050106
Content-Type: text/plain;
 name="hcidump_X_V.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump_X_V.txt"

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:60:57:EA:DB:DE class 0x500204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:60:57:EA:DB:DE role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:60:57:EA:DB:DE type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: de db ea 57 60 00 01                              ...W`..
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
  0000: 29 00 18 cc                                       )...
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0045
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0045 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0045 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0045 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x1 len 0x8
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 65535
          cont 00
< ACL data: handle 41 flags 0x02 dlen 34
    L2CAP(d): cid 0x0045 len 30 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x19
          count 5
          handles 0x0 0x10000 0x10001 0x10002 0x10003
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x2 len 0xe
          handle 0x0
          max 1024
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 41 flags 0x02 dlen 154
    L2CAP(d): cid 0x0045 len 150 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x91
          count 142
          aid 0x0000 (SrvRecHndl)
             uint 0x0
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1000 (SDServer) >
          aid 0x0003 (SrvID)
             uuid-16 0x0001 (SDP)
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) uint 0x1 uint 0x1 > >
          aid 0x0005 (BrwGrpList)
             < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0006 (LangBaseAttrIDList)
             < uint 0x656e uint 0x6a uint 0x100 >
          aid 0x0100 (SrvName)
             str "SDP Server"
          aid 0x0101 (SrvDesc)
             str "Bluetooth service discovery server"
          aid 0x0102 (ProviderName)
             str "BlueZ"
          aid 0x0200 (VersionNumList)
             < uint 0x100 >
          aid 0x0201 (SrvDBState)
             uint 0x440fe3cf
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x3 len 0xe
          handle 0x10000
          max 1024
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 41 flags 0x02 dlen 125
    L2CAP(d): cid 0x0045 len 121 [psm 1]
        SDP SA Rsp: tid 0x3 len 0x74
          count 113
          aid 0x0000 (SrvRecHndl)
             uint 0x10000
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1001 (BrwsGrpDesc) >
          aid 0x0006 (LangBaseAttrIDList)
             < uint 0x656e uint 0x6a uint 0x100 >
          aid 0x0100 (SrvName)
             str "Public Browse Group Root"
          aid 0x0101 (SrvDesc)
             str "Root of public browse hierarchy"
          aid 0x0102 (ProviderName)
             str "BlueZ"
          aid 0x0200 (VersionNumList)
             uuid-16 0x1002 (PubBrwsGrp)
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x4 len 0xe
          handle 0x10001
          max 1024
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 41 flags 0x02 dlen 146
    L2CAP(d): cid 0x0045 len 142 [psm 1]
        SDP SA Rsp: tid 0x4 len 0x89
          count 134
          aid 0x0000 (SrvRecHndl)
             uint 0x10001
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1105 (OBEXObjPush) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x3 > <
             uuid-16 0x0008 (OBEX) > >
          aid 0x0005 (BrwGrpList)
             < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
          aid 0x0100 (SrvName)
             str "Obex Push Server"
          aid 0x0101 (SrvDesc)
             str "KDE OBEX Object Push Service"
          aid 0x0303 (SuppFormatsList)
             < uint 0xff uint 0x1 uint 0x2 uint 0x3 uint 0x4 uint 0x5 uint 0x6 >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x5 len 0xe
          handle 0x10002
          max 1024
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 41 flags 0x02 dlen 111
    L2CAP(d): cid 0x0045 len 107 [psm 1]
        SDP SA Rsp: tid 0x5 len 0x66
          count 99
          aid 0x0000 (SrvRecHndl)
             uint 0x10002
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1101 (SP) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x5 > >
          aid 0x0005 (BrwGrpList)
             < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0100 (SrvName)
             str "KBtSerialChat"
          aid 0x0101 (SrvDesc)
             str "KDE Bluetooth Serial Chat Service"
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x6 len 0xe
          handle 0x10003
          max 1024
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 41 flags 0x02 dlen 133
    L2CAP(d): cid 0x0045 len 129 [psm 1]
        SDP SA Rsp: tid 0x6 len 0x7c
          count 121
          aid 0x0000 (SrvRecHndl)
             uint 0x10003
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1101 (SP) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1b > >
          aid 0x0005 (BrwGrpList)
             < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0100 (SrvName)
             str "KDE Bemused Server"
          aid 0x0101 (SrvDesc)
             str "KDE Server for the Bemused remote control protocol"
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0045
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0045
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41


--------------060902020404010403050106--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
