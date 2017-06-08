Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Eric Khach <eric.khach@withings.com>
Date: Thu, 8 Jun 2017 18:19:15 +0200
Message-ID: <CAOUq_=X3YJ3jWe8KtSbOAy3wO-zWp6Wi9F1wgBa6x5F_-SOpGA@mail.gmail.com>
Subject: Could not force LE connection to a dual mode server
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have two dual mode devices (BR/EDR & LE) and I need them to
communicate through LE transport. The server device advertises as an
LE general discoverable mode and does not specify that BR/EDR is not
supported (in the advertisement flags). Is there a way to force LE
connection ?

I have seen that BR/EDR has priority over LE since version 4.2 but I
could not find any way to force bluetoothd to use LE connection.
However, it sometimes did use LE connection (it might have something
to do with the duration threshold in select_conn_bearer function in
device.c).

If there is no way to do so, I thought that I could maybe add an
optional parameter in the Connect dbus method on org.bluez.Device1
interface. This optional parameter for the bearer type would only be
used in case BR/EDR and LE timestamps are equal (or come from the same
advertisement packet) and would default to BR/EDR so that priority
stays like before.

Thank you for your consideration,
Eric KHACH
