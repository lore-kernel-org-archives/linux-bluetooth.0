Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496B51C064
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666375; cv=pass; b=hlLF/ytlcMc331RN0CkSpy0SvoG6/JlAOxYksSzHJsb7G2Q4gJjgnlFnHv+GjKg5+YT6I1LXSFS/XbYb4SJhWbFYGiCNQdaNQ2nQjoBu0Yxc/DHwCefPSt6eCPTG7vQYwv8qBcrU2PdEsKnKTOWMkjnYDSNNile4QcY0NwJ8h0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666375; c=relaxed/simple;
	bh=fCHS4IHeQAYgGh5P7zRweVXQPLec2Fo+Q61gLU6QnQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/BJ/OGrI1wJHhiC19VlfRfTL8u76jNqcQ6sctKuAx08fgNq9NdAASdP6AuzuSg5jfJQJfEuPAjus+1k7T2b/OcNhbL6yyNc0RE4yg+N37yX6DQ+Wg4n5UiKeGSiSI2joXeGNbAYnstN/xyaCe7jETIiUKV9jd4c/Wz5TwBmPiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mU4v/wzT; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU4v/wzT"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a9b9so543583fac.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 10:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789666372; cv=none;
        d=google.com; s=arc-20260327;
        b=l5vMRocZCLC/3Cvpe9l4Mm9nW5M/QXwYgeRvEqNo1o3s3SXKA881obCzMoGzomq3Fw
         dIjEvI5GyuF4uYgkDaxoLkWNuX8AESZr3qDDGyt2riCslJKYotJKexRjqyOZZCOPB+hR
         4Fl2Rq+3wx6836pP0zn+DamJD3F15js1KtZ5HTO44dug6f89+pm89/0JCpm5HN/iUx7F
         MpTT5GLuQnNRUHG+rVh1WNF+wUmh8Da2UQ/+PJ0hMiUt+qv4iU3aZ53FHf3l269xjvUR
         orNPL6Pxthzo1DY2eDG4zPdw1vo+4C5Tg2OVJw5N5q0EH72UQxCXvi5+7HXQ3cd394oz
         3IEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jEV7dciLyGPdDGWwnb/i3JjcVCocsXgbRdzjUR8A13c=;
        fh=rhg0Gle/4xL7toZLvPTXiQYaR5XkHzpydvfLlubNvfM=;
        b=SPPrClGJYccZMbxvlusWji0EJEmO0wWv17i3wZJA5+HcUROmiULtWKmUTR5mi2fK9/
         vflR4k8+4T45vuA7Dm3zdFQRL4v1NVMu+shqZbeIhp2OGP1BDXm5Ddokzq+U7BPzeURK
         sdA4q5m2QXTHRhby3Bv5Rj0Fs1SBPqOqedbHY5u8UK1wbE30BkrJUBhc4LkVDrIx/z1p
         gN3OS/6yeasetTruSutNvfyR4utaBTZNYOITWqa1bk945WDzNfqtXPE3w/hc2gp+OcpV
         N49/jzJ4PzSeCGYHL7KtZIrcmm6dnbWNhLJeXQDftQeW+UDbjNbnNqdWzUrQkEfvB7LX
         q6PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789666372; x=1790271172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jEV7dciLyGPdDGWwnb/i3JjcVCocsXgbRdzjUR8A13c=;
        b=mU4v/wzTzqYkHChchvow2jvN4SPV6jCL8u/kmIKZPuY4djy+dDLN+jbyjV3e4I//89
         GGY8VkKQwNBq2buqGOJpUZg2My4giuSHdYkS3qzlm+4SaNwQqlcFmnfHbMeLxiIljPFS
         3qyP9RkajCWT1uSsbLeCHIQo3d+uHWd85NRfmq33AsDiV8P2rJFhZsAesxeH1Z5d5SUo
         O2drQTspS9aNS5wm2BEZTDovaju/eqF3oubm3QTv9OQLBStS7GQLQRpBQ1p+tpuVeCc1
         YEA0X3ZPS+K+lNb/z9p88x7TlOXxWIbb3y7dEDvslwnLBiaVVjPOPWUWIOirkOs/CArx
         Wa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789666372; x=1790271172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEV7dciLyGPdDGWwnb/i3JjcVCocsXgbRdzjUR8A13c=;
        b=jultaMhnrEiqTla24FBJxilmiizwEgvU0UkAeIrRuDiGNMP3mBimOH70Xib7OST7Mk
         NAoslvy56MLs4AxuGqSO8aqoCi3wePuSHbzgR818jC2IplpblO7RDjdjpawDxQk4J7QX
         36EKGkMrQVRRpKGltru5uXjEqaYKVPmrzeNaOqB4I5f32cCKDRnfsqTNTbcqaz/UVj+W
         W2aRxm5tgpqqVGQGHq3FKmo76+aCE0+uWM/tKYTcDSnqHN4os0UPvOrwY+GO2JZ0CFSI
         hdsnUSIOl3By17+EEHcYJf6yU5FnE6UVihuB0ia4aWUk4Qqrirld2vfk5dxExLFeEPaf
         hneQ==
