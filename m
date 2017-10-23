Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1508773754.28409.4.camel@hadess.net>
Subject: Re: [PATCH v2 2/3] profiles/battery: Add Bluetooth LE Battery
 service
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 23 Oct 2017 17:49:14 +0200
In-Reply-To: <20171023154814.20607-2-hadess@hadess.net>
References: <20171023154814.20607-1-hadess@hadess.net>
         <20171023154814.20607-2-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2017-10-23 at 17:48 +0200, Bastien Nocera wrote:
> Only the Battery Level characteristic was tested with a
> Microsoft Arc Touch Mouse SE.
> 
> This patch however hopes to support both the Battery Level and
> the Battery Power State characteristics.

Interdiff for this one, fixing the "Connected" state not changing:

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 8e967e159..ab4603de3 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -400,6 +400,7 @@ static void batt_reset(struct batt *batt)
        batt->db = NULL;
        bt_gatt_client_unregister_notify(batt->client, batt->batt_power_state_cb_id);
        bt_gatt_client_unregister_notify(batt->client, batt->batt_level_cb_id);
+       bt_gatt_client_cancel_all(batt->client);
        bt_gatt_client_unref(batt->client);
        batt->client = NULL;
        if (batt->path) {
@@ -408,6 +409,7 @@ static void batt_reset(struct batt *batt)
                g_free(batt->path);
                batt->path = NULL;
        }
+       btd_device_unref(batt->device);
 }
 
 static gboolean property_get_battery_level(
