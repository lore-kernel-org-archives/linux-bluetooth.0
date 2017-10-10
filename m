Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yunhanw@nestlabs.com
From: Yunhan Wang <yunhanw@nestlabs.com>
Date: Tue, 10 Oct 2017 00:57:20 -0700
Message-ID: <CALvjcs8EHZWsNd+wwcQ_XgdstpgLCpVa-Je-Xuo0PYq=anrtuw@mail.gmail.com>
Subject: notification has not yet been cleaned in server side when ble is disconnected.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Luiz

I am seeing a bluez gatt notification problem in gatt-database.c

Here is scenario:

1. Assume server has one characteristic A that is subscribed by client
and sending notification,
2. Then ble connection is disconnected by client directly or
connection disappear without unsubscribing A.
3. Client tries to connect to ble successfully
4. Client fails to subscribe that characteristic A.
5. Another retry to make Ble connection and subscribe to A can work.

It seems ble disconnect does not cleanup notify_io and stop
notification in step 3 at code,
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c

It seems retry in step 5 would

ccc_write_cb() External CCC write received with value: 0x0000
pipe_hup() 0x921290 closed
gatt_ccc_write_cb() CCC write called for handle: 0x0037
