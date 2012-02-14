Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/4] GATT over LE reverse service discovery fixes
Date: Tue, 14 Feb 2012 12:06:00 -0400
Message-Id: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series fixes issues when doing reverse GATT service discovery over LE.

There is still one open issue: If BlueZ creates a device without bonding (i.e.
CreateDevice() D-Bus method), but the remote requests SMP pairing with
"Security Request", at the end of the pairing a reverse GATT service discovery
is issued, *regardless* of BlueZ being the initiator or not. BlueZ should only
do reverse discovery if it is the acceptor (see comments on the
device_bonding_complete() function on src/device.c).

To fix this, I think we need to have a more robust way to check whether we are
initiator or acceptor, instead of simply checking for an active bonding
request. Currently, if BlueZ receives keys from kernel over mgmt,
device_bonding_complete() is eventually called, and if there is no active
bonding, BlueZ assumes to be an acceptor.

In any case, with these patches we make sure this spurious service discovery
will not crash BlueZ or create leaks. It is also applicable for "normal"
reverse service discovery as well.

Best Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil
