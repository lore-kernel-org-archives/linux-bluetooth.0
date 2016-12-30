Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 30 Dec 2016 09:21:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Gr=E9goire?= Gentil <gregoire@gentil.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: rfcomm without bluetoothd?
Message-ID: <20161230072113.GA20773@x1c.P-661HNU-F1>
References: <f4fea7cd-a68c-abc4-3e5e-c4ff80df118c@gentil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <f4fea7cd-a68c-abc4-3e5e-c4ff80df118c@gentil.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grégoire,

On Thu, Dec 29, 2016, Grégoire Gentil wrote:
> I'm posting here because there doesn't seem to be any more the bluez-users
> mailing list.
> 
> I have a very optimized and constrained embedded device and I would like to
> use rfcomm WITHOUT dbus and bluetoothd daemon.
> 
> The following works:
> 
> dbus-daemon --system --fork
> bluetoothd
> sdptool add --channel=22 SP
> rfcomm listen /dev/rfcomm0 22
> 
> but I would like to use rfcomm without dbus and bluetoothd running. How
> could I do that?

It's certainly possible, however you'll then need to provide the few
critical features that bluetoothd provides through some other means.
E.g. the BlueZ for Android implementation (see android/ subdirectory)
uses neither D-Bus nor bluetoothd. You'd still need some daemon to
provide an SDP server ("sdptool add.." talks to bluetoothd which manages
the local service records) and to handle pairing related functionality
such as responding to PIN code/passkey requests and storing the
resulting link keys (and reloading them once your daemon restarts).

Johan
