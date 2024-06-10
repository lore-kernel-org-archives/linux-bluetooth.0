Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF2C1509A7
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058975; cv=none; b=lLaur1S0oI7tGfMQydV0RgBCPqzF3uQCJlZMqgn2z+e5XMUWN7KCYstOzidKnD/nty/9i+OwNyfyel/9zxsBQ7Ak872zYU6GhhLjvU4b6ruNBMNfID8o9pWI4Apg7Wh8r8TO9TY5kOJ39TuMwVE2KPcNX4y58CnRm5wc7Tzzip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058975; c=relaxed/simple;
	bh=nPDywn0tj8lVWC6ia1S1axYcky1wisRxE01rfCsr34k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtrbU5rMwLyBrOXznU+ExFXAzBnZmSKq31BnbbzgNqLPzTULxXNG669ZG4CCPUa/s6e35QBN3ROcWb7SmN7T9uedEwH4pbAlp+iTFPvd66ltUovNm1BODHTDcPeHnLtQPLV0Q6aYSDeN0JTCDFPf37opszZAHVGUZmOQ8cxCDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=KyE0OWE7; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="KyE0OWE7"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4405743ac19so19659081cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1718058971; x=1718663771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v2d06+guO1PwQL/lLWpqf8Gb8WpYdr2rO8E1Fh0RzE=;
        b=KyE0OWE7nH/q/im2GkkEshg6f+V8bXs+I+cfeVpFO25ADp1iXJ6W66VyJiFq/5OK/Q
         BnFNDutxuM3sWqrjYQXjE8sQoPu1+N4/DBpyfwb5trM3PJAB6+NyiHq2xonxDKdl4eok
         DHfsK0c2w82RMf8PTCOqy8wCuifnc9MLB8g+KLZK+r0EnIBlwTJFFfMduuphSOI9dRyp
         pI+TEQ0vEAuAXQjt2F/pjPq1V81+Z9xhhN0ILrqNxxlVkookuez0dAZ94fR70yqlmzmY
         jgZKaMvmoEc7ucAsj0vVYOE5xLH75yTpnjousFzpFnzGD/8FtnKLNo/cBGxs69Gkr9W7
         xXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058971; x=1718663771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v2d06+guO1PwQL/lLWpqf8Gb8WpYdr2rO8E1Fh0RzE=;
        b=rzeBv2Yn8xXiTSa1O2lENmjQqmefH0HPcrs6tvgp7L51D55TYe0t2m95nLyqvuz7Cb
         oX/oux/f6LU2QPxmaE5yCl/JlDbl5JUzUTmutjSOnAVSUqIJto8hGo8DojWNu5XAIma7
         5lI1hngl21sGvMqjvuW/MHGN2KdUzO38MLfJtRZ5PYXY/mqBKUKH4OOqGYBVF1ULFWEc
         CJgDPc6aGRWXUxGrqcZya1TJq+Rx666rYDHVvdqnlFSauznn/LHtM3N6Qdi2QhVbIEPe
         gpFP36uF7viKm8pQvb6qMg+HYWztalbhkXkJuggRMHr2Bb8g1N2gofZ8YLflzH39Thga
         6LKA==
X-Gm-Message-State: AOJu0YwNIUBoTHZV+nElSDOGrSJF9eMesxQ58E70FpH6ZBfnZnrFUkYN
	imrj9V7pM301bNwK3OUl+BwuInNc53Iq/f86E+SJ4k1uNFCjXFaY0ay+HKQNJ816QhofLo94sYO
	C
X-Google-Smtp-Source: AGHT+IHmsiWe5jDpJJSKJXytdtdx+lscQqEjhtvFJM/ZDt2ai7vwP8dLOqlkMEURTJyS8r8k4d887w==
X-Received: by 2002:a05:622a:281:b0:440:97b5:cb with SMTP id d75a77b69052e-4413ba8d789mr20481211cf.32.1718058971307;
        Mon, 10 Jun 2024 15:36:11 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440711c3c53sm16283221cf.80.2024.06.10.15.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:36:10 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v9 3/3] test: Add a script to test ASHA
Date: Mon, 10 Jun 2024 18:36:01 -0400
Message-ID: <20240610223601.378127-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240610223601.378127-1-arun@asymptotic.io>
References: <20240610223601.378127-1-arun@asymptotic.io>
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
2.45.2

