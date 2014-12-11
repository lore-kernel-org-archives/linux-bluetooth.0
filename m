Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418305513-4327-1-git-send-email-jpawlowski@google.com>
References: <1418305513-4327-1-git-send-email-jpawlowski@google.com>
Date: Thu, 11 Dec 2014 07:48:02 -0800
Message-ID: <CAHrH25RzOXdJ9es+PZ+PAvjn3kUYFdQ1nvsxStuLLmpso9f73g@mail.gmail.com>
Subject: Re: [PATCH v2] doc/adapter-api.txt: StartServiceDiscovery method.
From: Arman Uguray <armansito@chromium.org>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> On Thu, Dec 11, 2014 at 5:45 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch proposes new method, StartServiceDiscovery to D-Bus Adapter API for
> desktop bluetoothd. It will allow for rapid discovery of nearby devices that
> advertise services.
>
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>

Omit "signed-off by" please.

> ---
>  doc/adapter-api.txt | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 74d235a..198a35a 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -22,6 +22,44 @@ Methods              void StartDiscovery()
>                         Possible errors: org.bluez.Error.NotReady
>                                          org.bluez.Error.Failed
>
> +               void StartServiceDiscovery(string mode, dict filter)
> +

I mentioned this before during the mgmt API patches (though I didn't
feel strongly about it) and I'm mentioning it now (this time I feel
more strongly) that I don't like the term "ServiceDiscovery" here. It
makes me immediately think of ATT/SDP, which is not what this API
doing. What's more, I can easily imagine that we potentially extend
this API to filter by other types of parameters, such as the
manufacturer data field for instance, so maybe it's better to rename
this to something more generic like "RequestDevice" or
"ScanDevicesWithFilter" (or something along those lines).

The behavior of this API with respect to simultaneous use by multiple
applications should be defined here as well. When more than one
application calls this, is the behavior basically "adding a new UUID
filter to the ongoing scan"?

Also, earlier we were talking about a one-shot API that would return
the object paths of devices that the application is particularly
concerned with. Is that the approach we should take here? Or are we
basically saying that applications should rely on InterfacesAdded
signals and then do their additional filtering on top of that based on
Device properties?

> +                       This method starts the device discovery session with
> +                       filtering by uuids, and rssi or pathloss value. Use
> +                       StopDiscovery to release the sessions acquired.
> +

You should document the behavior of this method if StartDiscovery was
called earlier. Does it just fail in that case or is it a no-op?

> +                       mode parameter:
> +                               "LE" - le only scan
> +                               "BR/EDR" - br/edr inquiry
> +                               "INTERLEAVED" - interleaved scan

This parameter looks to MGMT-like. Why do we need an "interlaved"
flag? Should an application care about which technology is being used?
Should this just be automatically determined by bluetoothd?

> +
> +                       Parameters that can be set in filter dictionary include
> +                       the following:
> +
> +                               string UUID : filtered service UUID (required)
> +                               string RSSI : RSSI threshold value (optional)
> +                               string pathloss : Pathloss threshold value
> +                                                   (optional)
> +
> +                       When a device is found that advertise UUID, it will be
> +                       reported if:
> +                       - pathloss and RSSI are both empty
> +                       - only pathloss param is set, device advertise TX pwer,
> +                         and computed pathloss is less than pathloss param,
> +                       - only RSSI param is set, and received RSSI is higher
> +                         than RSSI param,
> +                       - both pathloss and RSSI is set. Then if TX power is
> +                         advertised, pathloss condition must be met, otherwise
> +                         RSSI condition must be met.
> +
> +                       This process will start creating Device objects as new
> +                       devices matching criteria are discovered. It will also
> +                       emit PropertiesChanged signal for already existing
> +                       Device objects, with updated RSSI value.
> +
> +                       Possible errors: org.bluez.Error.NotReady
> +                                        org.bluez.Error.Failed
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
