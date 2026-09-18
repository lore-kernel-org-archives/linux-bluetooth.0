Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA052CCFE
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 21:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767886; cv=pass; b=oY38msDQLpbs7lqsjSWnk3z3HIQmtlXN3NVjv7Mpd8psfpk2ii87cxjoHWh4ssal14ubCdl5jEosNg42+xXAB3CoStq5RMjBFJJAvkGDbOUuqckxlYUohobdTB/gjmbS1nCTPaDBAxoeN7o9minBzwYW6zQgJPy/JVY8op90sIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767886; c=relaxed/simple;
	bh=zS6Zmv0ZfROEWi3veQMipP8pqIp75NYaPnea7MOM28Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkhUmDfnBmK/OZd/dz8YonT+/TLat4Y3aYS3/iHGy2ZdmMUIdAYqiBlL9sk8cmPG4BozW3ke/7mWsd2xTJ5L57osKbdUMS2V7LTRmSkIMDxsxF1WEVkp0U1LFs/4qhpIUmuzO+tzaK6wR1KrHSpG5CR5or/+x6JhNBZekz7tO1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwA67NsJ; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwA67NsJ"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e56a1fe3fso1225466d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789767884; cv=none;
        d=google.com; s=arc-20260327;
        b=XuMxi3sL6irf8umygPKeC2aBBjFeGIzoEN1xUwpxCd0I/idLJ0SzdwQdUdLo9Xg9xi
         BS5jX5cGmaers7nZQpAoKyYPAFARjt3hAmGb7IV0bNK9uVSa+QEYavW6zFKMllNPh4pi
         wFhNHfD1wGMe4p/S/tfBaznfSbLp7YXndlNv/EODd/08mQxVF8XMnW4EPQA6eKQTDXW/
         zntgsiGn8EsmdUCHrALh0R8fEa4pCOm0Xl+mKT2EvN2phLKrfhrV60kWqFd7as1AtHaY
         W4lAI9jioqdFJo6bDHXbFdSZfhEUBgbA/EnMXO3klwGhf9rTMhSIY55hy0KPHVJhFBuX
         VI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08tN3YpqUvcfjRk5DoF60k9QmITiPhJmX4y3qhseqZU=;
        fh=rhg0Gle/4xL7toZLvPTXiQYaR5XkHzpydvfLlubNvfM=;
        b=nsjIUV/APx41rSGq9uGYXj+Vl8HNgeUs+nsGfHqJA7KATFp9hIB3SzVKd81Sbp1Q1U
         vxY+B8iJo1OD8PD5xjuKSYnND0jiA0qx9P9n5yqxetQZJxqlvJJ0icbg0t42d1FZ52nC
         ZoPHxqAW4L+fs1wYs+Haf4OxmQ0bjPDnK/8Xy4pbMbDKp8Je92vtDOh0jHAPMKyFPYAz
         vbij4iYlkcLNVFlLL5asd8NGn48OcWyBIDPJ2Uof5aB201sdgnz2eoBIG1/9xXt5QiD7
         HkR3nMDS2pssEUig2ylrxQeMm5up/uEuQMv5u7V4PAsN/GoJeBupQQm5x0JxZ5wkdc7L
         pDdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789767884; x=1790372684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08tN3YpqUvcfjRk5DoF60k9QmITiPhJmX4y3qhseqZU=;
        b=lwA67NsJ5UC4y0ucyU2eEDvTj8rW16jQTe0pmuAhRxxcnQyACXwmZYkqwWmYWBU8Qk
         PQj2M/RtHShEED5uwB3gu5roacqQojCJ16GXayyV78fNrnm1jpjuCR+c2899xVPc52/5
         t8ABVJzGd4fShTmTsZGwN3UDQeQ7YUYcHv0HeVTf956K9iCrQebmZhlGZHQN4deN1ZY2
         ioMZNnuHCSnga0NOVLxwmx62vGXK7DCE/speqv4NjW7ffDHs5wUq8Kha4HKUaa/ryhIW
         +CYH8Xsp21hwvHWU7LSYx/VvTqQbNHIZCieMgCRPG+JkAEkHGUUlPstCZbdG5+pWfvbV
         Wv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789767884; x=1790372684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08tN3YpqUvcfjRk5DoF60k9QmITiPhJmX4y3qhseqZU=;
        b=OhUix4PvyQp2C9hPwo6jTQ735vSSw6s1EArzia6cHlGvKLRj9/3idmdNvD9MzUktPE
         XONthxb20mUNvOCMroU3kHVvEMhxNytdo+ztMhtYw1oDKKObEIGc1jkcCfHwvz/PSQmZ
         +9uoep0HjRJb15ACUbTH7y0MHQtWlVwoHx1wyzUXEW3NRWFJMsm6rIEcJmrLlO3HrD50
         6uzA6t2ieAmFL0SXFg9Q3q2/r5ur9mGp845BrxIIgyfNW6mt2VNqZyWQSJy07MeN19yK
         g/U/FfDXtWR92+H/83uHyM7UiZ3vKpy4Cg7avzUJHflRVRLQQYnkdtsrsJcqgoHWWvNf
         k06g==
