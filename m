Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 14:26:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Colin Didier <didier@archos.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix left overs handling in bluetooth_a2dp_write() of
 audio/pcm_bluetooth.c
Message-ID: <20100825112636.GA23943@jh-x301>
References: <20100825084932.GA27072@cybione.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100825084932.GA27072@cybione.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Wed, Aug 25, 2010, Colin Didier wrote:
> If for some reason there is not enough data provided to the function
> bluetooth_a2dp_write() and there are left overs to handle, the ALSA
> module will segfault.
> 
> The test at the line 1053 of audio/pcm_bluetooth.c is wrong because it
> compares unsigned integers and will lead to an unsigned integer overflow
> if bytes_left is inferior to a2dp->codesize - data->count.
> 
> Here is a patch to fix this issue.

Thanks for the patch, however it doesn't compile cleanly:

audio/pcm_bluetooth.c: In function ‘bluetooth_a2dp_write’:
audio/pcm_bluetooth.c:1055: error: comparison between signed and unsigned integer expressions
make[1]: *** [audio/audio_libasound_module_pcm_bluetooth_la-pcm_bluetooth.lo] Error 1
make: *** [all] Error 2

Always make sure that patches compile cleanly with
./bootstrap-configure. Also, could you please use git format-patch to
create the patches and make sure they have properly formated commit
messages (fits within an 80-column terminal with git log, not formated
like an email, etc). Thanks.

Johan
