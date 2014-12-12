Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418381649-17818-1-git-send-email-jpawlowski@google.com>
References: <1418381649-17818-1-git-send-email-jpawlowski@google.com>
Date: Fri, 12 Dec 2014 14:28:20 -0800
Message-ID: <CAHrH25QKcazHUtPf=KJs5UW3q-Xt+EnAY4CtQHuwjeftVzJ=EA@mail.gmail.com>
Subject: Re: [PATCH v3] doc/adapter-api.txt: StartFilteredDiscovery method.
From: Arman Uguray <armansito@chromium.org>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> On Fri, Dec 12, 2014 at 2:54 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch proposes new method, StartFilteredDiscovery to D-Bus Adapter
> API for desktop bluetoothd. It will allow for rapid discovery of nearby
> devices that advertise services.
>
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  doc/adapter-api.txt | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 74d235a..7e688ef 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -22,6 +22,40 @@ Methods              void StartDiscovery()
>                         Possible errors: org.bluez.Error.NotReady
>                                          org.bluez.Error.Failed
>
> +               void StartFilteredDiscovery(dict filter, string transport)
> +
> +                       This method starts the device discovery session with
> +                       filtering by uuids, and rssi or pathloss value. Use
> +                       StopDiscovery to release the sessions acquired.
> +
> +                       transport parameter:
> +                               "auto"  - interleaved scan, default value

I would explain this a little further, just saying "default value"
doesn't seem to do it justice. Say that "auto" will cause a BR/EDR &
LE interleaved scan on dual-mode controllers, on single-mode
(LE-only/BREDR-only) controllers it will work on whatever the
controller supports.

> +                               "bredr" - br/edr inquiry
> +                               "le"    - le only scan
> +
> +                       Parameters that can be set in filter dictionary include
> +                       the following:
> +
> +                       array{string} UUIDs : filtered service UUIDs (required)
> +                       int16 RSSI      : RSSI threshold value (optional)
> +                       uint16 pathloss : Pathloss threshold value (optional)
> +
> +                       When a device is found that advertise any UUID from
> +                       UUIDs, it will be reported if:
> +                       - pathloss and RSSI are both empty,
> +                       - only pathloss param is set, device advertise TX pwer,
> +                         and computed pathloss is less than pathloss param,
> +                       - only RSSI param is set, and received RSSI is higher
> +                         than RSSI param,
> +
> +                       This process will start creating Device objects as new
> +                       devices matching criteria are discovered. It will also
> +                       emit PropertiesChanged signal for already existing
> +                       Device objects, with updated RSSI value.
> +
> +                       Possible errors: org.bluez.Error.NotReady
> +                                        org.bluez.Error.Failed

You probably want to add org.bluez.Error.InvalidArguments as a
possible error. You'll have to check that the filter dictionary
contains values of the correct type (since it's type is a{sv}) and the
"transport" argument contains auto/le/bredr. For anything else, you
should return the InvalidArguments error.

> +
>                 void StopDiscovery()
>
>                         This method will cancel any previous StartDiscovery
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