X-Gm-Message-State: AFuF++nLB+n7xfNwvqy6iIcfB6F7WyW1qrfGlPlcC7F1eeSPSfuXIsD1
	cpc5bKEff0RCArmTsZXnOCTVXDLxYDxRzmReO4c2oEtlYnxPEFxuoJk6a1PevE3F50+vid1I37/
	4i7otsSVXZEZrcRapOn7GeahyiS6L4Jg=
X-Gm-Gg: AYBFou1ovfjnhA3nX9wx4YpAUPuLdFgaowqQZWa8jR1duUd2SMfybr9hWXSxXt6XLZE
	OzuZMydVH/MKOlAbwAxs/GJRcBgsMiS98W7eEkmJaJmKxdqISZcONFUVIN4xfsHq4EoNEYxfuvw
	W1KBzzWpgBVruUl2HKkzsWw4+ROROnNGs1rspWvX27M2Nfruxj9HwW1rk6Qp5+sX/L0wJ3nrqKB
	shAgQM4msKMuVotK3stVO29zCiuTetbWItw2GKSJ7ogg3z/E12jh/OtUivl3ch4vc6R6kocgrMU
	uoaySOOLqmjyIQEj4fbuRWg4EZqLEl7VQu6VXegXOpW0oZGaLgeFWjW4VHNeX5mPBf5nt8Hhf0P
	AXUiEz7ismI1jrjcmxkpWI0//go11EDQ6UtYRXl9xeg==
X-Received: by 2002:a05:6820:8105:b0:6b7:8415:d780 with SMTP id
 006d021491bc7-6c7d27e327emr6658489eaf.43.1789666371826; Thu, 17 Sep 2026
 10:32:51 -0700 (PDT)
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
 <CABBYNZ+OqjfHErzn96k6vw_end_LLM8uECOgyeuncTxt0MJFFA@mail.gmail.com>
 <BL2ma9jjRAUeT3MnEg6XM7bojQ-aauPDy75cebC98yo5E9OVFN0uhsKtemymwe6669o08bpgH5T9_tqgx9tZ9NISnATcThQ8fJ4qujO7fZE=@proton.me>
 <N6chZc2PG1IpFdftdUK9QY8V8u64pnKS9bvFVoOvdqLwVBN0WBY7gx_UOLAA74ICFbjI0iguwbG0GrndRQP5fbaSG9IK14SZxr6Y-bPQJ-o=@proton.me>
