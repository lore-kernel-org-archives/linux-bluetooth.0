Received: from mail-vs2-f26.google.com (mail-vs2-f26.google.com [74.125.227.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090E51476B
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024512; cv=none; b=gIrn8qNyeXU5R9IuCM4ySlKI9e4i8GfR8lBG8/0IqBBZSlMM/4jYTjp99ObO7zY3k2MttU/oAPB/DPknIREgGSg0k3MONefm2h5GHHRzOW013iYSjWxyX86fTl1tIox5/F6+shGguDVBIa6tUmQ5lHiTRZT+zUB+UQFYPstbgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024512; c=relaxed/simple;
	bh=L3oGAlDAZ1bV+Obg5iRxW9Iy895ZFOSq2hrOcxKb5yo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7ZmOixdiPiywknzq4xOjIW1LmZeN+BdeP8u2TMhSGO/xVLy1hi3fr1sUwaAEO8Jek3tnsXbmVqnoN0vl+hHDaGj7qsdMJCUXf0diAxmZifuWjDbxPUADPWdxQh78o4n4oDOVeBfQIg/P2awVJWYDUZqqDYP7Ca8DpkS7bNGFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSU4SiAk; arc=none smtp.client-ip=74.125.227.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSU4SiAk"
Received: by mail-vs2-f26.google.com with SMTP id 71dfb90a1353d-5c67e529da9so1267693e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024510; x=1790629310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vEdh73Be0jPgEiK/B/oYi0n0+lHCaiWMs/AxZ9D8d5Y=;
        b=jSU4SiAkJpBBIpSm0bUs/cwiVMuxFcPA9nGxCy9sHewmAgZcS+ggqR6BY+gJJTGKjz
         RzCCfQ5I1SYCvtRLkWBCzta+Wh0sJDrVRDlJIKCQZJUOyhuCXLGQWMyEZLdEaxky1pZO
         ScakrO2miJGBzAMs7VDWewqv70Jvikg9nbPGkLFi5MdATApTsV0ioySiL8dYhloPbqOH
         aRKww7dRabUIgZQVR2JGZJpcawUR8cn1Ij2StVOSKHQKdkj5mfegLkz5KIP0qk0ojlrN
         XdyLjesOtJRgt0RY7L+FJsTiN6wLIjfW8ePRrrBwAsAmjhFmHDJ4NAKKYdDqQeiz0LP6
         ESNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024510; x=1790629310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vEdh73Be0jPgEiK/B/oYi0n0+lHCaiWMs/AxZ9D8d5Y=;
        b=D7ZFW6SWQiwUesM7cTKvuhrllydSKxWvTmce9qOQrPkYThMXF+K4nLU9DrLEE/xqST
         zQ5LxSqvfYITsOFHyRJROtauWeu1Lp0qpvxeGEzN34FV8KMjcBIOBzUjMVRQ4+6vL/LK
         RcAAV5H/jf+wBaKriD7mi1kDjgi30Pe8MREdNSz0qLlPWJvX+eFbWIwCjNFRVgU4IicP
         lN11LvfhcOMXM/mf3igX32h/CoEyivAOWht90THjVPFDZc04OHXHgaeMRtgRhX319wM+
         XzN7j+FLxy8BXOktxAN2wJtG7o2if575kcSDTa5u03okf3QrAzMbQYyX2l3p6NojmMrE
         v6Vg==
X-Gm-Message-State: AFuF++nz/Q+DJHcZAK5m9o3KVmnC9IeC3AMCP3lX9fTILtqO2GNDJ37x
	JNNGECf3FZJri4gy1N6LUWZHxH3UuRgqdMaShYRSiAsF9oR47xuaPSqSEMbPV/Zd
X-Gm-Gg: AYBFou0RT5A63zH6o7egv+ydsD/4RbLjFFt/j1pejOfEH7r1K7d6YlqHY5dvZ/LYnhf
	mbbaIQ8AxdXBKUCquS8FaJo2jLR7i3lvJ81RuzF979vw1p/JR5geAYuA2Fce/J7S1UMQ3HgYmcd
	8XAVSQFMGzcOD4nlLDbs/9fhoWoHDK8Hf1LhAVBMcevfxNADWFXxxVtG7nEW90qUju8Iv/1G+Qz
	oV6uYWKp0MMOGYKmi9EqUZRuvAzFe4MIPvog8i7/biKG/2y6DqBDFu5rlEc010oTt9uUEcU0j1r
	0dKBpb2G+YR6F+wudMtZKLvlAVvd8Ohvi89a5YLDTdOfHtQFPJxhNN+YuhMHI3FEpsN26n24BNm
	eU2cz+DURntuPqBizXK0dGHmXLiV6yA8VkRfl+O+7vj6CD5oFT0I9+sWGdLn1whiRNQZVcyduAp
	eBjAiRqKSpVgU5rNbf4kldn/Cw93I3RPK6RDv13d0IL8jS9henQZi/QTYGAY81IGdfBitVhw4dK
	/gRnx2PMHlr7ERxCuDeJ3RaYYc3Iso/t1QiQCDrm/Rtk4O89oLTeDislqpeZA3z
X-Received: by 2002:a05:6123:12f:b0:5c7:ab80:2922 with SMTP id 71dfb90a1353d-5c9b591f65cmr6478497e0c.6.1790024504920;
        Mon, 21 Sep 2026 14:01:44 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9850c318641sm83527241.9.2026.09.21.14.01.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:01:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/6] test: functional: add the true wireless broadcast tests
Date: Mon, 21 Sep 2026 17:01:20 -0400
Message-ID: <20260921210123.3690449-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921210123.3690449-1-luiz.dentz@gmail.com>
References: <20260921210123.3690449-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Assisted-by: opencode:claude-opus-5
---
 client/scripts/broadcast-sink-left.bt  |  23 ++++++
 client/scripts/broadcast-sink-right.bt |  23 ++++++
 doc/functional-bap.rst                 |  10 ++-
 test/functional/test_bap.py            | 104 +++++++++++++++++++++++++
 4 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100644 client/scripts/broadcast-sink-left.bt
 create mode 100644 client/scripts/broadcast-sink-right.bt

diff --git a/client/scripts/broadcast-sink-left.bt b/client/scripts/broadcast-sink-left.bt
new file mode 100644
index 000000000000..d5ad2ed25abb
--- /dev/null
+++ b/client/scripts/broadcast-sink-left.bt
@@ -0,0 +1,23 @@
+power on
+#
+#
+# Register a Broadcast Sink endpoint with LC3 taking a single channel,
+# to act as the left side of a true wireless pair. Each side syncs to
+# the Broadcast Source on its own, with no assistant involved.
+#
+endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Left, so only the BIS carrying that channel is synced
+1
+# Supported Context: Media
+4
+#
+#
+# Scan for Broadcast Sources: the sink syncs to the periodic
+# advertising and creates a transport for the BIS matching its own
+# location.
+#
+scan on
diff --git a/client/scripts/broadcast-sink-right.bt b/client/scripts/broadcast-sink-right.bt
new file mode 100644
index 000000000000..58f07dbe67ec
--- /dev/null
+++ b/client/scripts/broadcast-sink-right.bt
@@ -0,0 +1,23 @@
+power on
+#
+#
+# Register a Broadcast Sink endpoint with LC3 taking a single channel,
+# to act as the right side of a true wireless pair. Each side syncs to
+# the Broadcast Source on its own, with no assistant involved.
+#
+endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Right, so only the BIS carrying that channel is synced
+2
+# Supported Context: Media
+4
+#
+#
+# Scan for Broadcast Sources: the sink syncs to the periodic
+# advertising and creates a transport for the BIS matching its own
+# location.
+#
+scan on
diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 87917065e1eb..7059e0c735f1 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -290,8 +290,9 @@ test_bap_broadcast_earbuds_transport_created
 :Steps:
 	1. Start `bluetoothctl` with the source script on host0.
 	2. Start `bluetoothctl` with the sink scripts on host1 and host2.
-	3. Each side: ``transport.list``, to check that nothing besides
-	   the transport of its own BIS was created.
+	3. Each side: list its **org.bluez.MediaTransport1** objects, to
+	   check that nothing besides the transport of its own BIS was
+	   created.
 
 :Expected:
 	1. ``Endpoint /local/endpoint/ep0 registered``, then two
@@ -307,6 +308,11 @@ test_bap_broadcast_earbuds_transport_created
 :Notes: The BIS index of the path is what tells the two apart, as each
 	side only ever sees its own.
 
+	The objects are listed over D-Bus rather than with
+	``transport.list``: the endpoint prints the transport it was
+	configured with as well, so a listing cannot be told apart from
+	it in the output.
+
 	Both transports of the source have to be acquired, as for the CIS
 	of a CIG: the BIG is only created once every BIS of it is ready.
 
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 7bd59777b53b..bfcb43c0ad67 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -312,6 +312,20 @@ def remote_transport_properties(remote):
     }
 
 
