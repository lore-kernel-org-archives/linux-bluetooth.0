Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC10D28D
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186080; cv=none; b=Gp0iPM9eg8vSGeWrrqJ1IoJmhnzuiAdvXZsgSFkUmmyIJXtFp4yClit8brBxxcbT1am5it+AC3bkdk4OqsZEHTiJWPKWfD+CZbOJJCqpj+QSlb7D5b2WYZiQQmc9gIAfpndJBtKoj03n2otHCGi7WDEwFouFkvuiMTczejap1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186080; c=relaxed/simple;
	bh=ffOCXFgR1ZORUzJfNVsRgVv2UX/K6eATjD8Z4hJJvxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdzRYXfgBRfWe5t/C+cJDWwWCAM3n6yLxEuItanNkTAzKPjBhMjbLEgLKBS/CAuEMRdRXPhYcJlQL/CWrF7V3gLy9+/x+hi2ilequd/lNo/bU1cjnJr/PUMx76ndLWm5cjpZ6X8qpr9bHqkxEzGbttglPj/VuuKiZMKTcgjRgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jtr4gGbw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jtr4gGbw"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e1d6166521so9075791fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715186077; x=1715790877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKrfwDWbn/xm6iQe+2dMhz1RZAFwtAa+kDjQTTVOfoc=;
        b=Jtr4gGbwKXUoZuB8mbK7Id8PN9OQdh22cL2qCqkTfDorP+24KmaaxFMjJADk9QDL2J
         oy9DoRNljA61bRKOJMJKMniip56A3K/wf5wS835Lyph+hooMSfrlGFpAsPhXdvKbi7AS
         sVZDMHriaMCE5pUBuUFsuD+O5BtLZsay0BbhqKy7O6n6enpJ5HUMcrXLO9yYzg2zP3PP
         huYjpb7U0EVryJhwq3RRr2dnmWWGu9Y/qS/eR/fHfE/jv0tgwY7PbeSVo7pndTeN9Abf
         NBZeaJBLbcewuCMaHKIog19ZFBG+AF0Ayacb5eAIOlR31CK7U5ARswmUuEJWqQdDuyDI
         1ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186077; x=1715790877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKrfwDWbn/xm6iQe+2dMhz1RZAFwtAa+kDjQTTVOfoc=;
        b=hZSyZfZQFckj3K53bOH8OdbcvreigyO0SnIAuE5YFfGoZuZ49vihq7RXtTn0d8IgJh
         T7DZMNn2pQahiEBY5mZVObHGwgCAEeDImgRJPe2zZun7uVNfiRPl2sISQyExioETOlvv
         1IRP7PyMkK3/KLacHUJ8boeaX4O1S7soBw7raIlgH3s8mUw0nVvFwYN0NYOKjIboVugV
         ek2Ia0m2W5w06fz4l3015KeQCN6cylxYYxO56vPnDDrpUwSYH3bOqeb0LPhDJoKH6cd0
         TKNcJUxVeaabjgkYdLutv/xPqzAhDz7A1GJmrG/iRIlK/kDoeTj4zVrWEniwFsEjf49a
         RAaQ==
X-Gm-Message-State: AOJu0Ywy3yP4BehFT2GkCqNV4RrzVgSVu6ZINvOiamZUCn1s8u9Q08Uo
	WYYeARQcsshgI6dx3uFoSeSha90RUQM19JTheaSv/hOk3wmUEgYeoPZl7ZysoHLAHNECr4YfZpN
	HxkD1ZiRmFSkZmMxds7ovpWdtEhT5QK1w
X-Google-Smtp-Source: AGHT+IHGfx4BctqD0bJ5OwRSL3/iJaqXHMr8CwPVxhDAfENofYxsJWZ3EYLDQ16Nj68/iFQUszeGwzwXShx5ZPJSLeg=
X-Received: by 2002:a2e:968d:0:b0:2e2:1b1c:7465 with SMTP id
 38308e7fff4ca-2e4b1122cb8mr455821fa.10.1715186076882; Wed, 08 May 2024
 09:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508154604.276763-1-arun@asymptotic.io> <20240508154604.276763-4-arun@asymptotic.io>
In-Reply-To: <20240508154604.276763-4-arun@asymptotic.io>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 May 2024 12:34:24 -0400
Message-ID: <CABBYNZKzCe-c-JivKC5gT0P0ZKGwXX9DQeEeZmeDvQS3CpyNTw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/5] test: Add a script to test ASHA
To: Arun Raghavan <arun@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arun,

