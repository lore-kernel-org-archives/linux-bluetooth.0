Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 3 Dec 2014 14:04:05 -0800
Message-ID: <CAD0=r8y1PncR+u8fxA5man-vLgHvODHf0Sk6wUfZVQJbCEbEkA@mail.gmail.com>
Subject: I tested Start Service Discovery on multiple controllers
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I've run my start service discovery method on:
- Intel Wilkins Peak 2
- Atheros WB222
- Marvell 8797
- Broadcom BCM20702A0

(Previously I was testing only on Broadcom and Atheros)

And I find out, that:
For LE scan, none of above controllers report same device multiple
times when rssi changes except for Marvell, which seems to ignore
LE_SCAN_FILTER_DUP_ENABLE, and reports all advertisements.
Therfore I just send updated version of my patches, that restarts LE
scan for all controllers when needed in mgmt_device_found.

I also decided not to use HCI_QUIRK_STRICT_DUPLICATE_FILTER, because
it applies to bluetooth classic scan (HCI_OP_INQUIRY), not LE scan
(HCI_OP_LE_SET_SCAN_ENABLE).

I remember when I was starting my work Marcel said that controllers
should report same device when it's RSSI changes when deduplication is
enabled, but it must be true for HCI_OP_INQUIRY, not for
HCI_OP_LE_SET_SCAN_ENABLE, right?


I also think that this method doesn't make sense for BREDR, or
interleaved scan, only for LE, so maybe we should remove type
parameter from MGMT_OP_START_SERVICE_DISCOVERY and make it LE only, or
return some error message ?
