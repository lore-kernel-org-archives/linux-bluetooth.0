Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Dorsch <rdorsch@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pand seem to ignore any pin configurations
References: <200505072203.45598.rdorsch@web.de> <200505072339.13643.rdorsch@web.de> <1115503367.9031.31.camel@pegasus>
In-Reply-To: <1115503367.9031.31.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200505081508.10056.rdorsch@web.de>
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
Date: Sun, 8 May 2005 15:08:09 +0200

Hi Marcel,

thanks again for the immediate answer.

Am Sonntag, 8. Mai 2005 00:02 schrieb Marcel Holtmann:
> Hi Rainer,
>
> > thanks for the quick reply. Where would I specify the PIN on the PANU?
> > Should pin_helper in hcid.conf provide this? Where would I specify the
> > PIN on the NAP?
>
> if you use "security user" then the PIN is provided through the PIN
> helper script.

and auto just uses the pin in 

/etc/bluetooth/pin ?

Then all the helper scripts in the net which print out

PIN: <content of /etc/bluetooth/pin>

are nonsense?

Examples are here http://www.triptico.com/software/bluetooth.html and here 
http://gentoo-wiki.com/HOWTO_The_host-to-host_Bluetooth


When security user on NAP and PANU, is pin_helper called both on PANU and NAP 
and the pins just should be the same?


>
> > There is no --auth for pand:
>
> You read my answer, do you? I said that I realized that it is missing
> and that you should use --encrypt instead. It is fixed in the CVS.

I apologize for not carefully reading.

>
> > Do I need
> >
> >         # Authentication and Encryption (Security Mode 3)
> >         auth enable;
> >         encrypt enable;
> >
> > in the device section of /etc/bluetooth/hcid.conf?
>
> If you know what security mode 3 means, feel free to use it otherwise
> you might wanna look into the Bluetooth specification first. And btw
> there is a reason why it is commented out ;)

Thanks. I commented it out again ;-)

>
> > When I do have them and the --encrypt option for pand on the NAP
> >
> > rd@silverboxy:~$ ps uaxwww|grep pand|grep -v grep
> > root     15840  0.0  0.1  1548  536 ?        Ss   23:32   0:00
> > /usr/bin/pand --encrypt --listen --persist --role NAP --pidfile
> > /var/run/pand.pid rd@silverboxy:~$
> >
> > I still get pinless authentification (or they somehow match, though I
> > tried to make them different in all files).
>
> Check with "hcidump -X -V" is you are not already paired and both sides
> only authenticate with a link key. You can also use "hcitool auth" do
> trigger the authentication by hand.

hcitool auth is pretty transparent. When I dump on the PANU and run hcitool 
auth <PANU-addr> on the NAP, I get no output at all from hcidump, when I run 
hcitool auth <NAP-addr>, I get (again from hcidump on PANU):


< HCI Command: Authentication Requested (0x01|0x0011) plen 2
  0000: 29 00                                             ).
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 41


Hmm....is pairing persistent over rebooting one or both systems (NAP: security 
auto and PANU: security user)? At least that is what I did and I did not 
enter a password. pin_helper is bluez-pin on the PANU, so I expect that PANU 
should have querried for a password in any case.

Replugging the usb bt dongle restarts bluez-utils. Is pairing persistent over 
restarting bluez-utils?

Is it ok that pand on the PANU dies after connection establishment?

root      4296  0.0  0.2  1548  492 ?        S<   14:48   0:00 /usr/bin/pand 
--nodetach --role PANU --search --encrypt
root      4303  0.0  0.2  1548  472 pts/2    S+   14:49   0:00 grep pand
topsi:~# ps uaxwww|grep pand
root      4397  0.0  0.2  1548  472 pts/2    S+   14:50   0:00 grep pand
topsi:~# 


I did an hcidump after replugging the bt usb dongle on PANU, hcidump is also 
on PANU:

topsi:~# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.17
Can't attach to device hci0. No such device(19)
topsi:~# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 0a 0a                                    3....
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:04:61:82:24:9F clkoffset 0x2945 class 0x3e0100
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 9f 24 82 61 04 00 18 cc  01 00 45 a9 01           .$.a......E..
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
  0000: 03                                                .
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    0000: 00                                                .
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
  0000: 00                                                .
> HCI Event: Command Complete (0x0e) plen 4
    Write Authentication Enable (0x03|0x0020) ncmd 1
    0000: 00                                                .
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
  0000: 00                                                .
