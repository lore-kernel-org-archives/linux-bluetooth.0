Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHF=Y4pkXTvcN6YQTH6DPboeav7BCa8T0HUSfOHfag+W9GJ8fQ@mail.gmail.com>
References: <1411746855-9936-1-git-send-email-fons@spotify.com>
 <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org> <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com>
 <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org> <CAHF=Y4p-st7N4+kUezYWjy7L58zcH-1t0AO0ME6axZ76ZK+oKQ@mail.gmail.com>
 <1D7AEE8B-51DB-4A6D-8EBA-3EC81760224E@holtmann.org> <CAHF=Y4pkXTvcN6YQTH6DPboeav7BCa8T0HUSfOHfag+W9GJ8fQ@mail.gmail.com>
From: Alfonso Acosta <fons@spotify.com>
Date: Fri, 3 Oct 2014 10:37:37 +0200
Message-ID: <CAHF=Y4r0Dx1b8vwWAwTWSNq+JD_1_622px4UG4FD1vsfS+BWiw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan and Marcel,

As you guys suggested, including ADV_IND in the Device Connected event
made the trick (for which I just submitted a patch).

Everything goes well if I disconnect when rebonding (using Unpair
Device with Disconnect=3D0x01).

However, I am struggling to go one step further and rebond without
disconnecting (using Unpair Device with Disconnect=3D0x00) before the
security elevation happens. The sequence of "events" is exactly as
Johan described:

> 1. mgmt_ev_device_connected (connected_callback() in adapter.c)
> 2. Connection indication on ATT server socket (src/attrib-server.c)
> 3. device_attach_attrib() called (due to step 2)
> 4. bt_io_set(io, ..., BT_IO_SEC_MEDIUM, ...);

Now I can detect the need to rebond in (1), which gives me control
over the next steps. However, since rebonding is asynchronous, I don't
know a simple way to ensure it is done before the security elevation
happens. My ideas so far:

* Stall (3) through synchronization primitives until the rebonding is
done, which sounds horrible.
* Cancel (3) and somehow force an ATT reconnection (2) once the
rebonding is done, which in turn would cause another security
elevation, but I don't know how (I am probably making wrong
assumptions about how the ATT socket works).

Do you have any suggestions?

Thanks,

Fons

On Mon, Sep 29, 2014 at 4:49 PM, Alfonso Acosta <fons@spotify.com> wrote:
>>
>> if it can not store its LTK, then why doesn't it use a key hierarchy (as=
 defined in the Bluetooth specification) so that it can restore its keys af=
ter reboot. If it remembers its Bluetooth address, then it could clearly re=
member a single master key.
>>
>> But seriously, if you can remember your BD_ADDR, then you might want to =
remember your LTK as well. Just a hint here.
>
>
> Thanks for the hint, I wasn't familiar with "key hierarchies".
>
>> So the encryption trigger is not done by the kernel. It is actually done=
 by userspace when you have an existing LTK. The kernel will auto-conect th=
e device with low security and then userspace will move it to medium securi=
ty in case we have an LTK. It will also move it to medium security for all =
HID devices since that is mandatory.
>>
> [...]
>> Having the advertising data in Device Connected event will actually allo=
w you to do exactly what you want. It would allow you to utilize Unpair Dev=
ice (with Disconnect 0x00) and Pair Device to recreate the bonding. All wit=
hout ever disconnecting the link.
>>
>> The important piece of detail is that the security elevation from low to=
 medium does not happen when the device is detected as initial powered on. =
So instead of security elevation, you do a re-bonding which will give you t=
he encrypted link HID requires and also the new LTK.
>
> Oh, I see. I was wrongly assuming that the encryption elevation was
> also done in the kernel without userspace involvement. Then, adding
> the contents of the ADV_IND report to the "Device Connected event"
> should indeed be good enough. I will try it out and send a patch if it
> works.
>
>
>> So before trying to redefine the Add Device command semantics, I would c=
learly go for adding the advertising data to Device Connected event and see=
 if that gets you where you need to go.
>
> Will do, thanks!
>
>
>
> --
> Alfonso Acosta
>
> Embedded Systems Engineer at Spotify
> Birger Jarlsgatan 61, Stockholm, Sweden
> http://www.spotify.com



--=20
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
