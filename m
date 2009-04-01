Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Apr 2009 08:56:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Fix memset of sco_opt
Message-ID: <20090401055635.GC17550@jh-x301>
References: <1238553045-23938-1-git-send-email-gustavo@las.ic.unicamp.br> <1238553045-23938-2-git-send-email-gustavo@las.ic.unicamp.br> <1238553045-23938-3-git-send-email-gustavo@las.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238553045-23938-3-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 31, 2009, Gustavo F. Padovan wrote:
> Now len has the correct value: sizeof(sco_opt)
> ---
>  common/btio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/common/btio.c b/common/btio.c
> index 9ff407f..030feda 100644
> --- a/common/btio.c
> +++ b/common/btio.c
> @@ -573,8 +573,8 @@ static gboolean sco_set(int sock, uint16_t mtu, GError **err)
>  	if (!mtu)
>  		return TRUE;
>  
> -	memset(&sco_opt, 0, len);
>  	len = sizeof(sco_opt);
> +	memset(&sco_opt, 0, len);
>  	if (getsockopt(sock, SOL_SCO, SCO_OPTIONS, &sco_opt, &len) < 0) {
>  		ERROR_FAILED(err, "getsockopt(SCO_OPTIONS)", errno);
>  		return FALSE;

Nice catch! This one has also been pushed upstream. It's strange though that we
haven't noticed any uninitialized variable compiler warnings because of it
earlier.

Johan
