Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Laczen JMS <laczenjms@gmail.com>
Date: Tue, 5 Sep 2017 15:30:39 +0200
Message-ID: <CAFxSrVvQFG-ByTFdR5tt64W=RK9e_=Xnyg9GPve4KZ00wM9Gow@mail.gmail.com>
Subject: bluetooth mesh (meshctl) - feedback
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have been working with meshctl the last days and I have some
feedback that may be interesting for the developers:

1. When disconnecting from the mesh (by disconnect or quit) the last
command that was received from the mesh is replayed. In some cases
this can result in a damaged provision database (e.g last command was
bind, this is added twice to the database after disconnect).

2. The services are not closed when exiting the program, when the
program is restarted there are some services and char connections
available, at startup you see:
Local config directory not provided.
# netkeys = 1
# appkeys = 2
# provisioners = 1
# provisioned nodes = 8
On/Off client model: new binding 0001
[NEW] Controller 00:1A:7D:DA:71:0D Dell-3721 #2 [default]
Service added /org/bluez/hci1/dev_C3_F0_13_5D_5F_5E/service000a
Char added /org/bluez/hci1/dev_C3_F0_13_5D_5F_5E/service000a/char000d:
Char added /org/bluez/hci1/dev_C3_F0_13_5D_5F_5E/service000a/char000b:
Service added /org/bluez/hci1/dev_C3_F0_13_5D_5F_5E/service0006
[NEW] Controller 9C:2A:70:C7:DB:F6 Dell-3721 #1
[meshctl]#

3. When using a node with static oob (16 byte) I have not succeeded in
entering the 16byte key data, I tried several methods: ab...,
0xab0x..,

Kind regards,

Jehudi
