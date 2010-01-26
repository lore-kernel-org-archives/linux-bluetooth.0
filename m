Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c101001260309h4464805eg3e52ace6dd28f677@mail.gmail.com>
References: <f9d4bd31001251014w1caaa753v39254c3031f5db0e@mail.gmail.com>
	 <2d5a2c101001260309h4464805eg3e52ace6dd28f677@mail.gmail.com>
Date: Tue, 26 Jan 2010 16:33:04 -0200
Message-ID: <f9d4bd31001261033g2d23a089r21069797fea38d9b@mail.gmail.com>
Subject: Re: bluetoothd bug
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@nokia.com>, luiz.dentz-von@nokia.com,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 26, 2010 at 9:09 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Claudio,
>
> On Mon, Jan 25, 2010 at 8:14 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> Hi Johan/Luiz,
>>
>> I found an error "invalid read". The pastebin log shows a PBAP
>> connection in the RFCOMM channel 15. See line 195 of the first log,
>> when the connection is refused the "temporary" device is being
>> removed, however it seems that the "reverse" SDP query still active.
>> PTS is establishing RFCOMM connection before "Encrypt Change" event,
>> but this wrong procedure should not "harm" bluetoothd. In some cases I
>> noticed segmentation fault, probably due this error.
>>
>> http://pastebin.com/m308f85ef
>> http://pastebin.com/m2d80dd71
>
> Does this fix the problem:
>
> diff --git a/src/device.c b/src/device.c
> index a2730ab..dfdacd8 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -239,6 +239,9 @@ static void device_free(gpointer user_data)
>        if (device->disconn_timer)
>                g_source_remove(device->disconn_timer);
>
> +       if (device->discov_timer)
> +               g_source_remove(device->discov_timer);
> +
>        debug("device_free(%p)", device);
>
>        g_free(device->authr);
>
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computação
>

Hi Luiz,

yep, it is working perfectly: no warning/no segmentation fault.

Claudio.
