Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MkCLLXsO6va+ZZ1n79Hh2d4FTiRp6UP_aZy+1EYik+ZQ@mail.gmail.com>
References: <1394597040-4483-1-git-send-email-armansito@chromium.org>
	<1394597040-4483-2-git-send-email-armansito@chromium.org>
	<CAJdJm_MkCLLXsO6va+ZZ1n79Hh2d4FTiRp6UP_aZy+1EYik+ZQ@mail.gmail.com>
Date: Fri, 14 Mar 2014 11:28:28 -0700
Message-ID: <CAHrH25QGb0UbQN5f5C8LaLf_jm3mZzSHzpAaQTMKbhp4+eQcuQ@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/2] gatt-dbus: Add remote GATT service objects.
From: Arman Uguray <armansito@chromium.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

First of all, sorry about the many small style issues. I don't usually
write a lot of C, so thanks for taking the time to address my style
mistakes. Please see my answers inline.

> What does "CL" mean?

Please ignore it. It's a Google/Chromium way of referring to a patch
and I used the term out of habit. What I really meant was "patch".

> Regarding coding style: we mostly follow kernel style, so be sure that
> your patches pass the "checkpatch.pl" script (available on the kernel
> sources). You can use this call as a start (which is what I use
> personally):
>
> ~/trees/linux.git/scripts/checkpatch.pl \
>                 --no-signoff --ignore
> INITIALISED_STATIC,NEW_TYPEDEFS,VOLATILE,CAMELCASE,FSF_MAILING_ADDRESS
> --show-types --mailback -
>
> See below for comments on the most obvious issues, but I suggest you
> clear all errors/warnings reported by checkpatch. Also make sure you
> are building your code using "./bootstrap-configure && make" and that
> you have run "make check && make distcheck" at least once.

Thanks, I will do this from now on.

> Why are you skipping those services from The D-Bus API? Some
> application why want access to the "raw" data such as GAP Appearance.

I was trying to decide whether or not it makes sense for an external
application to interact with the GATT/GAP services directly when BlueZ
takes care of the specifics. This was something I wasn't really sure
about myself, but I included this in the patch anyway to see what you
think. I think it's ok to simply expose them for now but maybe
abstract the specifics away later in a higher-level API?

>> -       if (device->connect) {
>> -               if (!device->le_state.svc_resolved)
>> -                       device_browse_primary(device, NULL);
>> +       if (!device->le_state.svc_resolved)
>> +               device_browse_primary(device, NULL);
>>
>> +       if (device->connect) {
>
>
> Are these changes related your last point on the cover letter? If yes,
> please move it to a separate commit with a descriptive commit message
> explaining the problem.

Yes they are. The reason that I included it in this patch is the
following: once BlueZ has connected to a device, it seems to mark it
as non-temporary and store the data. If, after connecting to a device,
I power off the device and then on again, BlueZ actually automatically
connects to it. It appears that, since BlueZ already caches the list
of service UUIDs that it fetched from the device, it doesn't run
service discovery again (afaict). This makes sense, but because of the
way I wired up GATT service object creation in this patch, GATT
service objects don't get created in the auto-connect case.

I kept this change in this patch to kind of initiate this discussion,
as I'm not quite convinced yet whether or not the way I register the
btd_gatt_dbus_service objects in device.c is the right way and I
wanted to hear you opinion on that. I'll remove this change from this
patch for now.

-Arman
