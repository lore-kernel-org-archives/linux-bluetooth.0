Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 00/15] android/client: Add audio support
Date: Wed, 05 Feb 2014 15:13:16 +0100
Message-ID: <3292854.LmJgykMhMc@uw000953>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 30 of January 2014 12:23:06 Jakub Tyszkowski wrote:
> This patch set adds audio support for haltest tool. It provides basic audio HAL
> functionality and adds ability to play PCM audio files.
> 
> I've also added sound generator when no file path is provided for "play"
> command. We can leave that be or push sample audio file to the tree, and/or
> hardcode the path. I think that leaving audio file selection to the user and
> providing fallback to sound generator is the right solution. Please let me know
> what is yours preference.
> 
> Regards.
> 
> Jakub Tyszkowski (15):
>   android/client-av: Fix checking for a2dp interface
>   android/client-audio: Add open/close output stream
>   android/client-audio: Add audio file playback
>   android/client-audio: Add playback suspend/resume
>   android/client-audio: Add get_latency for output
>   android/client-audio: Add get_buffer_size for output
>   android/client-audio: Add get_channels
>   android/client-audio: Add getting audio format
>   android/client-audio: Add getting sample rate
>   android/client-audio: Add get_parameters for output
>   android/client-audio: Add set_parameters
>   android/client-audio: Add setting sample rate
>   android/client-audio: Add init_check
>   android/client-audio: Add sine generator as fallback
>   android/client-audio: Fix getting audio module on Android
> 
>  android/Makefile.am       |   2 +-
>  android/client/if-audio.c | 477 +++++++++++++++++++++++++++++++++++++++++++++-
>  android/client/if-av.c    |   4 +-
>  3 files changed, 479 insertions(+), 4 deletions(-)

Despite it being RFC it looks good for me so I've applied patches 1-14.

For 15 I think haltest should not try to stop media server as this might
have unexpected side effects on Android. If one wants to use haltest for
audio testing on Android he can disable media server by hand.

-- 
Best regards, 
Szymon Janc
