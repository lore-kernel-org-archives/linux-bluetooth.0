Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643182;
	b=KSirXRwu2HfNGHM3hNSamYj64Ep+83HZV6+74OCNROeRt/75wlk+tcVR4Ut4uwRdqfOi
	 eD5Uiy/YCtl6Aghd7QZfv2H5MJIY6mSdxmcrKtEl3zZm/28OBeJpfxd7kqdVXyLs2luHA
	 Ou9OFllgPkfYia5UzSYSNH1v7SiPZ8wI6qgHVmPJfOef30EmkGNdsIuHckG3ulEx3O2bF
	 OZuXqZHWsHoGZ+d7RVZPUZ6ggjfL9eFQSWzU4yjL3zAPfK2KLsinU7jIYyvLRECNr+Zaa
	 8sMKyYxKMNe6dOJ3I/0jSgi0AcESAdVgAor07bcDgmo2rATv2Y9A0nj4t0QBtNr4+fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hlgmg3esh5CYVJ2svWUtYGDM4XIk/DGjXX1VET3IwJA=;
	b=OiHM5yH9HuV+sf9qGUb2xKN0s0tPaLsPtnMMv/HWQQZEPvhV3awL5JaRtASPlHVk6vUC
	 g5Fn1B30gz6ox42jrFWFBh6Mnzd8cvG1l+gG4S8M0T06XFel7wVGdULuhBUcutdOIt/Bw
	 56zmavguwQX5q7rFWRmXh+qvn0MHWntJGqZvowIEItAyY7Vn4DRXRbSGfwjNCyQjzSkR6
	 fXqY2wuJNwbNk+8xFjp3OY+LdbxYnSoGyp1zCCaE/8eSKmJ5f0+xcBEzgzIwOzH93vO4z
	 SM1W88E5zVWggc1zBWCiVqDjQncC74nINPuIllPfxk1YNt9ibxiOSkUBJMXFQSuywCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TyICGyi/";
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD5606A32D
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 18:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29BD5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TyICGyi/
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eae1276409so1006145e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643181; x=1794247981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hlgmg3esh5CYVJ2svWUtYGDM4XIk/DGjXX1VET3IwJA=;
        b=TyICGyi/xDWk+Xcw5xPx/xDAU3zNOv3zQyWU/qACXPEZLwILhwdLuzWDtNGLJzD25f
         0tDn/bEGtzyEmgyIZYSpfD0CWojFoe+CnKd+/FmKnox0EKCJB8g9hCTGvhmlB07Y0hBH
         wISMDIDhdYfJ4kXo6GOTMt0YvygiuLzoT4p4aFf8cNOyu7FP9ZQPqWAHI3kFf/vLNXxV
         9ZdHZj6nMowyEWjttHvfL7kY3O5gjg1FEtT0aE4hTjYifyK5dsyOgCKbX/xUdlN5sIFk
         qsi3WGhRFluOy7B2IqCmI5hSAtOtAFn1yg4U2xe+5uKKIHSlRcLqxazGw+6LmyHOD4Dh
         N9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643181; x=1794247981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Hlgmg3esh5CYVJ2svWUtYGDM4XIk/DGjXX1VET3IwJA=;
        b=S2oLFzDd4S0gwmJSdoK3IbTgR6aqnxO3k+JrMkjgbJUu5asNSxYpm5xJziO1z+Chva
         F9ATWa5SeKdTuT7Q0eyIXcfRabmQLH/QFbHQ8NHMHztZgw72do03oBVt4mgkoMe+BQ+m
         bCOFsG85++gUUs05OAITbrKOp8xFothErMLIIcVNfMzDfd3L8rhXQHyT1k9uB5Vp8RQw
         GBpMqrbIfi77FxyqFdwWoUmw6T1qDM7TVl+7n120cW0JCPGT3X9GD9+QpkfZbFrUKlwf
         2vyc+bUIJF/3BHhA9AZhwAd1bSPpnTy8DlZqf6ukhOoVm/pAR/tpmDwCev0m9EiAqcwk
         Cspg==
X-Gm-Message-State: APuU4Z/WtvnRtUmp4ws+Sm7Z2S0pbE/hX2CjmRiKJvfD7XZ6JqW7f8W5
	Z4RvMMMknu1hEuVbuodbqNbeaLzC8nBRjEkBToXDhIYmOsyMGBdMJPj4LbbsafV2
