Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Oct 2013 14:11:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] build: Move Makefile.android to android/Makefile.am
Message-ID: <20131029121109.GB31901@x220.p-661hnu-f1>
References: <1382978226-28073-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382978226-28073-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Oct 28, 2013, Szymon Janc wrote:
> This will keep all Android related changes within android directory.
> ---
> 
> Will also fix messing with Marcel's tab completion habits :-)
> 
>  Makefile.am         |   2 +-
>  Makefile.android    | 113 ----------------------------------------------------
>  android/Makefile.am | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+), 114 deletions(-)
>  delete mode 100644 Makefile.android
>  create mode 100644 android/Makefile.am

Applied. Thanks.

Johan
