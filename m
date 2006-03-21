Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Johannes Kapune <listen@kapune.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1142957469.7800.15.camel@johannes_01.kapune.local>
Mime-Version: 1.0
Subject: [Bluez-users] minimum requirements for A2DP?
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
Date: Tue, 21 Mar 2006 17:11:09 +0100

Hi to all.

Fist of all: I'm a newby of compilation and all the stuff around. I'm
sure I will ask a lot of "well known tings"; excuse me.

I checked my installation of my bluetooth dongle with this site:
http://www.gentoo.org/doc/en/bluetooth-guide.xml

I think it runs (see the outputs at the end)

Now there are some questions:

# rfcomm connect 0
Can't connect RFCOMM socket: Connection refused

Why this does not work? What I'm missing?

I hope last question: What I need minimum for bringing A2DP to work?
What I have to test? What are the minimum software I need to install?

If I have to post more informations please tell me.


Thank
Johannes




# /etc/init.d/bluetooth restart
Shutting down bluetooth ( dund opd sdp hcid)
done
Starting bluetooth:  hcid sdpd opd rfcomm dund
done
# hciconfig
hci0:   Type: USB
        BD Address: 00:0A:94:02:7D:A0 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:648 acl:0 sco:0 events:63 errors:0
        TX bytes:986 acl:0 sco:0 commands:50 errors:0

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0A:94:02:7D:A0 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:648 acl:0 sco:0 events:63 errors:0
        TX bytes:986 acl:0 sco:0 commands:50 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ johannes_01 (0)'
        Class: 0x700100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x5dc LMP Ver: 1.1 (0x1) LMP Subver:
0x5dc
        Manufacturer: Cambridge Silicon Radio (10)

# ps -ae | grep hcid
 8107 ?        00:00:00 hcid
# ps -ae | grep sdpd
 8109 ?        00:00:00 sdpd
# hcitool dev
Devices:
        hci0    00:0A:94:02:7D:A0
# hcitool scan
Scanning ...
        00:0A:94:A0:59:3B       BTST-9300
# hcitool inq
Inquiring ...
        00:0A:94:A0:59:3B       clock offset: 0x09e5    class: 0x240404
# l2ping 00:0a:94:a0:59:3b
Ping: 00:0a:94:a0:59:3b from 00:0A:94:02:7D:A0 (data size 20) ...
44 bytes from 00:0a:94:a0:59:3b id 0 time 30.50ms
44 bytes from 00:0a:94:a0:59:3b id 1 time 49.95ms
44 bytes from 00:0a:94:a0:59:3b id 2 time 43.60ms
44 bytes from 00:0a:94:a0:59:3b id 3 time 34.65ms
4 sent, 4 received, 0% loss
  



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
