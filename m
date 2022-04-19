Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9289AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 15:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245336AbiDSPKL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiDSPKK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 11:10:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D43A5FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 08:07:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t11so33518788eju.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3upJnd1aFZWxs7CUK2+oITgLbb7BGw/zMQnr9toHaSs=;
        b=0M7CquJBhu5fjpa4MROl+9MnpsIVBzSo4IW7KLgebmcShhLxP+hqHW6h7EVqgUtJgA
         FYPdlfO3L4LSs+EAyfk2o2V9B6tdVi2+73MOlgYJ+ZKRPr0/Hda+e9zvcT83d8/oGRNN
         bJrH15T6uBuxwAhQ3THVesldTN2j5qBeqYi9dEUgo1QYFKaeEZOd+ORITSwm/r+pYrCk
         tsrTZ3IpTOXqtaWlexR2vOd4oeh7qixaRVyanTDRvFiz6cIbeagzm6zMwlK0hscuO9O+
         6a3Cbfg95BFkRiumWWvpEGtOB0U+EiNc71L5J5Y3YrSZkfe8Nj8xq/Qdf+4LcI6NrA6m
         dTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3upJnd1aFZWxs7CUK2+oITgLbb7BGw/zMQnr9toHaSs=;
        b=rc9qIMppror774pPvgkaFRTombNLaTco6TILWgL2xv6DygNE2/1NkG8nf/uuDSWcFi
         mxTsCcxzR5XQvlonSzeTdAChqbxb2hjCOj0/aTLixYGhPPILH70b3+2Ft2/tMkfSaAP9
         2WziqC1AFE9qEdF1jyODPVxJWgUUV3H9ahsry4Mb26GA+Mh4ksTzeMpa8/eLRhzvz0mZ
         fUQY6rURxQlS+hSNzf8EnMYkzelvviVpjTA3BUhPK0n8CDCBPBxHo7nwByjiRgbrWz9v
         4y4LZ7b+Qej89g3cQwCoyfGvf0823xktf3AkuatLdYu02qlLFh7MXkk0OgbtFd9bmbvY
         Hg3A==
X-Gm-Message-State: AOAM5306bZgwY7QbeotA35G7oShnrZzRH7KSAeixmzKpMTMJ/FLZEUmo
        1TRk6+TUEAhJpj/69oR0TVOL7BMaQMDw8w==
X-Google-Smtp-Source: ABdhPJw8DNpA7SmhRE7PS57BYAM3jOKH9htevRS1dTPBEv43men3WRkM3kQX+TUYAQPDgNsh0H4nUw==
X-Received: by 2002:a17:907:728c:b0:6e8:a052:4f03 with SMTP id dt12-20020a170907728c00b006e8a0524f03mr13724227ejc.344.1650380844764;
        Tue, 19 Apr 2022 08:07:24 -0700 (PDT)
Received: from localhost.lan (217-133-17-98.static.clienti.tiscali.it. [217.133.17.98])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402036100b004240a3fc6b4sm74200edw.82.2022.04.19.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:07:24 -0700 (PDT)
From:   Diego Rondini <diego.rondini@kynetics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Diego Rondini <diego.rondini@kynetics.com>
Subject: [PATCH BlueZ] test: changes for Python3
Date:   Tue, 19 Apr 2022 17:09:49 +0200
Message-Id: <20220419150949.694702-1-diego.rondini@kynetics.com>
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

