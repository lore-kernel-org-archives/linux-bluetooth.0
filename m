Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Oct 2013 15:05:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix build errors
Message-ID: <20131029130512.GA12758@x220.p-661hnu-f1>
References: <1383050922-27758-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383050922-27758-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Oct 29, 2013, Andrei Emeltchenko wrote:
> The patch fixes following issues when building:
> 
> Make links to sco.h and rfcomm.h needed for Android sockets.
> ...
> btio.c:39:30: fatal error: bluetooth/rfcomm.h: No such file or directory
> compilation terminated.
> ...
> btio.c:40:27: fatal error: bluetooth/sco.h: No such file or directory
> compilation terminated.
> ...
> ---
>  android/Android.mk |    2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
