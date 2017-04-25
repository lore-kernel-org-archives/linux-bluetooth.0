Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: "sayandasgupta12@gmail.com" <sayandasgupta12@gmail.com>
Date: Tue, 25 Apr 2017 16:13:28 +0530
Message-ID: <CAF6QkFKyKtJA-TVQnpDCb1inrSMXLkSd14WNJzRREAZbTnf-Ng@mail.gmail.com>
Subject: SENDING GATT NOTIFICATION USING DBUS
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to send GATT notification in bluez 5.43 using DBUS. But
currently the gatt-service.c doesn't provide any details how to send
it using DBUS. Currently

static DBusMessage *chr_start_notify(DBusConnection *conn, DBusMessage
*msg, void *user_data)

    return g_dbus_create_error(msg, DBUS_ERROR_NOT_SUPPORTED, "Not Supported")


is given like this as no characteristic supports notification in the
given code. But I am trying to build a custom service which has
notifiable characteristics. How should i handle it. What should be the
code that i need to write inside char_start_notify to achieve it.
