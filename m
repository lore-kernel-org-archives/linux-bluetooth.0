Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D8516145
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789662090; cv=pass; b=I1f6iGh9SG4rxfoTTVn1olH/qoFLc3EjdUjEc61+n7qZBjCgpiwuZPMCNYgMxxG2Yo/sJsvBs8wSXZWcMmVMat15EZJyKkJ+jlkRjlJsAR9vyYc0c4G/N2rs352wjAnIn/kJbEL+F71wbyo+LP4IyT6R56d8vcRz4nNh1Aife4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789662090; c=relaxed/simple;
	bh=rvnpwn/r+SHtk016hWUK9vLIhYkIPpJK3J6WBWHI1cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyplxzouVO183nDng6YzeB6ggOl0ocgEzFxpqPsLQkKYUUgc4g96BP4c6Xt7pY+xem48vRdij19dQkgGmdqY+zK9SzquVXkHR8mj2sMe5e6vS9NGmtNVucw44qyzCuC5MgBdHzfNRksw508bNtyG9lQTV9GsSWjKDNi3JWEg424=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNT6eW2w; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNT6eW2w"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4aae3147so962961d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 09:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789662087; cv=none;
        d=google.com; s=arc-20260327;
        b=qyvD0InAveDzd34RTSiEBundX3UBYYhpn0kcoS7k9ZiOEHICaFlCmw58QJ7NecCZ3R
         X1PWGzxsCjYVmjInD17kJTpgTfJVAxt7Dg9dalTyq81gylaxeoIq6GibiSlb0Cmwz/4N
         3Ueg31iJ+AmCXQEupOPSxyBvQTy/BZ6cnPwvJczibGkstnpsl0gDLYqFAUcLOT+uX5pp
         LlrwCoZIoElr/32+qdAxVfEZv3+tWhGkbJSLazzhheGhU7pj3P+Gusvk7vXpToLvnOgC
         l035YorQjheWlYIFh/6GjikOl5C6oZd+xrlZeVpWa8lXx/qyFFX8zofgHZ1EDpM+Q4p7
         xtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8EABfJJTqPMC7IkidW4ikQAFEstQfWADcyPSf4I7HlI=;
        fh=rhg0Gle/4xL7toZLvPTXiQYaR5XkHzpydvfLlubNvfM=;
        b=jAtT/9x1Bc16oDfwjani2TUP3JuEMrxe5exOypGcLoqO5CW9gotNzWxC9xW9494+h/
         zTxeHtVoQKPdBZ5rVLOrxuEXurkKSekQ8BzSOjJ/llgkHVP7ikmcqutLFt/pgw4cpv/K
         GH7DpAYd2JfqHpSuwmxUpPhwPwb6mhZkCPLqFv7IhRTTzn16nG+X3TGVhtrS6vzUeIOX
         LwDpET2Q6UDvhzTenlfXItagd4pjp024uP1Y1ozRLJ0GscwMWyZGvEMJ+wqjsIPWLhoo
         Qc9HL8qtk3NP/M+Gziwa4hSlzI5VRyuQAu35wz0dvZRrWGdjaiQhW3iPyQfyt+knqNJk
         35rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789662087; x=1790266887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8EABfJJTqPMC7IkidW4ikQAFEstQfWADcyPSf4I7HlI=;
        b=cNT6eW2wgUmRNFxdFdcxekmIUbbxB16apV6fWSUBP+fP1kviE12v75GE6aCdomq1si
         2Aa9F8UDnePnoDddjr4fFuwNiw2cftGkHxbGWndmf9PIEKExpJQCvHMOylIXpU3/Cfv4
         E4o8MjpU/+8yJY89sBEJBl5pSTgfMwSkBZTphUjPcqeAGZS13IMLUz0enHp2Gg7haz73
         /sSxGIymn/5ILAWt/sBTSl/Na7s/SDaO5DlMHdZJwFoJhtHpYTMpiL4D79LdjDFIWU/7
         rT4NmXMOtPbJGfPh/8HVb+zT9m1/JpvEq3L+AbojJIHEpGCYqMvYRwB3GqdmO0f1o7vq
         NtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789662087; x=1790266887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8EABfJJTqPMC7IkidW4ikQAFEstQfWADcyPSf4I7HlI=;
        b=eCpHPdznKVzdsgUKz5IBJz8Ur+/BEjrG30GqjyJEbQuegWtm3Sk4ptVSote7W0gzeF
         PYKt+OyQQcE54Tyi6T3OH1BlpW3MEazl0p0qf0+uQTPuz+BbK6aLcoSthp5qoEHA2ILb
         WvTDGhosccPPretKohgI62etxk8opDpCIseWPNWwsjzSSIH2BuEZ+d/BxMuyuMpAbB72
         vD8Z6XuTRH/q0EnOzcLZSdf2yZBahOZn5EQDwK0d3nUV8cw+U7QjfL6wCV7jMUKLJSr7
         yArg47vYO34e23OTNNhy2jA9TGkkQaZAckmQ/+mHMmRsu/9z/wgC6bU6fCDwvZmoPhQS
         Bbeg==
