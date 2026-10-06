Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22D36AB57
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284507; cv=none; b=kQ5twWHlQgchConBeaRzFA2UrNvM0YroydQKyBo19KYswas0sekOxhLTkqlT5RKpHnJ4SntC1CaBCpOIu82XEBGtDCRZT5sygo8ufzdtgp/uVJrMOkQFOzMgAZd9pMwM6FZ7U3zIELM7L9aoHEPyDQIa6XHwR2bUXa0xP0ca5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284507; c=relaxed/simple;
	bh=41dmh7rWVp0WpihKV7L4Z7xS8BuHA18OCfEgsh9wSHo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqoVPbw2EudrIocIx9rs0jNvDm38Vn3XPiJGW1916lwpRP8f2bKf53uvIa6Tp6SpIKRfszRCMdbA/RdHuCl5imwy446X/3Xsg0uO5k9NuZxu4T0/vzWrl7Okw7QQpBUEMF79pv3FJ6bbLIpXnX0zWI8n333/ai+H0JNEsxN0Vfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Vph8+3nb; arc=none smtp.client-ip=79.135.106.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Vph8+3nb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791284500; x=1791543700;
	bh=Td0ZfcsDJQdfahnawxbx7F4iS663JS8J509BLONCwZU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Vph8+3nbZimv2dSI13nVvJj01kY4RSVl8MUedzIgE9+SMA63bb91wkgnYwMmRDzFT
	 wuy7NwpVS2Z+xe0bnbqUHSBM0QbNX0z7A3U7j/wGv0xmPG7NrbQNVBYw/IXI1RTwoB
	 SdfxdbpMKQXsGlPVUBHWfCfyc6sdilB4dDSDfI3ltuyI1EqFUBhLBGxdfxaowBM989
	 +UeAz+tiI+zzDhQ5l1DPlkm7qVk35+AMEIxiwbkJfoK9PBZjkNAYTw7oGks5GGFJtr
	 wwEOHJVNIoziHgDT1EMWv7XghL6cvhJY7iHcKnc2XK/kB7IYQQGC+ZaPBrAr61eC5b
	 nyBEzXmyIhrsg==
Date: Tue, 06 Oct 2026 11:01:38 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: dt <derektern@proton.me>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2 3/3] test: Cover BAP transport release and reacquire
Message-ID: <XeUkQReo5ALmzkY49ud7OnOxPBOSKZxHIkBN_TYmldF7p6pmEb5gM7FWxNLI5Qv67-d1ZxZrVxnwxA0OJvzIxUDjnsVcoNKuxiBSrBV6X-M=@proton.me>
In-Reply-To: <1u4ljEAFqePjPZEbN-y_9BTWLNsqBnUqRAbQRokpIgWxUtdGlZtDC3gN8xIf4ovMpyIQ_UKBvvo2U1qgLrd7AHY8a2x1weRU9PUXtwSzUbc=@proton.me>
References: <1u4ljEAFqePjPZEbN-y_9BTWLNsqBnUqRAbQRokpIgWxUtdGlZtDC3gN8xIf4ovMpyIQ_UKBvvo2U1qgLrd7AHY8a2x1weRU9PUXtwSzUbc=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 7ca3efaabd98245d44edfaea322b8987ac25ffbf
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

Acquire both unicast transports, close their sockets and release them
through the same D-Bus owner. Require an empty Release reply so a late
ready callback cannot pass unnoticed by returning an Acquire payload.

Wait for both Acquire replies before Release, and for both Release
replies before the next Acquire. Only requests on different transport
paths are concurrent; no path has successive operations queued without
waiting for its preceding reply.

Repeat three times with immediate, 100 ms and one-second reacquisition.
Check Acquire reply types and active transport states. Close returned
FDs even when a reply is malformed.

Assisted-by: Codex:GPT-6
---
 doc/functional-bap.rst      |  23 ++++++++
 test/functional/test_bap.py | 103 ++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 74a6604ad..42fa7fda8 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -105,6 +105,29 @@ test_bap_unicast_transport_acquire
 =09be established, as `bluetoothd` sets up the ISO listener on its own
 =09when the stream is enabled.
