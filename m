Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH] BlueZ line discipline baud rate setting update
Date: Mon, 15 Jun 2015 12:50:06 -0400
Message-ID: <1434387007-3666-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

At Marcel's request, I'm providing a version of the hci_uart_set_baudrate
function that works well for me.

Ilya Faenson (1):
  BlueZ line discipline baud rate setting update

 drivers/bluetooth/hci_ldisc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
1.9.1

