Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/2] Bluetooth: btusb: Add new Realtek devices
Date: Sun, 11 Feb 2018 12:24:31 -0600
Message-Id: <20180211182433.591-1-Larry.Finger@lwfinger.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Realtek has several devices that have recently been released, or will be
released in the near future. These changes enable the BT portion of them.

The necessary firmware updates have been submitted to linux-firmware.

Larry

Hon Weng Chong (1):
  bluetooth: btusb: Add device ID for RTL8822BE

Alex Lu (1):
  Bluetooth: btrtl: Add RTL8723D and RTL8821C devices

-- 
2.16.1
