Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 11 Aug 2011 14:56:01 -0400
Message-ID: <CAJLFYtqqVRU920HwvNm1tfxW7F_QnB-ESK3HR21eO6Of4P_yzw@mail.gmail.com>
Subject: =?UTF-8?Q?A_problem_about_Authentication=E2=80=8F?=
From: cheng zheng <czheng4ml@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
I am using bluez on Gentoo and meet a problem recently.
I was trying to connect to a medical device via bluetooth.
(00:11:B1:B3:4E:B4    clock offset: 0x1242    class: 0x001f00). When I
connect it at first, it works. However, if I accidentally shut off the
device manually and reconnect it, I got the failed message like this,

localhost ~ # rfcomm connect 0 00:11:B1:B3:4E:B4 1
Can't connect RFCOMM socket: Permission denied

The message from hcidump is


localhost ~ # hcidump hci0
HCI sniffer - Bluetooth packet analyzer ver 2.0
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:11:B1:B3:4E:B4 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:11:B1:B3:4E:B4
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:11:B1:B3:4E:B4 key C0451619A2D93536E094FCFFE8DA160E
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:11:B1:B3:4E:B4
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 12 bdaddr 00:11:B1:B3:4E:B4 type ACL encrypt 0x00
    Error: Authentication Failure

So I think I should clean up some residues to finish the process of
authentication. But I don't know where they are under linux filesystem
hierarchy. Of course I can delete them through some GUI bluetooth
manager like gnome-bluetooth. But my supervisor expects that I can
write a code to clean them up.

Can anyone help me?

Thanks

Cheng
