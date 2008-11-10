Return-Path: <cyrus@holtmann.org>
Message-ID: <491868E6.6000406@parrot.com>
Date: Mon, 10 Nov 2008 18:01:26 +0100
From: Matthieu CASTET <matthieu.castet@parrot.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: btusb and HCI_RAW
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,


with HCI_RAW, application can bypass the bluez stack and send raw stuff
to dongle.

This seems not possible anymore with btusb because it uses
"hdev->conn_hash" to check if ACLDATA/SCODATA should be send/received.

These checks make the HCI_RAW mode a bit useless (ie not working for acl
and sco).

Can we make the HCI_RAW work like before with acl and sco data ?
For example we can ignore theses check in HCI_RAW mode and send a notify
event when we turn on/off HCI_RAW mode.


Matthieu


PS : what happen if a dongle receive acl/sco data that aren't collected
by the host (because urb aren't submitted) ?
They remain in a FIFO ? There are dropped ?
