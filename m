Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Seon-Wook Park <seon.wook@swook.net>
Date: Tue, 17 Jun 2014 19:29:53 +0900
Message-ID: <CANLOmB5UXAJRModTofiYy-gtj=DvDiq_PU_n6NswrbXw_9_94A@mail.gmail.com>
Subject: L2CAP socket to HCI handle, opposite possible?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm currently using noble, a BLE library written in node.js.

The issue, as mentioned in more detail on GitHub [2], has to do with
setting connection parameters on connect to a peripheral.

The library currently connects to peripherals via a L2CAP socket
connection. The HCI handle for each connection is retrieved via
`getsockopt` using the key `L2CAP_CONNINFO`. This HCI handle is then
used for actions such as retrieving RSSI values.

This unfortunately does not allow the setting of connection parameters
which can later be updated with `hci_le_conn_update` with a long
interval (15s) between connecting and acknowledging of parameters
update. This is not appropriate for our use.

>From looking through bluez sources, I have gathered that min/max
interval parameters are taken from a `struct hci_dev` associated with
the connection attempt, while supervisation_timeout values have
hardcoded defaults. The `hci_dev` struct is unretrievable however. Is
there a way I have missed?

These problems could be alleviated if I could create a HCI socket
connection and retrieve/create a L2CAP channel from it to use in
further communication. Is this possible?

Thanks,

Seon-Wook Park

[1] https://github.com/sandeepmistry/noble
[2] https://github.com/sandeepmistry/noble/issues/78
