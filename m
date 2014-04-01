Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [RFC 1/2] android/hal-audio-hsp: Add audio HAL for HSP handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140401083034.GA13320@aemeltch-MOBL1>
Date: Tue, 1 Apr 2014 07:26:13 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B83A3E79-05FC-42BC-9248-B9B0F58D11B3@holtmann.org>
References: <1396266260-31712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <C3ED99D0-24D1-4D9A-A99E-B5EA1E1D6E63@holtmann.org> <20140401083034.GA13320@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>> This adds audio HAL for handling SCO. Following needs to be added to
>>> audio_policy.conf:
>>> 
>>> hsp {
>>>   outputs {
>>>     hsp {
>>>       ...
>>>       devices AUDIO_DEVICE_OUT_ALL_SCO
>>>       ...
>>>     }
>>>   }
>> 
>> if we need modifications to /etc/audio_policy.conf, we should have this
>> part of android/README or some other documentation. I also wonder if
>> this not also needs an inputs { } section since HSP is actually
>> full-duplex.
> 
> Yes we need input section as well, this was just example, the complete
> sections would look like (copied from real device):
> 
> ...
>  hsp {
>    outputs {
>      hsp {
>        sampling_rates 44100
>        channel_masks AUDIO_CHANNEL_OUT_STEREO
>        formats AUDIO_FORMAT_PCM_16_BIT
>        devices AUDIO_DEVICE_OUT_ALL_SCO
>      }
>    }
>    inputs {
>      hsp {
>        sampling_rates 44100
>        channel_masks AUDIO_CHANNEL_IN_MONO
>        formats AUDIO_FORMAT_PCM_16_BIT
>        devices AUDIO_DEVICE_IN_BLUETOOTH_SCO_HEADSET
>      }
>    }
>  }
> …

how does sampling_rates of 44100 work here? Standard SCO/eSCO is 8000. And then we have Wideband speech as well.

Regards

Marcel

