Return-Path: <cyrus@holtmann.org>
Date: Sun, 11 Nov 2012 15:19:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 5/7] adapter: Remove DevicesFound signal
Message-ID: <20121111131921.GA4405@x220>
References: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1352385015-2127-6-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352385015-2127-6-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Nov 08, 2012, Mikel Astiz wrote:
> ObjectManager reports the D-Bus interfaces of all known devices,
> including the ones detected during discovery. Therefore this signal is
> not required.
> ---
>  doc/adapter-api.txt |  13 ++-----
>  src/adapter.c       | 102 ++--------------------------------------------------
>  2 files changed, 4 insertions(+), 111 deletions(-)

If you look at the commit history you'll see that this signal was added
after the introduction of object manager and was part of the patches
that removed the old DeviceFound signal.

You're right in that our original plan was to replace the device
discovery completely with ObjectManager signals but that turned out to
be infeasible in practice. Even the python script for doing discovery
ended up being quite complex (meaning most other languages would be even
worse) and we didn't get any signals for discovered devices that already
existed in the bluetoothd object hierarchy (since nothing changes for
them from an ObjectManager perspective).

Due to these issues we decided to reintroduce a dedicated signal for
device discovery and at the same time fix the bottle neck we've seen
during the past years where the high frequency of signals in a busy
environment (e.g. UPF) consumes a lot of resources.

The DevicesFound signal is emitted once a second and contains all
devices found since the last period. If no device was found during the
last period the signal is sent as soon as the first device is found.
There's also an (adjustable through a define, right now 5) maximum size
for the list length which forces the signal to be sent as soon as the
limit is reached.

Johan
