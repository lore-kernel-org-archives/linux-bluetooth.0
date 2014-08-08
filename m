Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Aug 2014 17:29:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH 1/2] android/a2dp: Improve avdtp_close function
Message-ID: <20140808142907.GA18870@t440s.P-661HNU-F1>
References: <1407505354-23072-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407505354-23072-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Aug 08, 2014, Lukasz Rymanowski wrote:
> With this patch avdtp_close does avdtp_abort under the hood in case
> stream is not yet in OPEN state.
> ---
>  android/avdtp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Both patches have been applied. Thanks.

Johan
