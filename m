Return-Path: <SRS0=eST2=AT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3553EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 15:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE85206F6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6etBYEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgGHPxN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHPxN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jul 2020 11:53:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE61C061A0B
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2020 08:53:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn17so1394035pjb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2020 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Rhw7BD+8GQYrmfzt2oYwuMMnAaDzpl0AiN3h3ecb1s=;
        b=n6etBYEN0g1HSageAUZbTww+qJrrsdPyEgON1OnzgBjLdR+5EDF5RqGyVC9t88JAdA
         BHPdLhAFCqx8JQqHyMvK9f2gReOFiyDNEu13EifQI7LN2guI9aLA4TnxapDiuLMhfw11
         2NkN2R7TlnL0IblcvCnnwx1fnHHZilkwx2QAyza8ZKHPZaxyXg+DEWhvCz0/Vu5BdGpA
         5mYoLpg5ixTGBKhsHgMOdgUC6ZUTGym19gRqpL44Lf7R2KxBIgJlhrnScLQfDP6G2pXX
         xm/UlRiilVoZIzv8pBEED3SUoCmOQPDB1I78Vr3vOk67fwPlxKeuug88L9PWR83Mk7EL
         zcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Rhw7BD+8GQYrmfzt2oYwuMMnAaDzpl0AiN3h3ecb1s=;
        b=m169Xp/bHEmadog4I/7rTAfGMu2WDdrpHeJobp+WCKMAiXErLyjFUQytx8dUy+mnfu
         4H95OrOHLXMTsvmtk8pFURB6z+kfbmwg/n3r5Ko8XBVJZHurPMXSo7A6C1Ori7qx/Gvj
         e7WB32i+y7YuQlJDqr4C2te/zssyxg5KIdrctY5xJkD+9yS+Pk5Igj38VYNC/PF02D5V
         DE+VvrsvDz98+D0SOHLGOsKoohisdB0PsqdV7LaTAhftbm3Ay29OSyysO3UeQD6SFpwE
         QhskZf4Pe2O8Y6tJ2S7W9dvCPgAB+f6NMwzqLtPN+/htI5cqzhHYJXdHj+1q7Ty5V5Nk
         FrgA==
X-Gm-Message-State: AOAM530bikkWA1tfMmUW5mEOAH7irzj9kzX++9KpR8Eyw8jTZhYSJwCn
        kV7NrHRslVCD1Js5hd3vRc8kJ7P0mpz/KyXV4Z3Xcqkw
X-Google-Smtp-Source: ABdhPJxZFVdQVAgOdGJQjbXNZd0io0/6Qd2EnPGJYjYGjmuS2/fEJUl0UbPDsExlLi5tOmqKX1ObL+WzfxRShEhnqZQ=
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr10262945pjb.91.1594223592841;
 Wed, 08 Jul 2020 08:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQQxWxKs7ewwVyq4mnsyLbRhErQe9vZc5joNK6zfGSO3wN5bg@mail.gmail.com>
 <d9eca20059088ad8bdaac70d7d98811166839b27.camel@hadess.net>
In-Reply-To: <d9eca20059088ad8bdaac70d7d98811166839b27.camel@hadess.net>
From:   Andrey Batyiev <batyiev@gmail.com>
Date:   Wed, 8 Jul 2020 18:53:00 +0300
Message-ID: <CAEQQxWyz-9iDU5Cs_NjHm81A6kdr0WUXPggp_2DTHeVVAQXUZQ@mail.gmail.com>
Subject: Re: Temporary device removal during discovery
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien, everyone,

I've made a patch to the bluez, so the temporary devices are routinely
purged based on their last_seen attribute.

What do you think about such solution?

Thanks,
    Andrey



diff --git a/src/adapter.c b/src/adapter.c
index 529002b02..101b03633 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -88,6 +88,7 @@

#define CONN_SCAN_TIMEOUT (3)
#define IDLE_DISCOV_TIMEOUT (5)
+#define TEMP_DEV_REAPER_INTERVAL (30)
#define TEMP_DEV_TIMEOUT (3 * 60)
#define BONDING_TIMEOUT (2 * 60)

