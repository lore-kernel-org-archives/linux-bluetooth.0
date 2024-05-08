Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B2126F39
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183178; cv=none; b=tTyoAHgZH+yJa8ZJInITrCn3bb1NmftXAyqWi9ctcbAyjR+6/JGlgKOUZENXMCwzVpCGqzsMndAZsJnlv3WvqDcRYAosgJBflqag4Ks4gsqBq22ApfOcza1OhMSI9ObUD4Q40uPYbx+1c2cwoVxHDW51FsFizNSyWFgdHq+EjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183178; c=relaxed/simple;
	bh=nNx6T8y+I4K4Gymzxivq/NvnOwRTIMdW0vn2FHy8dZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1qnNS2zzgxYo1DcB9YvivuUQEU5BTHqlJ/A7nlIxDhv0LIxYS1hKI69Ak3gmVMonLUdFRt696EfB/u3vs9mgjnF+JpCPK/y5yo4Pp1R6c0Xm1CSEPoVUZ/milrxZk5l533fZIhSgI75GFOf3KT/cENwDbWa2A39f/T/Vu9hvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=bKl43xuS; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="bKl43xuS"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23f2996b634so2507402fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715183175; x=1715787975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMHpIX9Yw1rlh52aQZ0bbkD2dzqr65a9Vkm4Deux0RI=;
        b=bKl43xuS0HBFiOKIan0tPIM87f8G74ufGwWTk4D8pmzh3/dV/8tJEH8bzUUL6PQtDn
         dHhALvD0P3M5NEHyWsMUT3oVm0ocAxB+D6NNR47hsv8ecbNTtNR8kH9a10tuGUp2/jsW
         p95F3keRo+uNPxbuRqdI1icGInJfE8pZoQNnSiYyOntZcffy5ua2mwuyyDWUFXsJcy9A
         Xwm5PbhlGWPXzS4UnxVE91EVxoupa/KekTTr/nfMfB8C7kHADu55tGLKNEb/FqQCtyMt
         zS/ejLph6i9KfDPGKNitxgTjAO+P4NdcF4hd5wZJQQlIo/u7PDJxcgXgZ+IsDso204xA
         GwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183175; x=1715787975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMHpIX9Yw1rlh52aQZ0bbkD2dzqr65a9Vkm4Deux0RI=;
        b=Q81JvJJh50c4JXLGygMu7nXWKo5OJ9yVRgmi6vWBTmjVYGpRtb2WVFyrNB/QtfmLaC
         /O1xd+SJprem8ZcXV/sWbp8Eyw4jRyWJffNO+YpZDH7nnJpVeDBQKhGcMKUhz30JTFy3
         n6Kl7XIqJYlZWKky50Ov/UEWjIFWZ9lSLVcPBELorcYk3/Vc/XG0oroXYVeAwevUcDRa
         QyWRe8cUh+Gsc471hHHqGmZVYwjv71s5h0Y6Y7Jxxvl1EdtBBp1ieSxDwzxjFy4UoSDX
         HHjRsk/b3e6TZKayAEZQYtGtb3SntysRbqUBWccIKyCgI4PrCzeXYfRU9/ux4yEHyTPN
         do+A==
X-Gm-Message-State: AOJu0Yx1YjkmBAXefUtHJ3ApVNmalwUM4HTcE4c1FPdaKRMzgZvGqHCP
	yN7reao4MSiT8BAahtuZErnMqNblf7LvtHbhVj+e7qIUjG43amO5V7LV7HXyyw6PheHVYFlRo6d
	X
X-Google-Smtp-Source: AGHT+IFpzkcEdf4Sh3ouP0EYhwDO22ZTYLp4F6dLYGYP2CcsPlXyczEkGxcG6Kp/HLo9oX1eJLeDKw==
X-Received: by 2002:a05:6870:524a:b0:22e:8ed:9f7a with SMTP id 586e51a60fabf-240979c065fmr2995280fac.4.1715183174752;
        Wed, 08 May 2024 08:46:14 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id cd14-20020a05622a418e00b0043791f7d831sm7756513qtb.63.2024.05.08.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:46:14 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ 3/5] test: Add a script to test ASHA
Date: Wed,  8 May 2024 11:46:02 -0400
Message-ID: <20240508154604.276763-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508154604.276763-1-arun@asymptotic.io>
References: <20240508154604.276763-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Plays out an audio file to the device. Depends on GStreamer for media
file reading and decoding (specifically, gstreamer core,
gst-plugins-base, gst-ffmpeg, and gst-python, or equivalent packages).
---
 test/simple-asha | 158 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100755 test/simple-asha

