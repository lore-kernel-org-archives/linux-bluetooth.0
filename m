Return-Path: <cyrus@holtmann.org>
Message-ID: <55AFD75C.3090004@ubnt.com>
Date: Wed, 22 Jul 2015 20:48:12 +0300
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: jamuraa@chromium.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: BUG: LE adv manager may miss DBus client disconnection
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

	LE adv manager is supposed to clear advertisements when the DBus client, which did the registration, is disconnected. However, client_disconnect_cb() from advertising.c is not called if DBus client calls RegisterAdvertisement DBus method and then immediately exits (like exit(0)). Next time, the client gets "Maximum advertisements reached" error and is unable to register advertisements until bluetooth daemon is restarted. Obviously, it shouldn't matter for BlueZ daemon whether client terminates gracefully or not. It might be related to some mistake in refcount handling of DBusClient in advertisement code, but I'm not really sure.
	Bluez 5.32 + Linux 4.1.2 used.

BR, Andrey