@@ -1491,18 +1492,18 @@ static gboolean remove_temp_devices(gpointer user_data)

       DBG("%s", adapter->path);

-       adapter->temp_devices_timeout = 0;
-
       for (l = adapter->devices; l != NULL; l = next) {
               struct btd_device *dev = l->data;

               next = g_slist_next(l);

-               if (device_is_temporary(dev) && !btd_device_is_connected(dev))
+               if (device_is_temporary(dev) &&
+                   !btd_device_is_connected(dev) &&
+                   device_last_seen_delta(dev) > TEMP_DEV_TIMEOUT)
                       btd_adapter_remove_device(adapter, dev);
       }

-       return FALSE;
+       return TRUE;
}

static void discovery_cleanup(struct btd_adapter *adapter)
@@ -1516,11 +1517,6 @@ static void discovery_cleanup(struct
btd_adapter *adapter)
               adapter->discovery_idle_timeout = 0;
       }

-       if (adapter->temp_devices_timeout > 0) {
-               g_source_remove(adapter->temp_devices_timeout);
-               adapter->temp_devices_timeout = 0;
-       }
-
       g_slist_free_full(adapter->discovery_found,
                                               invalidate_rssi_and_tx_power);
       adapter->discovery_found = NULL;
@@ -1536,9 +1532,6 @@ static void discovery_cleanup(struct btd_adapter *adapter)
               if (device_is_temporary(dev) && !device_is_connectable(dev))
                       btd_adapter_remove_device(adapter, dev);
       }
-
-       adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
-                                               remove_temp_devices, adapter);
}

static void discovery_free(void *user_data)
@@ -2405,7 +2398,7 @@ static bool parse_pathloss(DBusMessageIter *value,
       return true;
}

-static bool parse_transport(DBusMessageIter *value,
+static bool parse_transport(DBusMessageIter *value,
                                       struct discovery_filter *filter)
{
       char *transport_str;
@@ -5362,6 +5355,11 @@ static void adapter_free(gpointer user_data)
               adapter->passive_scan_timeout = 0;
       }

+       if (adapter->temp_devices_timeout > 0) {
+               g_source_remove(adapter->temp_devices_timeout);
+               adapter->temp_devices_timeout = 0;
+       }
+
       if (adapter->load_ltks_timeout > 0)
               g_source_remove(adapter->load_ltks_timeout);

@@ -6343,6 +6341,9 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)

       adapter->auths = g_queue_new();

+       adapter->temp_devices_timeout =
g_timeout_add_seconds(TEMP_DEV_REAPER_INTERVAL,
+                                               remove_temp_devices, adapter);
+
       return btd_adapter_ref(adapter);
}

diff --git a/src/device.c b/src/device.c
index 0deee2707..cebbabab2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4240,6 +4240,15 @@ void device_update_last_seen(struct btd_device
*device, uint8_t bdaddr_type)
               device->le_seen = time(NULL);
}

+time_t device_last_seen_delta(struct btd_device *device)
+{
+       const time_t now = time(NULL);
+       const time_t bredr_time = now - device->bredr_seen;
+       const time_t le_time = now - device->le_seen;
+
+       return bredr_time < le_time ? bredr_time : le_time;
+}
+
/* It is possible that we have two device objects for the same device in
 * case it has first been discovered over BR/EDR and has a private
 * address when discovered over LE for the first time. In such a case we
diff --git a/src/device.h b/src/device.h
index cb8d884e8..75fd3ec60 100644
--- a/src/device.h
+++ b/src/device.h
@@ -44,6 +44,7 @@ void device_update_addr(struct btd_device *device,
const bdaddr_t *bdaddr,
void device_set_bredr_support(struct btd_device *device);
void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type);
void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type);
+time_t device_last_seen_delta(struct btd_device *device);
void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup);
uint32_t btd_device_get_class(struct btd_device *device);
uint16_t btd_device_get_vendor(struct btd_device *device);
