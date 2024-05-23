Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62563134A8
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479598; cv=none; b=BfJLCNLtmA/WeKkEK9jtqrw+4RgHodvAQrXZtEl3g23GG5OhIJPIncgXL92KN0RUWTvFbgkHJP8pGrqCqrnWFeVYVJZzutYUEJvatrifAFIQ0ppHTjToImIzrk8XIqpGeokBA1C7mLND6yb5Nhhll0aEsMsOSjNa1LZCUoJWitY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479598; c=relaxed/simple;
	bh=kTXOnNSQePf4pgiLORlZ9YxnWTryJR4pVGlUK03V0yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ek0lTUomeW84PAs28v9glfsvJLKCi3lZR6nIUjLJ7nv0Nb+WHh9yHtEFeKyiC6oUD08VPH92R3KaNvZl2HmhhPen+7M27aej3BP9+11dkM7a3KGoB7KOAcbsOtA6CSWL2085V+SGry/a2/3zhfhF2bm9fBla9L/R4S0DpWMHFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=YJCW81e3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="YJCW81e3"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a620a28e95cso417723466b.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716479594; x=1717084394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pauh3OFCW1CJgYFyOsqdbbndY3lRlzePb7/+UlEtxfs=;
        b=YJCW81e3sz/aVGds8n2Vyd1q8yweECOB9WVnK9tJF4FspT7UUYKSAnY9CbcnMKxZfA
         o3JhEsvFWcGMXKIB8HgYpPZvG4KmZEXpSMmwV3gPI9TlJkZI1QDc56LgMAynrXUeX4JU
         gYaWFcDZn79mLu/ufaVRtHGpY1PFseiwguNYBvTRGhOYfQ7QTyXFEa9iaiRWNAmw2J7k
         nv4Muop2btM8V5F4PA1qF7qLVlvwBdjYC0gMWC1L84kMma/JFzSdzpbVkBkCQ+l4JvmS
         p5x0tlUjS+biIMXwVDC6zOLjwbz0GLLxH6p4EQCvH8jvOVo+nftoDFyvT/YGKvrpHU52
         bXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716479594; x=1717084394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pauh3OFCW1CJgYFyOsqdbbndY3lRlzePb7/+UlEtxfs=;
        b=WUcQsSia1OA2oaZp18n1CsiDEE3+ll1zG2UAYKa2Q3oTI9VAYphqrTRB1oRgit0jj/
         GkD3gXohzeOkqFCW1AdAFU06Na2m6EETxUUuba99VV7gfgQC4Xl8HDmWvRkZrK2+yIka
         W7tIUPQ0uGusHC6L07gsfcSzSd3ss8381QLTzmmVt7hSg2jRIjTnoYuGq8zCP8QAvTGO
         ow9wcdYzMRv8HVyawMXkE2mitU996zgKrLgGlWzQG9ukBbin9aKbVuK8d5heSHFfPXzR
         VbyVXwFmDaNi9fRDQq3H/Idh+L0ydBhZB11U1V45LyC3is8r52dQOr33GjW0AYArE2Bn
         VUrQ==
X-Gm-Message-State: AOJu0YwD8vwTq3qWLFqRdbYmXulhMUg+l8FzqSPfsm1QrVJTaWy/ZA9I
	sUcF5iIbiKw/olQgSKbJZkpJDeB3txc4/WsW9MpJzrIJsFhhLq8C+bJ4cN3ZXAAMY8R/E/qEXJZ
	9
X-Google-Smtp-Source: AGHT+IHIOdfOdaz9oBujj4BxvdZq8+P+t9xGi7FWysn45OT+fEGvepLByIItaSkDFjZhAZmgIUDl2A==
X-Received: by 2002:a17:907:a0c7:b0:a59:d4f0:cfc3 with SMTP id a640c23a62f3a-a6228125461mr342422966b.59.1716479594641;
        Thu, 23 May 2024 08:53:14 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c686sm1947600566b.47.2024.05.23.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:53:14 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v8 3/5] test: Add a script to test ASHA
Date: Thu, 23 May 2024 11:52:59 -0400
Message-ID: <20240523155301.140522-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523155301.140522-1-arun@asymptotic.io>
References: <20240523155301.140522-1-arun@asymptotic.io>
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
 test/simple-asha | 166 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100755 test/simple-asha

diff --git a/test/simple-asha b/test/simple-asha
new file mode 100755
index 000000000..c90f8a12b
--- /dev/null
+++ b/test/simple-asha
@@ -0,0 +1,166 @@
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
+def start_playback(fd: int, omtu: int):
+    global mainloop, pipeline
+    pktsize = 161
+
+    if omtu < pktsize:
+        print("Weird mtu", omtu)
+
+    outdata = bytearray(pktsize)
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
+            if info.size != pktsize - 1:
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
+                if n != pktsize:
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
+        return True
+
+    bus = pipeline.get_bus()
+    bus.add_watch(GLib.PRIORITY_DEFAULT, bus_message, None)
+
+    pipeline.set_state(Gst.State.PLAYING)
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
+    asha_object_path = device.object_path + "/asha"
+
+    print("Looking up ASHA object", asha_object_path)
+    asha = bus.get_object("org.bluez", asha_object_path)
+
+    print("Looking up endpoint properties for", asha.object_path)
+    props = asha.GetAll(
+        "org.bluez.MediaEndpoint1",
+        dbus_interface="org.freedesktop.DBus.Properties",
+    )
+    path = props["Transport"]
+
+    print("Trying to acquire", path)
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
+    print("Setting initial volume to", volume)
+    transport.Set(
+        "org.bluez.MediaTransport1",
+        "Volume",
+        dbus.UInt16(volume, variant_level=1),
+        dbus_interface="org.freedesktop.DBus.Properties",
+    )
+
+    print("Acquiring transport")
+    (fd, imtu, omtu) = transport.Acquire()
+
+    print("Starting playback, hit Ctrl-C to stop")
+    start_playback(fd.take(), omtu)
+
+    mainloop.run()
+
+    pipeline.set_state(Gst.State.NULL)
+    transport.Release()
-- 
2.45.1

