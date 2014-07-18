Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 00/21] Second iteration of SCO Audio HAL fixes
Date: Fri, 18 Jul 2014 13:49:40 +0200
Message-ID: <1833630.zaps8haTKY@uw000953>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 18 of July 2014 12:47:59 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> The code makes SCO Audio HAL working with Intel device and USB Bluetooth.
> 
> Changes:
> 	* v2: Remove connect SCO from Audio HAL, change function to get_fd(),
> 	fixing other comments from review.
> 
> Andrei Emeltchenko (21):
>   android/hal-sco: Use nanosleep for SCO synchronization
>   android/hal-sco: Move mtu assignment to open_stream()
>   android/hal-sco: Add SCO packet cache
>   android/hal-sco: Make use of config parameter
>   android/hal-sco: Implement open input stream
>   android/hal-sco: Check file descriptor >= 0
>   android/hal-sco: Use global sco file descriptor
>   android/hal-sco: Make debug more readable
>   android/hal-sco: Fix memory leak
>   android/hal-sco: Implement read
>   android/hal-sco: Skip resampling for output stream with 8k
>   android/hal-sco: Skip resampling for input of 8k
>   android/hal-sco: Choose buffer size
>   android/hal-sco: Add stream synchronization
>   android/hal-sco: Get SCO audio fd on demand
>   android/hal-sco: Defer SCO connection to write()
>   android/hal-sco: Fix incorrect assignment
>   android/hal-audio: Fix leaving open socket
>   android/hal-sco: Fix leaving open socket
>   android/hal-sco: Fix error code printing
>   android/ipc: Rename connect_sco to get_fd
> 
>  android/hal-audio.c     |  12 +-
>  android/hal-sco.c       | 602 ++++++++++++++++++++++++++++++++++++++++++------
>  android/handsfree.c     |  10 +-
>  android/sco-ipc-api.txt |   6 +-
>  android/sco-msg.h       |   4 +-
>  5 files changed, 544 insertions(+), 90 deletions(-)
> 

I've pushed all patches except last one which needs to be rebased. Thanks.
 

-- 
Best regards, 
Szymon Janc
