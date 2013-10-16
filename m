Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 18:48:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 04/11] android: sdp: Reuse BlueZ SDP server in Android
Message-ID: <20131016154818.GD19385@x220.p-661hnu-f1>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381934198-7955-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381934198-7955-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381934198-7955-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 16, 2013, Andrei Emeltchenko wrote:
> Reuse existing SDP server code in Android GPL daemon.
> ---
>  Makefile.android   |    4 +++-
>  android/Android.mk |    8 ++++++++
>  android/main.c     |    5 +++++
>  3 files changed, 16 insertions(+), 1 deletion(-)

I've applied patches 1-4 upstream, however from there onwards there were
some issues that will still need to be resolved.

Johan
