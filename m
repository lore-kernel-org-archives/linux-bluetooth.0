Return-Path: <cyrus@holtmann.org>
From: Damjan Cvetko <Damjan.Cvetko@monotek.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: LE auto connect
Date: Mon, 28 Jan 2013 12:09:21 +0000
Message-ID: <CEE0DF8E7B2727428D202DA3F3FBC4DD8C753ABB@PULWAR.mtk.lan>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I checked out latest code, and found that LE auto connection does not work at all. Dug a bit in the code to see there is no relevant implementation (related to connect_list).
Here a few lines that make it work.

Best
Damjan

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 5c56d3f..1788d4f 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -801,6 +801,8 @@ static int heartrate_device_register(struct btd_device *device,
        hr->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
                                                attio_disconnected_cb, hr);

+       device_set_auto_connect(device, TRUE);
+
        return 0;
}

diff --git a/src/adapter.c b/src/adapter.c
index 43a9a3a..20667c8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4071,6 +4071,12 @@ static void update_found_devices(struct btd_adapter *adapter,

done:
        if (device_is_le(dev) && g_slist_find(adapter->connect_list, dev)) {
+               if (!device_is_connected(dev)) {
+                       err = device_connect_le(dev);
+                       if (err < 0) {
+                               DBG("LE auto connection failed %s (%d)", strerror(-err), -err);
+                       }
+               }
        }
}

