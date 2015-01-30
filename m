Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 29 Jan 2015 19:17:48 -0800
Message-ID: <CAHrH25TefKw1M8vP4q0217tBvuHbcdRxWvrvgbVayaH-Qkhd9w@mail.gmail.com>
Subject: Changing gatt_db_attribute_read|write signatures
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm currently in the process of implementing a shared/gatt based
version of src/attrib-server for bluetoothd. I'm basically adding a
new src/gatt-server module that hosts the GATT/GAP services for the
daemon and will manage things like per-device CCC states and sending
out "Service Changed" on modifications to the gatt-db.

For the CCC part, I wanted to make use of the bdaddr_t* parameter to
gatt_db_attribute_read|write (and the corresponding gatt_db_read_t &
gatt_db_write_t callbacks), then I realized that we may need to pass
in the bdaddr_type as a parameter as well.

Since this involves modifying the android part of the code, is there
any preference as to how the bdaddr data should be passed? Should I
introduce a new baddr structure that stores both the bdaddr_t and the
type? Or would we want to go a different route and perhaps pass in a
bt_att* there instead (I'm already modifying bt_att so that core can
set and get bdaddr data from it)?

Let me know what works better!
Arman
