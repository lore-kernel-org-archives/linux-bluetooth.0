Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Oct 2010 09:57:11 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix issue when setting limited discoverable mode
Message-ID: <20101029135710.GA2453@jh-x301>
References: <1288357083-24664-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288357083-24664-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Oct 29, 2010, Luiz Augusto von Dentz wrote:
> When setting limited discoverable mode it will always switch to
> discoverable on adapter_mode_changed which doesn't match the pending mode
> requested.
> 
> To fix this MODE_LIMITED was removed since it didn't represent a real
> scan mode but a discoverable mode so that limited discoverable and
> general discoverable are now both represented by MODE_DISCOVERABLE.
> 
> Also limited bits are now set at same point the timeout start and removed
> when mode change to something different then discoverable or when
> discoverable timeout is removed permanently (set to 0).
> ---
>  src/adapter.c |   76 +++++++++++++++++++++++++-------------------------------
>  src/hcid.h    |    1 -
>  2 files changed, 34 insertions(+), 43 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
