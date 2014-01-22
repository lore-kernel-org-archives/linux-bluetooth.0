Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Jan 2014 15:51:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pan: Fix wrong freeing dev
Message-ID: <20140122135159.GA21733@x220.p-661hnu-f1>
References: <1390387737-324-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390387737-324-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Jan 22, 2014, Andrei Emeltchenko wrote:
> It does make sense free() dev after it is used. g_free() is not needed
> here since it will be already executed in bt_pan_notify_conn_state().
> ---
>  android/pan.c | 1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

Johan
