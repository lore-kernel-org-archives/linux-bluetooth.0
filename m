Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F249AA20
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763108; cv=none; b=RmCT2teHaY50lFg5/JtSn4SiCRYUEGt7Q0FZBRvwvNL2JOBDbP7CO4kjwoFLJ8/vZF82Fkdm9+pvW4w3J2OKf78DETQ+5l2qBVW79NKEELX4Re87l9L8uV5F6za5rAs+eBCdTmpxXBOSPvqozUQSJr3NEi+DRwjzeg5/FIMMEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763108; c=relaxed/simple;
	bh=WL7Qu4YQPuHnN7FKBTxAkeFIuCQLFqQHps38sYLYPqY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fqaa4YY245SKvkJxhS6BZmVbmobiduSXXxZEHIk7p6W9tzy1hKKPpv9ZcnNaHfOjpUvcSc9u+AtxqyZCeI0XYP16UZjyPbgxXDQLUG14IuCRQDPS2XrPTf0qd9M6n5YNcDwF2rDY7SpZp9bf1vBxCRhmCacNCIFqHD3xV9BKOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lqZv31Gl; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lqZv31Gl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789763095; x=1790022295;
	bh=c3fjCl0H0cFbPtwqfONrQcecOoTaHKK/kKxy9sHBqZg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lqZv31Gl6Qc88on68qGLynIyeqsPhS5K5qsysXCwC2u44p8GSQm+vl0csaNOH2hpp
	 nymaEwIhm91uU4oIV2bTDjm6nLD08yA8lKZhU1BTsXBysNfCxZ05sXu4/TPVSFCHVG
	 qWu/lLZJT67J+nT8fPAGn1lxLSt1fTk08hsYxE0c6eGqaKsvJw2IR8nMlmpaMY7iK6
	 qDmfxotiYQrcZ7ywryvpkAC0fuv2YMhuZD2NzwJmoOiaF7aN2xgRli19WXAaeF/0/O
	 r/upXOZb3Yn2bzv0xxns13KW2sRgmA18pNimzy3wwk0StY7bmzbVUv2XjhPIqRijIc
	 RcRB59WpnR1fw==
Date: Fri, 18 Sep 2026 20:24:51 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ 3/3] test: Cover BAP transport release and reacquire
Message-ID: <bJzWf-DKkZ2NJt0LruBxuNgW3xnTzD5zu2ll54ZFD3hN89Bul7SbBAeOcvTK_S8vnaM-F5QpmQ0wZuDs9_M_G0fAbPTS8NMxFxctkbXnr2I=@proton.me>
In-Reply-To: <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
References: <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 937de00aa1e8a015ef3de920ed35c06cc1c75c98
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

Repeat three times with immediate, 100 ms and one-second reacquisition.
Check Acquire reply types and active transport states. Close returned
FDs even when a reply is malformed.
---
 doc/functional-bap.rst      |  20 +++++++
 test/functional/test_bap.py | 102 ++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 60c38c5ed..96e398a43 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -105,6 +105,26 @@ test_bap_unicast_transport_acquire
 =09be established, as `bluetoothd` sets up the ISO listener on its own
 =09when the stream is enabled.
=20
+test_bap_unicast_transport_resume[0|0.1|1.0]
+------------------------------------------
+
+:Setup: As above, with both transports already created.
+
+:Steps:
+=091. Acquire both transports through one D-Bus connection.
+=092. Close both acquired sockets and call ``MediaTransport1.Release``
+=09   for both transports without waiting between requests.
+=093. After both replies, reacquire immediately or after 0.1 or 1 second.
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
index 7bd59777b..76b2c9f6e 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -4,7 +4,9 @@
 Tests for BAP (LE Audio) using bluetoothctl in VM instances
 """
=20
+import os
 import threading
+import time
 import warnings
=20
 import dbus
@@ -276,6 +278,106 @@ def test_bap_unicast_transport_acquire(unicast_hosts)=
:
     )
=20
=20
+def resume_transports(paths, delay):
+    """Release and reacquire all CIS in a CIG through the same D-Bus owner=
."""
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
+            # Close the client sockets before Release, then reacquire as s=
oon
+            # as both replies arrive (or after a short playback pause).
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

