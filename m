Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40DA45E0.9000207@popak.myftp.org>
From: Ramin Rezaiifar <ramin@popak.myftp.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Low bit rate
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
Date: Wed, 23 Jun 2004 20:09:20 -0700


I use the bluetooth link between a Palm T3 and a Linux machine.
The data rate seems to be noticeably lower than the rate when I use the 
Palm device with a Windows XP machine.  In both cases I use a Linksys 
USB dongle.

The following is the hciconfig output.  Has anyone else experienced such 
a difference between windows and Linux?
Can I increase the rate with the hcitool by changing the pcacket type 
for the connection?

thanks,

-Ramin


[root@popak root]# hciconfig -a
hci0:   Type: USB
       BD Address: 00:0C:41:E1:E9:E1 ACL MTU: 192:8  SCO MTU: 64:8
       UP RUNNING PSCAN ISCAN AUTH
       RX bytes:1554350 acl:33441 sco:0 events:55264 errors:0
       TX bytes:9553470 acl:66586 sco:0 commands:160 errors:0
       Features: 0xff 0xff 0x0f 0x00
       Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
       Link policy: HOLD SNIFF PARK
       Link mode: SLAVE ACCEPT
       Name: 'popak.myftp.org-0'
       Class: 0x120104
       Service Classes: Networking, Object Transfer
       Device Class: Computer, Desktop workstation
       HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
0x20d
       Manufacturer: Cambridge Silicon Radio (10)




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