In-Reply-To: <N6chZc2PG1IpFdftdUK9QY8V8u64pnKS9bvFVoOvdqLwVBN0WBY7gx_UOLAA74ICFbjI0iguwbG0GrndRQP5fbaSG9IK14SZxr6Y-bPQJ-o=@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Sep 2026 13:32:40 -0400
X-Gm-Features: AcwNN1VPqBnTeH8AvUsvwfp_c4Grzf4UQpWuIqe4aUBSpUFmvcQJq45uOYUd7RI
Message-ID: <CABBYNZL22xwzZ5ZgV+k66nNLprgvOM59vEdkq2dq+JX3C2ZMsA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 2/2] test-functional: Cover BAP metadata reconfiguration
To: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 17, 2026 at 1:03=E2=80=AFPM dt <derektern@proton.me> wrote:
>
> From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
>
> Reconfigure both unicast streams with empty or Media metadata at ATT
> MTU 64. The batched response and first Codec Configured notification fit
> together, while the second notification must be sent separately. This
> exposes premature QoS setup from a local metadata callback.
>
> Check that old transports disappear, both replacements retain their
> codec configuration and metadata, and both can be acquired.
>
> Use D-Bus because endpoint.config omits unicast metadata. Remove the
> fixture's redundant configuration command: SelectProperties already
> configures both streams after pairing.
> ---
>  doc/functional-bap.rst      |  38 +++++++--
>  test/functional/test_bap.py | 156 +++++++++++++++++++++++++++++++++---
>  2 files changed, 178 insertions(+), 16 deletions(-)
>
> diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
> index 3fc3439c1..704970d53 100644
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
> @@ -108,6 +105,35 @@ test_bap_unicast_transport_acquire
>         be established, as `bluetoothd` sets up the ISO listener on its o=
wn
>         when the stream is enabled.
>
> +test_bap_unicast_reconfigure_metadata[empty|media]
> +------------------------------------------------
> +
> +:Setup: As above, with both transports already created and ATT MTU 64.
> +
> +:Steps:
> +       1. Save both codec configurations and QoS, then call
> +          ``MediaEndpoint1.ClearConfiguration`` on the remote endpoint.
> +       2. Wait for completion and check that both old transports are gon=
e.
> +       3. Call ``MediaEndpoint1.SetConfiguration`` for both streams with=
out
> +          waiting between requests, using the saved configurations and
> +          empty or Media streaming-context metadata.
> +       4. Acquire both replacement transports.
> +
> +:Expected: Both configuration requests succeed. Two replacement transpor=
ts
> +       retain their codec configurations and the requested metadata. Bot=
h
> +       acquisitions succeed and the transports become active.
> +
> +:Notes: MTU 64 meets BAP's minimum. It fits the two-ASE Codec Configurat=
ion
> +       response and one Codec Configured notification together, but not =
the
> +       second ASE notification. This exercises the interval in which the
> +       initiator has received a successful response but is still waiting
> +       for a fresh Configured state before starting QoS.
> +
> +       Reconfiguration uses the D-Bus method directly because
> +       ``bluetoothctl endpoint.config`` does not pass metadata for unica=
st
> +       presets. This test covers the initiator's playback streams; it do=
es
> +       not exercise microphone streams or simultaneous playback and capt=
ure.
> +
>  BROADCAST
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
> index ce11dc38d..a941cafb9 100644
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
> @@ -274,6 +276,140 @@ def test_bap_unicast_transport_acquire(unicast_host=
s):
>      )
>
>
> +def reconfigure_transports(transports, metadata):
> +    """Clear both streams and reconfigure them together with explicit me=
tadata."""
> +    done =3D threading.Event()
> +    errors =3D []
> +    configs =3D []
> +    replies =3D []
> +    remote =3D transports[0].rsplit("/", 1)[0]
> +    assert all(path.rsplit("/", 1)[0] =3D=3D remote for path in transpor=
ts)
> +
> +    def failed(error):
> +        errors.append(error)
> +        done.set()
> +
> +    def wait():
> +        assert done.wait(DEFAULT_TIMEOUT), "reconfiguration did not comp=
lete"
> +        if errors:
> +            raise errors[0]
> +        done.clear()
> +
> +    def get_transports():
> +        objects =3D dbus.Interface(
> +            get_dbus().get_object("org.bluez", "/"),
> +            "org.freedesktop.DBus.ObjectManager",
> +        ).GetManagedObjects()
> +        return {
> +            str(path): interfaces["org.bluez.MediaTransport1"]
> +            for path, interfaces in objects.items()
> +            if path.startswith(remote + "/")
> +            and "org.bluez.MediaTransport1" in interfaces
> +        }
> +
> +    @mainloop_wrap
> +    def clear():
> +        bus =3D get_dbus()
> +        for transport in transports:
> +            props =3D dbus.Interface(
> +                bus.get_object("org.bluez", transport),
> +                "org.freedesktop.DBus.Properties",
> +            ).GetAll("org.bluez.MediaTransport1")
> +            qos =3D {k: v for k, v in props["QoS"].items() if k not in (=
"CIG", "CIS")}
> +            qos["TargetLatency"] =3D dbus.Byte(2)
> +            configs.append(
> +                dbus.Dictionary(
> +                    {
> +                        "Capabilities": props["Configuration"],
> +                        "QoS": dbus.Dictionary(qos, signature=3D"sv"),
> +                        "Metadata": dbus.ByteArray(metadata),
> +                    },
> +                    signature=3D"sv",
> +                )
> +            )
> +
> +        # The reply waits for Release to finish for both peer ASEs.
> +        dbus.Interface(
> +            bus.get_object("org.bluez", remote), "org.bluez.MediaEndpoin=
t1"
> +        ).ClearConfiguration(
> +            dbus.ObjectPath(remote), reply_handler=3Ddone.set, error_han=
dler=3Dfailed
> +        )
> +
> +    clear()
> +    wait()
> +
> +    @mainloop_wrap
> +    def configure():
> +        # Transport paths may be reused, so check their removal before
> +        # creating replacements instead of comparing old and new paths.
> +        assert not get_transports(), "old transports remain after releas=
e"
> +        endpoint =3D dbus.Interface(
> +            get_dbus().get_object("org.bluez", remote), "org.bluez.Media=
Endpoint1"
> +        )
> +
> +        def configured():
> +            replies.append(True)
> +            if len(replies) =3D=3D len(configs):
> +                done.set()
> +
> +        # Queue both requests without waiting for the first response, al=
lowing
> +        # the Codec Configuration control-point operation to include bot=
h ASEs.
> +        for config in configs:
> +            endpoint.SetConfiguration(
> +                dbus.ObjectPath("/local/endpoint/ep0"),
> +                config,
> +                reply_handler=3Dconfigured,
> +                error_handler=3Dfailed,
> +            )
> +
> +    configure()
> +    wait()
> +
> +    @mainloop_wrap
> +    def check_transports():
> +        current =3D get_transports()
> +        assert len(current) =3D=3D len(transports)
> +        assert sorted(bytes(props["Configuration"]) for props in current=
.values()) =3D=3D (
> +            sorted(bytes(config["Capabilities"]) for config in configs)
> +        )
> +        assert all(bytes(props["Metadata"]) =3D=3D metadata for props in=
 current.values())
