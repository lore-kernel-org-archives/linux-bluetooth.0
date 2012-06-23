Return-Path: <cyrus@holtmann.org>
Message-ID: <4FE5D57B.7090603@ruff.mobi>
Date: Sat, 23 Jun 2012 16:40:59 +0200
From: "Ruslan N. Marchenko" <me@ruff.mobi>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] pcm_bluetooth: accept BT_A2DP_SBC_SOURCE codec
References: <4FE44DAD.90004@ruff.mobi> <CABBYNZLKfMYfuk=N2qwh4skzffM5PT5hu5HXCPiZOZiAgdj=Eg@mail.gmail.com>
In-Reply-To: <CABBYNZLKfMYfuk=N2qwh4skzffM5PT5hu5HXCPiZOZiAgdj=Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz Augusto,

Am 22.06.2012 22:34, schrieb Luiz Augusto von Dentz:
> Hi Ruslan,
>
> On Fri, Jun 22, 2012 at 1:49 PM, Ruslan N. Marchenko <me@ruff.mobi> wrote:
>> Current implementation of the PCM code is considering capture (source) mode
>> however it ignores codecs of the SBC_SOURCE type while parsing capabilities.
>> With these two lines source codec is accepted, although proper capture mode
>> might require additional changes.
>>
>> Signed-off-by: Ruslan N. Marchenko <me@ruff.mobi>
>> ---
>>   audio/pcm_bluetooth.c |    4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> We are about to remove alsa support from BlueZ as it doesn't support
> the Media API, so this is a nak
I see even trunk PA, mentioned [1] to be using Media API is using same 
calls in the same ipc.c(bt_audio_service_open) - is it something still 
to be cleaned up?
Anyway - does it make sense to port pcm_bluetooth to Media API 
(media.c)? Or BlueZ team is going to abandon it in favour of PA in any 
case? I mean if someone submit patches for pcm on Media API is there 
chance for patches to be accepted?

1. - 
http://lists.freedesktop.org/archives/pulseaudio-discuss/2011-November/012222.html
> Please next time use git format-patch + git send-email so it is easier
> to us to apply the patch using git am, also there is no need for the
> signed-off-by for userspace patches.
Thanks for tips, will follow.

-- 
Looking forward to reading yours...
      Ruslan N. Marchenko

