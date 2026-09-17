Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DA4DDB49
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659046; cv=none; b=Ti4VvVRuTF+TSo9x7e6LUOzGHXOTKrNbV28WChN0A/jmLJNE9gXt6FwhqdKn82T49gHbOfWq42kcU5dLjVzGpJx/YxZ0TVB3YNcKD2iCL1Cf5tqpjzoFnWodAGu9B6H9ntXjmYx2BhbRu2L9YOgGZXNF3nrklJhOnOzytC48xVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659046; c=relaxed/simple;
	bh=AWTXA7L/vzT+uvByhViVTOaXNBcMeuiDo6XdEvpgReU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYGZ151dw/HTyDVPuYWeh0K5XDNBcoKVSSLLYMPFNhHlZp7IZY2pRWcJ/YBozC8+mo8eP5t9Nu8AhptBv7zjLvK0gQeXeyGLAvJysm7QqH48+mr3Sw0p4z8aIcETSX5/3u0fvwqREsYy5XaHuYzK5qjIgNtmPsfRSjPM0gzcE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CiZpRc/w; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CiZpRc/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789659031; x=1789918231;
	bh=4AFXsGgDWQfPPc9sH+1K9tU+2j/sFjsiZlGy8VKWmaw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CiZpRc/wy0073FSVByAXDyq1K+2uuJRArG9jaKned6X3oQZ82TZ/kltdcAnioxoXP
	 M6+jqyGm4CkSFlX+Nbz3iWWQZRGDqSmj/4ZKzdkMUHUPBApSUTPIVcoNb+uGmX1L49
	 QPaCHfTUszhPGv9lR4Vm5VSiGNr4mdN36W85q3Jnu5PF53PS2S9KGJ/o7I1EDJjMQw
	 Sm1fb+13aaJbtV7DXPZuT2pj+KABM2g32MQqukARmc+D7JFDifq/EwG7MbjgtCA4tx
	 UbXhiD/mS+shOJL0V0Sy1snsuK1h2Wa2yTl0hVnRdPfqx5RFnO55xoX1HB9ilLKNlX
	 N/9Lyrtv5s31g==
Date: Thu, 17 Sep 2026 15:30:28 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v3 2/2] test-functional: Cover BAP metadata reconfiguration
Message-ID: <70Tk7oozT7RMA83SmYEKlhm5sNES1V664l63179SDXwOnzZnXOurvxWa-gGmSDBQ_OS7_2m1ibyKcUr1_CBNoNFsnm-PdGGSOWGeXsgBH9k=@proton.me>
In-Reply-To: <6TMaqpYkRT0WXnrX1OlkxzNfaStK17vM4wQJWLFJWEP4ZZ_VRyfVhUEMg8KwzWWQzOsyUY8zEzSg1SBT04BDh9F9yC4Y9rft9GtBAzekwF4=@proton.me>
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me> <pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy_IaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=@proton.me> <CABBYNZ+hzc_v_t5xtwsMPDzrhFgLzUwcN6QmABy_=GqJjMHEHg@mail.gmail.com> <6TMaqpYkRT0WXnrX1OlkxzNfaStK17vM4wQJWLFJWEP4ZZ_VRyfVhUEMg8KwzWWQzOsyUY8zEzSg1SBT04BDh9F9yC4Y9rft9GtBAzekwF4=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 12d1171f151e9104fd3315bd860fee9fb369c822
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

Exercise the real daemon by clearing a configured unicast endpoint and
reconfiguring its retained ASE with empty or Media-context metadata.
Require successful configuration and check the resulting transport.

Use ATT MTU 48 to prevent the control-point response and fresh ASE
notification from being batched together. Without the shared/bap fix,
the Media case fails QoS setup; the empty-metadata control still passes.

