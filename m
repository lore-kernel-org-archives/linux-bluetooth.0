Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 13:16:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] plugins: hciops: remove scan disable on poweroff
Message-ID: <20110126111617.GA31721@jh-x301>
References: <1295973136-30908-1-git-send-email-pavan_savoy@sify.com>
 <AANLkTinGAorqPagx_hLakiSoadbOQKv5OE4KBSa1fr5q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTinGAorqPagx_hLakiSoadbOQKv5OE4KBSa1fr5q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On Tue, Jan 25, 2011, Pavan Savoy wrote:
> From: Pavan Savoy <pavan_savoy@sify.com>
> 
> remove sending of the scan disable command when the
> device is being powered off.
> 
> Signed-off-by: Pavan Savoy <pavan_savoy@sify.com>
> ---
>  plugins/hciops.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

The patch seems to be corrupted (looks like the whitespace is messed
up):

Applying: plugins: hciops: remove scan disable on poweroff
fatal: corrupt patch at line 10
Patch failed at 0001 plugins: hciops: remove scan disable on poweroff

Could you try re-sending it e.g. with git send-email?

Johan
