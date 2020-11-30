Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5040FC63777
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A6E206C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 20:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kkoY7A9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbgK3UEK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgK3UEK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 15:04:10 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA527C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:03:29 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b10so9722708pfo.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AOX3JjGk6r22Q8PnBEHUiCVd9fNzB32v3Zc3lXH8gg=;
        b=kkoY7A9Wj8u16rFgLTo2scZDrmJD5DwmXdGY7oYFMpZ39hy7QfX0aPyChLgG6JPmDW
         i+miVUZnk/5DnrPDzSKo3nUvQRToWGxaHqTbVl2PKGCJr/HSs3eZ3dmChm+pkrQc3UlI
         0uL2Tebw+GtcO8RgouMsDuPdbCZleg4qPoS6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AOX3JjGk6r22Q8PnBEHUiCVd9fNzB32v3Zc3lXH8gg=;
        b=S+oLkfRPJiVc+4cYocoaOF474cFyIXlQlFTT128rbpR+iujHTcvUpFkLI3QQxA26NA
         pkxIblmSTlcLxbDy2jbtfYbn4jcBQoVVVwPJ8lrlln7iCYgkRZ1guFHxOepY5GLTJXwF
         vFiOvImgjte+a3dC+Hrkyjs+b5w6Q7z/irTTisiG8BK3e65iJrdianKAddfXziJvL0/t
         IdF0HvdHv343SSVZTmNvHkobNbxZmplpuqbc0ekg2MidTKybux3R+PmH7FUGusPPwYvW
         3mqKVJiPE7mfJmRUoWnMeKhiQiOugH8Z+JfS7CKZ1mArNPVtw2ka1TQplhXBubsFuEnK
         MDow==
X-Gm-Message-State: AOAM5331TnmLI5il5zTNb2/5z5KW36Go4yhsnsE6FMmQrQpWp9JOUI7n
        1NrZxhZGG3ognENKb60MM5YtFM8nb0O2ew==
X-Google-Smtp-Source: ABdhPJxEq7JTxONZIVzG4BzbVJ81hh9UjdyfOpLpLak/8iRJw8YkrWCfaY4+CiD+CNBQW3cczu+f/Q==
X-Received: by 2002:a05:6a00:225c:b029:18b:d208:a366 with SMTP id i28-20020a056a00225cb029018bd208a366mr20258769pfu.5.1606766608315;
        Mon, 30 Nov 2020 12:03:28 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y24sm17117184pfn.176.2020.11.30.12.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 12:03:27 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v4 5/7] test: Add test app for Battery Provider API
Date:   Mon, 30 Nov 2020 12:03:05 -0800
Message-Id: <20201130200307.386410-5-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130200307.386410-1-sonnysasaka@chromium.org>
References: <20201130200307.386410-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The python test app simulates an application registering to BlueZ as a
Battery Provider providing three fake batteries drained periodically.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 test/example-battery-provider | 232 ++++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)
 create mode 100755 test/example-battery-provider