X-Gm-Gg: AYBFou0HuK7Hb/Mv1+9JA7XBSAzGWfkUA31zL5SZx7/Iwbh0IpzjOUtmIvNYmY4iCWB
	GxCgW7xVWu1PLynzt+kVLyyyolBCrR5AWNDb9K6cM2hGJkcl1LS3NwjRpeFpOTX9gPn9DdcZXUZ
	KgwGlfFNdOtfcX+AkffJwlXpm3Ma8K+4uI25L4q3a6LVBqHakBdE84QngzrtMrFbCkekNBSANg0
	y+8tS6oJQUlFsU9giMotK1flibgcM/wUP5bke/i4LjiImKDH7oCn/IsWyrqjh2tlfmXtBVWPCE9
	5lyz1pt4X32JsSLu2l8n/7ln2VIxc8UzCIPXunpjZhraOCYjOc2ysQ6MC+sh/TQmWbVPzo2dpUT
	XMZHGT2UyyWcQmJFGV5ovDhUT0gkHuHUbt2/lc/ABu7ITGti/CgVXpqu1V3LjSC7kL3WKE9YuUJ
	RIIJ4LPF2BSycJSVgkt1/C8V+3KsxhYS3qPOrQkvmYjPPZBQrED0bhgNxCNgsNJ/VFxbQgLQOK7
	iig1uvtuVh9gLyd3r19P2xckgQdqgj/OaERgwHyRMVbaq4Y5KJ697ParuQUYME64rb7ONRk7LI7
	WQ5Zd51FN5h15w6PKwNXj9lUKu6DEenOiEJuMOgTluu6tzj3KNxP5auHyqtIF8o+jVVvCWXIzM8
	8gI4UjxNT5UYC95h9pb2ZEZS0C20mLVSxe7CbFliwlgg3rcOxtTfndFVGFGEeO9OdGVmTFNiA4t
	ZHKgir2RVgJyG3xcyJgC9klu/Wog==
X-Received: by 2002:a05:6122:2908:b0:5ea:c214:b5cf with SMTP id 71dfb90a1353d-5ec6851f4a6mr4811176e0c.1.1793643181000;
        Mon, 02 Nov 2026 10:13:01 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf220esm10300208e0c.7.2026.11.02.10.13.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:13:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/6] test: functional: Cover enabling one ASE of a bidirectional CIS
Date: Mon,  2 Nov 2026 13:12:53 -0500
Message-ID: <20261102181256.2321329-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102181256.2321329-1-luiz.dentz@gmail.com>
References: <20261102181256.2321329-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Have the initiator, in testing mode, desynchronize its linked
transports and enable the Source ASE of the acceptor alone, as a phone
may do in a voice call, then check that the transport of the Sink ASE,
still in QoS Configured, is neither pending nor acquired along with its
link.

Also check the Desynchronized property on its own, so a failure to
enable the ASEs separately can be told apart.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 170 ++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 221efd982071..5465615e8135 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -583,6 +583,176 @@ def test_bap_unicast_reconfigure_metadata(unicast_hosts, metadata):
     )
 
 