X-Gm-Message-State: AFuF++nqfVVHiZMLmUozyhAhqPzUnFeQjuIywx2ReY/QeZE7JcaR442M
	Jbbjkw97sitvyfZe61Qu5++1BHH45ntTcvhLreOk6UIiK2wxEEoYBsLK5h68gA8Py3dSHYDHqe0
	9YB23H2l0OUZf0Ay+FU8A+LFdnoohmzc=
X-Gm-Gg: AYBFou0Q/at/Ff/cZuE9MepmJ+AfUJjnK7a2XYCo3GA9DbcKBZ5kbguXMFAanNvEOeO
	iIWk4zZBvvZF84rzpMLO9HatTqoiby1tqWHjct8o8WR0jXVT45j/JIvZ6cEuY9DQ+G54Y0ktTwb
	PMa8QdLczXwT7S9R9ceVlMwnC2FpdMy4PGIzioY/g5owTCKY56wOzFbVJkIYUsVFbqRZMWUzcC+
	hAeubAyrO7YNI412x4FJE4tidWK2CvjcjnM0hhiQLgSmWCo5W6Uk1lEkprJK4rmpgV0goH+Qden
	4gkn+z8l8sAWjmMleIkHwC9XFaFTQQUKEsC8gGHE3jQ2fuvqieumcJ18qorF1qFbhN8gNn3lxKx
	6+MYFu9GnU34R12AEkk6WE4r/Rp7HW509+QreAnMnCg==
X-Received: by 2002:a05:690e:4894:10b0:671:3c99:c857 with SMTP id
 956f58d0204a3-6717fcb43admr893046d50.24.1789767883793; Fri, 18 Sep 2026
 14:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5yh1Rc6x2sD0mB4Zq0o-3_jmYYKB43NbYyd-ZXGrHGZRN61HyoWYmLVVTTHE2-SyPhNj8g2ktGAB0Zy_Jnq-Htnc1JspqPSHvIsZDC3KFlM=@proton.me>
 <bJzWf-DKkZ2NJt0LruBxuNgW3xnTzD5zu2ll54ZFD3hN89Bul7SbBAeOcvTK_S8vnaM-F5QpmQ0wZuDs9_M_G0fAbPTS8NMxFxctkbXnr2I=@proton.me>
In-Reply-To: <bJzWf-DKkZ2NJt0LruBxuNgW3xnTzD5zu2ll54ZFD3hN89Bul7SbBAeOcvTK_S8vnaM-F5QpmQ0wZuDs9_M_G0fAbPTS8NMxFxctkbXnr2I=@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 18 Sep 2026 17:44:32 -0400
X-Gm-Features: AcwNN1VPWhIk0zak2tcT-PnclcsmgvVnPJuKz1NeSu6sqxUYAy2FE76xQgpWCgo
Message-ID: <CABBYNZ+MCKEz_v2Uz+hDU0sn0COYj=guj9P8Fxu-qzp93XEufQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] test: Cover BAP transport release and reacquire
To: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 18, 2026 at 4:24=E2=80=AFPM dt <derektern@proton.me> wrote:
>
> From: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
>
> Acquire both unicast transports, close their sockets and release them
> through the same D-Bus owner. Require an empty Release reply so a late
> ready callback cannot pass unnoticed by returning an Acquire payload.
>
> Repeat three times with immediate, 100 ms and one-second reacquisition.
> Check Acquire reply types and active transport states. Close returned
> FDs even when a reply is malformed.

I don't think this is valid behavior, though; successive
Release/Acquire calls should wait for the reply not just enqueue.
Applications have the state to track if the transport is ready to be
called again.

