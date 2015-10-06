Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
Subject: LE ADV data is lost after first connection
Message-ID: <56137272.2040809@ubnt.com>
Date: Tue, 6 Oct 2015 10:04:18 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

	I'm on Bluez 5.35 + Kernel 4.1.6 using D-Bus LE Adv Manager to register my own advertisement structure (with service UUID). Everything works fine, I see my UUID is present in scan record (using Android Bluetooth LE Scanner or iOS Light Blue App). But scan record becomes empty (all zeros) after I connect/disconnect to the peripheral.

	This issue, however, only present on Atheros AR3012 Bluetooth chip (USB vendor:product is 0cf3:3004) and not present neither on Broadcom BCM20705 nor on CSR. Based on btmon traces I see that after peripheral is disconnected, LE adv is enabled again using HCI "LE Set Advertising Parameters" and "LE Set Advertise Enable" commands which obviously do not set the adv data again.

	My assumption is that BT chip is expected to keep LE adv data between re-connections, but Atheros AR3012 (at least the revisions we use) has a bug which erases Adv data after the connection is made.

	Can someone confirm that my assumption is correct and workaround/quirk is needed for AR3012 or maybe there is something else may be wrong here?


BR, Andrey
