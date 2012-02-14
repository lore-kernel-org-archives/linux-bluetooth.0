Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Feb 2012 14:39:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 18/22] adaptername: Fix clang warning related to
 unaligned memory access
Message-ID: <20120214123900.GB12437@x220.ger.corp.intel.com>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
 <1328910007-25604-19-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328910007-25604-19-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Feb 10, 2012, Vinicius Costa Gomes wrote:
> ---
>  plugins/adaptername.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/plugins/adaptername.c b/plugins/adaptername.c
> index e154e92..a2f9c8f 100644
> --- a/plugins/adaptername.c
> +++ b/plugins/adaptername.c
> @@ -241,7 +241,7 @@ static gboolean handle_inotify_cb(GIOChannel *channel, GIOCondition cond,
>  
>  	i = 0;
>  	while (i < len) {
> -		struct inotify_event *pevent = (struct inotify_event *) &buf[i];
> +		struct inotify_event *pevent = (void *) &buf[i];
>  
>  		/* check that it's ours */
>  		if (pevent->len && pevent->name != NULL &&

I see how this might remove the warning but not how it removes potential
unaligned access of pevent->len and pevent->name.

Johan
