Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1913683.ZfTpeeEFIY@leonov>
References: <1393610480-5775-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1393610480-5775-2-git-send-email-andrzej.kaczmarek@tieto.com> <1913683.ZfTpeeEFIY@leonov>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Mon, 3 Mar 2014 09:32:13 +0100
Message-ID: <CAF3PWx1fVjSnHOyu3e3zzw_m-Cxkc=2LSn_EXqf7ZdUFzjHj_A@mail.gmail.com>
Subject: Re: [PATCH 1/5] android/hal-audio: Add open/close_endpoint helpers
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On 1 March 2014 12:51, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Andrzej,
>
> On Friday 28 of February 2014 19:01:16 Andrzej Kaczmarek wrote:

<snip>

>> +     }
>> +
>> +     if (fcntl(fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
>> +             error("fcntl(F_SETFL): %s (%d)", strerror(errno), errno);
>> +             return -errno;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static bool open_endpoint(struct audio_endpoint *ep,
>> +                                             struct audio_input_config *cfg)
>> +{
>> +     struct audio_preset *preset;
>> +     const struct audio_codec *codec;
>> +     uint16_t mtu;
>> +     int fd;
>> +
>> +     if (ipc_open_stream_cmd(ep->id, &mtu, &fd, &preset) !=
>> +                                                     AUDIO_STATUS_SUCCESS)
>> +             return false;
>> +
>> +     if (!preset || fd < 0)
>
> If this can happen despite ipc_open_stream_cmd() returned success then freeing
> preset or closing fd should be handled here.

I'll remove this check since ipc_open_stream_cmd guarantees that both
preset and fd are valid on success.

BR,
Andrzej
