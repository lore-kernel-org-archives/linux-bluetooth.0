Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [RFC 1/2] android/hal-audio-hsp: Add audio HAL for HSP handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1396266260-31712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 31 Mar 2014 09:31:57 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C3ED99D0-24D1-4D9A-A99E-B5EA1E1D6E63@holtmann.org>
References: <1396266260-31712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> This adds audio HAL for handling SCO. Following needs to be added to
> audio_policy.conf:
> 
>  hsp {
>    outputs {
>      hsp {
>        ...
>        devices AUDIO_DEVICE_OUT_ALL_SCO
>        ...
>      }
>    }

if we need modifications to /etc/audio_policy.conf, we should have this part of android/README or some other documentation. I also wonder if this not also needs an inputs { } section since HSP is actually full-duplex.

Also for the A2DP part, has something checked what happens if we provide additional settings.

  a2dp {
    outputs {
      a2dp {
        sampling_rates 44100
        channel_masks AUDIO_CHANNEL_OUT_STEREO
        formats AUDIO_FORMAT_PCM_16_BIT
        devices AUDIO_DEVICE_OUT_ALL_A2DP
      }
    }
  }

So something like actually telling it about all 4 sampling rates or MP3 format?

Regards

Marcel

