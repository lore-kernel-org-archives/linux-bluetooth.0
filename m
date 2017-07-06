Return-Path: <shapiroc@chromium.org>
MIME-Version: 1.0
In-Reply-To: <1c5fb2d7-8671-b5f7-9773-0454ee3ca7da@jp.fujitsu.com>
References: <20170705161602.95344-1-shapiroc@chromium.org> <1c5fb2d7-8671-b5f7-9773-0454ee3ca7da@jp.fujitsu.com>
From: C Shapiro <shapiroc@chromium.org>
Date: Thu, 6 Jul 2017 09:46:27 -0600
Message-ID: <CALM0h1kjYUQrcxu_uOzMNMqVkntzSTjcjox17kqOeBxG2yFo7Q@mail.gmail.com>
Subject: Re: [PATCH v2] Support to change set file via arg
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
	Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,
Thanks for the feedback...below are responses to the questions:

Are there any merits for other software/users (e.g. container, etc.)?
 - As more platforms implement verified boot and need to support many
platforms, this will become more common (e.g. Android)

Why do not you pass DeviceID as an argument instead of a config file?
 - This would be viable also, but then this arg could contradict the
config file setting and allowing the config file to be passed is more
powerful overall.

How can I sign up?
 - Sorry, I accidentally gave the wrong links.
 - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-pyro/chromeos-base/chromeos-bsp-pyro/files/main.conf
 - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-reef/chromeos-base/chromeos-bsp-reef/files/main.conf
 - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-snappy/chromeos-base/chromeos-bsp-snappy/files/main.conf

Why do not you change only ChromeOS init script?
 - ChromeOS uses verified boot with a read only file system, so we
can't change any of the files at runtime.

Thanks,
Charles

On Wed, Jul 5, 2017 at 10:21 PM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Charles,
>
> On 07/06/2017 01:16 AM, C Shapiro wrote:
>> ChromeOS is currently shifting to a more dynamic build system where a
>> single build will be created/managed/deployed to support multiple models
>> that were all created based on a single reference board.
>>
>> This is being done for general cost/maintenance savings around the sheer
>> number of builds that are currently managed for ChromeOS.
>
> I could not understand whether there were any merits except maintenance
> of your ChromeOS.
> Are there any merits for other software/users (e.g. container, etc.)?
>
>> For the bluetooth stack, models have different product id values in the
>> DeviceID field for the main.conf config file.
>
> Why do not you pass DeviceID as an argument instead of a config file?
>
>> E.g.
>> https://chromium.git.corp.google.com/chromiumos/overlays/board-overlays/+/master/overlay-pyro/chromeos-base/chromeos-bsp-pyro/files/main.conf
>> https://chromium.git.corp.google.com/chromiumos/overlays/board-overlays/+/master/overlay-reef/chromeos-base/chromeos-bsp-reef/files/main.conf
>> https://chromium.git.corp.google.com/chromiumos/overlays/board-overlays/+/master/overlay-snappy/chromeos-base/chromeos-bsp-snappy/files/main.conf
>
> I could not access without an account.
> How can I sign up?
>
>> This change allows the config file to be passed as a runtime argument to
>> bluetoothd, which allows the ChromeOS init script to determine the model
>> at runtime and then pass the appropriate model specific config file.
>
> Why do not you change only ChromeOS init scirpt?
>
> For example, in ChromeOS init scirpt,
>  1. Determine the model.
>  2. Run ln command with --force option to link /etc/bluetooth/main.conf to
>     the appropriate config file.
>
>
> Thank you for reading this to the end :)
>
> Regards,
> Eramoto
