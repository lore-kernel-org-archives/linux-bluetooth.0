Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 Oct 2013 16:51:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] Tab completion for haltest tool
Message-ID: <20131018135113.GA12559@x220.p-661hnu-f1>
References: <1382102160-21532-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382102160-21532-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Fri, Oct 18, 2013, Jerzy Kasenberg wrote:
> This patchset add tab completion to haltest so using this tool
> will be much easier.
> 
> It allows to build for andriod 4.3 and for host with autotools.
> 
> Jerzy Kasenberg (3):
>   android: Add tab completion to haltest
>   android: Fix error in draw line in haltest tool
>   android: Add completion for adapter to haltest
> 
>  Makefile.android               |    2 +
>  android/Android.mk             |    1 +
>  android/client/haltest.c       |   11 +-
>  android/client/if-bt.c         |  331 ++++++++++++++++++++++++++++++++++------
>  android/client/if-main.h       |   44 +++++-
>  android/client/tabcompletion.c |  313 +++++++++++++++++++++++++++++++++++++
>  android/client/terminal.c      |    4 +-
>  android/client/textconv.c      |   21 +++
>  android/client/textconv.h      |    4 +
>  9 files changed, 673 insertions(+), 58 deletions(-)
>  create mode 100644 android/client/tabcompletion.c

All three patches have been applied. Thanks.

Johan
