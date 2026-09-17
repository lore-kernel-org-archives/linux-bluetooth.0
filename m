Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E44D1788
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664636; cv=none; b=hrgmsYhFdNyXCkjYpWdrH6yrm5BL3G1tAWa42ruAHZmc0B9m6yvhJMFKhycaKXx+ljZkWDHlG+RyLTLci9+WTP8/VG1sub3mtXOZ9vb93FadsaICbuZciWkV3hn6aGlL7zqzu0dF0VnxZ+/O0oEC1eIeBdLarR02oB3JCNLHas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664636; c=relaxed/simple;
	bh=BkUqKmq0Ka2ud2dXMAWah9qX4QN269PyB5k0Zd1L1l0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixKkrHWvyF8XXg6X6WSCZy1kb/RqH7IwyPrVDq5VPvCljngSdOk17laRY27vwC5SBZhWFiNHzPkLDmaT4wT6umSA3P2UKTD8b18VQoQntyUzMibp5JwsFF4c0RdJiOWQA8ia1kEKXS9X48M0MTT/Bg6HzX7vQ2g6yy0KeSpB/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=egzByd1n; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="egzByd1n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789664630; x=1789923830;
	bh=1NpyaxQXKVd/3odsB/WP0YqJ6vXApQKEPvQlb0nWVvA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=egzByd1nPbEoC5irBhSyP/nMqKtOb9IkBJQvSWknRt42WyjA1ZyYPYzp+l8qv/g7a
	 3a+H0OL9JcMTmj/dJGPhrjUA/IcpRwpUN4GIY7mKiQ2acoRproWVLtA1sNxdjRS+hc
	 sr2PCJhzQfT1LkP2ez1xJM4swSQKplE2af3bAgfUZDkzAUbupYzlZ6GMMGxznj5Gzr
	 i+x/E9cjQDHS9HPvcIVrBjbdVfxBfYMzKrqUUpYxj+shBdKhJW4zd5rxnEyoqa1mc0
	 IghmqfDRglO3CHmxtRpQjWqS9LW9nad+jGyvBPIawfUzuGC2BhjD4hv6949Zc8IoM6
	 96Mi/0pTpUDng==
Date: Thu, 17 Sep 2026 17:03:45 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v4 2/2] test-functional: Cover BAP metadata reconfiguration
Message-ID: <N6chZc2PG1IpFdftdUK9QY8V8u64pnKS9bvFVoOvdqLwVBN0WBY7gx_UOLAA74ICFbjI0iguwbG0GrndRQP5fbaSG9IK14SZxr6Y-bPQJ-o=@proton.me>
In-Reply-To: <BL2ma9jjRAUeT3MnEg6XM7bojQ-aauPDy75cebC98yo5E9OVFN0uhsKtemymwe6669o08bpgH5T9_tqgx9tZ9NISnATcThQ8fJ4qujO7fZE=@proton.me>
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me> <pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy_IaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=@proton.me> <CABBYNZ+hzc_v_t5xtwsMPDzrhFgLzUwcN6QmABy_=GqJjMHEHg@mail.gmail.com> <6TMaqpYkRT0WXnrX1OlkxzNfaStK17vM4wQJWLFJWEP4ZZ_VRyfVhUEMg8KwzWWQzOsyUY8zEzSg1SBT04BDh9F9yC4Y9rft9GtBAzekwF4=@proton.me> <70Tk7oozT7RMA83SmYEKlhm5sNES1V664l63179SDXwOnzZnXOurvxWa-gGmSDBQ_OS7_2m1ibyKcUr1_CBNoNFsnm-PdGGSOWGeXsgBH9k=@proton.me> <CABBYNZ+OqjfHErzn96k6vw_end_LLM8uECOgyeuncTxt0MJFFA@mail.gmail.com> <BL2ma9jjRAUeT3MnEg6XM7bojQ-aauPDy75cebC98yo5E9OVFN0uhsKtemymwe6669o08bpgH5T9_tqgx9tZ9NISnATcThQ8fJ4qujO7fZE=@proton.me>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: c24e9a3eb52b120aa8932905419234732cd4d952
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

