Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Oct 2013 15:59:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Make use of Android system headers instead of
 local one
Message-ID: <20131023125904.GA23296@x220.p-661hnu-f1>
References: <1382532281-5445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382532281-5445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 23, 2013, Andrei Emeltchenko wrote:
> Since the headers were copied to android/ folder Android build started
> to use those instead of original Android system headers. The patch
> puts Android system headers first.
> ---
>  android/Android.mk | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
