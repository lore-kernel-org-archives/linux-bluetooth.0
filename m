Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Apr 2014 11:30:36 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/2] android/hal-audio-hsp: Add audio HAL for HSP handling
Message-ID: <20140401083034.GA13320@aemeltch-MOBL1>
References: <1396266260-31712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <C3ED99D0-24D1-4D9A-A99E-B5EA1E1D6E63@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C3ED99D0-24D1-4D9A-A99E-B5EA1E1D6E63@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 31, 2014 at 09:31:57AM -0700, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > This adds audio HAL for handling SCO. Following needs to be added to
> > audio_policy.conf:
> > 
> >  hsp {
> >    outputs {
> >      hsp {
> >        ...
> >        devices AUDIO_DEVICE_OUT_ALL_SCO
> >        ...
> >      }
> >    }
> 
> if we need modifications to /etc/audio_policy.conf, we should have this
> part of android/README or some other documentation. I also wonder if
> this not also needs an inputs { } section since HSP is actually
> full-duplex.

Yes we need input section as well, this was just example, the complete
sections would look like (copied from real device):

...
  hsp {
    outputs {
      hsp {
        sampling_rates 44100
        channel_masks AUDIO_CHANNEL_OUT_STEREO
        formats AUDIO_FORMAT_PCM_16_BIT
        devices AUDIO_DEVICE_OUT_ALL_SCO
      }
    }
    inputs {
      hsp {
        sampling_rates 44100
        channel_masks AUDIO_CHANNEL_IN_MONO
        formats AUDIO_FORMAT_PCM_16_BIT
        devices AUDIO_DEVICE_IN_BLUETOOTH_SCO_HEADSET
      }
    }
  }
...

> Also for the A2DP part, has something checked what happens if we provide
> additional settings.
> 
>   a2dp {
>     outputs {
>       a2dp {
>         sampling_rates 44100
>         channel_masks AUDIO_CHANNEL_OUT_STEREO
>         formats AUDIO_FORMAT_PCM_16_BIT
>         devices AUDIO_DEVICE_OUT_ALL_A2DP
>       }
>     }
>   }

This looks like default configuration for Intel devices.

Best regards 
Andrei Emeltchenko 
