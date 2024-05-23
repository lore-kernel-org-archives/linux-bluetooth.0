Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C059C1411C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460184; cv=none; b=ONJrK24reqQO+vEd4LVmibokTICUJP9DTmOvQhKEX/BFDLsD8Km7qtgu6AcCYE0vr+ZVgdqUqW/jyuL6/bfvC3AoUOZHclJdDQb8WDNxst16QEm7952RZENHgJWlTAQjBUAv+lwV+Bljk2+UvUsTwC33jXLlMasEZmBD2a6Sdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460184; c=relaxed/simple;
	bh=kTXOnNSQePf4pgiLORlZ9YxnWTryJR4pVGlUK03V0yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoX+Zeq3lU9G9I9PZN5vd+wMt79AxDUQz2MqSgJqQHdkQM3a/csUkexKugyUGzeSPWcAdBvYBYGxiAj9fS9nTgXEWx6xYblmqbMKjm7lfmtHwmiKPqTVKjbg1KhMA4YjjZTVYnTBzmPbL1q+qzcrSqg4n3ZvFvPIrQ3seOJi9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=Re8y+oQi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="Re8y+oQi"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso3978312a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1716460181; x=1717064981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pauh3OFCW1CJgYFyOsqdbbndY3lRlzePb7/+UlEtxfs=;
        b=Re8y+oQiSDIzGbxlXOvDNv5i9MO5NQ3K+WhZK3tSxe/k9APmyoT0tl10pcPWHqjpDN
         Lqysye5xI1N6kzw7KRbngSmPLi43HLUIz9McjzNqJKCSRnDPCeTVvSO2ygkgtiIMut3Q
         tteNXiIVXCI56UqG7Q5dmPg+VvcPnNNFV2UdvFbNDoHrYGGlpmtzt24SZa8/6x6u+gZK
         xXMeulS0L014jWy6PLQjIyQaWutlNUBmsc9w7824lKNT3kWSDg26QBXBM37DW/dXCTIz
         Eq2CisHRBefA1hckhOjzdW0p0ylArJp4j0FISYMfW/xsWcyds8RHXDFkpOJXPWRDbrIJ
         gjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460181; x=1717064981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pauh3OFCW1CJgYFyOsqdbbndY3lRlzePb7/+UlEtxfs=;
        b=qi5e8jufBtKDvKgHsXuRanHgKHrOJKa+HDkpU75gKvo0NwaiFrRqBOxb53y1osPI/U
         1XQJJ8hks8C271xaz8LYD+/7WtsWVz3yrcfOtJD7JoDCGfebztuMsEsgHqqeZTdCGsL2
         pSsJqGcpPwPtQqjMAFSLTDOZXYtYhKA8SYjSsnu8Bgo+/dEjZ8VKGfghraR4EXQi09u4
         Iw+ZZ/HTUutbTyUvYHGOGhzLjy32TyiBD/y2DDJDEDpN4YmT6cOPUcc5vZvGnCHrFcHr
         8QV+3U9oyGZz1JEsAYJnpIH+aQq8ASv8q6lAW7LFp3e0GnTNNn+jmpiMAM1miOdx+SlF
         UKXQ==
X-Gm-Message-State: AOJu0YxXdOkJxzeMwd88x56j1VB664hmbz6Xa1nWRFYg7bR9Pvb09Xtt
	FNjjHyhjdMeC+qfqvYSIsEqpJ6letjshchYRnXCQ3/rJL+7C7iighQkYuPHprGBFPNbq/J49OZf
	i
X-Google-Smtp-Source: AGHT+IGZzrawUYwztnUFhQNN21ho4YrzWoHlwBs4KHzG6NVSXocWdh5lQPV1lDgR/9FWWUi51cLwMg==
X-Received: by 2002:a17:906:a096:b0:a5c:fc25:2730 with SMTP id a640c23a62f3a-a62280b0a6dmr288056366b.4.1716460180809;
        Thu, 23 May 2024 03:29:40 -0700 (PDT)
Received: from andromeda.llama-bortle.ts.net (bras-base-toroon0359w-grc-41-70-27-101-40.dsl.bell.ca. [70.27.101.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a50365669sm1673515666b.193.2024.05.23.03.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:29:40 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ,v7 3/6] test: Add a script to test ASHA
Date: Thu, 23 May 2024 06:29:26 -0400
Message-ID: <20240523102929.37761-4-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523102929.37761-1-arun@asymptotic.io>
References: <20240523102929.37761-1-arun@asymptotic.io>
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

