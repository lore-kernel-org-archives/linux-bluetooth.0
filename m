Return-Path: <cyrus@holtmann.org>
From: Ankur Patel <ankur@embertec.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 1 Jun 2015 19:00:18 +0930
Subject: As Slave: Disable/Delay  the sending of Connection Parameter Update
 Request
Message-ID: <BD5E516FF3711A41B93DC005170007BB010E5DB58388@EMBSVR01.ember.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Folks,

Using Bluez 5.30 based controller acting as Slave Role, I would like to prevent/delay the send Connection Parameter Update Request just after successful connection. 

Steps of Communication b/w Host and Controller:
1. Contoller prepared in connectable mode by issuing command:  hciconfig hci0 leadv
2) Below is the communication sequence:
        (H -> C): Type: Command opcode: 0x200d - Create Connection
        (C -> H): Type: Event   opcode: 0x200d - Command Status
        (C -> H): Type: Event                  - LE Connection Complete
        (C -> H): ACL Data:  Connection Parameter Update Request

Is it possible to disable/delay controller to send Connection Parameter Update Request or send it with any delay?


Some Info on the Modes set on Controller:
root@imx28evk:~# hciconfig -a
hci0:   Type: BR/EDR  Bus: UART
        BD Address: 1C:BA:8C:86:81:21  ACL MTU: 1021:6  SCO MTU: 180:4
        UP RUNNING 
        RX bytes:1776 acl:1 sco:0 events:72 errors:0
        TX bytes:1118 acl:2 sco:0 commands:69 errors:0
        Features: 0xff 0xfe 0x2d 0xfe 0xdb 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF 
        Link mode: SLAVE ACCEPT 
        Name: 'bttest'
        Class: 0x001f00
        Service Classes: Unspecified
        Device Class: Invalid Device Class!
        HCI Version: 4.0 (0x6)  Revision: 0x0
        LMP Version: 4.0 (0x6)  Subversion: 0xac6c
        Manufacturer: Texas Instruments Inc. (13)


Regards,
Ankur
