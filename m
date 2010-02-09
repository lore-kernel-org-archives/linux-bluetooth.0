Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <912bb79a1002080934r5cab2823kded04a942cd4a993@mail.gmail.com>
References: <912bb79a1002080934r5cab2823kded04a942cd4a993@mail.gmail.com>
Date: Tue, 9 Feb 2010 09:48:30 +0200
Message-ID: <2d5a2c101002082348j263b46f7je0039b811ea31d0a@mail.gmail.com>
Subject: Re: Unable to get device name while discovery
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi,

On Mon, Feb 8, 2010 at 7:34 PM, nirav rabara <niravrabara@gmail.com> wrote:
> Hi,
>
> Most of the time I am unable to get device name while discovering for
> new device.
>
> I am using Dbus API to discover new devices, I am able to get the
> signal DeviceFound() , using this signal I am able to get device
> addresses, paired or not, connected or not, but some times its not
> showing the name of the device.

It may take some time to resolve the name, specially if there are many
devices to resolve their names.

> Can anybody suggest me what should i do to get device name while
> searching for the new devices.

If you want to display the name you should probably wait until it is
resolved, a new DeviceFound will be emitted with the resolved name.

> ( If the file names available at /var/lib/run/bluetooth/... then it's
> shows device name , as per my understanding while searching its trying
> to get device name from this "names " file , but if the file is not
> available it won't show the device name.  If the bluetooth dongle is
> connection at first time then no "names" file will be available , so
> how to get device name? )

The names file will be created if it doesn't exist, you just need to
keep the discovery session active to be able to resolve the devices
which may take some time, again once it is done you will receive a new
DeviceFound with the updated name.


-- 
Luiz Augusto von Dentz
Computer Engineer