X-Gm-Message-State: AFuF++n5tDtfH2piqqC5IXzaGTLEC9cxBPHxP20XcGLpLEpPG7qHTkyq
	XwKa2ANHHXZq9aWujokjTNcH9XYyg4joj9ZXLDmiir5QyKMqYrrEcT9+gazdiL8CbIEEtZW1g2a
	c+Ja7raKpoKRe4Ey4ouMTzK8Z0771lNA=
X-Gm-Gg: AYBFou3YRPvkmyiI1mvyK6d0yym8Hp0Yts1+3zoZWtUFDzwKiqXQ+Xe6PhneMZITk0/
	SFhRfyA1csWTD5YO3qp3V6+uz2f8aTmEn8TDM4Pn0wFQdeAJFq6ok66Ni8xLjabDAFor08vyk2w
	GoW/QNgM186qt23A3/SnZftwBTFbOx12jeSnn5zC4kJSx+B8WWAidqHRjMho77TI0Um1maQ4WUb
	ywbkX4QlmZ6PMWrKSspF+VhfEeHk9o6rtAQofaDrMcaM6wBv+UtSdqtf+eBV3ahKRt1FUvpDuMf
	CL22c0QFAM4UpJimAezqo6/yp1iqpaM7/SOsJZf9QrmlNXB2h/vwpDbt+716Q87yQVnP35B2V/x
	GOcaM4HSrcqyzxmb/8mASf3Mc1EB38AbPcmMdXvc=
X-Received: by 2002:a05:690e:4594:10b0:671:70d1:d6dc with SMTP id
 956f58d0204a3-67170d1ded6mr666996d50.78.1789662087049; Thu, 17 Sep 2026
 09:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IGuo_ED6hoZcdNfKi5TCkYNNfYCJKn1CUSYS4a4ZNZ9WjaZCMI3rmBzLoslV22TvEjShB4iyBBAec3nrM4mMGI_r8dHKBUfAGLjZxXmgfIE=@proton.me>
 <pEIogdpm1KrQokz6n7Vp2rMm4FqyjlQ2X2YtxXFBhhWy_IaqXXNp8K7EwDeohmT6yelHFNOy7IuYYi7ooLtT2zeODVf8LPoBiOTrs7ua3O4=@proton.me>
 <CABBYNZ+hzc_v_t5xtwsMPDzrhFgLzUwcN6QmABy_=GqJjMHEHg@mail.gmail.com>
 <6TMaqpYkRT0WXnrX1OlkxzNfaStK17vM4wQJWLFJWEP4ZZ_VRyfVhUEMg8KwzWWQzOsyUY8zEzSg1SBT04BDh9F9yC4Y9rft9GtBAzekwF4=@proton.me>
 <70Tk7oozT7RMA83SmYEKlhm5sNES1V664l63179SDXwOnzZnXOurvxWa-gGmSDBQ_OS7_2m1ibyKcUr1_CBNoNFsnm-PdGGSOWGeXsgBH9k=@proton.me>
