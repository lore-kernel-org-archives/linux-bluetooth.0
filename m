Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45BF14B972
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871323; cv=none; b=PTz76bKA0lZLpfnbUuOk8aIxOUfUjvJbq8dJtZk5ZLTn/GY9jTTV6hcZARN9slNVYLiPhkVtW2KOuFvXKNHayNzBRDYAmI/AvjpBlHwlc2tu6sLVq/KQralXNBc8mt1nmgpD3Nm6PKAr8UX49JNeHjiocRyT0XxZzboia+ZN3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871323; c=relaxed/simple;
	bh=gbVMrPY70hNGVRJcd+ramq0kJAcmnRVOFYt+seXkXT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8QEXguB5MS4Y2f0yexZvi/Ybhgmlxo8nOWNGq6624/RZvCRRrYjaqjFyhDxuuEONpnIU8S5X3LiwtCAfW7A2xuquIOO1tEKyKaE/YfareLL+cw19gATmYWVopPJDL3+6kpNmkJ77diUdTksZnMw9Zmn4hyKKa8NlRVKzJ0OprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=ubTjf/Fi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="ubTjf/Fi"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso3631403a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715871320; x=1716476120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqSpV7fmg1v3Tem3cwAYpfCqBii01pFKWcG15GV8olM=;
        b=ubTjf/Fi/8E6huYljmvja7kLIqT75RDmrPW2ZCo6/6R8++JPRbBHbDJulSiwfapiyJ
         Cfzq3VEev4E68nkhSCW6s3o5hCH6Y4YpNz/cHj6ZfKziVJxZgjAR0LBbvHzazz1Pnkjv
         o/Srt+6fD4ewzm1a8hCwgPdzmp/igEyxC52/kYvtN+KtoPGIVqxuQq6wBFa6fKlA/To7
         H//gk1cEG96sOz46wC9fs3+o1D+t9woaeiuWMwcGtuBcdLgM84WlpnRfOQLSF2zsAL2W
         kB2vkxq4Eq2VQxo6OduQ8TLbZKMthYtfxK97zbApDrNltrlDj57RIyPNyoCQIbKL5qSu
         SxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871320; x=1716476120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqSpV7fmg1v3Tem3cwAYpfCqBii01pFKWcG15GV8olM=;
        b=RjblK9wjKA5Ks13GlE4o7WTmxlyk+DxSrvX6HJQSAUJOSqscorBJx38um8u/33hH4X
         oLNglhKE+vOzmSA/27K2QjfZ7ispY9cGQzTm5ULoJ+Lt0+NzxC1Y8n8CESaIrr9nDuI4
         F+PgweurstLhQh+0vFssjBWYGTn7R+EjV1pkQAMwQSrTFXGzz6U5EA/vahWgIK3bD+G3
         Uo9HPF6YrqBlZg/zqZpvAXWRpZ1j54lwpiW2da1Avfo2HoE9Fc8fjxSPNY3z3VFoFjgZ
         pVaCPEjeRwjP/je7tzw3ve9I1UA/RwbPJNLvQwt484Uf8+SZOLsx4/I3ncIXw6qimeGa
         svVw==
X-Gm-Message-State: AOJu0Yw2jmHvBbLTAbBqovjO9QLf8Uu+HpoOLTKwmOctMpyyD/yXjUyi
	OuL0Rj8XXkidr7OdVYES6wGdWfT/vCx8+2lbjqMkRhB2OPZQa/hcsC/IdbxTX6yfHiRM7ypMkMa
	8IZo=
X-Google-Smtp-Source: AGHT+IHG6kxnYEvrfwgTIpU6jjaIFWXt7bwtg7QoSHVG0Sj0GfG4vN5AXBA9guM3UsLQA7gpXfx/OA==
X-Received: by 2002:a50:bb05:0:b0:572:5f28:1f25 with SMTP id 4fb4d7f45d1cf-5734d5c1692mr13682172a12.7.1715871320143;
        Thu, 16 May 2024 07:55:20 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574b6f6c53asm7484372a12.16.2024.05.16.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 07:55:19 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v4 3/5] test: Add a script to test ASHA
Date: Thu, 16 May 2024 10:54:59 -0400
Message-ID: <20240516145501.134118-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516145501.134118-1-arun@asymptotic.io>
References: <20240516145501.134118-1-arun@asymptotic.io>
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

