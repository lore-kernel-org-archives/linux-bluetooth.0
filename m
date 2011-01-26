Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 13:36:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: pavan.savoy@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Pavan Savoy <pavan_savoy@sify.com>
Subject: Re: [PATCH] plugins: hciops: remove scan disable on poweroff
Message-ID: <20110126113608.GA9658@jh-x301>
References: <1296040915-5519-1-git-send-email-pavan_savoy@sify.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296040915-5519-1-git-send-email-pavan_savoy@sify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On Wed, Jan 26, 2011, pavan.savoy@gmail.com wrote:
> From: Pavan Savoy <pavan_savoy@sify.com>
> 
> remove sending of the scan disable command when the
> device is being powered off.
> 
> Signed-off-by: Pavan Savoy <pavan_savoy@sify.com>
> ---
>  plugins/hciops.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)

Pushed upstream after I added some extra info to the commit message and
removed the signed-off-by line (since we don't use that in user space).

Johan
