Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC5181BAA
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209277; cv=none; b=riJqLuCdSYB7qy/svIJrAxs5r5n7RaqbjriPlocA90HkzVxxnk30kHD4p0DxyEoxKgCcSbtMM0LNG5+DdTweuL6D//midgxJr553WQ00c0z/zTS7+LNLd15AlXSQRr7p1sge7j0JRgok0y0JubB0fFzf3n8WgEQo1Mh9P0nQ1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209277; c=relaxed/simple;
	bh=LK8PRW7YnqLwZKI1w6ie6G28qbhpou+6p4JjGEvZEvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4xjizne8XbMkQALRc488rksRPRTvjkR5XvhfvUP38mIKl7ghPL1PM3BScDySMHNMA3mnDd8ndCpdanz10SphumzXIxvhSKkISiCpQrq3+iF3uQ2Z5sY6Ymo4DH3lbZQyVnjPM/tXrcY/93dwoyUCvN+89mn3ViowRp7X8JJJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=nG/sN4AJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="nG/sN4AJ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6aedd5167d1so13429536d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1718209274; x=1718814074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIPQ2p2JQ9cgzYNS6qKd0wXGcyBXoGdSDweRnIvgR1k=;
        b=nG/sN4AJzq1Bx0qGi59jTtw3fxLeYG8O1WQBw1olxFCF/+dV6cokaqhrdQUXkmZ0ld
         7+NL79X3X4H0jas6HMvuxVMpPt4IyuW4wrEa4YHRh3xxF8c0RWVKye/2bRRmxdRYdwdy
         Zrbr6894vxaCkk+yrDuHO0GMX/e37a9GmPWLGH/1IzbABWEwOGs/lx+8xysCBhFHbGXR
         h21O9Q02/OIkU86HpZY0/l06VLUNgkeuLb7Q9hfE1nNo2wdYnbj14U3bwypBFPOHNarz
         JWsLgRzqEFQLxuMP0yGXnvtG+nA5ij+rDd7uQ/NU3cAyG5Gzm8lMee0kaYoXORmWd0kg
         dj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209274; x=1718814074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIPQ2p2JQ9cgzYNS6qKd0wXGcyBXoGdSDweRnIvgR1k=;
        b=dY2+ur/S+a0mF6Yp7oiesUNIMk7GvjoIK1UP7lprDJmBGRUjVMzw+ITHD01AA07X5B
         e1SjEad7e0cSj8udRLDeKK9Oduf6jHZ6i+v1Kjc30YPTSGRfBnknZAaWxVbmLjzf3Ow0
         Qw3LiFiiVx0vuMNmN0bbY949gAFg7BH+enrgs87rRDMVrvz72N8Jc1P2BODxqxbEY0jZ
         bJQx5afAczb+FUGnIxKYATaou26i110MNq7C07wagx9rmFvW6LeW5TCokCo8c74uVktP
         HZhYJmQkS8iN7LhTQTHG4M1UxfA0zP4AQSl/6Gn7IVPaYZNtg+acczedZnLUTm6SjJpJ
         SMZA==
X-Gm-Message-State: AOJu0YxQ/o5fja8S2UPfEAbGjBFlrDP+VPACJdHqzW59IoLkYELGmw+w
	31RwxNQlEwWQNmthAmia5Ug0wJqakgkbX7Db22m7cxvYwzNsJ5dPENywC/lyqVYVnsZ9WtENDyk
	rWTA=
X-Google-Smtp-Source: AGHT+IGmatHBoHF3N15k8rsx1q8nOK6NclsiYCttkqU+eGSTHW6LO9F6ySp94Ln3+XTh+mRKvZwY4A==
X-Received: by 2002:a05:6214:5541:b0:6b0:8b2d:b6e with SMTP id 6a1803df08f44-6b1a731aeefmr27964216d6.63.1718209273089;
        Wed, 12 Jun 2024 09:21:13 -0700 (PDT)
Received: from andromeda.lan ([70.27.101.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b089aa106csm21899616d6.127.2024.06.12.09.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:21:12 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v10 3/3] test: Add a script to test ASHA
Date: Wed, 12 Jun 2024 12:20:41 -0400
Message-ID: <20240612162041.689679-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612162041.689679-1-arun@asymptotic.io>
References: <20240612162041.689679-1-arun@asymptotic.io>
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

Resolves: https://github.com/bluez/bluez/issues/481
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
2.45.2