Call SetConfiguration directly because endpoint.config does not pass
metadata for unicast presets. Remove the fixture's redundant config
command: SelectProperties already configures both ASEs after pairing.
---
 doc/functional-bap.rst      |  33 +++++++++---
 test/functional/test_bap.py | 103 ++++++++++++++++++++++++++++++++----
 2 files changed, 120 insertions(+), 16 deletions(-)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 3fc3439c1..effcc1c99 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -67,17 +67,14 @@ test_bap_unicast_transport_created
 =091. Start `bluetoothctl` with the scripts on both hosts.
 =092. Pair over LE: ``scan on`` on the initiator, ``advertise on`` on
 =09   the acceptor, then ``pair``.
-=093. Initiator: ``endpoint.config <remote endpoint>
-=09   /local/endpoint/ep0 16_2_1``, using the remote PAC Sink endpoint
-=09   exposed once the services are resolved.
+=093. Wait for automatic stream configuration through the registered
+=09   endpoint's ``SelectProperties`` method.
 =094. Initiator: ``transport.show <transport>`` for each transport.
=20
 :Expected:
 =091. ``Endpoint /local/endpoint/ep0 registered`` on both hosts.
 =092. ``Pairing successful``.
-=093. The remote endpoint appears as
-=09   ``Endpoint /org/bluez/hci0/dev_XX/pac_sinkN``, and configuring it
-=09   creates one transport per location on *both* hosts.
+=093. One transport per location is created on *both* hosts.
 =094. Each transport of the initiator reports the local PAC Source
 =09   UUID (``00002bcb-...``), ``Codec: 0x06`` for LC3, ``Device:``
 =09   pointing at the acceptor device object, and ``State: idle``.
@@ -108,6 +105,30 @@ test_bap_unicast_transport_acquire
 =09be established, as `bluetoothd` sets up the ISO listener on its own
 =09when the stream is enabled.
=20
+test_bap_unicast_reconfigure_metadata[empty|media]
+------------------------------------------------
+
+:Setup: As above, with the transports already created and ATT MTU 48.
+
+:Steps:
+=091. Call ``MediaEndpoint1.ClearConfiguration`` on the remote endpoint
+=09   and wait for completion. The peer retains the codec configuration.
+=092. Call ``MediaEndpoint1.SetConfiguration`` with the previous codec
+=09   configuration and QoS, and empty or Media streaming-context metadata=
.
+
+:Expected: Reconfiguration completes successfully after the fresh
+=09Codec Configured notification. The same ASE is reused, and the new
+=09transport retains the requested metadata.
+
+:Notes: MTU 48 fits each notification separately, but prevents the peer
+=09from batching the Codec Configuration response and the fresh ASE
+=09notification together. Nonempty metadata must not let the initiator
+=09use the cached Configured state to start QoS prematurely.
+
+=09Reconfiguration uses the D-Bus method directly because
+=09``bluetoothctl endpoint.config`` does not pass metadata for unicast
+=09presets.
+
 BROADCAST
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index ce11dc38d..917e24f27 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -5,12 +5,21 @@ Tests for BAP (LE Audio) using bluetoothctl in VM instanc=
es
 """
=20
 import re
+import threading
 import warnings
=20
+import dbus
 import pytest
=20
-from pytest_bluezenv import Bluetoothd, Pexpect, find_exe, host_config
-from pytest_bluezenv.utils import bluez_src_dir
+from pytest_bluezenv import (
+    Bluetoothd,
+    Pexpect,
+    find_exe,
+    get_dbus,
+    host_config,
+    mainloop_wrap,
+)
+from pytest_bluezenv.utils import DEFAULT_TIMEOUT, bluez_src_dir
=20
 pytestmark =3D [pytest.mark.vm]
=20
@@ -24,8 +33,6 @@ KernelExperimental =3D true
 ControllerMode =3D le
 """
=20
-PRESET =3D "16_2_1"
-
 TRANSPORT_RE =3D r"Transport (/org/bluez/\S+/fd\d+)"
=20
=20
@@ -214,12 +221,7 @@ def unicast_hosts(hosts):
=20
     pair_le(host0, initiator, host1, acceptor)
