Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Alexandre Coser Monteiro" <coser@cos.ufrj.br>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Thu, 13 Jul 2006 20:27:07 -0200
Message-Id: <20060713213636.M32080@cos.ufrj.br>
In-Reply-To: <1152824744.4838.83.camel@localhost>
References: <1152824480.6204.18.camel@anselm.venusberg.augustinnetz.de>
	<1152824744.4838.83.camel@localhost>
MIME-Version: 1.0
Subject: [Bluez-users] hold mode Disallowed
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


    I`m new in this bluetooth stuff and I`ve tried some experiments for my graduation,
but I find some problems.
    I would like to know why my hold command isn`t working ? My connection it is OK, I
have the hold feature, I set the link policy in Hold mode, but hcidump get an error :
command disallowed. Why ?
    At same set, what kind of fault is possible to make sniff mode doesn`t work almost
evrytime and work at next second time, if I do nothing different to submit the command ?
    There is some way to set this bluetooth dongle in park mode with this feature not
show up in feature status of this device ?
   
 Thanks for any help !

--
Sds,
 Alexandre

[root@prata ~]# hcitool con Connections:
        > ACL 00:10:60:B0:B8:F3 handle 6 state 1 lm SLAVE

Machine 2 - Slave

[root@prata ~]# hcitool cmd 0x02 0x0001 0x06 0x00 0x80 0x00 0x40 0x00

HCIDUMP

< HCI Command: Hold Mode (0x02|0x0001) plen 6
  0000: 06 00 80 00 40 00                                 ....@.> HCI Event: Command
Status (0x0f) plen 4
    Hold Mode (0x02|0x0001) status 0x0c ncmd 1
    Error: Command Disallowed


[root@prata ~]# hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:10:60:B0:B8:69 ACL MTU: 377:10 SCO MTU: 16:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <AFH cap. slave> <AFH cap. master>



[root@prata ~]# hciconfig -a hci0
hci0:   Type: USB
        BD Address: 00:10:60:B0:B8:69 ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:11885 acl:344 sco:0 events:53 errors:0
        TX bytes:336 acl:10 sco:0 commands:42 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2035'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)

Machine 1 - Master

[root@helio script]# hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:10:60:B0:B8:F3 ACL MTU: 377:10  SCO MTU: 16:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <AFH cap. slave> <AFH cap. master>

[root@helio script]#  hciconfig -a hci0
hci0:   Type: USB
        BD Address: 00:10:60:B0:B8:F3 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:9138055 acl:25059 sco:0 events:130106 errors:0
        TX bytes:8677635 acl:21920 sco:0 commands:125603 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD
        Link mode: SLAVE ACCEPT
        Name: 'Broadcom BCM2035'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
        Manufacturer: Broadcom Corporation (15)








-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
