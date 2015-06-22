Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2015 12:13:48 +0200
Message-ID: <CANzaTi7NSBf8iuTC41jBA=732PCZUYkzw_ZTywGM-xNQt68qbw@mail.gmail.com>
Subject: BLE Advertise and Scan at the same time?
From: dogan yazar <doganyazar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is it possible to advertise (leadv) and scan (scan on) using the same
ble adaper?
The moment that I enable scanning (scan on) with bluetoothctl, leadv
is disabled.

The reason I want is to have a GATT client and server at the same time.
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
