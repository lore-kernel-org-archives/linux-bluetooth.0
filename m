Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 23 Jan 2014 21:21:04 -0800
Message-ID: <CAGXr9JEPv+onq6+WZTJ46oRtnrOJBPVQToKA82E84Sg9eSOP5A@mail.gmail.com>
Subject: Paired LE HoG devices are unable to reconnect to BlueZ host when
 discovery is active
From: Petri Gynther <pgynther@google.com>
To: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With BlueZ 5.13, I've noticed that previously paired LE HoG devices
are unable to reconnect to the host when device discovery is active on
the BT interface.

Steps to reproduce:
1. Pair LE HoG device with BlueZ 5.13 host.
2. Verify that keypresses from HoG device are delivered to uHID input pipeline.
3. Let HoG device disconnect from host (due to inactivity timeout).
4. Press key on HoG device. At this point, it reconnects to host fine.
5. Let HoG device disconnect from host again.
6. Start "test-discovery" script.
7. Press key on HoG device => it does not reconnect to host.
8. Kill "test-discovery" script.
9. Press key on HoG device => it now reconnects to host successfully.

It looks to me that the root cause is in src/adapter.c:update_found_devices()

        /*
         * Only if at least one client has requested discovery, maintain
         * list of found devices and name confirming for legacy devices.
         * Otherwise, this is an event from passive discovery and we
         * should check if the device needs connecting to.
         */
        if (!adapter->discovery_list)
                goto connect_le;

        if (g_slist_find(adapter->discovery_found, dev))
                return;

When (active) discovery is on, adapter->discovery_list != NULL, and
g_slist_find(adapter->discovery_found, dev) will obviously find this
device since it is already paired. So, we end up returning from the
function without an attempt to reconnect to the previously paired LE
device.

What would be the right fix here? Stop discovery before attempting to
reconnect to the LE device?
