Return-Path: <cyrus@holtmann.org>
From: Manoj Iyer <manoj.iyer@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [Patch 0/1] Bluetooth: btusb: Add vendor specific ID (0a5c:21f4) BCM20702A0
Date: Wed, 11 Apr 2012 13:39:22 -0500
Message-Id: <1334169563-2948-1-git-send-email-manoj.iyer@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>


Please consider this patch to add vendor specific ID 
for BCM20702A0. Reported/Tested by Dennis Chua <dennis.chua@canonical.com>
on a Lenovo system.

root@u-k29-814ti006g:~# hcitool dev
Devices:
 hci0	E4:D5:3D:F1:55:84