Reconfigure both unicast streams with empty or Media metadata at ATT
MTU 64. The batched response and first Codec Configured notification fit
together, while the second notification must be sent separately. This
exposes premature QoS setup from a local metadata callback.

Check that old transports disappear, both replacements retain their
codec configuration and metadata, and both can be acquired.

Use D-Bus because endpoint.config omits unicast metadata. Remove the
fixture's redundant configuration command: SelectProperties already
configures both streams after pairing.
---
 doc/functional-bap.rst      |  38 +++++++--
 test/functional/test_bap.py | 156 +++++++++++++++++++++++++++++++++---
 2 files changed, 178 insertions(+), 16 deletions(-)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 3fc3439c1..704970d53 100644
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
@@ -108,6 +105,35 @@ test_bap_unicast_transport_acquire
 =09be established, as `bluetoothd` sets up the ISO listener on its own
 =09when the stream is enabled.
=20
+test_bap_unicast_reconfigure_metadata[empty|media]
+------------------------------------------------
+
+:Setup: As above, with both transports already created and ATT MTU 64.
+
+:Steps:
+=091. Save both codec configurations and QoS, then call
+=09   ``MediaEndpoint1.ClearConfiguration`` on the remote endpoint.
+=092. Wait for completion and check that both old transports are gone.
+=093. Call ``MediaEndpoint1.SetConfiguration`` for both streams without
+=09   waiting between requests, using the saved configurations and
+=09   empty or Media streaming-context metadata.
+=094. Acquire both replacement transports.
+
+:Expected: Both configuration requests succeed. Two replacement transports
+=09retain their codec configurations and the requested metadata. Both
+=09acquisitions succeed and the transports become active.
+
+:Notes: MTU 64 meets BAP's minimum. It fits the two-ASE Codec Configuratio=
n
+=09response and one Codec Configured notification together, but not the
+=09second ASE notification. This exercises the interval in which the
+=09initiator has received a successful response but is still waiting
+=09for a fresh Configured state before starting QoS.
+
+=09Reconfiguration uses the D-Bus method directly because
+=09``bluetoothctl endpoint.config`` does not pass metadata for unicast
+=09presets. This test covers the initiator's playback streams; it does
+=09not exercise microphone streams or simultaneous playback and capture.
+
 BROADCAST
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index ce11dc38d..a941cafb9 100644
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
@@ -274,6 +276,140 @@ def test_bap_unicast_transport_acquire(unicast_hosts)=
:
     )
