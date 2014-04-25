Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Apr 2014 11:16:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] gobex: Fix removing invalid source
Message-ID: <20140425081608.GA2689@t440s.lan>
References: <1397743186-29897-1-git-send-email-szymon.janc@tieto.com>
 <1397743186-29897-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397743186-29897-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Apr 17, 2014, Szymon Janc wrote:
> Since GLib 2.39 calling g_source_remove on already removed source
> is causing critical warning.
> 
> This was affecting unit/test-gobex-transfer when running with
> GLib 2.40.
> 
> /gobex/test_packet_get_req_suspend_resume:
> (./unit/test-gobex-transfer:28879): GLib-CRITICAL **: Source ID 263 was
>     not found when attempting to remove it
> Trace/breakpoint trap
> ---
>  gobex/gobex.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Both patches in this set have been applied, however I fine-tuned this
one a bit to have all checks in the consistent "id > 0" form.

Johan
