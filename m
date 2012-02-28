Return-Path: <cyrus@holtmann.org>
From: "Malovany, Ram" <ramm@ti.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"sunil.a.kumar@intel.com" <sunil.a.kumar@intel.com>,
	"rashmi.g.nair@intel.com" <rashmi.g.nair@intel.com>,
	"prashant.khanzode@intel.com" <prashant.khanzode@intel.com>,
	"luiz.von.dentz@intel.com" <luiz.von.dentz@intel.com>
Subject: RE: [PATCH BlueZ] AVCTP: return not-implemented for unknown
 passthrough
Date: Tue, 28 Feb 2012 15:40:00 +0000
Message-ID: <2683478DEE33CD4DAF508ABCF391F6A40B415E18@DNCE02.ent.ti.com>
References: <CABBYNZL32nUYXTXTM1gCmRhGms5qGpW2uibyT5j5gDBow8Akiw@mail.gmail.com>
 <1330438817-23824-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1330438817-23824-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Lucas De Marchi
> Sent: Tuesday, February 28, 2012 4:20 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: luiz.dentz@gmail.com; sunil.a.kumar@intel.com; rashmi.g.nair@intel.com;
> prashant.khanzode@intel.com; luiz.von.dentz@intel.com; Lucas De Marchi
> Subject: [PATCH BlueZ] AVCTP: return not-implemented for unknown passthrough
> 
> ---
>  audio/avctp.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 5bd5db1..1d425eb 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -235,9 +235,12 @@ static size_t handle_panel_passthrough(struct avctp
> *session,
>  		break;
>  	}
> 
> -	if (key_map[i].name == NULL)
> +	if (key_map[i].name == NULL) {
>  		DBG("AV/C: unknown button 0x%02X %s",
>  						operands[0] & 0x7F, status);
> +		*code = AVC_CTYPE_NOT_IMPLEMENTED;
> +		return 0;

This line here is problematic in the current implementation you will reply with the wrong values at the AVRCP respond packet , when returning 0 you will truncated the Operands( State Flag , Operation Id and Operation Data Length) from the AVRCP reply.
You need to return with the operand_count this way you will include the full response at the AVRCP profile.

> +	}
> 
>  done:
>  	*code = AVC_CTYPE_ACCEPTED;
> --
> 1.7.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Thanks,

Malovany Ram

