Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 4 Aug 2010 19:38:51 +0530
Message-ID: <AANLkTimAktDFG+abbsMpgKfkNtmX3tqqhwXd-OZwgRWj@mail.gmail.com>
Subject: Reg: L2cap Security And Role Switch
From: "Prabhakaran M.C" <mcprabhakaran@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello All,

 Whenever L2cap security is HIGH and remote device does role switch,
Bluez accepts the Role switch and L2cap disconnects the channel
because of HIGH security.

 For PAN profile, I would like to keep the L2cap security to HIGH
since it involves internet browsing but the Widcomm stack always does
a role switch in PAN connection and Bluez disconnects l2cap channel.

 Can someone please point in specification about the l2cap security
level and Role switch relation. I tried to find out this but I could
not get this behavior described in specification. Please provide your
comments and inputs. Thanks in Advance.

Thanks,
Prabhakaran.
