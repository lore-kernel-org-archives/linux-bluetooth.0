Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Baptiste Mille-Mathias <baptiste.millemathias@gmail.com>
Date: Mon, 15 Feb 2010 13:54:44 +0100
Message-ID: <920101ab1002150454t31c94b2bh4b1825b4d8ed0db9@mail.gmail.com>
Subject: API broken in bluez 4.61
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

While packaging latest release of bluez, I seen the API compatibility
was broken.
hci_read_inquiry_transmit_power_level was removed and thus would have
required to bump the soname.

Thanks for fixing that.

Regards
-- 
Baptiste Mille-Mathias
Les gens heureux ne sont pas pressés
