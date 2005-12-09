Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4303.128.59.13.26.1134166099.squirrel@webmail.cs.columbia.edu>
From: mv2147@cs.columbia.edu
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Bluez-users] bluetooth USB device Class for Audio Handoff.
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
Date: Fri, 9 Dec 2005 17:08:19 -0500 (EST)



Hi everyone,

    I am developing a SIP based application for RTP audio handoff
between bluetooth headsets while a call session is in progress.
I am using Dlink DBT-120 adapters and Jabra-250v headsets.
Unfortunately, the correct class of the Dlink DBT-120 is not being
recognized. Though it is able to discover the headset, it is not able
to connect the headset.
I am able to change the class with....

hciconfig hci0 class 0x3e0100, but this does not help.

Can someone help me out with the firmware upgrade or
bluetooth setup?
Please see below for details...
root@lirr sipua]# btsco 00:07:A4:26:8D:3F
Error: Failed to connect to SDP server: Function not implemented  !!!
Assuming channel 2

[root@lirr kernel]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:13:46:4C:0B:8B ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1570 acl:0 sco:0 events:59 errors:0
        TX bytes:347 acl:0 sco:0 commands:40 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'lirr.cs.columbia.edu-0'
        Class: 0x000000 --------------------------???!!!!!!
        Service Classes: Unspecified --------------????!!!!
        Device Class: Miscellaneous,--------------????!!!!
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
