Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Apr 2012 17:46:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	sunil.a.kumar@intel.com, rashmi.g.nair@intel.com,
	prashant.khanzode@intel.com, luiz.von.dentz@intel.com
Subject: Re: [PATCH BlueZ] AVCTP: return not-implemented for unknown
 passthrough
Message-ID: <20120402144623.GA31518@x220.P-661HNU-F1>
References: <CABBYNZL32nUYXTXTM1gCmRhGms5qGpW2uibyT5j5gDBow8Akiw@mail.gmail.com>
 <1330438817-23824-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330438817-23824-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Feb 28, 2012, Lucas De Marchi wrote:
> ---
>  audio/avctp.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 5bd5db1..1d425eb 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -235,9 +235,12 @@ static size_t handle_panel_passthrough(struct avctp *session,
>  		break;
>  	}
>  
> -	if (key_map[i].name == NULL)
> +	if (key_map[i].name == NULL) {
>  		DBG("AV/C: unknown button 0x%02X %s",
>  						operands[0] & 0x7F, status);
> +		*code = AVC_CTYPE_NOT_IMPLEMENTED;
> +		return 0;
> +	}
>  
>  done:
>  	*code = AVC_CTYPE_ACCEPTED;

Applied. Thanks.

Johan
