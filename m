Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335799650-17597-1-git-send-email-dh.herrmann@googlemail.com>
References: <1335799650-17597-1-git-send-email-dh.herrmann@googlemail.com>
Date: Wed, 2 May 2012 16:09:32 -0300
Message-ID: <CAAngNMabAxO9fVN2DM=5xPJAVk_is3QoS1=+TGZPJAbY3TYHMQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] HID: User-space HID I/O driver (UHID)
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, marcel@holtmann.org,
	claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 30, 2012 at 12:27 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi
>
> This implements a hid_ll_driver user-space interface similar to uinput fo=
r the
> input devices. It allows to implement the HID transport-layer in user-spa=
ce as
> required by Bluetooth Low-Energy (HoG).
>
> This is my "first final revision" for the module. Please review and test.
> Changes from the previous RFCs include:
> =C2=A0- The feature-report mechanism is now implemented
> =C2=A0- Several min_t() fixes
> =C2=A0- Minor coding-style issues
>
> I did not change __attribute__((__packed__)) to __packed as the latter on=
e is
> not provided to user-space.
>
> If there are any more issues, please tell me. And for the record, the HoG=
 devs
> told me that they are working since several months with it now so we have=
 a real
> user-space application that needs it ;)
>
> If there are no more issues (which i doubt) I can also resend this splitt=
ed into
> multiple patches.
>

Thanks for your work, David. I'll test and review this new version.
Did you find out the what is the problem when passing BUS_BLUETOOTH on
the 'bus' field of the create request?

Also, how does the HID subsystem differentiate from HID protocol
versions? We've just found out that HoG exposes what HID protocol
version the device implements, is it the case of having an extra field
on the uhid_create_req structure to pass this information, or is it
already present on the HID descriptor (sorry for my limited knowledge
on the HID protocol itself)?

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
