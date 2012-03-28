Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Mar 2012 14:25:47 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: james.steele@accenture.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] lib: Add HCI write SSP debug mode library function
Message-ID: <20120328112547.GA28908@x220>
References: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E1131D@048-CH1MPN1-101.048d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <81C9FA9C1C2E9E45A9AC3EDD1858BC4323E1131D@048-CH1MPN1-101.048d.mgd.msft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

On Wed, Mar 28, 2012, james.steele@accenture.com wrote:
> Adds a hci_write_simple_pairing_debug_mode function.
> Also corrects the Testing OGF value to match the specification.
> ---
>  lib/hci.c     |   28 ++++++++++++++++++++++++++++
>  lib/hci.h     |    2 +-
>  lib/hci_lib.h |    2 ++
>  3 files changed, 31 insertions(+), 1 deletions(-)

<snip>

> --- a/lib/hci.h
> +++ b/lib/hci.h
> @@ -1428,7 +1428,7 @@ typedef struct {
>  #define WRITE_REMOTE_AMP_ASSOC_RP_SIZE 2
> 
>  /* Testing commands */
> -#define OGF_TESTING_CMD                0x3e
> +#define OGF_TESTING_CMD                0x06
> 
>  #define OCF_READ_LOOPBACK_MODE                 0x0001
> 

I should have mentioned this already in my previous feedback (sorry for
failing to do that) but this is quite clearly an independent change and
therefore belongs in a separate patch. Whenever you've got words like
"also.." or "additionally.." in your commit message warning bells should
go off in your head and you should ask yourself if the patch needs
splitting into smaller logical chunks.

Please also be consistent with the commit message format: use "Add ..."
instead of "Adding ..." and don't put a dot at the end of the summary
line. Also use proper English in the commit message ("This patch adds.."
instead of "Adds...") and don't be afraid to be too verbose.

Johan
