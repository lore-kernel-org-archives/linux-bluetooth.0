Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D539C63E
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672760; cv=none; b=BHTosX6r8VFVv/z7kgFtRndkq4Q1j38vud7KG6aBH2tSVUAdVKfQN0o3phQ4yZ+e2lfZ16mr2030bt0bOC0d1wl/NhIwEp8+7PZl1cNRGaZuNXss04dW0uWpAUbcx8V+XWpBQyQVpIiX+e+5BdwDbXTSiBh75QiwjOfMBggCLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672760; c=relaxed/simple;
	bh=WaIOKGmZ0G+mOb2LHomqssJw1rUsiLrz1Zh/ljox9Uk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ns87nvKKuy2eYyt9/4fq89zsd0D/GKzq2txje6xCmv4bZqPA7euCSRIBj+Ymvm2yjKmDfuABrvotdWTdoNSAOY7dGjTfAaAEjXWxVbkG+2J1xFPrCruJpgi1idBrxfzs0g/6rCxVcXWqui0hsEzesstDVwzFDrn5nW08e/gOCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Nfx8GidP; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Nfx8GidP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789672754; x=1789931954;
	bh=1Vj0XsEA5LCHe7q4ksn8D6N0e9DwwDiT1cFPPaXihpE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Nfx8GidPK8LKacQswSGJHHWzyk2cT6cxJoZt9TWl3WQAzwS5fFyAX8Rtj7kybIobK
	 dI0Yrfg+RIzvaoC8f6ZLsEcpRoW4y6A711i+nqgcIXMjNbdXPG0r7Lnl4zpDOEreI1
	 zjhPAhw6spB7qTcxLaJMG7/gd6VWYjsjFLUmFI6RsmZhndgoa01eNUZztJ2RNboMWX
	 7pdZyYVH6v/rE85VmuI93sBcyLvlkeBsx10nBF1p+Eq0iE/8XvyqzyyutRwjYVtNTm
	 D4miCmctuPxDmm6ytjyj6gQlkce3nGsxEJWvH/spPp9e97EV3N3UHgoubBi0j66aTJ
	 AlqxB67RVf1Hw==
Date: Thu, 17 Sep 2026 19:19:10 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ v5 3/3] test-functional: Cover BAP metadata reconfiguration
Message-ID: <-WGjNEUV9HK5Jg7D9eBbJwqO-tCeOB690GTlCyOAPJBkIb18yj4JxK_XDpSY8Zy8afTeIkADVifDaX_hVgpmE98D1_z5HOloS5NVDq8hZoQ=@proton.me>
In-Reply-To: <ys4-B1PGqhV2wgPjUFnZLGOi_QkoCs1ZyOZl679pGV8nNJLfR28E4wDuGQti0eyGwIYHgFGa4GqfTi5Vg_nvOqQBqEhRaTlA_D9MxgEblZo=@proton.me>
References:
	=?us-ascii?Q?<IGuo=5FED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI=5Fr8dHKBUfAGLjZxXmgfIE=3D@proton.me>_<pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy=5FIaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=3D@proton.me>_<CABBYNZ+hzc=5Fv=5Ft5xtwsMPDzrhFgLzUwcN6QmABy=5F=3DGqJjMHEHg@mail.gmail.com>_<6TMaqpYkRT0WXnrX1OlkxzNfaStK17vM4wQJWLFJWEP4ZZ=5FVRyfVhUEMg8KwzWWQzOsyUY8zEzSg1SBT04BDh9F9yC4Y9rft9GtBAzekwF4=3D@proton.me>_<70Tk7oozT7RMA83SmYEKlhm5sNES1V664l63179SDXwOnzZnXOurvxWa-gGmSDBQ=5FOS7=5F2m1ibyKcUr1=5FCBNoNFsnm-PdGGSOWGeXsgBH9k=3D@proton.me>_<CABBYNZ+OqjfHErzn96k6vw=5Fend=5FLLM8uECOgyeuncTxt0MJFFA@mail.gmail.com>_<BL2ma9jjRAUeT3MnEg6XM7bojQ-aauPDy75cebC98yo5E9OVFN0uhsKtemymwe6669o08bpgH5T9=5Ftqgx9tZ9NISnATcThQ8fJ4qujO7fZE=3D@proton.me>_<N6chZc2PG1IpFdftdUK9QY8V8u64pnKS9bvFVoOvdqLwVBN0WBY7gx=5FUOLAA74ICFbjI0iguwbG0GrndRQP5fbaSG9IK14SZxr6Y-bPQJ-o=3D@proton.me>_<CABBYNZL22xwzZ5ZgV+k66nNLprgvOM59vEdkq2dq+JX3C2ZMsA@mail.gmail.com>_<ys4-B1?=
 =?us-ascii?Q?PGqhV2wgPjUFnZLGOi=5FQkoCs1ZyOZl679pGV8nNJLfR28E4wDuGQti0eyGwIYHgFGa4GqfTi5Vg=5FnvOqQBqEhRaTlA=5FD9MxgEblZo=3D@proton.me>?=
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 111d40ae5555c149567083973c497bcdd6c2ddfa
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>

Reconfigure both unicast streams using custom presets with empty or
Media metadata at ATT MTU 64. The second Configured notification arrives
separately, exposing premature QoS setup from a local metadata callback.

Check that old transports disappear, both replacements retain their
codec configuration and metadata, and both can be acquired.

