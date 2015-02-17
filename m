Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Feb 2015 22:22:05 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] doc/gatt-api: Introduce GattProfile1 concept
Message-ID: <20150217202205.GA27637@t440s.P-661HNU-F1>
References: <1424165181-22895-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424165181-22895-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Feb 17, 2015, Johan Hedberg wrote:
> Until now the GATT D-Bus API doesn't provide any way to register client
> role profiles so that bluetoothd would be able to add matching devices
> to its auto-connect list (managed by the kernel from 3.17 onward). To
> keep the GATT D-Bus interface as capable as the internal plugin API this
> patch adds a new concept of a GattProfile1 D-Bus object. By registering
> such an object and providing a set of mandatory service UUIDs bluetoothd
> will start performing matching against remote devices and add them to
> the auto-connect list.
> ---
>  doc/gatt-api.txt | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

Since there doesn't seem to be any major objections I went ahead and
applied this patch. One small I made though: a "dict options" parameter
to GattManager1.RegisterProfile() to make future extensibility easier.
In the end we might drop this, but for now it's there to stay consistent
with a similar solution for the RegisterService() method.

Johan
