Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100630075348.GA23471@jh-x301>
References: <201006291845.53998.siarhei.siamashka@gmail.com>
	<20100630075348.GA23471@jh-x301>
Date: Wed, 30 Jun 2010 11:31:53 +0300
Message-ID: <AANLkTildwDBZR2U6AtxGEiq4Mv-PBnDoqY1xfqHHmzL2@mail.gmail.com>
Subject: Re: SBC encoder/decoder API & errors handling
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 30, 2010 at 10:53 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Siarhei,
>
> On Tue, Jun 29, 2010, Siarhei Siamashka wrote:
>> When I tried to run some SBC encoder tests a few days ago, I noticed that
>> there is a regression introduced by commit:
>> http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=c43f8bdcc1d527e2d77481a66217771038be3acd
>>
>> It is caused by the change from 'int' to 'size_t' for the type of variable
>> 'encoded' in 'sbcenc.c'. After this modification, the check for 'encoded <= 0'
>> does not catch the case when 'sbc_encode' tries to return a negative number in
>> 'encoded' variable. Later we end up calling 'write' function with a negative
>> size for the data block.
>>
>> Right now, in the case of error 'sbc_encode' function may either return a
>> negative number as a return value, or return a negative value in 'encoded'
>> variable. But this second type of error is apparently not handled by anything
>> other than 'sbcenc' tool at the moment.
>>
>> Any opinions about how to fix it in the best way? Because it is a flaw in the
>> library API, comments from the interested parties are welcome.
>
> In general the API feels a bit weird in that it can return errors in two
> different ways. A less obtrusive fix would be to make the variable type
> ssize_t instead of size_t. Regarding breaking the SBC library API, I
> don't see any big issue with that since it's internal to bluetoothd and
> we can easily update the pulseaudio copy accordingly. Would the attached
> patch make sense?

I guess it make sense, but we should also fix alsa and gstreamer code
to use variables of type ssize_t instead of int:

audio/pcm_bluetooth.c:1060:		encoded = sbc_encode(&a2dp->sbc,
data->buffer, a2dp->codesize,
audio/pcm_bluetooth.c:1096:		encoded = sbc_encode(&a2dp->sbc, buff,
a2dp->codesize,
audio/gstsbcenc.c:391:		consumed = sbc_encode(&enc->sbc, (gpointer) data,

-- 
Luiz Augusto von Dentz
Computer Engineer