On Wed, May 8, 2024 at 11:48=E2=80=AFAM Arun Raghavan <arun@asymptotic.io> =
wrote:
>
> Plays out an audio file to the device. Depends on GStreamer for media
> file reading and decoding (specifically, gstreamer core,
> gst-plugins-base, gst-ffmpeg, and gst-python, or equivalent packages).
> ---
>  test/simple-asha | 158 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100755 test/simple-asha
>
> diff --git a/test/simple-asha b/test/simple-asha
> new file mode 100755
> index 000000000..feff9d29c
> --- /dev/null
> +++ b/test/simple-asha
> @@ -0,0 +1,158 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: LGPL-2.1-or-later
> +
> +import os
> +import signal
> +import sys
> +
> +import dbus
> +import dbus.service
> +import dbus.mainloop.glib
> +
> +import gi
> +
> +gi.require_version("Gst", "1.0")
> +gi.require_version("GLib", "2.0")
> +from gi.repository import GLib, Gst
> +
> +import bluezutils
> +
> +mainloop =3D None
> +pipeline =3D None
> +seqnum: int =3D 0
> +
> +
> +def signal_handler(_sig, _frame):
> +    print("Got interrupt")
> +    mainloop.quit()
> +
> +
> +signal.signal(signal.SIGINT, signal_handler)
> +
> +
> +def usage():
> +    print(f"Usage: simple-asha <remote addr> <audio file name> (optional=
 volume 0-127)")
> +
> +
> +def start_playback(fd: int):
> +    global mainloop, pipeline
> +
> +    outdata =3D bytearray(161)
> +
> +    Gst.init(None)
> +
> +    pipeline =3D Gst.parse_launch(
> +        f"""
> +          filesrc location=3D"{sys.argv[2]}" ! decodebin !
> +          audioconvert ! audioresample !
> +          audiobuffersplit output-buffer-duration=3D"20/1000" ! avenc_g7=
22 !
> +          appsink name=3Dsink emit-signals=3Dtrue
> +    """
> +    )
> +
> +    def on_new_sample(sink):
> +        global seqnum
> +
> +        sample =3D sink.emit("pull-sample")
> +        buf =3D sample.get_buffer()
> +
> +        with buf.map(Gst.MapFlags.READ) as info:
> +            pos =3D 0
> +
> +            if info.size !=3D 160:
> +                print("Unexpected buffer size: ", info.size)
> +
> +            outdata[pos] =3D seqnum % 256
> +            pos +=3D 1
> +
> +            for byte in info.data:
> +                outdata[pos] =3D byte
> +                pos +=3D 1
> +
> +            try:
> +                n =3D os.write(fd, outdata)
> +                if n !=3D 161:
> +                    print("Wrote less than expected: ", n)
> +            except:
> +                return Gst.FlowReturn.ERROR
> +
> +        seqnum +=3D 1
> +
> +        return Gst.FlowReturn.OK
> +
> +    sink =3D pipeline.get_by_name("sink")
> +    sink.connect("new-sample", on_new_sample)
> +
> +    pipeline.set_state(Gst.State.PLAYING)
> +
> +    def bus_message(_bus, message, _data) -> bool:
> +        typ =3D message.type
> +
> +        if typ =3D=3D Gst.MessageType.EOS:
> +            print("End of stream")
> +            mainloop.quit()
> +        elif typ =3D=3D Gst.MessageType.ERROR:
> +            err, debug =3D message.parse_error()
> +            print(f"Pipeline error: {err} ({debug})")
> +            mainloop.quit()
> +
> +    bus =3D pipeline.get_bus()
> +    bus.add_watch(GLib.PRIORITY_DEFAULT, bus_message, None)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
> +
> +    mainloop =3D GLib.MainLoop()
> +    bus =3D dbus.SystemBus()
> +
> +    if (len(sys.argv) =3D=3D 3) or (len(sys.argv) =3D=3D 4):
> +        device =3D bluezutils.find_device(sys.argv[1])
> +        if device is None:
> +            print("Could not find device: ", sys.argv[1])
> +            exit(255)
> +    else:
> +        usage()
> +        sys.exit(255)
> +
> +    asha =3D bus.get_object("org.bluez", device.object_path + "/asha")
> +    media =3D dbus.Interface(
> +        bus.get_object("org.bluez", device.object_path + "/asha"),
> +        "org.bluez.MediaEndpoint1",
> +    )
> +
> +    props =3D asha.GetAll(
> +        "org.bluez.MediaEndpoint1",
> +        dbus_interface=3D"org.freedesktop.DBus.Properties",
> +    )
> +    path =3D props["Transport"]
> +
> +    print("Trying to acquire", path)
> +
> +    transport =3D dbus.Interface(
> +        bus.get_object("org.bluez", path),
> +        "org.bluez.MediaTransport1",
> +    )
> +
> +    # Keep default volume at 25%
> +    volume =3D 32
> +    if len(sys.argv) =3D=3D 4:
> +        volume =3D int(sys.argv[3])
> +        if volume < 0 or volume > 127:
> +            print("Volume must be between 0 (mute) and 127 (max)")
> +
> +    transport.Set(
> +        "org.bluez.MediaTransport1",
> +        "Volume",
> +        dbus.UInt16(volume, variant_level=3D1),
> +        dbus_interface=3D"org.freedesktop.DBus.Properties",
> +    )
> +
> +    (fd, imtu, omtu) =3D transport.Acquire()
> +
> +    start_playback(fd.take())
> +
> +    mainloop.run()
> +
> +    pipeline.set_state(Gst.State.NULL)
> +    transport.Release()
> --
> 2.45.0

While I don't mind having a python example I think we are much better
of adding such support in bluetoothctl, most should already work with
transport submenu but perhaps we want to add support for gstreamer
pipeline instead of just a file which would be useful for creating
A2DP sbc and BAP lc3 streams.

>


--=20
Luiz Augusto von Dentz
