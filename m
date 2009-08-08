Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
Date: Sat, 8 Aug 2009 05:22:09 -0300
Message-ID: <6b53b1990908080122m1f66f07et97d05a163be5d58a@mail.gmail.com>
Subject: [BUG] kernel panic with bluetooth-testing
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

This commit is broken, but I don' t know why ;-). It's causing a
kernel panic on my machine.
The case is: I run a l2test server and a l2test client to transfers
some data and the I try to reload l2cap. When reloading, the kernel
crashes.

commit f571be19e140443e25092638433aeec776688f50
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Thu Jul 30 06:04:52 2009 +0200

    Bluetooth: Fix wrong device reference counting

    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


-- 
Gustavo F. Padovan
http://padovan.org