=20
-    # Remote PAC Sink endpoint is exposed once services are resolved
-    _, m =3D initiator.expect(r"Endpoint (/org/bluez/\S+/pac_sink\d+)")
-    remote =3D m[0].decode("utf-8")
-
-    initiator.send(f"endpoint.config {remote} /local/endpoint/ep0 {PRESET}=
\n")
-
+    # SelectProperties configures the streams automatically after pairing.
     yield host0, host1, initiator, acceptor
=20
=20
@@ -274,6 +276,87 @@ def test_bap_unicast_transport_acquire(unicast_hosts):
     )
=20
=20
+def reconfigure_transport(transport, metadata):
+    """Clear a configured stream and reuse its ASE with explicit metadata.=
"""
+    done =3D threading.Event()
+    errors =3D []
+    remote =3D transport.rsplit("/", 1)[0]
+
+    def failed(error):
+        errors.append(error)
+        done.set()
+
+    @mainloop_wrap
+    def start():
+        bus =3D get_dbus()
+        props =3D dbus.Interface(
+            bus.get_object("org.bluez", transport),
+            "org.freedesktop.DBus.Properties",
+        ).GetAll("org.bluez.MediaTransport1")
+        endpoint =3D dbus.Interface(
+            bus.get_object("org.bluez", remote), "org.bluez.MediaEndpoint1=
"
+        )
+        qos =3D {k: v for k, v in props["QoS"].items() if k not in ("CIG",=
 "CIS")}
+        qos["TargetLatency"] =3D dbus.Byte(2)
+        config =3D {
+            "Capabilities": props["Configuration"],
+            "QoS": dbus.Dictionary(qos, signature=3D"sv"),
+            "Metadata": dbus.ByteArray(metadata),
+        }
+
+        def configure():
+            endpoint.SetConfiguration(
+                dbus.ObjectPath("/local/endpoint/ep0"),
+                dbus.Dictionary(config, signature=3D"sv"),
+                reply_handler=3Ddone.set,
+                error_handler=3Dfailed,
+            )
+
+        # The reply waits for Release to return the peer ASE to CONFIG.
+        endpoint.ClearConfiguration(
+            dbus.ObjectPath(remote), reply_handler=3Dconfigure, error_hand=
ler=3Dfailed
+        )
+
+    start()
+    assert done.wait(DEFAULT_TIMEOUT), "reconfiguration did not complete"
+    if errors:
+        raise errors[0]
+
+    @mainloop_wrap
+    def check_transport():
+        objects =3D dbus.Interface(
+            get_dbus().get_object("org.bluez", "/"),
+            "org.freedesktop.DBus.ObjectManager",
+        ).GetManagedObjects()
+        transports =3D [
+            interfaces["org.bluez.MediaTransport1"]
+            for path, interfaces in objects.items()
+            if path.startswith(remote + "/")
+            and "org.bluez.MediaTransport1" in interfaces
+        ]
+        assert len(transports) =3D=3D 1
+        assert bytes(transports[0]["Metadata"]) =3D=3D metadata
+
+    check_transport()
+
+
+# Fit each notification, but not both the Codec Configuration response and
+# Codec Configured state in one ATT Multiple Handle Value Notification.
+@host_config(
+    [Bluetoothd(conf=3DBAP_CONF + "\n[GATT]\nExchangeMTU =3D 48\n"), Pexpe=
ct()],
+    [Bluetoothd(conf=3DBAP_CONF), Pexpect()],
+)
+@pytest.mark.parametrize("metadata", [b"", b"\x03\x02\x04\x00"], ids=3D["e=
mpty", "media"])
+def test_bap_unicast_reconfigure_metadata(unicast_hosts, metadata):
+    host0, host1, initiator, acceptor =3D unicast_hosts
+    left, _ =3D expect_transports(initiator)
+    expect_transports(acceptor)
+
+    # endpoint.config currently omits Metadata for unicast presets. Exerci=
se
+    # its D-Bus entry point directly, after bluetoothctl's initial setup.
+    host0.call(reconfigure_transport, left, metadata)
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE =3D (
--=20
2.55.0


