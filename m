Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F113CA9E
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221633; cv=none; b=eHAi+hYDQeJRYL5QW2+3OSJ49aP7A0fhWhlhwLd+PKLXZJXyEdx+QWrk+fBNIXsKexNyBXFK45+jjBlueNhm2Sg64Y2EDpluKnLk25slk9iTIWAXJ5WipBp2KcwR/i6HB5NLMaCn/b8BPqxURpoP7UkMfg30X8rbnw12jvJsRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221633; c=relaxed/simple;
	bh=gbVMrPY70hNGVRJcd+ramq0kJAcmnRVOFYt+seXkXT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rojSqtOikfHSvilx1tkQKzbnXih5Sjm1J8Xux3dLYv1lBhYtyFfpySuT/kswi21fCOsPK4QakXzbIU657aNhDm3AuRk1lKbYPZsCHk575sSzFyGotxgLn4Ptm+Wp6O2V/PWQnVeYlRrzWeebIQsbSSq+UCbWE5GUykKUAb4KV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=Na8D5HQH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="Na8D5HQH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43df14d8a27so1479221cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 19:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715221630; x=1715826430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqSpV7fmg1v3Tem3cwAYpfCqBii01pFKWcG15GV8olM=;
        b=Na8D5HQHBaGMsKN2Y1WvY+LjkmUrijzHzodZ76Nxyx1MScBhQI3uGgx8njHRBL57yu
         ZW8nkIn8Qr3Au1cUsOpetJPY+HjhmiNc+mvacS9C5YZ8Ct9GEFS1X31i3sU8KY36UYBx
         ApX8p3K5sqaLc2BERDQwN78PJ7GbxVcKAcDE5le4YUXCIAYI1FSF+1Bbxgfq3/O1P1eZ
         lDELyBDDjCd0IeT0Dcr6yP+GTLytFnsKDb57NT8CxkAPLqJ1z3gjyLliq3srLr7T7sKT
         UMvqBW4aYO3cUPbQpnPOp5dZeh57TYiOLNJe/d4Usvj6nNveoWHu7J5HGV9TjTj5ca2e
         HjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715221630; x=1715826430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqSpV7fmg1v3Tem3cwAYpfCqBii01pFKWcG15GV8olM=;
        b=VHyZAfWdDcyFDetYsqSQWZY5K5s6Lto0Y2nbgmbaszXOIpVc5Kk7F3RutIwsCbwAj1
         TzLOs55A1cyW3p2SuYwgMK97/hmS+ssMxU3ScrYZATNAgqnvuUMCO7sP0dOToFpNN/Wp
         XRTerZxg/JhrTB1S3zn04AOLKMWgb99imh+HfbMCDzXj2suZmZh/TQICR4h6CYM/7EXo
         EDVlPFfq6OpWX2pvTjJ7rMlpOGBZN5JA5el1VV2f9X73YORw2b05G8FFw5W9olJxTYU3
         qjipTcFUyidZDydM81spgX6zbSp7wGMKOJF+p8gRu9JauVwifcLezVLGRDhJFBHfsNFf
         y7Ow==
X-Gm-Message-State: AOJu0YweOUpiaqOb821rSEADvBgV+ipe/S1wAB1+EY1A+cdLqG/hILRk
	T4LafX8AUanGrJk/ZI9WBi44UbMiYTlInXx/389V5GOqae8aMw5R9Klag7w95olNeYqq5S5N2zj
	B
X-Google-Smtp-Source: AGHT+IFl1cg67E3MP1c9zQVQNv+ONBhXX9Wfkc8AEnPTty8Uw7xlHXiboLkLaB5yQY87FnTKej75wQ==
X-Received: by 2002:a05:622a:1a0d:b0:43c:5d37:5a97 with SMTP id d75a77b69052e-43dbed30d10mr56293111cf.31.1715221630560;
        Wed, 08 May 2024 19:27:10 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56e278csm2091761cf.93.2024.05.08.19.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:27:10 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v2 2/4] test: Add a script to test ASHA
Date: Wed,  8 May 2024 22:26:38 -0400
Message-ID: <20240509022640.451351-3-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509022640.451351-1-arun@asymptotic.io>
References: <20240509022640.451351-1-arun@asymptotic.io>
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
index 000000000..bd2e05ce0
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
+def start_playback(fd: int, mtu: int):
+    global mainloop, pipeline
+
+    outdata = bytearray(mtu)
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
+            if info.size != mtu - 1:
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
+                if n != mtu:
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
+    start_playback(fd.take(), omtu)
+
+    mainloop.run()
+
+    pipeline.set_state(Gst.State.NULL)
+    transport.Release()
-- 
2.45.0

