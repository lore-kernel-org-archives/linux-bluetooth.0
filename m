Return-Path: <cyrus@holtmann.org>
Date: Sat, 18 Aug 2012 15:28:16 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH BlueZ v3 09/15] gdbus: Group interface changes to reduce
 the amount of signals emitted
Message-ID: <20120818182815.GC30527@echo>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1345272662-2850-10-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345272662-2850-10-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 03:50 Sat 18 Aug, Lucas De Marchi wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> InterfacesAdded and InterfacesRemoved can group all the interfaces
> changes together in one message.
> ---
>  gdbus/object.c | 363 +++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 209 insertions(+), 154 deletions(-)
> 
>  

[snip]

>  static struct interface_data *find_interface(GSList *interfaces,
> @@ -440,6 +495,7 @@ static struct interface_data *find_interface(GSList *interfaces,
>  
>  	for (list = interfaces; list; list = list->next) {
>  		struct interface_data *iface = list->data;
> +

Seems I have a special talent for spotting these things (on others patches
;-)) 

>  		if (!strcmp(name, iface->name))
>  			return iface;
>  	}
> @@ -468,45 +524,37 @@ static gboolean g_dbus_args_have_signature(const GDBusArgInfo *args,
>  	return TRUE;
>  }


Cheers,
-- 
Vinicius
