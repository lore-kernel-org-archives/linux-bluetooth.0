Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 14:54:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] android/AVDTP: Fix not removing start_timer source
Message-ID: <20131218125404.GB31383@x220.p-661hnu-f1>
References: <1387369783-28164-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387369783-28164-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Dec 18, 2013, Luiz Augusto von Dentz wrote:
> It is possible that stream->start_timer can be set on stream_free which
> should then should take care of remove it properly otherwise it can
> trigger which would very likely cause a crash.
> 
> Thanks to Hannu Mallat <hannu.mallat@jolla.com> for reporting it.
> ---
>  android/avdtp.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
