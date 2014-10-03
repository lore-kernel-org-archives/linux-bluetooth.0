Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CAHF=Y4oGjUc=j4DE_pyC5Ue5ymsaoaGXJRzYHdWTHa2EF1k9Gg@mail.gmail.com>
References: <CAHF=Y4pBMLaF1osqQNk1fkw1UHGk6SMYhQ=u5zYZ6qswoFKWBA@mail.gmail.com>
	<F54B539B-3C7A-48C6-B608-417FBCB5050F@holtmann.org>
	<CAHF=Y4oGjUc=j4DE_pyC5Ue5ymsaoaGXJRzYHdWTHa2EF1k9Gg@mail.gmail.com>
Date: Fri, 3 Oct 2014 08:35:09 -0700
Message-ID: <CAHrH25Qw2s0T_MCJndAbv63Eixc7zcJ-KTZG8Y1aKZTy+J8gMw@mail.gmail.com>
Subject: Re: Connecting to propietary remote GATT service: plugins vs D-Bus
 GATT API
From: Arman Uguray <armansito@chromium.org>
To: Alfonso Acosta <fons@spotify.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Mattias Jansson <mjansson@spotify.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel & Alfonso,

> I did start it with -E . In fact "gdbus introspect -r --system -o /
> -d org.bluez" shows the GattManager1 interface, but no
> dev_XX_XX_XX_XX_XX_XX/serviceXX(/charYYYY) object exposing
> GattService1 or GattCharacteristic1, not even while connecting to
> a bonded BLE device with GATT services.

The experimental D-Bus API is not implemented, so yeah you won't see
any of those objects. It is in the timeline to get that support built
in the upcoming months but currently everyone who's using that API
went and wrote their forked implementation of it. Some of the GATT
server side support is there, so building and running with -E should
expose a GattManager1, though I don't think that's fully implemented
either.

For client the quickest way for you might be to actually write a
plugin (using the GAttrib code). I would just look at some of the
profile code, like input/hog or heartrate and maybe add your
implementation as a profile and expose a simple D-Bus API for it if
necessary. Since you're not going to submit this upstream, this might
be the quickest approach for the short term.

Cheers,
Arman
