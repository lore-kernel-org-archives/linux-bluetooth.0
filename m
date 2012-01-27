Return-Path: <cyrus@holtmann.org>
From: Manoj Iyer <manoj.iyer@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [Patch 0/1] Bluetooth: Add support for BCM20702A0 [0a5c:21e1]
Date: Thu, 26 Jan 2012 18:46:38 -0600
Message-Id: <1327625199-10750-1-git-send-email-manoj.iyer@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>


Please consider this patch to add vendor specific ID 
for BCM20702A0. This was tested by me on HP ProBook series, and found 
to work. 

For example.
With this quirk, hci tool is able to list devices correctly. 

$ hcitool dev 
Devices:
        hci0    60:D8:19:F0:3A:6D
 
