Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 13:52:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix crash in get_profile_interface
Message-ID: <20131031115247.GA16308@x220.p-661hnu-f1>
References: <1383216986-302-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383216986-302-1-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Thu, Oct 31, 2013, Jerzy Kasenberg wrote:
> This fixes crash due to uncheck input from user.
> ---
>  android/client/if-bt.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied (after minor coding style fix to add an empty line after }).
Thanks.

Johan