In-Reply-To: <70Tk7oozT7RMA83SmYEKlhm5sNES1V664l63179SDXwOnzZnXOurvxWa-gGmSDBQ_OS7_2m1ibyKcUr1_CBNoNFsnm-PdGGSOWGeXsgBH9k=@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Sep 2026 12:21:15 -0400
X-Gm-Features: AcwNN1WYvXg7K02vEh00R6qUVJqKDSl2LxMG1jPrWeh-CiBWBkQx5FmtkeCHjXA
Message-ID: <CABBYNZ+OqjfHErzn96k6vw_end_LLM8uECOgyeuncTxt0MJFFA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 2/2] test-functional: Cover BAP metadata reconfiguration
To: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 17, 2026 at 11:30=E2=80=AFAM dt <derektern@proton.me> wrote:
>
> From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
>
> Exercise the real daemon by clearing a configured unicast endpoint and
> reconfiguring its retained ASE with empty or Media-context metadata.
> Require successful configuration and check the resulting transport.
>
> Use ATT MTU 48 to prevent the control-point response and fresh ASE
> notification from being batched together. Without the shared/bap fix,
> the Media case fails QoS setup; the empty-metadata control still passes.
>
> Call SetConfiguration directly because endpoint.config does not pass
> metadata for unicast presets. Remove the fixture's redundant config
> command: SelectProperties already configures both ASEs after pairing.
> ---
>  doc/functional-bap.rst      |  33 +++++++++---
>  test/functional/test_bap.py | 103 ++++++++++++++++++++++++++++++++----
>  2 files changed, 120 insertions(+), 16 deletions(-)
>
> diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
> index 3fc3439c1..effcc1c99 100644
> --- a/doc/functional-bap.rst
> +++ b/doc/functional-bap.rst
> @@ -67,17 +67,14 @@ test_bap_unicast_transport_created
>         1. Start `bluetoothctl` with the scripts on both hosts.
>         2. Pair over LE: ``scan on`` on the initiator, ``advertise on`` o=
n
>            the acceptor, then ``pair``.
> -       3. Initiator: ``endpoint.config <remote endpoint>
> -          /local/endpoint/ep0 16_2_1``, using the remote PAC Sink endpoi=
nt
> -          exposed once the services are resolved.
> +       3. Wait for automatic stream configuration through the registered
> +          endpoint's ``SelectProperties`` method.
>         4. Initiator: ``transport.show <transport>`` for each transport.
>
>  :Expected:
>         1. ``Endpoint /local/endpoint/ep0 registered`` on both hosts.
>         2. ``Pairing successful``.
> -       3. The remote endpoint appears as
> -          ``Endpoint /org/bluez/hci0/dev_XX/pac_sinkN``, and configuring=
 it
