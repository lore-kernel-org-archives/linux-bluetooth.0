Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Johannes Kapune <listen@kapune.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1151660752.7416.12.camel@johannes_01.kapune.local>
References: <1151660752.7416.12.camel@johannes_01.kapune.local>
Date: Fri, 30 Jun 2006 17:58:10 +0200
Message-Id: <1151683090.8460.9.camel@johannes_01.kapune.local>
Mime-Version: 1.0
Subject: Re: [Bluez-users] a2play will not work
Reply-To: listen@kapune.de, BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello,
now I can play mp3 on my headphone 
but 
after playing one piece of mp3 the headphone stays in a status in which
it doesn't want to play another mp3. I only can switch the headphone off
an on, bring in pairing-mode and then start the next mp3 which then this
is playing.

Normally when the headphone is idle or working there is a LED blinking,
but at the end of one mp3 it is always off or on.

In my kde-kontrol-window for paired devices it is not listed also not
when the mp3 is playing. At the end of the mp3 I get this in the hcidump
-X -V window:

> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 25]
      AVDTP(s): Close cmd: transaction 5
        ACP SEID 1
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< HCI Command: Read RSSI (0x05|0x0005) plen 2
  0000: 2a 00                                             *.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00
    0000: 2a 00 00                                          *..
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 42
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    status 0x00 bdaddr 00:04:09:00:00:2A
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< HCI Command: Read RSSI (0x05|0x0005) plen 2
  0000: 2a 00                                             *.
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00
    0000: 2a 00 00                                          *..
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 42
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    status 0x00 bdaddr 00:04:09:00:00:2A
< HCI Command: Read RSSI (0x05|0x0005) plen 2
  0000: 2a 00                                             *.
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00
    0000: 2a 00 00                                          *..
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 42
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    status 0x00 bdaddr 00:04:09:00:00:2A
< HCI Command: Read RSSI (0x05|0x0005) plen 2
  0000: 2a 00                                             *.
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00
    0000: 2a 00 00                                          *..
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 42
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    status 0x00 bdaddr 00:04:09:00:00:2A
< HCI Command: Read RSSI (0x05|0x0005) plen 2
  0000: 2a 00                                             *.
> HCI Event: Command Complete (0x0e) plen 7
    Read RSSI (0x05|0x0005) ncmd 1
    status 0x00
    0000: 2a 00 00                                          *..
< HCI Command: Role Discovery (0x02|0x0009) plen 2
    handle 42
> HCI Event: Command Complete (0x0e) plen 7
    Role Discovery (0x02|0x0009) ncmd 1
    status 0x00 bdaddr 00:04:09:00:00:2A
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 42 reason 0x13
    Reason: Remote User Teminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x16
    Reason: Connection Terminated by Local Host
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
                                                        
I hope someone can help.


Johannes   


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
