Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0E2E3EB
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 20:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804182; cv=none; b=PAt+Nf1a+LmLIXKT935fqW7egEKyvxhTxaYzF6BFXDEMH8xmdqDnyWtkxRvRldL3Vr5A/QcSwp9OvWySrAg8r98grcKv6Dkc0SzLbcJ6GyIT97s8/gJZm9WCp5UhuTciT8REtfAIMW3DhcPOrhCCaLyZPxJUn5bEZHleUxheJVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804182; c=relaxed/simple;
	bh=gbVMrPY70hNGVRJcd+ramq0kJAcmnRVOFYt+seXkXT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f001cIyb9b1oJRnlwcw9VvrKAYIhh4wMX0Q+H5FHbNou9e0KaBcJ6dSfst1CmGMXMttqLg1X363C+57H2eoOCYqWLpID/BxSliM+JKqUtfHyXfBAAHRx7LRrAvW3vT5GzuxueIkaJiS9oJZJiw5WZCepfm2Y+US6oEcXcybXhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=sUDO5aDA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="sUDO5aDA"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5731ffcc905so2634646a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715804179; x=1716408979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqSpV7fmg1v3Tem3cwAYpfCqBii01pFKWcG15GV8olM=;
        b=sUDO5aDArZEp/n/zZgU3IOKCw5iX0FDejJoNLxdcP7vPzut5pZH3QXs/SJ4Zu769Im
         +Wbg9oUXHrHV+PeTKLgcsGt51uv+Jk52C5MEvK6sHonPGJj8IqFDUWNVBk+f4nK5qdDV
         bQgbwfByLFgm2wqCU8MNTQXvb4yG6PbA5/UqelFFySS7Cz2IVO8jNH6D2GtWzOWbD70Z
         6naRcHYGWO3RUJVtNmB3fG6swFjQT26giysR7n/JLlmPcyCxPmeJN1m8zgaaEmqG40kg
         mGDfblfqYUulXzoGSd7FzqSffknTNaQrSO1OMZoqEn4sUcpTIyqVMW5QSkOP/gq5yTAR
         L0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715804179; x=1716408979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqSpV7fmg1v3Tem3cwAYpfCqBii01pFKWcG15GV8olM=;
        b=tOjd/UKUOsaJvz+MBflDwbl7VW5n05+771CZEAFmY2l2e9z6oznp4VtTi4TnKwcQX4
         Qe0KSPJR05znVwj2TW6+EYI3j8ofbaf6E5cUc6ibaJ3KJCxJ/RjDrhijFU8tgT7jjSm3
         CsrQoi+Wty3aA2y0S92qwI8PM53V3N6IvfBzRtw1E/YwGQnsW3Nd9kxrZXtDWGfTzKn8
         VOR8b9799/AmK6KPljGCnmgseVge1nNh28EnWRo9CbqY7V3kaQs6T18ZN6Vgjiw/xpJn
         0ery/toIPJ5nuX3GHmAWy4krRRw0Ke5At2qBpAwRIrMOLzQPgYphfTGKzknwBQIjb9YH
         YDcQ==
X-Gm-Message-State: AOJu0YzSpP7ry0ckThsV2fAwrGo23aco/PQgGQ1PNfleKxuZcnl1KCm/
	tJykc3g74SDcvUzybgJ+UxOa4kBacLwlv85492Avjl3CzeVxj3moA1huJLjl2XF/qR4bFMcppF/
	a
X-Google-Smtp-Source: AGHT+IGafyqJSuDbJ6OvyAiT2PhR7Whlsa/f8LbP7Z7W9VtNL0WN7o2607kix9VuHw5n2Gbao3ru8w==
X-Received: by 2002:a50:aac7:0:b0:572:71b2:e200 with SMTP id 4fb4d7f45d1cf-5734d5ce3d3mr11343963a12.22.1715804178686;
        Wed, 15 May 2024 13:16:18 -0700 (PDT)
Received: from andromeda.lan ([74.15.47.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5743065dd09sm7457142a12.64.2024.05.15.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:16:18 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v3 3/5] test: Add a script to test ASHA
Date: Wed, 15 May 2024 16:15:50 -0400
Message-ID: <20240515201552.1831618-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515201552.1831618-1-arun@asymptotic.io>
References: <20240515201552.1831618-1-arun@asymptotic.io>
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