> HCI Event: Command Complete (0x0e) plen 4
    Write Authentication Enable (0x03|0x0020) ncmd 1
    0000: 00                                                .
< HCI Command: Write Encryption Mode (0x03|0x0022) plen 1
  0000: 00                                                .
> HCI Event: Command Complete (0x0e) plen 4
    Write Encryption Mode (0x03|0x0022) ncmd 1
    0000: 00                                                .
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
  0000: 00 01 3e                                          ..>
> HCI Event: Command Complete (0x0e) plen 4
    Write Class of Device (0x03|0x0024) ncmd 1
    0000: 00                                                .
< HCI Command: Write Local Name (0x03|0x0013) plen 248
  0000: 74 6f 70 73 69 2d 30 00  00 00 00 00 00 00 00 00  topsi-0.........
  0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00                           ........
> HCI Event: Command Complete (0x0e) plen 4
    Write Local Name (0x03|0x0013) ncmd 1
    0000: 00                                                .
> HCI Event: Role Change (0x12) plen 8
  0000: 00 9f 24 82 61 04 00 01                           ..$.a...
> HCI Event: Link Key Request (0x17) plen 6
  0000: 9f 24 82 61 04 00                                 .$.a..
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 9f 24 82 61 04 00 bf 9c  53 9d f1 8e fb 60 50 c7  .$.a....S....`P.
  0010: 11 26 ac e3 16 06                                 .&....
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    0000: 00 9f 24 82 61 04 00                              ..$.a..
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:04:61:82:24:9F type ACL encrypt 0x01
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 29 00 0f 00                                       )...
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    0000: 00 29 00                                          .).
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1116 (NAP)
          max 1
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          count 1
          handle 0x10001
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 15]
      BNEP: Control(0x01|0)
        Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Setup Rsp(0x02) res 0x0000
< ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x000c
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
< ACL data: handle 41 flags 0x02 dlen 32
    L2CAP(d): cid 0x0040 len 28 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0018
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          33:33:00:00:00:01 - 33:33:00:00:00:01
< ACL data: handle 41 flags 0x02 dlen 44
    L2CAP(d): cid 0x0040 len 40 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0024
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          33:33:ff:81:10:da - 33:33:ff:81:10:da
          33:33:00:00:00:01 - 33:33:00:00:00:01
< ACL data: handle 41 flags 0x02 dlen 44
    L2CAP(d): cid 0x0040 len 40 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0024
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          33:33:ff:81:10:da - 33:33:ff:81:10:da
          33:33:00:00:00:01 - 33:33:00:00:00:01
> ACL data: handle 41 flags 0x02 dlen 20
    L2CAP(d): cid 0x0041 len 16 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x000c
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> ACL data: handle 41 flags 0x02 dlen 32
    L2CAP(d): cid 0x0041 len 28 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0018
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 44
    L2CAP(d): cid 0x0041 len 40 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0024
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          33:33:00:00:00:01 - 33:33:00:00:00:01
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> ACL data: handle 41 flags 0x02 dlen 56
    L2CAP(d): cid 0x0041 len 52 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0030
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          33:33:ff:82:24:9f - 33:33:ff:82:24:9f
          33:33:00:00:00:01 - 33:33:00:00:00:01
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> ACL data: handle 41 flags 0x02 dlen 56
    L2CAP(d): cid 0x0041 len 52 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0030
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          33:33:ff:82:24:9f - 33:33:ff:82:24:9f
          33:33:00:00:00:01 - 33:33:00:00:00:01
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 56
    L2CAP(d): cid 0x0041 len 52 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0030
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          33:33:ff:82:24:9f - 33:33:ff:82:24:9f
          33:33:00:00:00:01 - 33:33:00:00:00:01
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 02 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
< ACL data: handle 41 flags 0x02 dlen 44
    L2CAP(d): cid 0x0040 len 40 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0024
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          33:33:ff:81:10:da - 33:33:ff:81:10:da
          33:33:00:00:00:01 - 33:33:00:00:00:01
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
< ACL data: handle 41 flags 0x02 dlen 192
< ACL data: handle 41 flags 0x01 dlen 149
    L2CAP(d): cid 0x0040 len 337 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst ff:ff:ff:ff:ff:ff [proto 0x0800]
        0000: 45 10 01 48 00 00 00 00  40 11 b6 88 c0 a8 02 65  
E..H....@......e
        0010: ff ff ff ff 00 44 00 43  01 34 f0 c2 01 01 06 
00  .....D.C.4......
        0020: 40 39 63 63 00 00 00 00  00 00 00 00 00 00 00 00  
@9cc............
        0030: 00 00 00 00 00 00 00 00  00 04 61 81 10 da 00 
00  ..........a.....
        0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0100: 00 00 00 00 00 00 00 00  63 82 53 63 35 01 03 
32  ........c.Sc5..2
        0110: 04 c0 a8 02 65 37 07 01  1c 02 03 0f 06 0c ff 
00  ....e7..........
        0120: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0130: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0140: 00 00 00 00 00 00 00 00                           ........
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
< ACL data: handle 41 flags 0x02 dlen 192
< ACL data: handle 41 flags 0x01 dlen 149
    L2CAP(d): cid 0x0040 len 337 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst ff:ff:ff:ff:ff:ff [proto 0x0800]
        0000: 45 10 01 48 00 00 00 00  40 11 b6 88 c0 a8 02 65  
E..H....@......e
        0010: ff ff ff ff 00 44 00 43  01 34 f0 be 01 01 06 
00  .....D.C.4......
        0020: 40 39 63 63 00 04 00 00  00 00 00 00 00 00 00 00  
@9cc............
        0030: 00 00 00 00 00 00 00 00  00 04 61 81 10 da 00 
00  ..........a.....
        0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0100: 00 00 00 00 00 00 00 00  63 82 53 63 35 01 03 
32  ........c.Sc5..2
        0110: 04 c0 a8 02 65 37 07 01  1c 02 03 0f 06 0c ff 
00  ....e7..........
        0120: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0130: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0140: 00 00 00 00 00 00 00 00                           ........
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 339
> ACL data: handle 41 flags 0x01 dlen 5
    L2CAP(d): cid 0x0041 len 340 [psm 15]
      BNEP: Compressed(0x02|0)
        [proto 0x0800]
        0000: 45 10 01 51 00 00 00 00  40 11 f3 d5 c0 a8 02 01  
E..Q....@.......
        0010: c0 a8 02 65 00 43 00 44  01 3d 71 7b 02 01 06 
00  ...e.C.D.=q{....
        0020: 40 39 63 63 00 04 00 00  00 00 00 00 c0 a8 02 65  
@9cc...........e
        0030: c0 a8 02 01 00 00 00 00  00 04 61 81 10 da 00 
00  ..........a.....
        0040: 00 00 00 00 00 00 00 00  73 69 6c 76 65 72 62 
6f  ........silverbo
        0050: 78 79 00 00 00 00 00 00  00 00 00 00 00 00 00 00  
xy..............
        0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 
00  ................
        0100: 00 00 00 00 00 00 00 00  63 82 53 63 35 01 05 
36  ........c.Sc5..6
        0110: 04 c0 a8 02 01 33 04 00  00 02 58 01 04 ff ff 
ff  .....3....X.....
        0120: 00 1c 04 c0 a8 02 ff 03  04 c0 a8 02 01 0f 13 
6b  ...............k
        0130: 61 74 68 72 69 6e 75 6e  64 72 61 69 6e 65 72 2e  
athrinundrainer.
        0140: 64 65 06 04 c0 a8 01 01  0c 06 74 6f 70 73 69 62  
de........topsib
        0150: ff                                                .
< ACL data: handle 41 flags 0x02 dlen 56
    L2CAP(d): cid 0x0040 len 52 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0030
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
          33:33:ff:81:10:da - 33:33:ff:81:10:da
          33:33:00:00:00:01 - 33:33:00:00:00:01
< ACL data: handle 41 flags 0x02 dlen 56
    L2CAP(d): cid 0x0040 len 52 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0030
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
          33:33:ff:81:10:da - 33:33:ff:81:10:da
          33:33:00:00:00:01 - 33:33:00:00:00:01
< ACL data: handle 41 flags 0x02 dlen 56
    L2CAP(d): cid 0x0040 len 52 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Set(0x05) len 0x0030
          ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
          01:00:5e:00:00:01 - 01:00:5e:00:00:01
          33:33:ff:81:10:da - 33:33:ff:81:10:da
          33:33:00:00:00:01 - 33:33:00:00:00:01
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Filter MultAddr Rsp(0x06) res 0x0000

Many thanks,
Rainer



>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
Rainer Dorsch
Alzentalstr. 28
D-71083 Herrenberg
07032-919495
Icq: 32550367


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