> +        return sorted(current)
> +
> +    return check_transports()
> +
> +
> +# MTU 64 meets BAP's minimum and fits a two-ASE Codec Configuration resp=
onse
> +# with one Codec Configured notification, but not both ASE notifications=
.
> +@host_config(
> +    [Bluetoothd(conf=3DBAP_CONF + "\n[GATT]\nExchangeMTU =3D 64\n"), Pex=
pect()],
> +    [Bluetoothd(conf=3DBAP_CONF), Pexpect()],
> +)
> +@pytest.mark.parametrize("metadata", [b"", b"\x03\x02\x04\x00"], ids=3D[=
"empty", "media"])
> +def test_bap_unicast_reconfigure_metadata(unicast_hosts, metadata):
> +    host0, host1, initiator, acceptor =3D unicast_hosts
> +    transports =3D expect_transports(initiator)
> +    expect_transports(acceptor)
> +
> +    # endpoint.config currently omits Metadata for unicast presets. Exer=
cise
> +    # its D-Bus entry point directly, after bluetoothctl's initial setup=
.

This is not quite correct, you can program a custom preset with
metadata and then use it with endpoint.config:

https://github.com/bluez/bluez/blob/master/doc/bluetoothctl-endpoint.rst#pr=
esets

> +    left, right =3D host0.call(reconfigure_transports, transports, metad=
ata)
> +    expect_all(
> +        initiator,
> +        [rf"NEW.*Transport {re.escape(path)} " for path in (left, right)=
],
> +    )
> +    initiator.send(f"transport.acquire {left} {right}\n")
> +    acquired =3D r"Acquire successful: fd \d+ MTU \d+:\d+"
> +    expect_all(
> +        initiator,
> +        [
> +            acquired,
> +            acquired,
> +            f"Transport {left} State: active",
> +            f"Transport {right} State: active",
> +        ],
> +    )
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