=20
+test_bap_unicast_transport_resume[0|0.1|1.0]
+------------------------------------------
+
+:Setup: As above, with both transports already created.
+
+:Steps:
+=091. Acquire both transports through one D-Bus connection and wait for
+=09   both replies.
+=092. Close both acquired sockets and call ``MediaTransport1.Release``
+=09   for both transports. Requests on different paths may be in flight
+=09   together; wait for both Release replies before the next step.
+=093. Reacquire immediately or after 0.1 or 1 second, and wait for both
+=09   Acquire replies before continuing.
+=094. Repeat the release/reacquire cycle three times.
+
+:Expected: Each ``Release`` succeeds with an empty reply. Every ``Acquire`=
`
+=09returns an FD and MTUs, and both transports become active again.
+
+:Notes: D-Bus is used directly to check the Release reply signature and
+=09close the client sockets before releasing the transports. A late ready
+=09callback must not answer a pending Release with an Acquire payload.
+=09These tests do not force ISO disconnection to overlap the next Enable.
+
 test_bap_unicast_reconfigure_metadata[empty|media]
 ------------------------------------------------
=20
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 8d0b4489d..c4bd5fc6a 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -4,6 +4,7 @@
 Tests for BAP (LE Audio) using bluetoothctl in VM instances
 """
=20
+import os
 import threading
 import time
 import warnings
@@ -282,6 +283,108 @@ def test_bap_unicast_transport_acquire(unicast_hosts)=
:
     )
=20
=20
+def resume_transports(paths, delay):
+    """Wait for each operation on all CIS before starting the next one."""
+    bus =3D None
+    interfaces =3D []
+    fds =3D {}
+
+    @mainloop_wrap
+    def setup():
+        nonlocal bus, interfaces
+        bus =3D get_dbus(private=3DTrue)
+        interfaces =3D [
+            dbus.Interface(
+                bus.get_object("org.bluez", path, introspect=3DFalse),
+                "org.bluez.MediaTransport1",
+            )
+            for path in paths
+        ]
+
+    def operation(method):
+        done =3D threading.Event()
+        replies =3D []
+        errors =3D []
+
+        def finished(index, error=3DNone, values=3D()):
+            replies.append(index)
+            if error is not None:
+                errors.append((paths[index], str(error)))
+            elif method =3D=3D "Acquire" and tuple(type(value) for value i=
n values) =3D=3D (
+                dbus.types.UnixFd,
+                dbus.UInt16,
+                dbus.UInt16,
+            ):
+                fds[index] =3D values[0].take()
+            elif method =3D=3D "Acquire" or values:
+                # Release has an empty reply: a late ready callback must n=
ot
+                # answer it with an Acquire payload. Dispose of any stray =
FDs.
+                for value in values:
+                    if isinstance(value, dbus.types.UnixFd):
+                        os.close(value.take())
+                errors.append((paths[index], f"invalid {method} reply"))
+            if len(replies) =3D=3D len(paths):
+                done.set()
+
+        @mainloop_wrap
+        def submit():
+            for index, interface in enumerate(interfaces):
+                if method =3D=3D "Release":
+                    os.close(fds.pop(index))
+                getattr(interface, method)(
+                    reply_handler=3Dlambda *values, i=3Dindex: finished(i,=
 values=3Dvalues),
+                    error_handler=3Dlambda error, i=3Dindex: finished(i, e=
rror=3Derror),
+                    timeout=3DDEFAULT_TIMEOUT,
+                )
+
+        submit()
+        # Different transport paths may have requests in flight together, =
but
+        # wait for every reply before another operation uses any of them.
+        assert done.wait(DEFAULT_TIMEOUT + 1), f"{method} did not complete=
"
+        assert not errors, (method, errors)
+
+    @mainloop_wrap
+    def check_active():
+        objects =3D dbus.Interface(
+            bus.get_object("org.bluez", "/"),
+            "org.freedesktop.DBus.ObjectManager",
+        ).GetManagedObjects()
+        for path in paths:
+            assert objects[path]["org.bluez.MediaTransport1"]["State"] =3D=
=3D "active"
+
+    @mainloop_wrap
+    def cleanup():
+        for fd in fds.values():
+            os.close(fd)
+        fds.clear()
+        if bus is not None:
+            bus.close()
+
+    try:
+        setup()
+        operation("Acquire")
+        check_active()
+        for _ in range(3):
+            # Acquire has completed on both paths before Release starts.
+            # Release also waits for both replies before the next Acquire.
+            operation("Release")
+            if delay:
+                time.sleep(delay)
+            operation("Acquire")
+            check_active()
+    finally:
+        cleanup()
+
+
+@unicast_host_config
+@pytest.mark.parametrize("delay", [0, 0.1, 1.0])
+def test_bap_unicast_transport_resume(unicast_hosts, delay):
+    host0, host1, initiator, acceptor =3D unicast_hosts
+    transports =3D expect_transports(initiator)
+    expect_transports(acceptor)
+    host0.call(resume_transports, transports, delay)
+
+
 def clear_remote_transports(remote):
     """Release the peer ASEs while retaining the connected GATT session.""=
"
     done =3D threading.Event()
--=20
2.56.0