+# The initiator runs in testing mode, so the Desynchronized property of
+# its transports can be set and each direction enabled on its own
+duplex_host_config = host_config(
+    [
+        Bluetoothd(conf=BAP_CONF.replace("[General]\n", "[General]\nTesting = true\n")),
+        Pexpect(),
+    ],
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+)
+
+# Sockets of the acquired transports, held by the host process until
+# the test ends, as closing them releases the stream
+held_fds = []
+
+
+@mainloop_wrap
+def transports_by_uuid():
+    """Transports of the host, with their properties, keyed by UUID."""
+    objects = dbus.Interface(
+        get_dbus().get_object("org.bluez", "/"),
+        "org.freedesktop.DBus.ObjectManager",
+    ).GetManagedObjects()
+    return {
+        str(props["org.bluez.MediaTransport1"]["UUID"]): (
+            str(path),
+            {
+                str(key): value
+                for key, value in props["org.bluez.MediaTransport1"].items()
+            },
+        )
+        for path, props in objects.items()
+        if "org.bluez.MediaTransport1" in props
+    }
+
+
+@mainloop_wrap
+def desynchronize(path):
+    dbus.Interface(
+        get_dbus().get_object("org.bluez", path),
+        "org.freedesktop.DBus.Properties",
+    ).Set("org.bluez.MediaTransport1", "Desynchronized", dbus.Boolean(True))
+
+
+@mainloop_wrap
+def acquire(path):
+    """Acquire a transport, returning the D-Bus error name if it fails."""
+    try:
+        fd, _, _ = dbus.Interface(
+            get_dbus().get_object("org.bluez", path),
+            "org.bluez.MediaTransport1",
+        ).Acquire(timeout=DEFAULT_TIMEOUT)
+    except dbus.exceptions.DBusException as e:
+        return e.get_dbus_name()
+
+    held_fds.append(fd.take())
+    return None
+
+
+@mainloop_wrap
+def release(path):
+    """Release a transport, returning the D-Bus error name if it fails."""
+    try:
+        dbus.Interface(
+            get_dbus().get_object("org.bluez", path),
+            "org.bluez.MediaTransport1",
+        ).Release(timeout=DEFAULT_TIMEOUT)
+    except dbus.exceptions.DBusException as e:
+        return e.get_dbus_name()
+
+    return None
+
+
+def wait_state(host, uuid, states):
+    """Wait for the transport with the given UUID to reach one of states."""
+    deadline = time.monotonic() + DEFAULT_TIMEOUT
+
+    while True:
+        path, props = host.call(transports_by_uuid)[uuid]
+        if props["State"] in states:
+            return
+
+        assert time.monotonic() < deadline, f"{path} not {states}: {props['State']}"
+        time.sleep(0.1)
+
+
+@pytest.fixture
+def duplex_hosts(hosts):
+    """
+    Initiator (host0) and acceptor (host1) each with a local PAC Sink and
+    PAC Source endpoint for a single location, paired over LE, with a
+    stream configured for each direction over the same CIS.
+
+    Initiator transports are keyed by the UUID of the local endpoint: the
+    local PAC Source streams to the remote Sink ASE, and the local PAC
+    Sink from the remote Source ASE. Acceptor transports carry the UUID
+    of the local PAC of their ASE.
+    """
+    host0, host1 = hosts
+
+    initiator = start_bluetoothctl(host0, "bap-duplex-lc3.bt")
+    acceptor = start_bluetoothctl(host1, "bap-duplex-lc3.bt")
+
+    pair_le(host0, initiator, host1, acceptor)
+
+    expect_all(initiator, [CONFIGURED + TRANSPORT_RE] * 2)
+    expect_all(acceptor, [TRANSPORT_RE] * 2)
+
+    transports = host0.call(transports_by_uuid)
+    to_sink, props = transports[PAC_SOURCE_UUID]
+    from_source, _ = transports[PAC_SINK_UUID]
+
+    # Both directions share the CIS, so their transports are linked
+    assert [str(link) for link in props.get("Links", [])] == [from_source]
+
+    yield host0, host1, to_sink, from_source
+
+
+@duplex_host_config
+def test_bap_unicast_desync(duplex_hosts):
+    host0, host1, to_sink, from_source = duplex_hosts
+
+    # Desynchronizing a transport desynchronizes its links as well
+    host0.call(desynchronize, to_sink)
+    transports = host0.call(transports_by_uuid)
+    for uuid in (PAC_SOURCE_UUID, PAC_SINK_UUID):
+        path, props = transports[uuid]
+        assert props["Desynchronized"], f"{path} not desynchronized"
+
+    # Acquiring one transport leaves its link alone
+    assert host0.call(acquire, from_source) is None
+    wait_state(host0, PAC_SINK_UUID, ("active",))
+    path, props = host0.call(transports_by_uuid)[PAC_SOURCE_UUID]
+    assert props["State"] == "idle", f"{path} {props['State']} not acquired"
+
+    # The link is acquired on its own, over the CIS already established
+    assert host0.call(acquire, to_sink) is None
+    wait_state(host0, PAC_SOURCE_UUID, ("active",))
+
+
+@duplex_host_config
+def test_bap_unicast_duplex_enable_one(duplex_hosts):
+    host0, host1, to_sink, from_source = duplex_hosts
+
+    host0.call(desynchronize, to_sink)
+
+    # Enable the remote Source ASE only, leaving its Sink ASE in QoS,
+    # while the CIS they share is established. bluetoothctl on the
+    # acceptor acquires a transport as soon as it is pending, as an
+    # audio server would.
+    assert host0.call(acquire, from_source) is None
+    wait_state(host1, PAC_SOURCE_UUID, ("pending", "active"))
+
+    # The Sink ASE has not been enabled, so its transport must not be
+    # reported as pending, nor acquired along with the Source one
+    path, props = host1.call(transports_by_uuid)[PAC_SINK_UUID]
+    assert props["State"] == "idle", f"{path} {props['State']} while in QoS"
+
+    # Once the initiator enables it, it is acquired on its own
+    assert host0.call(acquire, to_sink) is None
+    wait_state(host1, PAC_SINK_UUID, ("active",))
+
+    # Disabling the Sink ASE alone leaves the Source one streaming
+    assert host0.call(release, to_sink) is None
+    wait_state(host1, PAC_SINK_UUID, ("idle",))
+    time.sleep(1)
+    for host, uuid in ((host0, PAC_SINK_UUID), (host1, PAC_SOURCE_UUID)):
+        path, props = host.call(transports_by_uuid)[uuid]
+        assert props["State"] == "active", f"{path} {props['State']}"
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0

