Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0A8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 15:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245557AbiDSPEg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347499AbiDSPEf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 11:04:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5FC2DD73
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 08:01:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t11so33481337eju.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3upJnd1aFZWxs7CUK2+oITgLbb7BGw/zMQnr9toHaSs=;
        b=zBGFOmpZB+cWlaU8mtqlsamhFT3VfmItJ0tOCiErvbVASvBzoC8a3T6htC8WUEkPeO
         dbCODvhVjVFQ7ktEowIgO9FYvQAf/L0a86Cpxv3ueS6/RO12vJqTMQmi4a9OVjl0KoQ7
         uowdsYY8oXel7L4WCs/AOFBeWbG1xZlqd1KQrZT//VevvtL2mcEsJJ5QdtF6njSCV4rs
         qkSI9D3P3CFggWhSSrSFBDqiitit4HDMtEHnJDrWsrf9A3BCzNBmJnAgio2r7Y4xzeqg
         Unin/jkt9Aerd1ZE0GPftWYtmBplqOTWsGBqML/nVao+cpW3ghe2h+AduY5LeLNls8dI
         LiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3upJnd1aFZWxs7CUK2+oITgLbb7BGw/zMQnr9toHaSs=;
        b=gWThs+KX6779nGvmHlWXI3ZdiFq6AZVrAk2cUMQlcNsuCsNK7jxauG2h4noF2zzpBi
         loy9P8csxvbeeNfGKDRKgb4qCYT9h2cAeapniyz6l+ZU0JW3WvShAwYOUgWyd059wltF
         Prkayl0Isx+tfH4PcrjQqL09Tzbk70+duhLc5oUPMfgpPD9uDMYCn0v0qTwHNG9S+qOh
         LxAzRaGhaE8PIlky/N25FcBDO/LLVejRfHf8dBwcxIaSsSgSIB/DAzLjpFtsIwUSsciM
         JgkL9czSYTjKIjViJmPuLSxH8GubzMHjesCH+aAc+2VUsOUmjGVBIkd77TNKkeAbnYDM
         MZRA==
X-Gm-Message-State: AOAM533w1nzSAytJGT0HuA+6c1rrCX4NDbpruDia0cRKqpEma7uWxjwx
        6X//aRRHEZjbET0pRG4JFaDW6L3uIesKlA==
X-Google-Smtp-Source: ABdhPJzLF9/E0KpOkRp7iyT7mQhXW820j1tI3Hs+jNBlGaz25zHsWp0Eonq+LBz/KswAwZMqI7dqiQ==
X-Received: by 2002:a17:906:6dc4:b0:6e8:465d:65c3 with SMTP id j4-20020a1709066dc400b006e8465d65c3mr13656666ejt.179.1650380510618;
        Tue, 19 Apr 2022 08:01:50 -0700 (PDT)
Received: from localhost.lan (217-133-17-98.static.clienti.tiscali.it. [217.133.17.98])
        by smtp.gmail.com with ESMTPSA id cr10-20020a056402222a00b0041d918fdf99sm8649389edb.85.2022.04.19.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:01:50 -0700 (PDT)
From:   Diego Rondini <diego.rondini@kynetics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Diego Rondini <diego.rondini@kynetics.com>
Subject: [PATCH BlueZ] test: changes for Python3
Date:   Tue, 19 Apr 2022 17:03:56 +0200
Message-Id: <20220419150356.694346-1-diego.rondini@kynetics.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove some leftover usage of Python2 code. In particular replace
iteritems() with items() to fix the following error:

	AttributeError: 'dbus.Dictionary' object has no attribute 'iteritems'
---
 test/list-devices      | 4 ++--
 test/map-client        | 2 +-
 test/monitor-bluetooth | 6 +++---
 test/test-adapter      | 2 +-
 test/test-device       | 2 +-
 test/test-discovery    | 4 ++--
 test/test-health       | 4 ++--
 test/test-health-sink  | 4 ++--
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/test/list-devices b/test/list-devices
index b112556c3..618d2867b 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -32,10 +32,10 @@ def extract_uuids(uuid_list):
 
 objects = manager.GetManagedObjects()
 
