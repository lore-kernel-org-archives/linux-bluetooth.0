Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2018BC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1D122253
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RKjRuVSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgKTU54 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbgKTU54 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:57:56 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124A6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:57:56 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y7so9017890pfq.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SALKOqvduBW19p97zuVc5XoKlMwFmjr1u1CvAIAAJ9A=;
        b=RKjRuVSlqgVrL3eJONyHEXi8gzjj43OVpRABUtoTdGkSsnR8x86gfxIe/EcgHpgkit
         zGBS3BTz9KtzXKClZjUlrTApbFJ8y6ticnx1N/qB59+MjFOsmHl8OlYVVBg8GHw4/QbD
         T+taJitkmVX2vgabEWGEbw9+Vv8kGCflnyZsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SALKOqvduBW19p97zuVc5XoKlMwFmjr1u1CvAIAAJ9A=;
        b=XrP5ES7WyldRiozANbuft5QGXZ/cGt+AFdIC2deTmMwlEUIKamSM8dyp+DCfyoAwwL
         tlEo5AYlP1xrXx9+804Cdc06VKEMSqZW2yXkyh4fcbEvNpbtAwNdgOkx9hSH+wuQpPJ3
         nb6TYxdB9w9VwYG+xHpWLIwPss10n0OHzrwX3U9+ds+qakkjh9CMKyF10sLpc6A/xuaY
         +mqPOfZmGeuCINhILbMUraFY9/MAxDAfxp88gmwozCBtVExEJcrLlNeyBKoM7VrZseMQ
         KO3J17vTlrUzWGD82g9h/WwQ5uc9LkCwPtTKn6yFxR7bpEOCL3rJZbgAyQENKlAEfiD9
         FH1Q==
X-Gm-Message-State: AOAM532FA91YYuGlsc4UTk1A2i+Ap40mwYqOhSHj+W2GHQMTQN1YFfBR
        xVnyyN2VIqVJ2BkWaz0nv2dpm0kaC9yZBQ==
X-Google-Smtp-Source: ABdhPJzFj8rad0SSJBQ58uG2Ksefexa81wEprngsFG9nGHYqLmEqTa2FsywUQQx1hqNjRp0F49wu0A==
X-Received: by 2002:a63:b05:: with SMTP id 5mr18410503pgl.267.1605905875293;
        Fri, 20 Nov 2020 12:57:55 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id a67sm3232080pfa.77.2020.11.20.12.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:57:54 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v3 5/7] test: Add test app for Battery Provider API
Date:   Fri, 20 Nov 2020 12:57:26 -0800
Message-Id: <20201120205728.339325-5-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120205728.339325-1-sonnysasaka@chromium.org>
References: <20201120205728.339325-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The python test app simulates an application registering to BlueZ as a
Battery Provider providing three fake batteries drained periodically.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 test/example-battery-provider | 230 ++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)
 create mode 100755 test/example-battery-provider

diff --git a/test/example-battery-provider b/test/example-battery-provider
new file mode 100755
index 000000000..3dbb08563
--- /dev/null
+++ b/test/example-battery-provider
@@ -0,0 +1,230 @@
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
+        self.path = BATTERY_PROVIDER_PATH + '/org/bluez/hci0/dev_' + dev
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

