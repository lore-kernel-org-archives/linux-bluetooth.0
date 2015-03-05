Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425584294-3721-1-git-send-email-jpawlowski@google.com>
References: <1425584294-3721-1-git-send-email-jpawlowski@google.com>
Date: Thu, 5 Mar 2015 12:15:40 -0800
Message-ID: <CAHrH25QNK=5d8PHg82hEm_A-UYW8_iLkXg4VWREHeKHx89k83A@mail.gmail.com>
Subject: Re: [PATCH v9] doc/adapter-api.txt: SetDiscoveryFilter method.
From: Arman Uguray <armansito@chromium.org>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> On Thu, Mar 5, 2015 at 11:38 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch proposes new method, SetDiscoveryFilter to D-Bus Adapter
> API for desktop bluetoothd. It will allow to set per-client discovery
> filter that would limit devices being discovered.
>

I think this looks good overall. See my comments below; I mostly
commented on grammar and phrasing.

> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  doc/adapter-api.txt | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 74d235a..528f0ba 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -43,6 +43,65 @@ Methods              void StartDiscovery()
>                         Possible errors: org.bluez.Error.InvalidArguments
>                                          org.bluez.Error.Failed
>
> +               void SetDiscoveryFilter(dict filter) [Experimental]
> +
> +                       This method sets the device discovery filter for
> +                       current discovery session. When this method is called
> +                       with no filter parameter, filter is removed.
> +

Say "This method sets the device discovery filter for the caller" to
make it clear that there is an individual filter for each application.

> +                       Parameters that can be set in filter dictionary include
> +                       the following:
> +

nit: "...set in the filter dictionary..."

> +                       array{string} UUIDs : filtered service UUIDs (required)
> +                       int16 RSSI      : RSSI threshold value (optional)
> +                       uint16 pathloss : Pathloss threshold value (optional)
> +                       string transport: type of scan to run
> +
> +                       When a device is found that advertise any UUID from

nit: s/device/remote device/
nit: s/advertise/advertises/

> +                       UUIDs, it will be reported if:
> +                       - pathloss and RSSI are both empty,
> +                       - only pathloss param is set, device advertise TX pwer,
> +                         and computed pathloss is less than pathloss param,
> +                       - only RSSI param is set, and received RSSI is higher
> +                         than RSSI param,
> +
> +                       transport parameter determines the type of scan:
> +                               "auto"  - interleaved scan
> +                               "bredr" - br/edr inquiry
> +                               "le"    - le only scan, default value
> +
> +                       If "le" or "bredr" transport is requested, and device
> +                       doesn't support it, org.bluez.Error.Failed error will

by "device doesn't support it" I think you mean "the controller
doesn't support it". Let's not say "device" since we've been using it
to refer to remote devices. Use "adapter"/"controller" to refer to the
local system to avoid ambiguities.

> +                       be returned. If "auto" transport is requested, scan
> +                       will use LE, BREDR, or both, depending on what's
> +                       currently enabled on controller.

nit: s/controller/the controller/

> +
> +                       When discovery filter is set, Device objects will be
> +                       created as new devices matching criteria are

nit: s/devices matching criteria/devices with matching criteria/

> +                       discovered. It will also emit PropertiesChanged signal

nit: "PropertiesChanged signals will be emitted"

> +                       for already existing Device objects, with updated RSSI
> +                       value. This is different from plain StartDiscovery
> +                       behaviour, that keeps imposing the delta-threshold. As
> +                       soon as there's one or more filters set, this type of
> +                       filtering is removed.

The documentation for StartDiscovery doesn't mention any threshold so
this sentence here will be confusing for someone who is new to the
code base. I would add a line to StartDiscovery that mentions the
current delta threshold and rephrase the last two sentences, probably
in a new paragraph: "If one or more discovery filters have been set,
the RSSI delta-threshold, that is imposed by StartDiscovery by
default, will not be applied."

> +
> +                       When multiple clients call StartDiscoveryFilter, their

nit: s/StartDiscoveryFilter/SetDiscoveryFilter/

> +                       filters are internally merged, and notifications about
> +                       new devices are sent to all clients. Therfore every

nit: s/Therfore/Therefore/

> +                       client must check wether Devices that he was notificed

nit: s/wether/whether/. Also, who is "he" :P? Rephrase: "Therefore,
each client must check that device updates actually match its filter."

> +                       about are matching it's filter.
> +
> +                       When SetDiscoveryFilter is called multiple times, last
> +                       filter passed will be active for given client.

Say "When SetDiscoveryFilter is called multiple times by the same
client", since I think that's what you're referring to here.

> +
> +                       SetDiscoveryFilter can be called before StartDiscovery.
> +                       It is useful when client will create first discovery
> +                       session, to ensure that proper scan will be started
> +                       right after call to StartDiscovery.
> +
> +                       Possible errors: org.bluez.Error.NotReady
> +                                        org.bluez.Error.Failed
> +
>  Properties     string Address [readonly]
>
>                         The Bluetooth device address.
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