-all_devices = (str(path) for path, interfaces in objects.iteritems() if
+all_devices = (str(path) for path, interfaces in objects.items() if
 					"org.bluez.Device1" in interfaces.keys())
 
-for path, interfaces in objects.iteritems():
+for path, interfaces in objects.items():
 	if "org.bluez.Adapter1" not in interfaces.keys():
 		continue
 
diff --git a/test/map-client b/test/map-client
index a2d96ae5f..f44f512bd 100755
--- a/test/map-client
+++ b/test/map-client
@@ -33,7 +33,7 @@ def unwrap(x):
         return tuple(map(unwrap, x))
 
     if isinstance(x, dict):
-        return dict([(unwrap(k), unwrap(v)) for k, v in x.iteritems()])
+        return dict([(unwrap(k), unwrap(v)) for k, v in x.items()])
 
     for t in [unicode, str, long, int, float, bool]:
         if isinstance(x, t):
diff --git a/test/monitor-bluetooth b/test/monitor-bluetooth
index a3977e206..99f3c857c 100755
--- a/test/monitor-bluetooth
+++ b/test/monitor-bluetooth
@@ -14,17 +14,17 @@ relevant_ifaces = [ "org.bluez.Adapter1", "org.bluez.Device1" ]
 
 def property_changed(interface, changed, invalidated, path):
 	iface = interface[interface.rfind(".") + 1:]
-	for name, value in changed.iteritems():
+	for name, value in changed.items():
 		val = str(value)
 		print("{%s.PropertyChanged} [%s] %s = %s" % (iface, path, name,
 									val))
 
 def interfaces_added(path, interfaces):
-	for iface, props in interfaces.iteritems():
+	for iface, props in interfaces.items():
 		if not(iface in relevant_ifaces):
 			continue
 		print("{Added %s} [%s]" % (iface, path))
-		for name, value in props.iteritems():
+		for name, value in props.items():
 			print("      %s = %s" % (name, value))
 
 def interfaces_removed(path, interfaces):
diff --git a/test/test-adapter b/test/test-adapter
index a216140ba..c56ba9577 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -61,7 +61,7 @@ if (args[0] == "list"):
 		om = dbus.Interface(bus.get_object("org.bluez", "/"),
 					"org.freedesktop.DBus.ObjectManager")
 		objects = om.GetManagedObjects()
-		for path, interfaces in objects.iteritems():
+		for path, interfaces in objects.items():
 			if "org.bluez.Adapter1" not in interfaces:
 				continue
 
diff --git a/test/test-device b/test/test-device
index a1e508166..c840f0565 100755
--- a/test/test-device
+++ b/test/test-device
@@ -49,7 +49,7 @@ if (args[0] == "list"):
 					"org.freedesktop.DBus.ObjectManager")
 	objects = om.GetManagedObjects()
 
-	for path, interfaces in objects.iteritems():
+	for path, interfaces in objects.items():
 		if "org.bluez.Device1" not in interfaces:
 			continue
 		properties = interfaces["org.bluez.Device1"]
diff --git a/test/test-discovery b/test/test-discovery
index eccc7c7e3..54fc51403 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -19,7 +19,7 @@ def print_compact(address, properties):
 	name = ""
 	address = "<unknown>"
 
-	for key, value in properties.iteritems():
+	for key, value in properties.items():
 		if type(value) is dbus.String:
 			value = unicode(value).encode('ascii', 'replace')
 		if (key == "Name"):
@@ -153,7 +153,7 @@ if __name__ == '__main__':
 	om = dbus.Interface(bus.get_object("org.bluez", "/"),
 				"org.freedesktop.DBus.ObjectManager")
 	objects = om.GetManagedObjects()
-	for path, interfaces in objects.iteritems():
+	for path, interfaces in objects.items():
 		if "org.bluez.Device1" in interfaces:
 			devices[path] = interfaces["org.bluez.Device1"]
 
diff --git a/test/test-health b/test/test-health
index d6b437ed8..3e16c415d 100755
--- a/test/test-health
+++ b/test/test-health
@@ -147,7 +147,7 @@ manager = dbus.Interface(bus.get_object(BUS_NAME, "/"),
 objects = manager.GetManagedObjects()
 adapters = []
 
-for path, ifaces in objects.iteritems():
+for path, ifaces in objects.items():
 	if ifaces.has_key(ADAPTER_INTERFACE):
 		adapters.append(path)
 
@@ -172,7 +172,7 @@ while select == None:
 adapter = dbus.Interface(bus.get_object(BUS_NAME, select), ADAPTER_INTERFACE)
 
 devices = []
-for path, interfaces in objects.iteritems():
+for path, interfaces in objects.items():
 	if "org.bluez.Device1" not in interfaces:
 		continue
 	properties = interfaces["org.bluez.Device1"]
diff --git a/test/test-health-sink b/test/test-health-sink
index 57665d2ba..13b9a6b04 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -41,7 +41,7 @@ manager = dbus.Interface(bus.get_object(BUS_NAME, "/"),
 objects = manager.GetManagedObjects()
 adapters = []
 
-for path, ifaces in objects.iteritems():
+for path, ifaces in objects.items():
 	if ifaces.has_key(ADAPTER_INTERFACE):
 		adapters.append(path)
 
@@ -67,7 +67,7 @@ adapter =  dbus.Interface(bus.get_object(BUS_NAME, select),
 						ADAPTER_INTERFACE)
 
 devices = []
-for path, interfaces in objects.iteritems():
+for path, interfaces in objects.items():
 	if "org.bluez.Device1" not in interfaces:
 		continue
 	properties = interfaces["org.bluez.Device1"]
-- 
2.34.1

