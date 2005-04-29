Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Attila Zsigmond <mail@backend-wizard.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Something strange with minicom
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200504300003.22570@ByZsA>
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
Date: Sat, 30 Apr 2005 00:03:21 +0200

> are you sure that you wanna be in security mode 3. Using auth and
>  encrypt is not advisable.

I turned off but it makes no difference...

> Make sure that you grep the initial HCI and L2CAP connection setup,
>  because otherwise hcidump is not able to decode RFCOMM. Or specific
> the --psm=3 option on the command line.

Here is a new dump with --psm=3:

HCI sniffer - Bluetooth packet analyzer ver 1.20
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      61
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      74
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      7A
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0D
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
      0D 0A 45 52 52 4F 52 0D 0A

I don't see any echoed characters at the end, only the "ERROR" message. 
But ATZ is a very common modem command and as I wrote earlier, it works 
with windows hyperterminal. I noticed that I enter only "AT", I got an 
OK. But any other AT commands don't work.

I'm sorry but I'm a newbe and don't know how to "grep the initial HCI 
and L2CAP connection setup". Here is my hcid.conf file:

options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /bin/bluepin;
}
device {
        name "Cornflower";
        class 0x3e0100;
        iscan enable; pscan enable;
        lm master;
        lp rswitch,hold,sniff,park;
}

My mobile is a sharp gx15. Here is its "hcitool info" output, maybe it 
can help:

Requesting information ...
        BD Address:  08:00:1F:51:D1:E9
        Device Name: Wildrose
        LMP Version: 1.1 (0x1) LMP Subversion: 0x460
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xef 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
        <3-slot packets> <5-slot packets> <encryption> <slot offset>
        <role switch> <hold mode> <sniff mode> <park state> <RSSI>
        <channel quality> <SCO link> <HV2 packets> <HV3 packets>
        <u-law log> <A-law log> <CVSD> <paging scheme>
        <transparent SCO>

Please tell me if you need any other info...

Attila


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
