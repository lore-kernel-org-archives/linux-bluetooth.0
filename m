Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1457626604-5656-1-git-send-email-luiz.dentz@gmail.com>
References: <1457626604-5656-1-git-send-email-luiz.dentz@gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Fri, 11 Mar 2016 12:05:23 +0100
Message-ID: <CADAkoF5psaM7eAgjMZGbq4Q-Kx_SDEbEn9MtQM8Mj9+g+ow0Aw@mail.gmail.com>
Subject: Re: [RFC BlueZ] doc/device-api: Replace GattServices with Discovering property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 10, 2016 at 5:16 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> GattServices is not really doing was it was meant to do which was to
> track progress of service discovery since it only worked for the very
> first time a device is connected but since we no longer remove the
> attributes an application would have the false impression the service are
> all resolved by the time it reconnects when in fact the service may have
> changed.
>
> Futhermore object tracking like it is doing has been obsolete by
> ObjectManager so this propose to replace the service discovery tracking
> with a boolean property which works both with SDP as well as GATT
> discovery.
> ---
>  doc/device-api.txt |  9 +++------
>  src/device.c       | 58 +++++++++++-------------------------------------------
>  2 files changed, 14 insertions(+), 53 deletions(-)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index a8076a2..9e58664 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -212,10 +212,7 @@ Properties string Address [readonly]
>                         Service advertisement data. Keys are the UUIDs in
>                         string format followed by its byte array value.
>
> -               array{object} GattServices [readonly, optional]
> +               bool Discovering [readonly, optional, experimental]

It's not optional - there's no exists method (which is fine).

I think a better name for this would be "Discovered" which has initial
value of false (once device is connected) and then changes to true
(once services are ready, either from cache or an actual discovery).
It could also change back to false once re-discovery due to Service
Changed is in progress which I think is also fine.

With "Discovering" the problem is still that once "Connected" changes
to true, reading "Discovering" will return false so you don't quite
know whether discovery already finished or has not yet started.
Application would need to wait for complete sequence to be sure:
Connected=false, Discovering=false
Connected=true, Discovering=false
Connected=false, Discovering=true
Connected=false, Discovering=false

With "Discovered" this is not a problem since sequence is as follows:
Connected=false, Discovered=false
Connected=true, Discovered=false
Connected=true, Discovered=true

> -                       List of GATT service object paths. Each referenced
> -                       object exports the org.bluez.GattService1 interface and
> -                       represents a remote GATT service. This property will be
> -                       updated once all remote GATT services of this device
> -                       have been discovered and exported over D-Bus.
> +                       Indicate whether or not service discovery is in
> +                       progress.

<snip>

BR,
Andrzej
