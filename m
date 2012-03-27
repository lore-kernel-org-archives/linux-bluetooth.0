Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 14:29:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: james.steele@accenture.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump] Fix for parsing of SSP debug mode command.
Message-ID: <20120327112938.GD14481@x220>
References: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E01ACF@048-CH1MPN1-101.048d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E01ACF@048-CH1MPN1-101.048d.mgd.msft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

On Mon, Mar 19, 2012, james.steele@accenture.com wrote:
> From: James Steele <james.steele@accenture.com>
> 
> ---
>  lib/hci.h    |    2 +-
>  parser/hci.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/hci.h b/lib/hci.h
> index b68dbc2..1765655 100644
> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -1419,7 +1419,7 @@ typedef struct {
>  #define WRITE_REMOTE_AMP_ASSOC_RP_SIZE 2
> 
>  /* Testing commands */
> -#define OGF_TESTING_CMD                0x3e
> +#define OGF_TESTING_CMD                0x06
> 
>  #define OCF_READ_LOOPBACK_MODE                 0x0001
> 

Could you send this lib/hci.h change as a separate patch since it needs
to be applied to bluez.git first before going into bluez-hcidump.git.
Thanks.

Johan
