Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 0/3] Another try for the Sixaxis plugin
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>
Date: Fri, 25 Feb 2011 12:34:02 +0000
In-Reply-To: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1298637244.10364.19.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2011-02-25 at 11:04 +0100, Antonio Ospite wrote:
> Hi,
> 
> this is another attempt to get the sixaxis plugin merged upstream in
> bluez, now cable pairing is done without libusb, which is good because
> the hid driver does not need to be detached anymore.

Good stuff.

> The work is based on patches by Bastian Nocera, so its SOB line comes
> first on the third patch, even though many parts have been totally
> reimplemented.  More comments on the patch itself.
> 
> Bastien, I took the liberty to impersonate you in the second patch about
> re-adding manager_get_default_adapter(), because the change was taken
> out from your bluez rpm package. I hope this is OK.

Both fine by me.

> I was wondering if it was possible to have the equivalent of this plugin
> as a separate daemon doing the association part with bluez over dbus,
> instead of having it builtin (I do not know the bluez dbus interface at
> all), and if there were any major drawbacks with that compared to the
> builtin plugin. What are your opinions on that?

This was already discussed, and I even created a patch to allow outside
pairing. I don't think there's much of a point doing this outside of
bluetoothd though, and Marcel preferred the pairing to be done within
bluetoothd.

> Anyhow,
> 
> HOWTO test it:
>   - Get a kernel supporting HIDIOCSFEATURE and HIDIOCGFEATURE: linux-next
>     should have that, or Jiki Kosina's hidraw-feature branch:
>     http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=shortlog;h=refs/heads/hidraw-feature
>   - Build it and install it with its linux-libc-dev package ("make
>     deb-pkg" on recent kernels builds that already).
>   - Apply the patches in this series and configure bluez, the ioctl
>     above should be detected automatically and the plugin enabled.
>   - If there is any problem, try backing up and cleaning up
>     /var/lib/bluetooth/
> 
> TODO before merging:
>   - Check the routine about bluetooth association. Also, is it strictly
>     necessary to grant manually the first connection?

The line setting the device trust should be enough to not have to
manually grant the first connection. You might want to double-check what
changes between the state of /var/lib/bluetooth after cable pairing and
before connecting for the first time.

>   - Add the actual official version of linux-libc-dev in which the
>     hidraw ioctl will be merged (now it is just 2.6.3x as a
>     placeholder).
>   - Check the last comment from Marcel about the timeout in
>     http://marc.info/?l=linux-bluetooth&m=125525415718147&w=2 Could you
>     comment on the third patch about that, please?

The timeout was to avoid reading data while udev was probing the device.
This might not be necessary anymore.

>   - When the controller is connected via USB after it is working over BT
>     it is seen as a second controller and the second LED is turned on,
>     should we force BT disconnection on USB connection?

If we can assert that the device is the same one, yes, I think we
should.

>   - Test with multiple controllers, and/or multiple BT adapters, which I
>     can't do right now.
>   - Remove the XXX comment about the lowercase hex bdaddr format.
> 
> 
> FUTURE plans:
>  - Add support for battery status report

Where is the battery level exported currently?

>  - Add support for Playstation Move (I don't have the hardware, tho),
>    Pascal?

The PS3 add-on keyboard, and the PS3 headset both use cable pairing. I
have them around, but was unable to get them to pair.

Cheers

