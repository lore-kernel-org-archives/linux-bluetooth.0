Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Oct 2010 15:00:43 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] Fix setting Discoverable when adapter is down
Message-ID: <20101028190043.GA3031@jh-x301>
References: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
 <1288252859-10337-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288252859-10337-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 28, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> This cause an error because adapter_up will load the mode from storage
> ignoring pending mode which cause modes to mismatch.
> 
> To fix this behavior now when attempting to change mode we first store
> the new mode and wait DEVUP to complete set the mode stored.
> ---
>  src/adapter.c |   19 +++++++++++--------
>  1 files changed, 11 insertions(+), 8 deletions(-)

Patches 3/5, 4/5 and 5/5 have also been pushed upstream. Thanks.

Johan
