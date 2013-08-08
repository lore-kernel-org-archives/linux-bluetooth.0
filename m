Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGoJ=AsiXm7=-0rK2Wm6k+DY85wDoM2WN-eCT8qFpm+sy2B62w@mail.gmail.com>
References: <CAGoJ=AsiXm7=-0rK2Wm6k+DY85wDoM2WN-eCT8qFpm+sy2B62w@mail.gmail.com>
Date: Thu, 8 Aug 2013 08:54:08 -0400
Message-ID: <CAJdJm_Pxpzs7yWmY0gz-7ifEdjHV4Zk88OvjWZLni_xw2mF4Tw@mail.gmail.com>
Subject: Re: using the DBus profiles in BlueZ 5
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: James Baker <j.baker@outlook.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

On Wed, Aug 7, 2013 at 10:21 AM, James Baker <j.baker@outlook.com> wrote:
> What I've done (beyond compile 5.7 with the experimental additions):
> Set systemd to launch with the argument -E in order to enable
> experimental profiles (as mentioned in
> https://gitorious.org/~moreira/bluez-le-docs/moreira-bluez-le-docs/blobs/master/bluez-le-howto.tex)

Note that this document, although mostly applicable to BlueZ 5, was
written to showcase an experimental API that is not upstream yet (and
that's why it is in our development trees as we have not published it
yet). In any case, it is not relevant to using the HeartRate API,
which works on latest BlueZ just fine (from my experience).

> Launched d-feet and navigated to org.bluez. Found hci0, enabled
> discovery. Waited to discover the correct device. Connected to the
> device.
> No heartrate information has been presented, and it is seemingly not
> present in the whole of the object tree.

I suggest you take a look on the example Python code: test/test-heartrate

You need to register a agent to receive heart rate measurements, and
this cannot be done with d-feet.

> Executing /test/test-heartrate results in an error such as
> org.freedesktop.DBus.Error.UnknownMethod "RegsterWatcher" with
> signature "s" on interface "org.bluez.HeartRateManager" doesn't exist.

Can you paste the exact error message? The snippet above contains two
typos which I'm not sure if it was on the original error or not:

* RegsterWatcher -> RegisterWatcher
* org.bluez.HeartRateManager -> org.bluez.HeartRateManager1

Make sure the test-heartrate you are using matches the BlueZ version
which is running.

> Does anyone know of anything I've missed? I've been reading the docs
> and they imply the service should have been registered when I
> connected.
>
> The device is definitely exposing itself as a heart rate monitor; I've
> checked with the Bluetooth SIG assigned numbers.

Can you send the raw HCI dump (using "btmon -w btmon.dump" and
attaching the generated *.dump file) from the connection up to when
you try to run test/test-heartrate?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