diff --git a/test/example-battery-provider b/test/example-battery-provider
new file mode 100755
index 000000000..1522a5e07
--- /dev/null
+++ b/test/example-battery-provider
@@ -0,0 +1,232 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
+import dbus
+import dbus.exceptions
+import dbus.mainloop.glib
+import dbus.service
+
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
+import sys
+
+mainloop = None
+app = None
+bus = None
+
+BLUEZ_SERVICE_NAME = 'org.bluez'
+DBUS_OM_IFACE =      'org.freedesktop.DBus.ObjectManager'
+DBUS_PROP_IFACE =    'org.freedesktop.DBus.Properties'
+
+BATTERY_PROVIDER_MANAGER_IFACE = 'org.bluez.BatteryProviderManager1'
+BATTERY_PROVIDER_IFACE = 'org.bluez.BatteryProvider1'
+BATTERY_PROVIDER_PATH = '/path/to/provider'
+
+BATTERY_PATH1 = '11_11_11_11_11_11'
+BATTERY_PATH2 = '22_22_22_22_22_22'
+BATTERY_PATH3 = '33_33_33_33_33_33'
+
+class InvalidArgsException(dbus.exceptions.DBusException):
+    _dbus_error_name = 'org.freedesktop.DBus.Error.InvalidArgs'
+
+
+class Application(dbus.service.Object):
+    def __init__(self, bus):
+        self.path = BATTERY_PROVIDER_PATH
+        self.services = []
+        self.batteries = []
+        dbus.service.Object.__init__(self, bus, self.path)
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    def add_battery(self, battery):
+        self.batteries.append(battery)
+        self.InterfacesAdded(battery.get_path(), battery.get_properties())
+        GObject.timeout_add(1000, drain_battery, battery)
+
+    def remove_battery(self, battery):
+        self.batteries.remove(battery)
+        self.InterfacesRemoved(battery.get_path(), [BATTERY_PROVIDER_IFACE])
+
+    @dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
+    def GetManagedObjects(self):
+        response = {}
+        print('GetManagedObjects called')
+
+        for battery in self.batteries:
+            response[battery.get_path()] = battery.get_properties()
+
+        return response
+
+    @dbus.service.signal(DBUS_OM_IFACE, signature='oa{sa{sv}}')
+    def InterfacesAdded(self, object_path, interfaces_and_properties):
+        return
+
+    @dbus.service.signal(DBUS_OM_IFACE, signature='oas')
+    def InterfacesRemoved(self, object_path, interfaces):
+        return
+
+
+class Battery(dbus.service.Object):
+    """
+    org.bluez.BatteryProvider1 interface implementation
+    """
+    def __init__(self, bus, dev, percentage, source = None):
+        self.path = BATTERY_PROVIDER_PATH + '/dev_' + dev
+        self.dev_path = '/org/bluez/hci0/dev_' + dev
+        self.bus = bus
+        self.percentage = percentage
+        self.source = source
+        dbus.service.Object.__init__(self, bus, self.path)
+
+    def get_battery_properties(self):
+        properties = {}
+        if self.percentage != None:
+            properties['Percentage'] = dbus.Byte(self.percentage)
+        if self.source != None:
+            properties['Source'] = self.source
+        properties['Device'] = dbus.ObjectPath(self.dev_path)
+        return properties
+
+    def get_properties(self):
+        return { BATTERY_PROVIDER_IFACE: self.get_battery_properties() }
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    def set_percentage(self, percentage):
+        if percentage < 0 or percentage > 100:
+            print('percentage not valid')
+            return
+
+        self.percentage = percentage
+        print('battery %s percentage %d' % (self.path, self.percentage))
+        self.PropertiesChanged(
+                BATTERY_PROVIDER_IFACE, self.get_battery_properties())
+
+    @dbus.service.method(DBUS_PROP_IFACE,
+                         in_signature='s',
+                         out_signature='a{sv}')
+    def GetAll(self, interface):
+        if interface != BATTERY_PROVIDER_IFACE:
+            raise InvalidArgsException()
+
+        return self.get_properties()[BATTERY_PROVIDER_IFACE]
+
+    @dbus.service.signal(DBUS_PROP_IFACE, signature='sa{sv}')
+    def PropertiesChanged(self, interface, properties):
+        return
+
+
+def add_late_battery():
+    app.add_battery(Battery(bus, BATTERY_PATH3, 70, 'Protocol 2'))
+
+
+def drain_battery(battery):
+    new_percentage = 100
+    if battery.percentage != None:
+        new_percentage = battery.percentage - 5
+        if new_percentage < 0:
+            new_percentage = 0
+
+    battery.set_percentage(new_percentage)
+
+    if new_percentage <= 0:
+        return False
+
+    return True
+
+def register_provider_cb():
+    print('Battery Provider registered')
+
+    # Battery added early right after RegisterBatteryProvider succeeds
+    app.add_battery(Battery(bus, BATTERY_PATH2, None))
+    # Battery added later
+    GObject.timeout_add(5000, add_late_battery)
+
+
+def register_provider_error_cb(error):
+    print('Failed to register Battery Provider: ' + str(error))
+    mainloop.quit()
+
+
+def find_manager(bus):
+    remote_om = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, '/'),
+                               DBUS_OM_IFACE)
+    objects = remote_om.GetManagedObjects()
+
+    for o, props in objects.items():
+        if BATTERY_PROVIDER_MANAGER_IFACE in props.keys():
+            return o
+
+    return None
+
+
+def unregister_provider_cb():
+    print('Battery Provider unregistered')
+
+
+def unregister_provider_error_cb(error):
+    print('Failed to unregister Battery Provider: ' + str(error))
+
+
+def unregister_battery_provider(battery_provider_manager):
+    battery_provider_manager.UnregisterBatteryProvider(BATTERY_PROVIDER_PATH,
+                                    reply_handler=unregister_provider_cb,
+                                    error_handler=unregister_provider_error_cb)
+
+
+def remove_battery(app, battery):
+    app.remove_battery(battery)
+
+
+"""
+Simulates an application registering to BlueZ as a Battery Provider providing
+fake batteries drained periodically.
+"""
+def main():
+    global mainloop, bus, app
+
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+    bus = dbus.SystemBus()
+
+    manager_path = find_manager(bus)
+    if not manager_path:
+        print('BatteryProviderManager1 interface not found')
+        return
+
+    print('BatteryProviderManager1 path = ', manager_path)
+
+    battery_provider_manager = dbus.Interface(
+            bus.get_object(BLUEZ_SERVICE_NAME, manager_path),
+            BATTERY_PROVIDER_MANAGER_IFACE)
+
+    app = Application(bus)
+
+    # Battery pre-added before RegisterBatteryProvider
+    battery1 = Battery(bus, BATTERY_PATH1, 87, 'Protocol 1')
+    app.add_battery(battery1)
+
+    mainloop = GObject.MainLoop()
+
+    print('Registering Battery Provider...')
+
+    battery_provider_manager.RegisterBatteryProvider(BATTERY_PROVIDER_PATH,
+                                    reply_handler=register_provider_cb,
+                                    error_handler=register_provider_error_cb)
+
+    # Unregister the Battery Provider after an arbitrary amount of time
+    GObject.timeout_add(
+            12000, unregister_battery_provider, battery_provider_manager)
+    # Simulate battery removal by a provider
+    GObject.timeout_add(8000, remove_battery, app, battery1)
+
+    mainloop.run()
+
+
+if __name__ == '__main__':
+    main()
-- 
2.26.2

