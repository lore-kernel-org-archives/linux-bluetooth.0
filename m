Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v1 0/1] Send correct response to IO Capability Request 
Date: Mon, 16 Jan 2012 13:34:28 +0530
Message-ID: <1326701069-19146-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates the IO Capability to DisplayYesNo in case Local Device
IO capability is set to KeyboardDisplay, which is a valid IO capability
for LE Device pairing using SMP.
Without this patch, SSP pairing for 2.1 Devices will not work for devices
having IO Capability set as Keyboard Display.

Hemant Gupta (1):
  Bluetooth: Send correct response to IO Capability Request

 net/bluetooth/hci_event.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

