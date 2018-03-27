Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <601e83b6-023b-0ba6-920e-9dfa66548393@jp.fujitsu.com>
References: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
 <CABBYNZLxMy-fj=HESjdzDt+CV2u3MJVCd-7shop+01PwUpXjVQ@mail.gmail.com> <601e83b6-023b-0ba6-920e-9dfa66548393@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Mar 2018 14:09:01 +0300
Message-ID: <CABBYNZJpVnXRoMDSxZrNm9b++P0S6tJwf99=LvTjTSLVRbK9zQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/6] Make commands return exit status
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Tue, Mar 27, 2018 at 8:38 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Luiz,
>
> On 03/26/2018 10:26 PM, Luiz Augusto von Dentz wrote:
>> Hi Eramoto,
>>
>> On Mon, Mar 26, 2018 at 11:25 AM, ERAMOTO Masaya
>> <eramoto.masaya@jp.fujitsu.com> wrote:
>>> Commands always return 0 as exit status in non-interactive mode. This
>>> patch set makes them return the exit_status variable as exit status.
>>>
>>> Note:
>>>   This patch set does not include the following fix for meshctl, due to
>>>   conflict with Inga's patch ("mesh/meshctl: Exit cleanly if start up
>>>   fails")[1]. I will send a rebased fix after merging Inga's patch to
>>>   BlueZ master branch.
>>>
>>>   [1]: https://www.spinics.net/lists/linux-bluetooth/msg75020.html
>>
>> So here is the concern the exit status or the memory leaks, because
>> the latter is not really a problem if the process will be terminated
>> all the resources will be freed anyway so calling bt_shell_cleanup
>> seems pointless in this regard. The status seems alright as I can see
>> it being used with scripts that may parse the exit status.
>
> bluetoothctl etc. always return 0 except calling exit(), since
> bt_shell_run() does not return value even if a subcommand fails.
> Because it is hard for scripts to handle them whose exit status is 0
> if they hit any unexpected problem, they are not convenient on
> non-interactive mode.
>
> This patch set makes bt_shell_run() return EXIT_SUCCESS/EXIT_FAILURE or
> error code, and bluetoothctl etc. be able to pass the status to scripts.

Applied, thanks.
