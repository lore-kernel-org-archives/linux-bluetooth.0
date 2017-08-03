Return-Path: <shapiroc@chromium.org>
MIME-Version: 1.0
In-Reply-To: <d57a3a6c-b8ed-3418-1239-12749de19a9d@jp.fujitsu.com>
References: <20170718154955.83197-1-shapiroc@chromium.org> <d57a3a6c-b8ed-3418-1239-12749de19a9d@jp.fujitsu.com>
From: C Shapiro <shapiroc@chromium.org>
Date: Thu, 3 Aug 2017 11:21:19 -0600
Message-ID: <CALM0h1m=AGjV_eqp0iB4nCtnvqwAye5CTikqRFz6YcmL_aWA5w@mail.gmail.com>
Subject: Re: [PATCH v3] Support to change set file via arg
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,
I appreciate the feedback.  I incorporated it into v4 that I just sent out.

Thanks,
Charles

On Tue, Aug 1, 2017 at 4:39 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Charles,
>
> On 07/19/2017 12:49 AM, C Shapiro wrote:
>> ChromeOS is currently shifting to a more dynamic build system where a
>> single build will be created/managed/deployed to support multiple models
>> that were all created based on a single reference board.
>>
>> This is being done for general cost/maintenance savings around the sheer
>> number of builds that are currently managed for ChromeOS.
>>
>> To support this, we're changing our build images to have all of the
>> configuration available for all of the models supported by a given
>> build.
>>
>> For the bluetooth stack, models have different product id values in the
>> DeviceID field for the main.conf config file.
>>
>> E.g.
>>  - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-pyro/chromeos-base/chromeos-bsp-pyro/files/main.conf
>>  - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-reef/chromeos-base/chromeos-bsp-reef/files/main.conf
>>  - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-snappy/chromeos-base/chromeos-bsp-snappy/files/main.conf
>>
>> This change allows the config file to be passed as a runtime argument to
>> bluetoothd, which allows the ChromeOS init script to determine the model
>> at runtime and then pass the appropriate model specific config file.
>>
>> Signed-off-by: C Shapiro <shapiroc@chromium.org>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>> Changes in v3:
>> - Fix the commit message with correct links to the example usage.
>>
>>  src/bluetoothd.8.in |  4 ++++
>>  src/main.c          | 12 +++++++++++-
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> Could you add the specified main.conf path to the following messages
> when --configfile command-line option was used.
>
>   Cscope tag: main.conf
>      #   line  filename / context / line
>      1    212  src/main.c <<<unknown>>>
>                warn("Unknown key %s for group %s in main.conf",
>      2    241  src/main.c <<<unknown>>>
>                warn("Unknown group %s in main.conf", keys[i]);
>      3    276  src/main.c <<<unknown>>>
>                DBG("parsing main.conf");
>
> I applied this patch and tested my patches (git log 32867836..c15b986e)
> with using this command-line option. At that time, I passed various
> main.confs composed of different config option settings to it. Using it
> was more useful than editing the fixed main.conf (CONFIGDIR "/main.conf"),
> but it was hard to resolve which output messages is related to any
> main.conf when I tested with each main.conf at once.
> So, I suggest to add the specified main.conf path to these messages. It
> seems we can make resolving easier when we hit a problem with a specified
> main.conf.
>
>
> Regards,
> Eramoto
>