Remove the fixture's redundant configuration command: SelectProperties
already configures both streams after pairing.
---
 doc/functional-bap.rst      |  38 ++++++++--
 test/functional/test_bap.py | 139 +++++++++++++++++++++++++++++++++---
 2 files changed, 160 insertions(+), 17 deletions(-)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 3fc3439c1..60c38c5ed 100644
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
+=091. Create two custom presets from the existing codec configurations
+=09   and QoS, with empty or Media streaming-context metadata. Call
+=09   ``MediaEndpoint1.ClearConfiguration`` on the remote endpoint.
+=092. Wait for completion and check that both old transports are gone.
+=093. Issue ``endpoint.config`` for both presets without waiting
+=09   between requests.
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
+=09Release uses D-Bus directly: bluetoothctl has no command for
+=09``ClearConfiguration``. This test covers the initiator's playback
+=09streams; it does not exercise microphone streams or simultaneous
+=09playback and capture.
+
 BROADCAST
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index ce11dc38d..06dd2720b 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -4,13 +4,21 @@
 Tests for BAP (LE Audio) using bluetoothctl in VM instances
 """
=20
-import re
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
@@ -24,8 +32,6 @@ KernelExperimental =3D true
 ControllerMode =3D le
 """
=20
-PRESET =3D "16_2_1"
-
 TRANSPORT_RE =3D r"Transport (/org/bluez/\S+/fd\d+)"
=20
=20
@@ -214,12 +220,7 @@ def unicast_hosts(hosts):
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
@@ -274,6 +275,122 @@ def test_bap_unicast_transport_acquire(unicast_hosts)=
:
     )
=20
=20
+def clear_remote_transports(remote):
+    """Release the peer ASEs while retaining the connected GATT session.""=
"
+    done =3D threading.Event()
+    errors =3D []
+
+    def failed(error):
+        errors.append(error)
+        done.set()
+
+    @mainloop_wrap
+    def clear():
+        dbus.Interface(
+            get_dbus().get_object("org.bluez", remote), "org.bluez.MediaEn=
dpoint1"
+        ).ClearConfiguration(
+            dbus.ObjectPath(remote), reply_handler=3Ddone.set, error_handl=
er=3Dfailed
+        )
+
+    clear()
+    assert done.wait(DEFAULT_TIMEOUT), "release did not complete"
+    if errors:
+        raise errors[0]
+
+
+@mainloop_wrap
+def remote_transport_properties(remote):
+    objects =3D dbus.Interface(
+        get_dbus().get_object("org.bluez", "/"),
+        "org.freedesktop.DBus.ObjectManager",
+    ).GetManagedObjects()
+    return {
+        str(path): props["org.bluez.MediaTransport1"]
+        for path, props in objects.items()
+        if path.startswith(remote + "/") and "org.bluez.MediaTransport1" i=
n props
+    }
+
+
+def add_preset(ctl, name, props, metadata):
+    """Make a custom preset from a transport's codec configuration and QoS=
."""
+
+    def expect_reply(pattern):
+        failures =3D FAILURES + [r"(Invalid [^\r\n]*)", r"(No preset found=
)"]
+        idx, matches =3D ctl.expect(failures + [pattern], timeout=3DREPLY_=
TIMEOUT)
+        if idx < len(failures):
+            raise AssertionError(matches[0].decode("utf-8") if matches els=
e "failed")
+
+    caps =3D " ".join(f"0x{byte:02x}" for byte in props["Configuration"])
+    meta =3D " ".join(f"0x{byte:02x}" for byte in metadata) or "no"
+    # dbus.Byte formats as a character unless converted to an ordinary int=
.
+    qos =3D {str(key): int(value) for key, value in props["QoS"].items()}
+    ctl.send(f'endpoint.presets /local/endpoint/ep0 {name} "{caps}"\n')
+    for prompt, value in [
+        ("Enter Target Latency", "Balance"),
+        ("Enter SDU Interval", qos["Interval"]),
+        ("Enter Framing", qos["Framing"]),
+        ("Enter PHY", qos["PHY"]),
+        ("Enter Max SDU", qos["SDU"]),
+        ("Enter RTN", qos["Retransmissions"]),
+        ("Enter Max Transport Latency", qos["Latency"]),
+        ("Enter Presentation Delay", qos["PresentationDelay"]),
+        ("Enter Metadata", meta),
+    ]:
+        expect_reply(prompt)
+        ctl.send(f"{value}\n")
+    ctl.send("version\n")
+    expect_reply(r"Version \d")
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
+    remote =3D transports[0].rsplit("/", 1)[0]
+    original =3D host0.call(remote_transport_properties, remote)
+    assert set(original) =3D=3D set(transports)
+    presets =3D [f"metadata-{i}" for i in range(len(transports))]
+    for name, transport in zip(presets, transports):
+        add_preset(initiator, name, original[transport], metadata)
+
+    host0.call(clear_remote_transports, remote)
+    # Transport paths can be reused: check removal before recreating them.
+    assert not host0.call(remote_transport_properties, remote)
+
+    # PTY input permits both asynchronous requests without waiting for rep=
lies.
+    initiator.send(
+        "".join(
+            f"endpoint.config {remote} /local/endpoint/ep0 {name}\n" for n=
ame in presets
+        )
+    )
+    expect_all(initiator, [r"Endpoint /local/endpoint/ep0 configured"] * 2=
)
+    current =3D host0.call(remote_transport_properties, remote)
+    assert len(current) =3D=3D len(original)
+    assert sorted(bytes(p["Configuration"]) for p in current.values()) =3D=
=3D sorted(
+        bytes(p["Configuration"]) for p in original.values()
+    )
+    assert all(bytes(p["Metadata"]) =3D=3D metadata for p in current.value=
s())
+    left, right =3D sorted(current)
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


