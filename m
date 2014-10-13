Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/10] android/map-client: Add MAP client daemon implementation
Date: Mon, 13 Oct 2014 22:47:45 +0200
Message-ID: <15197372.1KNekK2V4o@athlon>
In-Reply-To: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 09 October 2014 14:45:04 Grzegorz Kolodziejczyk wrote:
> v1.
> *Add MAP client daemon implementation (skeleton, body)
> *Add haltest MAP client support
> 
> Aleksander Drewnicki (4):
>   android/client: Add skeleton for mce calls
>   android/client: Add code for mce callback
>   android/client: Add code for mce method
>   android/client: Add completion for mce method
> 
> Grzegorz Kolodziejczyk (6):
>   android/map-client: Add initial files
>   android/map-client: Add stubs for MAP client commands handlers
>   android/map-client: Add support for get remote MAS instances
>   android/ipc-tester: Add missing service opcode boundries test cases
>   android/ipc-tester: Add case for MAP client service opcode boundries
>   android/ipc-tester: Add cases for MAP client msg size
> 
>  android/Android.mk       |   5 +-
>  android/Makefile.am      |   2 +
>  android/client/haltest.c |   2 +
>  android/client/if-bt.c   |   3 +
>  android/client/if-main.h |   3 +
>  android/client/if-mce.c  |  87 +++++++++++++++++++++
>  android/ipc-tester.c     |  32 ++++++++
>  android/main.c           |  12 +++
>  android/map-client.c     | 197
> +++++++++++++++++++++++++++++++++++++++++++++++ android/map-client.h     | 
> 26 +++++++
>  10 files changed, 368 insertions(+), 1 deletion(-)
>  create mode 100644 android/client/if-mce.c
>  create mode 100644 android/map-client.c
>  create mode 100644 android/map-client.h

android/client patches are now upstream so no need to resend them. Thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
