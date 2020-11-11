Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1927EC56202
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7A5221FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NfLwFxol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbgKKBR6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 20:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732962AbgKKBR5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 20:17:57 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE18C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:57 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g7so539634pfc.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SALKOqvduBW19p97zuVc5XoKlMwFmjr1u1CvAIAAJ9A=;
        b=NfLwFxolhCwG2+rFQ5PNxdYs+rvkmno1b5SwXhpC8lERMS5D2VY7C0Z8tIy5i5tOBe
         NFsiZb/PONbwq/J35AVCFrNHKOOA2Xqtk2wTUwFmntI76jmJJIhnfe6+RjXR+WTm8dt8
         aFeKGllCB+6Ps3k50RfTMn1TyPG0TXVasejow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SALKOqvduBW19p97zuVc5XoKlMwFmjr1u1CvAIAAJ9A=;
        b=Fa4vy7o4BHRZ5ZkLdV22qzDxvi0R2zTf1tgzWmUidOL5z9wo3E+UGueq6ZXtbq6N7l
         6nxq+c5oEpzZBw61tjn9kw2IP6xtmiWv0wIgV5zgFIHYr4eCXJ0Mquv2mFsZEWhZbplX
         i8HuaUYeu+B61YbEChOnLmKp4TsvxLH6BIf2YoyzRS7JkUGd0KfWtpzk7rb0pOlVbJGY
         v02lsNWOnDiyYMyYPByqPJRlwsef1ZvVyyhH8sJwMBo/maq+0BMuwuiRSUZ2C5If8GNf
         XEBW3yZf+2IluBckP6zz2hSUGVJ6nGrfzx3TXCzRQVtimN/T1S0QNzefnityy7xG/b/t
         6LZQ==
X-Gm-Message-State: AOAM531FXrg4V2/BVLpe8vwq20n4j4gtj9kx9uJvzmKEYV6yl/+q7Spd
        gW4DRDimvSZWJDoV7FM70LUEAfJcAaHXDQ==
X-Google-Smtp-Source: ABdhPJyscjxdb06+AcOp02lfjVsCAg9Iazi2/3ijinQpLFIqhUA68ghKLEbU9jqO8yS47wsmPR7cag==
X-Received: by 2002:a63:5a07:: with SMTP id o7mr18850552pgb.77.1605057476334;
        Tue, 10 Nov 2020 17:17:56 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y19sm331695pfn.147.2020.11.10.17.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 17:17:55 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v2 5/7] test: Add test app for Battery Provider API
Date:   Tue, 10 Nov 2020 17:17:43 -0800
Message-Id: <20201111011745.2016-5-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111011745.2016-1-sonnysasaka@chromium.org>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
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

