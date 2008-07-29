Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jul 2008 17:39:56 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, maxk@qualcomm.com
Message-ID: <1882591226.12271217333396980.JavaMail.root@mbv7.indiatimes.com>
Subject: HCI_Reset and Notification to User-Space
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to understand the HCI_RESET procedure and the notification of new device to the user-space, in case of a UART Bluetooth device.

What I am trying to understand is, in what place of hciattach does the whole system, [through dbus] get to know the existance of the bt device and what call [from which module] does that notification go to the user-space.

Just a brief about the hciattach / notification to user-space and socket setup.


Thanks in advance.
Pavan
