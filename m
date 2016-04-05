Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56FE6EFA.5060406@pointpro.nl>
References: <56FE6EFA.5060406@pointpro.nl>
Date: Tue, 5 Apr 2016 18:03:29 +0300
Message-ID: <CABBYNZL37HmNtchJQGkOccgwGFa6Cp-igPOGvjrJRKzELSkqCA@mail.gmail.com>
Subject: Re: Configuring a Bluetooth PAN server: can't find docs
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Egbert van der Wal <ewal@pointpro.nl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Egbert,

On Fri, Apr 1, 2016 at 3:52 PM, Egbert van der Wal <ewal@pointpro.nl> wrote:
> Hi,
>
> Short story: I'd really like to RTFM, but in all of my online quests I can't
> find where it is. Where can I find documentation about bluez, configuration
> files and pand?
>
> With a bit more information: I'm trying to configure a device (Odroid XU4
> running Ubuntu 14.04, using Bluez 4.101) to accept PAN-connections. Doing
> this I want to provide the connecting user with a web interface to perform
> some configuration tasks (such as connecting to a wifi).

Unfortunately 4.101 is a bit too old and I guess even NetworkManager
does support that.

> The resulting connection will not provide internet access and will only be
> used to expose access to an internal IP address (e.g. 10.0.0.1). I want the
> device to basically accept any pairing request using a fixed, pre-configured
> pin-code.
>
> I've been trying to get this working for a while now using various howto's
> but it seems to me that each and every one of them uses a different way to
> configure Bluez, probably resulting from a different version. I basically
> tried all of them and none seem to work (due to missing / invalid commands
> or missing / ignored configuration files).

Have you tried connman tethering? https://01.org/connman/documentation

> I couldn't find any documentation on bluez.org itself. The bluetoothd
> man-page refers to a man-page of /etc/bluetooth/main.conf that doesn't seem
> to exist, and the contents of /etc/bluetooth/main.conf also seem to be
> ignored so I'm quite stuck here.

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/network-api.txt

>
> Any pointers to any type of documentation that covers my version of bluez
> and the steps to set this up would be highly appreciated.

Create a bridge and pass it to org.bluez.NetworkServer1.Register, the
process need to remain connected to D-Bus otherwise it will be
unregistered, but other than that it should be really simple.

> Thanks in advance!
>
> Regards,
>
> Egbert
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