diff --git a/test/simple-asha b/test/simple-asha
new file mode 100755
index 000000000..feff9d29c
--- /dev/null
+++ b/test/simple-asha
@@ -0,0 +1,158 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
+import os
+import signal
+import sys
+
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+import gi
+
+gi.require_version("Gst", "1.0")
+gi.require_version("GLib", "2.0")
+from gi.repository import GLib, Gst
+
+import bluezutils
+
+mainloop = None
+pipeline = None
+seqnum: int = 0
+
+
+def signal_handler(_sig, _frame):
+    print("Got interrupt")
+    mainloop.quit()
+
+
+signal.signal(signal.SIGINT, signal_handler)
+
+
+def usage():
+    print(f"Usage: simple-asha <remote addr> <audio file name> (optional volume 0-127)")
+
+
+def start_playback(fd: int):
+    global mainloop, pipeline
+
+    outdata = bytearray(161)
+
+    Gst.init(None)
+
+    pipeline = Gst.parse_launch(
+        f"""
+          filesrc location="{sys.argv[2]}" ! decodebin !
+          audioconvert ! audioresample !
+          audiobuffersplit output-buffer-duration="20/1000" ! avenc_g722 !
+          appsink name=sink emit-signals=true
+    """
+    )
+
+    def on_new_sample(sink):
+        global seqnum
+
+        sample = sink.emit("pull-sample")
+        buf = sample.get_buffer()
+
+        with buf.map(Gst.MapFlags.READ) as info:
+            pos = 0
+
+            if info.size != 160:
+                print("Unexpected buffer size: ", info.size)
+
+            outdata[pos] = seqnum % 256
+            pos += 1
+
+            for byte in info.data:
+                outdata[pos] = byte
+                pos += 1
+
+            try:
+                n = os.write(fd, outdata)
+                if n != 161:
+                    print("Wrote less than expected: ", n)
+            except:
+                return Gst.FlowReturn.ERROR
+
+        seqnum += 1
+
+        return Gst.FlowReturn.OK
+
+    sink = pipeline.get_by_name("sink")
+    sink.connect("new-sample", on_new_sample)
+
+    pipeline.set_state(Gst.State.PLAYING)
+
+    def bus_message(_bus, message, _data) -> bool:
+        typ = message.type
+
+        if typ == Gst.MessageType.EOS:
+            print("End of stream")
+            mainloop.quit()
+        elif typ == Gst.MessageType.ERROR:
+            err, debug = message.parse_error()
+            print(f"Pipeline error: {err} ({debug})")
+            mainloop.quit()
+
+    bus = pipeline.get_bus()
+    bus.add_watch(GLib.PRIORITY_DEFAULT, bus_message, None)
+
+
+if __name__ == "__main__":
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+    mainloop = GLib.MainLoop()
+    bus = dbus.SystemBus()
+
+    if (len(sys.argv) == 3) or (len(sys.argv) == 4):
+        device = bluezutils.find_device(sys.argv[1])
+        if device is None:
+            print("Could not find device: ", sys.argv[1])
+            exit(255)
+    else:
+        usage()
+        sys.exit(255)
+
+    asha = bus.get_object("org.bluez", device.object_path + "/asha")
+    media = dbus.Interface(
+        bus.get_object("org.bluez", device.object_path + "/asha"),
+        "org.bluez.MediaEndpoint1",
+    )
+
+    props = asha.GetAll(
+        "org.bluez.MediaEndpoint1",
+        dbus_interface="org.freedesktop.DBus.Properties",
+    )
+    path = props["Transport"]
+
+    print("Trying to acquire", path)
+
+    transport = dbus.Interface(
+        bus.get_object("org.bluez", path),
+        "org.bluez.MediaTransport1",
+    )
+
+    # Keep default volume at 25%
+    volume = 32
+    if len(sys.argv) == 4:
+        volume = int(sys.argv[3])
+        if volume < 0 or volume > 127:
+            print("Volume must be between 0 (mute) and 127 (max)")
+
+    transport.Set(
+        "org.bluez.MediaTransport1",
+        "Volume",
+        dbus.UInt16(volume, variant_level=1),
+        dbus_interface="org.freedesktop.DBus.Properties",
+    )
+
+    (fd, imtu, omtu) = transport.Acquire()
+
+    start_playback(fd.take())
+
+    mainloop.run()
+
+    pipeline.set_state(Gst.State.NULL)
+    transport.Release()
-- 
2.45.0