=20
=20
+def reconfigure_transports(transports, metadata):
+    """Clear both streams and reconfigure them together with explicit meta=
data."""
+    done =3D threading.Event()
+    errors =3D []
+    configs =3D []
+    replies =3D []
+    remote =3D transports[0].rsplit("/", 1)[0]
+    assert all(path.rsplit("/", 1)[0] =3D=3D remote for path in transports=
)
+
+    def failed(error):
+        errors.append(error)
+        done.set()
+
+    def wait():
+        assert done.wait(DEFAULT_TIMEOUT), "reconfiguration did not comple=
te"
+        if errors:
+            raise errors[0]
+        done.clear()
+
+    def get_transports():
+        objects =3D dbus.Interface(
+            get_dbus().get_object("org.bluez", "/"),
+            "org.freedesktop.DBus.ObjectManager",
+        ).GetManagedObjects()
+        return {
+            str(path): interfaces["org.bluez.MediaTransport1"]
+            for path, interfaces in objects.items()
+            if path.startswith(remote + "/")
+            and "org.bluez.MediaTransport1" in interfaces
+        }
+
+    @mainloop_wrap
+    def clear():
+        bus =3D get_dbus()
+        for transport in transports:
+            props =3D dbus.Interface(
+                bus.get_object("org.bluez", transport),
+                "org.freedesktop.DBus.Properties",
+            ).GetAll("org.bluez.MediaTransport1")
+            qos =3D {k: v for k, v in props["QoS"].items() if k not in ("C=
IG", "CIS")}
+            qos["TargetLatency"] =3D dbus.Byte(2)
+            configs.append(
+                dbus.Dictionary(
+                    {
+                        "Capabilities": props["Configuration"],
+                        "QoS": dbus.Dictionary(qos, signature=3D"sv"),
+                        "Metadata": dbus.ByteArray(metadata),
+                    },
+                    signature=3D"sv",
+                )
+            )
+
+        # The reply waits for Release to finish for both peer ASEs.
+        dbus.Interface(
+            bus.get_object("org.bluez", remote), "org.bluez.MediaEndpoint1=
"
+        ).ClearConfiguration(
+            dbus.ObjectPath(remote), reply_handler=3Ddone.set, error_handl=
er=3Dfailed
+        )
+
+    clear()
+    wait()
+
+    @mainloop_wrap
+    def configure():
+        # Transport paths may be reused, so check their removal before
+        # creating replacements instead of comparing old and new paths.
+        assert not get_transports(), "old transports remain after release"
+        endpoint =3D dbus.Interface(
+            get_dbus().get_object("org.bluez", remote), "org.bluez.MediaEn=
dpoint1"
+        )
+
+        def configured():
+            replies.append(True)
+            if len(replies) =3D=3D len(configs):
+                done.set()
+
+        # Queue both requests without waiting for the first response, allo=
wing
+        # the Codec Configuration control-point operation to include both =
ASEs.
+        for config in configs:
+            endpoint.SetConfiguration(
+                dbus.ObjectPath("/local/endpoint/ep0"),
+                config,
+                reply_handler=3Dconfigured,
+                error_handler=3Dfailed,
+            )
+
+    configure()
+    wait()
+
+    @mainloop_wrap
+    def check_transports():
+        current =3D get_transports()
+        assert len(current) =3D=3D len(transports)
+        assert sorted(bytes(props["Configuration"]) for props in current.v=
alues()) =3D=3D (
+            sorted(bytes(config["Capabilities"]) for config in configs)
+        )
+        assert all(bytes(props["Metadata"]) =3D=3D metadata for props in c=
urrent.values())
+        return sorted(current)
+
+    return check_transports()
+
+
+# MTU 64 meets BAP's minimum and fits a two-ASE Codec Configuration respon=
se
+# with one Codec Configured notification, but not both ASE notifications.
+@host_config(
+    [Bluetoothd(conf=3DBAP_CONF + "\n[GATT]\nExchangeMTU =3D 64\n"), Pexpe=
ct()],
+    [Bluetoothd(conf=3DBAP_CONF), Pexpect()],
+)
+@pytest.mark.parametrize("metadata", [b"", b"\x03\x02\x04\x00"], ids=3D["e=
mpty", "media"])
+def test_bap_unicast_reconfigure_metadata(unicast_hosts, metadata):
+    host0, host1, initiator, acceptor =3D unicast_hosts
+    transports =3D expect_transports(initiator)
+    expect_transports(acceptor)
+
+    # endpoint.config currently omits Metadata for unicast presets. Exerci=
se
+    # its D-Bus entry point directly, after bluetoothctl's initial setup.
+    left, right =3D host0.call(reconfigure_transports, transports, metadat=
a)
+    expect_all(
+        initiator,
+        [rf"NEW.*Transport {re.escape(path)} " for path in (left, right)],
+    )
+    initiator.send(f"transport.acquire {left} {right}\n")
+    acquired =3D r"Acquire successful: fd \d+ MTU \d+:\d+"
+    expect_all(
+        initiator,
+        [
+            acquired,
+            acquired,
+            f"Transport {left} State: active",
+            f"Transport {right} State: active",
+        ],
+    )
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE =3D (
--=20
2.55.0


