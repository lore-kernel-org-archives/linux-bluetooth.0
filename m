Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 18:34:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Stack independent BT HAL test tool
Message-ID: <20131016153400.GA19385@x220.p-661hnu-f1>
References: <1381932012-29641-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381932012-29641-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Wed, Oct 16, 2013, Jerzy Kasenberg wrote:
> v3:
>  - underscores changed to dash in file names.
>  - corrected cast style (space after cast).
>  - structure initialization with explicit filed names.
> v2:
>  - license changed to apache
>  - source folder changed to hal-client (underscore to dash)
> v1:
> This tool is for testing Android HAL interfaces from command line.
> Due to lack of readline on Android simple equivalent is hand coded.
> This tool can be used with bluedroid stack so no glib dependency.
> 
> Tool source code is in folder hal_client, please comment if it should be
> somewhere else.
> 
> Comments welcome.
> 
> Best regards
> Jerzy Kasenberg
> 
> Jerzy Kasenberg (5):
>   android: Add haltest skeleton
>   android: Add line editing to haltest
>   android: Add history to line editor in haltest
>   android: Add text conversion helpers to haltest
>   android: Add calls to adapter methods in haltest
> 
>  android/Android.mk           |   21 ++
>  android/client/haltest.c     |  161 +++++++++++
>  android/client/history.c     |   98 +++++++
>  android/client/history.h     |   21 ++
>  android/client/if-bt.c       |  631 ++++++++++++++++++++++++++++++++++++++++++
>  android/client/if-main.h     |   99 +++++++
>  android/client/pollhandler.c |  123 ++++++++
>  android/client/pollhandler.h |   26 ++
>  android/client/terminal.c    |  538 +++++++++++++++++++++++++++++++++++
>  android/client/terminal.h    |   59 ++++
>  android/client/textconv.c    |  205 ++++++++++++++
>  android/client/textconv.h    |  113 ++++++++
>  12 files changed, 2095 insertions(+)
>  create mode 100644 android/client/haltest.c
>  create mode 100644 android/client/history.c
>  create mode 100644 android/client/history.h
>  create mode 100644 android/client/if-bt.c
>  create mode 100644 android/client/if-main.h
>  create mode 100644 android/client/pollhandler.c
>  create mode 100644 android/client/pollhandler.h
>  create mode 100644 android/client/terminal.c
>  create mode 100644 android/client/terminal.h
>  create mode 100644 android/client/textconv.c
>  create mode 100644 android/client/textconv.h

All five patches have been pushed upstream. I did have to fix "empty
line before EOL" errors for each of the first three patches though, so
please avoid that in the future.

Johan
