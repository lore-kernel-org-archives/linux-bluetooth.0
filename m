Return-Path: <cyrus@holtmann.org>
Message-ID: <55279AD0.9010305@ubnt.com>
Date: Fri, 10 Apr 2015 12:41:36 +0300
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: D-Bus signal race condition for Gatt characteristic notification
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

	There is a race condition when Gatt-client characteristic (att attribute) is notified (or indicated) by the remote server multiple times in a row and D-Bus property change signals with notified "Value" are emitted. It happens in write_characteristic_cb(). D-Bus signal is scheduled to be emitted later (during main loop idle, for example) in g_dbus_emit_property_changed::add_pending(). As I see, there are two issues here:

1) Each property can have at most one pending notification signal. If the previous signal is not yet sent out, the new signal is discarded (see g_dbus_emit_property_changed::find_property()). It looks bad to me, because there is no guarantee that D-Bus listener will get all received notifications/indications.

2) When property change D-Bus signal is emitted, the current value of the characteristic is used which might be already overwritten since the moment of Att notify/indicate receiving.

Such behavior is fatal when each notification carries some new data. If notification is lost, data is also lost.

I have fixed it in a trivial way - by adding g_dbus_flush() call into the write_characteristic_cb(). So that each each Att notification synchronously triggers the sending of D-Bus property change signal and it helps in my scenario. The question - is it a good way to fix it? If yes, I can submit a patch.

BR, Andrey
