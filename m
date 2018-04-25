Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <C239547F-75D2-418F-9472-561FFE5E352E@holtmann.org>
References: <1524506380-7417-1-git-send-email-loic.poulain@linaro.org>
 <21D02E4F-2AFB-4B2F-9696-969E1632D70D@holtmann.org> <CAMZdPi90M71dXo+mHf=9X0AyZkBm_zNk0qQ+O-bRqcuQSabP0w@mail.gmail.com>
 <C239547F-75D2-418F-9472-561FFE5E352E@holtmann.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Wed, 25 Apr 2018 15:34:06 +0200
Message-ID: <CAMZdPi86LvtWP4RLV=o5iqZznYr3E8tkUSwV24rV=F+yoC77XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add __hci_cmd_sync_noev function
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	kkapra@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 25 April 2018 at 14:10, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Loic,
>
>>> so this is not a _sync command. You are not waiting for the completion.=
 So this is more like __hci_cmd_send or __hci_cmd_submit. I am also debatin=
g if this should be limited to vendor OGF only, meaning it should throw an =
error for all others.
>>
>> This makes sense, I agree we should not allow standard HCI command to
>> be unresponded and strictly follow the specification.
>> I think __hci_cmd_send/submit is a bit too generic and we already have
>> a hci_send_cmd which has a different behavior, don't want to cause
>> confusion. So what about __hci_cmd_noresp or __hci_cmd_vendor...?
>
> so perfect would be that we have at least a =E2=80=9Csync=E2=80=9D comman=
d in that sense that we know the controller has send it to the hardware. Ho=
wever from a driver framework point of view we do not have this concept. An=
d we don=E2=80=99t have it, because that kind of =E2=80=9Cflow control=E2=
=80=9D is not needed since we have HCI command and also ACL packet flow con=
trol that should be used.
>
> My concern is that you can easily overload the controller since there are=
 no checks and balances from a HCI point of view. The transport might have =
some, but otherwise you push things in a queue and hope that all goes well.

Yes, we are out of spec here and the only overload protection is UART
hardware flow control in this case.

> Anyway, I am against __hci_cmd_vendor since that is a bit misleading and =
the _noresp seems a bit off as well. We could do __hci_cmd_dispatch or __hc=
i_cmd_post. I am not convinced that __hci_cmd_send would be actually that b=
ad. It is essentially the just that (except it bypasses the hdev->cmd_q.

Fair enough.

Regards,
Loic