> ---
>  doc/functional-bap.rst      |  20 +++++++
>  test/functional/test_bap.py | 102 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
>
> diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
> index 60c38c5ed..96e398a43 100644
> --- a/doc/functional-bap.rst
> +++ b/doc/functional-bap.rst
> @@ -105,6 +105,26 @@ test_bap_unicast_transport_acquire
>         be established, as `bluetoothd` sets up the ISO listener on its o=
wn
>         when the stream is enabled.
>
> +test_bap_unicast_transport_resume[0|0.1|1.0]
> +------------------------------------------
> +
> +:Setup: As above, with both transports already created.
> +
> +:Steps:
> +       1. Acquire both transports through one D-Bus connection.
> +       2. Close both acquired sockets and call ``MediaTransport1.Release=
``
> +          for both transports without waiting between requests.
> +       3. After both replies, reacquire immediately or after 0.1 or 1 se=
cond.
> +       4. Repeat the release/reacquire cycle three times.
> +
> +:Expected: Each ``Release`` succeeds with an empty reply. Every ``Acquir=
e``
> +       returns an FD and MTUs, and both transports become active again.
> +
> +:Notes: D-Bus is used directly to check the Release reply signature and
> +       close the client sockets before releasing the transports. A late =
ready
> +       callback must not answer a pending Release with an Acquire payloa=
d.
> +       These tests do not force ISO disconnection to overlap the next En=
able.
> +
>  test_bap_unicast_reconfigure_metadata[empty|media]
>  ------------------------------------------------
>
> diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
> index 7bd59777b..76b2c9f6e 100644
> --- a/test/functional/test_bap.py
> +++ b/test/functional/test_bap.py
> @@ -4,7 +4,9 @@
>  Tests for BAP (LE Audio) using bluetoothctl in VM instances
>  """
>
> +import os
>  import threading
> +import time
>  import warnings
>
>  import dbus
> @@ -276,6 +278,106 @@ def test_bap_unicast_transport_acquire(unicast_host=
s):
>      )
>
>
> +def resume_transports(paths, delay):
> +    """Release and reacquire all CIS in a CIG through the same D-Bus own=
er."""
> +    bus =3D None
> +    interfaces =3D []
> +    fds =3D {}
> +
> +    @mainloop_wrap
> +    def setup():
> +        nonlocal bus, interfaces
> +        bus =3D get_dbus(private=3DTrue)
> +        interfaces =3D [
> +            dbus.Interface(
> +                bus.get_object("org.bluez", path, introspect=3DFalse),
> +                "org.bluez.MediaTransport1",
> +            )
> +            for path in paths
> +        ]
> +
> +    def operation(method):
> +        done =3D threading.Event()
> +        replies =3D []
> +        errors =3D []
> +
> +        def finished(index, error=3DNone, values=3D()):
> +            replies.append(index)
> +            if error is not None:
> +                errors.append((paths[index], str(error)))
> +            elif method =3D=3D "Acquire" and tuple(type(value) for value=
 in values) =3D=3D (
> +                dbus.types.UnixFd,
> +                dbus.UInt16,
> +                dbus.UInt16,
> +            ):
> +                fds[index] =3D values[0].take()
> +            elif method =3D=3D "Acquire" or values:
> +                # Release has an empty reply: a late ready callback must=
 not
> +                # answer it with an Acquire payload. Dispose of any stra=
y FDs.
> +                for value in values:
> +                    if isinstance(value, dbus.types.UnixFd):
> +                        os.close(value.take())
> +                errors.append((paths[index], f"invalid {method} reply"))
> +            if len(replies) =3D=3D len(paths):
> +                done.set()
> +
> +        @mainloop_wrap
> +        def submit():
> +            for index, interface in enumerate(interfaces):
> +                if method =3D=3D "Release":
> +                    os.close(fds.pop(index))
> +                getattr(interface, method)(
> +                    reply_handler=3Dlambda *values, i=3Dindex: finished(=
i, values=3Dvalues),
> +                    error_handler=3Dlambda error, i=3Dindex: finished(i,=
 error=3Derror),
> +                    timeout=3DDEFAULT_TIMEOUT,
> +                )
> +
> +        submit()
> +        assert done.wait(DEFAULT_TIMEOUT + 1), f"{method} did not comple=
te"
> +        assert not errors, (method, errors)
> +
> +    @mainloop_wrap
> +    def check_active():
> +        objects =3D dbus.Interface(
> +            bus.get_object("org.bluez", "/"),
> +            "org.freedesktop.DBus.ObjectManager",
> +        ).GetManagedObjects()
> +        for path in paths:
> +            assert objects[path]["org.bluez.MediaTransport1"]["State"] =
=3D=3D "active"
> +
> +    @mainloop_wrap
> +    def cleanup():
> +        for fd in fds.values():
> +            os.close(fd)
> +        fds.clear()
> +        if bus is not None:
> +            bus.close()
> +
> +    try:
> +        setup()
> +        operation("Acquire")
> +        check_active()
> +        for _ in range(3):
> +            # Close the client sockets before Release, then reacquire as=
 soon
> +            # as both replies arrive (or after a short playback pause).
> +            operation("Release")
> +            if delay:
> +                time.sleep(delay)
> +            operation("Acquire")
> +            check_active()
> +    finally:
> +        cleanup()
> +
> +
> +@unicast_host_config
> +@pytest.mark.parametrize("delay", [0, 0.1, 1.0])
> +def test_bap_unicast_transport_resume(unicast_hosts, delay):
> +    host0, host1, initiator, acceptor =3D unicast_hosts
> +    transports =3D expect_transports(initiator)
> +    expect_transports(acceptor)
> +    host0.call(resume_transports, transports, delay)
> +
> +
>  def clear_remote_transports(remote):
>      """Release the peer ASEs while retaining the connected GATT session.=
"""
>      done =3D threading.Event()
>


--=20
Luiz Augusto von Dentz
