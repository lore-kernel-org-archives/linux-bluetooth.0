Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Feb 2015 22:00:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android: Fix btmgmt build for Android
Message-ID: <20150213200019.GA26435@t440s.P-661HNU-F1>
References: <1423854975-16515-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423854975-16515-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Feb 13, 2015, Szymon Janc wrote:
> Android doesn't provide readline and wordexp libraries. Since
> interactive mode is not necessary for now just provide stubbed
> implementation.
> 
> Since those headers are loosly based on those libraries original
> licence and copyright are present.
> ---
>  android/Android.mk                          |   2 +
>  android/compat_includes/readline/history.h  |  31 ++++++++
>  android/compat_includes/readline/readline.h | 110 ++++++++++++++++++++++++++++
>  android/compat_includes/wordexp.h           |  44 +++++++++++
>  4 files changed, 187 insertions(+)
>  create mode 100644 android/compat_includes/readline/history.h
>  create mode 100644 android/compat_includes/readline/readline.h
>  create mode 100644 android/compat_includes/wordexp.h

All three patches have been applied. Thanks.

Johan
