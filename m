Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B271C6BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184233; cv=none; b=HHAjXkdt0fVYiORfhSh8UXKCkhcvrQr3YY9DiymkQVir5n9HO7BRRRV7EXQSmpLlhhKNbtFCpu8UQvfCRYO5wHpKDi5jYkLAIDNHcA9NOO320/5zya2iy6ihgEohijmE70ZijuLiXv638KL+0I0GlyiROeeQNcwjSIX5+q4L2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184233; c=relaxed/simple;
	bh=Yze7wy3biolSt3rBVbeJjaEPIGzudfSTbxZVhLvwY0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGUQSVROun8z1KLXKj/OFbflAiV5zB8v3XDjl732JRYSHaEQHD5yyb9BYFnRIK2MNLgGH1AT6Xb+DTs+dCEZ9PihHNzKVuWSo+cL19//HyOE+hcCNnkfybbW+3hUzSx+Y+sf/gOx09YkF5pOGe6/gpeoWRdjAkbf7V3sOgfG2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com; spf=pass smtp.mailfrom=prestonhunt.com; dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b=xw/raM+D; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b="xw/raM+D"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-702536f4fc9so220881b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestonhunt-com.20230601.gappssmtp.com; s=20230601; t=1717184231; x=1717789031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/khTKtDM/gFR4Uw3Z/yqR3LBStGnIH/5qw8Lv0s5ZU8=;
        b=xw/raM+D5MkfoofUaDi8sBHEc4MujtKXaMeFwU4fmwe5zxT7qXaa1wXwtWPqOnFAw1
         AHNdpeJFLL+ydEkhVjdIZYdrYGi+fZg7kWIK6APbU4YSHnjhTdiZ7jteoHX8h5vnf5cK
         OOuX5ejmOrI8SR8kXdETKPIm2NHr2V0MTJopEiotsL5kjC0VblonVJ92mwTK2XWprw5T
         1RS4mHnpfxVXgMktkr3wAfxskNs6+1/C49qmlvD5SYr5y0YdWYsK2XpFUxvCbHeK2C4S
         ePg4GN2Bd9ItyOPp7/FUXpe/d/6rcqm1yKFzVyJL/Z8vWrmZtpTd0iRYyVXHQE5/DvfY
         Cchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717184231; x=1717789031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/khTKtDM/gFR4Uw3Z/yqR3LBStGnIH/5qw8Lv0s5ZU8=;
        b=LaGYd2hU96zHW4EcwEZHnQMtbmyAMm6C4wCVKUJYtkt9J/F4XDBEOkhOKdd00UaD2n
         ljvXYbEbcHy7ZkGFmN+fTprvTqVva4pm7hJUq1IrO07GkmPGp8vCbXBgdIXZXWLOce8D
         3RaIQeX2Fi5W1k3Tv0qKztrsxrCwcCsWi7G1iYSAchGrJajNGoGaGGN/1Bvkk99sTk2l
         oOy6ZIlSf68wzCVF3MstrwigLECdcdDtHYgOMGTpydkwmVIXcc9ClR4Y1EIlJfLRCE9s
         BAmUDBZrtgOKybO/9G6BkMmo1qLNwzV7QkJ7hpkPCCmEcuFoyq62uc/CLA3gJys/9ivg
         a31Q==
X-Gm-Message-State: AOJu0Yz6nE9bcwhaGSeiZ/Rj3o6ZzxGjahCznJOwLLjc1B3liJvFXQKi
	07ASHaIjt5btCQoR7rMenf3Xfrnezu4wARRC31y/Fh2ITl/kwvLpJPw6HT1HvvcRbzyHlitaogu
	p
X-Google-Smtp-Source: AGHT+IFZY8C28S2mo+b5viSoC3qGN2MLu2p1PfnW6k+CJMjRpu5jLJgAkOS4Tl+RETzEVsEU2XVg7g==
X-Received: by 2002:a05:6a21:6d85:b0:1af:cc48:3e25 with SMTP id adf61e73a8af0-1b26f0f029cmr3231405637.10.1717184230813;
        Fri, 31 May 2024 12:37:10 -0700 (PDT)
Received: from localhost.localdomain ([97.115.143.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b2c262sm1720956b3a.190.2024.05.31.12.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 12:37:10 -0700 (PDT)
From: Preston Hunt <me@prestonhunt.com>
To: linux-bluetooth@vger.kernel.org
Cc: Preston Hunt <me@prestonhunt.com>
Subject: [PATCH BlueZ 1/1] test/example-gatt: fix deprecation warning
Date: Fri, 31 May 2024 12:36:22 -0700
Message-ID: <20240531193622.1696328-2-me@prestonhunt.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240531193622.1696328-1-me@prestonhunt.com>
References: <20240531193622.1696328-1-me@prestonhunt.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use GLib instead of GObject to fix deprecation warning. Remove python2
gobject import.
---
 test/example-gatt-client |  7 ++-----
 test/example-gatt-server | 11 ++++-------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/test/example-gatt-client b/test/example-gatt-client
index 5e6bef9d7..38ca97eae 100755
--- a/test/example-gatt-client
+++ b/test/example-gatt-client
@@ -2,10 +2,7 @@
 # SPDX-License-Identifier: LGPL-2.1-or-later
 
 import dbus
-try:
-  from gi.repository import GObject
-except ImportError:
-  import gobject as GObject
+from gi.repository import GLib
 import sys
 
 from dbus.mainloop.glib import DBusGMainLoop
@@ -189,7 +186,7 @@ def main():
     global bus
     bus = dbus.SystemBus()
     global mainloop
-    mainloop = GObject.MainLoop()
+    mainloop = GLib.MainLoop()
 
     om = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, '/'), DBUS_OM_IFACE)
     om.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
diff --git a/test/example-gatt-server b/test/example-gatt-server
index 77231c3ad..83b700901 100755
--- a/test/example-gatt-server
+++ b/test/example-gatt-server
@@ -7,10 +7,7 @@ import dbus.mainloop.glib
 import dbus.service
 
 import array
-try:
-  from gi.repository import GObject
-except ImportError:
-  import gobject as GObject
+from gi.repository import GLib
 import sys
 
 from random import randint
@@ -305,7 +302,7 @@ class HeartRateMeasurementChrc(Characteristic):
         if not self.notifying:
             return
 
-        GObject.timeout_add(1000, self.hr_msrmt_cb)
+        GLib.timeout_add(1000, self.hr_msrmt_cb)
 
     def StartNotify(self):
         if self.notifying:
@@ -392,7 +389,7 @@ class BatteryLevelCharacteristic(Characteristic):
                 service)
         self.notifying = False
         self.battery_lvl = 100
-        GObject.timeout_add(5000, self.drain_battery)
+        GLib.timeout_add(5000, self.drain_battery)
 
     def notify_battery_level(self):
         if not self.notifying:
@@ -649,7 +646,7 @@ def main():
 
     app = Application(bus)
 
-    mainloop = GObject.MainLoop()
+    mainloop = GLib.MainLoop()
 
     print('Registering GATT application...')
 
-- 
2.42.0

