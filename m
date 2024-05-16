Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C36156F55
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888334; cv=none; b=AfznbXh8Av9i2/oUNJTezEBYfXaaYCx6jUorZCIJ7QhYpApiC12w+DmTgUHQ6NWZ02JFs2n+S13W3A/OD0dXvyG4JJzPhf4OEQA/wxd9Uo/dCW2sYuCuB8hNywv/NiyBPJP/kgVX3v80F1/vtN04mjJKYjwZ7yDnvXB5HG/AoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888334; c=relaxed/simple;
	bh=6c/+ROLbNRm+TTNLh/XMDSCBnMGGRkXBbB88D1oCe7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFB+MMrldTZMHcNCaOtSyA8Q5mEeASbsczKhGi5QqDcQOI68Adok/Wez9iXI4In90cZ54IEPyh4i90ZXVPjf+thff5+hqiUYVp4ImOZSa4JEl5TyiWtl5sr/pvlZikcsQofFOn6gAaYYJ81ck421bDvhScz0+LW/mO32nUkdXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=pcXxMiAt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="pcXxMiAt"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-574f7c0bab4so4161781a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715888330; x=1716493130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP83zmkg4iOCBpHuxWEl236Q3HLHXrWJIoI0wnT6wN0=;
        b=pcXxMiAt8Ip/T4Fo+h+3D2m+aGgaUFqJy/6G9U9Mxe9DwTXyfKqiFjZ7iHfkp5Scuq
         7oPTvOmlHVnMTTDpZSdKrRMaOMT7o9PSMZHIrTsJEPC5YyLABL+8muQZG0YXscujqtkK
         64VLMmWQbkYoBrzgb3MVs+TF6yR7z5ok9/lihc0/l8Hfan6BhXr6N2Odk0/KUDr7sSs8
         eF9PZH+1YFDwQ8+jhs0jIqo/iRnXLLsuPBVlM0ux0kaY3CGoUzfT1kYowyYCIa4+s5WI
         atMIcCzolqsUPDfkrEd/7sAxjKZX+4m6PPUZ50QbBgboGT69y6nXyj9byxPOFU5ZRBLc
         r2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715888330; x=1716493130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP83zmkg4iOCBpHuxWEl236Q3HLHXrWJIoI0wnT6wN0=;
        b=wolzfgu+r0PhP4o1EUpVO4o3PjTmVjMWKTIKsshC04Qf8gJhXLhKwg5+zDr6VExPnC
         aKOyZChLlMDtzbcrAqc0WWI9+NOqvCETDgE3KjnNcU+92Oc8QSZrq7s+05LHZsI44tYY
         iv9Z64iTN4bl4i0SaDDD1i6Z29aNOwqiP1P+FkLsBTU9uZQw1XOclifBzd4wY7YaavqT
         u3izgmtV7uLdjNERR7+dKzhBIBls7gcfLdcqGlYz/ZDSwXUJAW+x7Ygpw8HKrL1MLsFR
         NOC7C7qHLnboJrxBLchpE/5MwV6ykwBzaBjNkKIKRShjtibtFF3m3SXYzGWJ1uQHb1Z+
         Owug==
X-Gm-Message-State: AOJu0Yxw9l/wLcpNzSgjmpapEHH2LV3HLDMTXoI664m3fmZtDaH+RhvE
	0dL1queJKARHXTJ/PxOXZI2b3LLtxT+oJJgMPGzzNK3eWfCSRMfIeOkzf3rzT6lKTqSgGmKsA2T
	rPNk=
X-Google-Smtp-Source: AGHT+IH7qZx4H4EHTJ4RhdONo9o/r8UA/+3TCgGtVWMne9ift1Bzn/4b4SQEZ8XXxhmXY2vAMJ04fA==
X-Received: by 2002:a17:907:25c5:b0:a5a:3e00:6317 with SMTP id a640c23a62f3a-a5a3e00636bmr1804132466b.31.1715888330235;
        Thu, 16 May 2024 12:38:50 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cd85sm1031241766b.15.2024.05.16.12.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:38:49 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v6 3/5] test: Add a script to test ASHA
Date: Thu, 16 May 2024 15:38:34 -0400
Message-ID: <20240516193836.228281-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516193836.228281-1-arun@asymptotic.io>
References: <20240516193836.228281-1-arun@asymptotic.io>
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
 test/simple-asha | 162 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100755 test/simple-asha

diff --git a/test/simple-asha b/test/simple-asha
new file mode 100755
index 000000000..96f115988
--- /dev/null
+++ b/test/simple-asha
@@ -0,0 +1,162 @@
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

