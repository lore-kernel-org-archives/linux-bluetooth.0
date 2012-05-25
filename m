Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 10:44:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: Re: [PATCH BlueZ] AVRCP: Remove unneeded check for set_volume
 callback
Message-ID: <20120525074409.GC13680@x220>
References: <1337880385-3894-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337880385-3894-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, May 24, 2012, Lucas De Marchi wrote:
> ---
> 
> Luiz, feel free to put this in your patchset if you prefer so it doesn't
> conflict with your patches.
> 
>  audio/avrcp.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

This didn't conflict with current git (with first three Luiz's patches)
so I went ahead and applied it.

Johan