> -          creates one transport per location on *both* hosts.
> +       3. One transport per location is created on *both* hosts.
>         4. Each transport of the initiator reports the local PAC Source
>            UUID (``00002bcb-...``), ``Codec: 0x06`` for LC3, ``Device:``
>            pointing at the acceptor device object, and ``State: idle``.
> @@ -108,6 +105,30 @@ test_bap_unicast_transport_acquire
>         be established, as `bluetoothd` sets up the ISO listener on its o=
wn
>         when the stream is enabled.
>
> +test_bap_unicast_reconfigure_metadata[empty|media]
> +------------------------------------------------
> +
> +:Setup: As above, with the transports already created and ATT MTU 48.
> +
> +:Steps:
> +       1. Call ``MediaEndpoint1.ClearConfiguration`` on the remote endpo=
int
> +          and wait for completion. The peer retains the codec configurat=
ion.
> +       2. Call ``MediaEndpoint1.SetConfiguration`` with the previous cod=
ec
> +          configuration and QoS, and empty or Media streaming-context me=
tadata.
> +
> +:Expected: Reconfiguration completes successfully after the fresh
> +       Codec Configured notification. The same ASE is reused, and the ne=
w
> +       transport retains the requested metadata.
> +
> +:Notes: MTU 48 fits each notification separately, but prevents the peer
> +       from batching the Codec Configuration response and the fresh ASE
> +       notification together. Nonempty metadata must not let the initiat=
or
> +       use the cached Configured state to start QoS prematurely.
> +
> +       Reconfiguration uses the D-Bus method directly because
> +       ``bluetoothctl endpoint.config`` does not pass metadata for unica=
st
> +       presets.
> +
>  BROADCAST
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
> index ce11dc38d..917e24f27 100644
> --- a/test/functional/test_bap.py
> +++ b/test/functional/test_bap.py
> @@ -5,12 +5,21 @@ Tests for BAP (LE Audio) using bluetoothctl in VM insta=
nces
>  """
>
>  import re
> +import threading
>  import warnings
>
> +import dbus
>  import pytest
>
> -from pytest_bluezenv import Bluetoothd, Pexpect, find_exe, host_config
> -from pytest_bluezenv.utils import bluez_src_dir
> +from pytest_bluezenv import (
> +    Bluetoothd,
> +    Pexpect,
> +    find_exe,
> +    get_dbus,
> +    host_config,
> +    mainloop_wrap,
> +)
> +from pytest_bluezenv.utils import DEFAULT_TIMEOUT, bluez_src_dir
>
>  pytestmark =3D [pytest.mark.vm]
>
> @@ -24,8 +33,6 @@ KernelExperimental =3D true
>  ControllerMode =3D le
>  """
>
> -PRESET =3D "16_2_1"
> -
>  TRANSPORT_RE =3D r"Transport (/org/bluez/\S+/fd\d+)"
>
>
> @@ -214,12 +221,7 @@ def unicast_hosts(hosts):
>
>      pair_le(host0, initiator, host1, acceptor)
>
> -    # Remote PAC Sink endpoint is exposed once services are resolved
> -    _, m =3D initiator.expect(r"Endpoint (/org/bluez/\S+/pac_sink\d+)")
> -    remote =3D m[0].decode("utf-8")
> -
> -    initiator.send(f"endpoint.config {remote} /local/endpoint/ep0 {PRESE=
T}\n")
> -
> +    # SelectProperties configures the streams automatically after pairin=
g.
>      yield host0, host1, initiator, acceptor
>
>
> @@ -274,6 +276,87 @@ def test_bap_unicast_transport_acquire(unicast_hosts=
):
>      )
>
>
> +def reconfigure_transport(transport, metadata):
> +    """Clear a configured stream and reuse its ASE with explicit metadat=
a."""
> +    done =3D threading.Event()
> +    errors =3D []
> +    remote =3D transport.rsplit("/", 1)[0]
> +
> +    def failed(error):
> +        errors.append(error)
> +        done.set()
> +
> +    @mainloop_wrap
> +    def start():
> +        bus =3D get_dbus()
> +        props =3D dbus.Interface(
> +            bus.get_object("org.bluez", transport),
> +            "org.freedesktop.DBus.Properties",
> +        ).GetAll("org.bluez.MediaTransport1")
> +        endpoint =3D dbus.Interface(
> +            bus.get_object("org.bluez", remote), "org.bluez.MediaEndpoin=
t1"
> +        )
> +        qos =3D {k: v for k, v in props["QoS"].items() if k not in ("CIG=
", "CIS")}
> +        qos["TargetLatency"] =3D dbus.Byte(2)
> +        config =3D {
> +            "Capabilities": props["Configuration"],
> +            "QoS": dbus.Dictionary(qos, signature=3D"sv"),
> +            "Metadata": dbus.ByteArray(metadata),
> +        }
> +
> +        def configure():
> +            endpoint.SetConfiguration(
> +                dbus.ObjectPath("/local/endpoint/ep0"),
> +                dbus.Dictionary(config, signature=3D"sv"),
> +                reply_handler=3Ddone.set,
> +                error_handler=3Dfailed,
> +            )
> +
> +        # The reply waits for Release to return the peer ASE to CONFIG.
> +        endpoint.ClearConfiguration(
> +            dbus.ObjectPath(remote), reply_handler=3Dconfigure, error_ha=
ndler=3Dfailed
> +        )
> +
> +    start()
> +    assert done.wait(DEFAULT_TIMEOUT), "reconfiguration did not complete=
"
> +    if errors:
> +        raise errors[0]
> +
> +    @mainloop_wrap
> +    def check_transport():
> +        objects =3D dbus.Interface(
> +            get_dbus().get_object("org.bluez", "/"),
> +            "org.freedesktop.DBus.ObjectManager",
> +        ).GetManagedObjects()
> +        transports =3D [
> +            interfaces["org.bluez.MediaTransport1"]
> +            for path, interfaces in objects.items()
> +            if path.startswith(remote + "/")
> +            and "org.bluez.MediaTransport1" in interfaces
> +        ]
> +        assert len(transports) =3D=3D 1
> +        assert bytes(transports[0]["Metadata"]) =3D=3D metadata
> +
> +    check_transport()
> +
> +
> +# Fit each notification, but not both the Codec Configuration response a=
nd
> +# Codec Configured state in one ATT Multiple Handle Value Notification.
> +@host_config(
> +    [Bluetoothd(conf=3DBAP_CONF + "\n[GATT]\nExchangeMTU =3D 48\n"), Pex=
pect()],

Ok, so this only manifests if the CP Write response and the ASE
Notification are not sent in the same package? So this is
implementation-specific. Also, LE Audio requires a minimum MTU of 64
octets:

3.5.1. ATT and EATT transport requirements

The Unicast Server shall support a minimum ATT_MTU of 64 octets for
one Unenhanced ATT bearer, or for at least one Enhanced ATT bearer if
the Unicast Server supports Enhanced ATT bearers.
[]https://www.bluetooth.com/specifications/specs/bap-1-0-1/

> +    [Bluetoothd(conf=3DBAP_CONF), Pexpect()],
> +)
> +@pytest.mark.parametrize("metadata", [b"", b"\x03\x02\x04\x00"], ids=3D[=
"empty", "media"])
> +def test_bap_unicast_reconfigure_metadata(unicast_hosts, metadata):
> +    host0, host1, initiator, acceptor =3D unicast_hosts
> +    left, _ =3D expect_transports(initiator)
> +    expect_transports(acceptor)
> +
> +    # endpoint.config currently omits Metadata for unicast presets. Exer=
cise
> +    # its D-Bus entry point directly, after bluetoothctl's initial setup=
.
> +    host0.call(reconfigure_transport, left, metadata)
> +
> +
>  # Broadcast code used by the broadcast scripts, see BCAST_CODE in
>  # client/player.c
>  BCAST_CODE =3D (
> --
> 2.55.0
>
>


--=20
Luiz Augusto von Dentz