+@mainloop_wrap
+def transport_paths():
+    """Paths of every MediaTransport1 object of the host."""
+    objects = dbus.Interface(
+        get_dbus().get_object("org.bluez", "/"),
+        "org.freedesktop.DBus.ObjectManager",
+    ).GetManagedObjects()
+    return sorted(
+        str(path)
+        for path, props in objects.items()
+        if "org.bluez.MediaTransport1" in props
+    )
+
+
 def add_preset(ctl, name, props, metadata):
     """Make a custom preset from a transport's codec configuration and QoS."""
 
@@ -460,6 +474,96 @@ def test_bap_broadcast_transport_acquire(hosts, source_script):
     )
 
 
+ACQUIRED = r"Acquire successful: fd \d+ MTU \d+:\d+"
+
+# Transport of a given BIS of a broadcast the sink is synced to
+BIS_TRANSPORT = r"Transport (/org/bluez/\S+/bis{}/fd\d+)"
+
+earbuds_host_config = host_config(
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+)
+
+
+def start_earbuds_broadcast(hosts):
+    """
+    Source broadcasting one BIS per channel, with the two sides of a
+    true wireless pair scanning for it, each one taking a single
+    channel.
+    """
+    source_host, left_host, right_host = hosts
+
+    source = start_bluetoothctl(source_host, "broadcast-source-2bis.bt")
+
+    # The BIG is only created once every BIS of it is ready, so the
+    # script acquires both transports
+    expect_all(source, [ACQUIRED, ACQUIRED])
+
+    left = start_bluetoothctl(left_host, "broadcast-sink-left.bt")
+    right = start_bluetoothctl(right_host, "broadcast-sink-right.bt")
+
+    return source, left, right
+
+
+def expect_bis_transport(ctl, host, bis):
+    """
+    Transport a side created for the BIS carrying its own channel,
+    checking it is the only one it has.
+    """
+    _, m = ctl.expect(BIS_TRANSPORT.format(bis))
+    transport = m[0].decode("utf-8")
+
+    # Checked over D-Bus rather than with transport.list, as the
+    # endpoint prints the transport it was configured with as well, so
+    # a listing cannot be told apart from it in the output
+    assert host.call(transport_paths) == [transport]
+
+    return transport
+
+
+@earbuds_host_config
+def test_bap_broadcast_earbuds_transport_created(hosts):
+    source_host, left_host, right_host = hosts
+    source, left, right = start_earbuds_broadcast(hosts)
+
+    # Each side syncs to the periodic advertising on its own and only
+    # creates a transport for the BIS whose channel allocation matches
+    # its own location
+    for ctl, host, bis in ((left, left_host, 1), (right, right_host, 2)):
+        transport = expect_bis_transport(ctl, host, bis)
+
+        ctl.send(f"transport.show {transport}\n")
+        ctl.expect(f"Transport {transport}")
+        ctl.expect(r"Codec: 0x06")
+        ctl.expect("State: idle")
+
+
+@earbuds_host_config
+def test_bap_broadcast_earbuds_transport_acquire(hosts):
+    source_host, left_host, right_host = hosts
+    source, left, right = start_earbuds_broadcast(hosts)
+
+    # The two sides sync independently, so each of them is given the
+    # broadcast code of its own, and both are checked
+    for ctl, host, bis in ((left, left_host, 1), (right, right_host, 2)):
+        transport = expect_bis_transport(ctl, host, bis)
+
+        # Selecting the transport syncs to the BIG and starts acquiring
+        ctl.send(f"transport.select {transport}\n")
+        ctl.expect(r"Enter bcode\[value/no\]:")
+        ctl.send(f"{BCAST_CODE}\n")
+
+        expect_all(
+            ctl,
+            [
+                f"Transport {transport} State: broadcasting",
+                ACQUIRED,
+                f"Transport {transport} State: active",
+            ],
+        )
+
+
 past_host_config = host_config(
     [Bluetoothd(conf=BAP_CONF), Pexpect()],
     [Bluetoothd(conf=BAP_CONF), Pexpect()],
-- 
2.55.0

