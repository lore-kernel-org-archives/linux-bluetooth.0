Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFjWW+aPVE4EMbsgem4MesotaXugE+=v5oYvLtT7n9KV5EQwpQ@mail.gmail.com>
References: <CAFjWW+aPVE4EMbsgem4MesotaXugE+=v5oYvLtT7n9KV5EQwpQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Oct 2016 11:15:56 +0300
Message-ID: <CABBYNZK5N4+6TURA3Hs8TCH7C8OQ5mHj3VP1cvvZjWj87jMJig@mail.gmail.com>
Subject: Re: Auto-Add Serial Port Profile?
To: aaron.hamilton@atlaslabs.io
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Aaron,

On Fri, Oct 7, 2016 at 5:10 AM, Aaron Hamilton
<aaron.hamilton@atlaslabs.io> wrote:
> I'm looking for direction on the best way of automatically adding a
> serial port profile when bluetoothd starts up (from any peer/device,
> not a specified one). Currently I'm having to do the following:
>
> 1. launch bluetoothd via OpenWrt procd script with "bluetoothd -d -n -C"
> 2. Execute "sdptool add --channel=2 SP". This is problematic in that
> it must be executed again if bluetoothd or the adapter is restarted,
> or it fails if run before bluetoothd is up.
> 3. Start rfcomm listener/watch: "rfcomm watch /dev/rfcomm0 2
> launcher.sh -c /dev/rfcomm0" (this is a custom process for accepting
> files from any client that connects).

This is all deprecated, sdptool and rfcomm tool, what you should be
using the Profile API:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/profile-api.txt

And there is an example in python:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/test-profile

> I'm open to suggestion for a more reliable method if there is one.
> Otherwise, I'd like to eliminate the need for executing the "sdptool
> add ..." command since this is creating reliability issues. I
> initially tried creating a profile based off bluez5.42 SAP, but it
> locks up my machine when a peer tries to pair.

Look at the profile API. As for pairing locking up I guess it is
waiting for input on the agent, anyway you can require or not both
authentication and authorization when registering the profile.

> Ultimately, I need a robust method for allowing legacy devices to pair
> with the adapter and transfer files. The adapter is a server, so it
> accepts connections from any device that pairs successfully.

Well for files there exists the OBEX based profiles, but you can of
course do a custom profile using a RFCOMM channel.

> Also, I don't have control over the other end, so all I can do is open
> up the RFCOMM port and accept files over it.



-- 
Luiz Augusto von Dentz
