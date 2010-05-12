Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Initial support for MCAP
From: Santiago Carot-Nemesio <scarot@libresoft.es>
To: Raul Herbster <raul.herbster@signove.com>
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTikVs1YfnusOO8sRO9xbbOcZNU6STTlkygFvpNv3@mail.gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
	 <1273571962-3558-1-git-send-email-sancane@gmail.com>
	 <1273572070.2126.30.camel@mosquito>
	 <AANLkTikVs1YfnusOO8sRO9xbbOcZNU6STTlkygFvpNv3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 May 2010 10:45:38 +0200
Message-ID: <1273653938.1997.33.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raul,
This patch is applied over a old version of MCAP (first that I sent).
New version (splited in 25 patches) fix more of typo error that you are
commented and Gustavo already notified.

El mar, 11-05-2010 a las 19:00 -0300, Raul Herbster escribió:
> Hi Santiago,
> 
> only typo errors:
> 
> diff --git a/mcap/mcap.c b/mcap/mcap.c
> index 404d7be..6142938 100644
> --- a/mcap/mcap.c
> +++ b/mcap/mcap.c
> @@ -116,7 +116,7 @@ struct mcap_mcl {
>  #define    MCAP_CTRL_CACHED    0x01    /* MCL is cached */
>  #define    MCAP_CTRL_STD_OP    0x02    /* Support for standard op
> codes */
>  #define    MCAP_CTRL_SYNC_OP    0x04    /* Support for
> synchronization commands */
> -#define    MCAP_CTRL_CONN        0x08    /* MCL is in connectcting
> process */
> +#define    MCAP_CTRL_CONN        0x08    /* MCL is in connecting
> process */

This error is already fixed in my previous patch. Be careful, above
definitions are not yet included in mcap.c, update you work tree from
latest patches ;)

>  #define    MCAP_CTRL_FREE        0x10    /* MCL is marked as
> releasable */
>  #define    MCAP_CTRL_NOCACHE    0x20    /* MCL is marked as not
> cacheable */
>  
> @@ -242,7 +242,7 @@ static char *error2str(uint8_t rc)
>          return "Invalid Operation";
>      case MCAP_RESOURCE_UNAVAILABLE:
>          return "Resource Unavailable";
> -    case MCAP_UNESPECIFIED_ERROR:
> +    case MCAP_UNSPECIFIED_ERROR:

You're right, I'll redo the patch to fix all "UNESPECIFIED" erroneous
word.

>          return "Unspecified Error";
>      case MCAP_REQUEST_NOT_SUPPORTED:
>          return "Request Not Supported";
> @@ -1056,8 +1056,8 @@ static void process_md_create_mdl_req(struct
> mcap_mcl *mcl, uint8_t *cmd, uint32
>      if ((cfga != 0) && (cfga != conf)) {
>          /* Remote device set default configuration but upper profile
> */
>          /* has changed it. Protocol Error: force closing the MCL by
> */
> -        /* remote device using UNESPECIFIED_ERROR response */
> -        send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP,
> MCAP_UNESPECIFIED_ERROR,
> +        /* remote device using UNSPECIFIED_ERROR response */
> +        send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP,
> MCAP_UNSPECIFIED_ERROR,
>                                  mdl_id);
>          return;
>      }
> @@ -1548,13 +1548,13 @@ static gboolean check_rsp(struct mcap_mcl
> *mcl, uint8_t *cmd, uint32_t len)
>          return FALSE;
>      }
>  
> -    if (rsp->rc == MCAP_UNESPECIFIED_ERROR)
> +    if (rsp->rc == MCAP_UNSPECIFIED_ERROR)
>          goto close_mcl;
>  
>      return TRUE;
>  close_mcl:
> -    if (rsp->rc == MCAP_UNESPECIFIED_ERROR)
> -        g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_UNESPECIFIED_ERROR,
> +    if (rsp->rc == MCAP_UNSPECIFIED_ERROR)
> +        g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_UNSPECIFIED_ERROR,
>                          "%s", error2str(rsp->rc));
>      else
>          g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
> diff --git a/mcap/mcap.h b/mcap/mcap.h
> index 598e6ce..77c83c2 100644
> --- a/mcap/mcap.h
> +++ b/mcap/mcap.h
> @@ -76,7 +76,7 @@ extern "C" {
>  #define MCAP_MDL_BUSY            0x06
>  #define MCAP_INVALID_OPERATION        0x07
>  #define MCAP_RESOURCE_UNAVAILABLE    0x08
> -#define MCAP_UNESPECIFIED_ERROR        0x09
> +#define MCAP_UNSPECIFIED_ERROR        0x09
>  #define MCAP_REQUEST_NOT_SUPPORTED    0x0A
>  #define MCAP_CONFIGURATION_REJECTED    0x0B
>  /*RESERVED                0x0C-0xFF*/
> diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
> index fd3eb74..d75e0f0 100644
> --- a/mcap/mcap_lib.h
> +++ b/mcap/mcap_lib.h
> @@ -45,7 +45,7 @@ typedef enum {
>      MCAP_ERROR_MDL_BUSY,
>      MCAP_ERROR_INVALID_OPERATION,
>      MCAP_ERROR_RESOURCE_UNAVAILABLE,
> -    MCAP_ERROR_UNESPECIFIED_ERROR,
> +    MCAP_ERROR_UNSPECIFIED_ERROR,
>      MCAP_ERROR_REQUEST_NOT_SUPPORTED,
>      MCAP_ERROR_CONFIGURATION_REJECTED,
>  /* MCAP Internal Errors */
> @@ -79,7 +79,7 @@ typedef void (* mcap_mdl_operation_cb) (struct
> mcap_mdl *mdl, GError *err,
>                          gpointer data);
>  typedef void (* mcap_mdl_del_cb) (GError *err, gpointer data);
>  
> -/* Next function should return an MCAP appropiate response code */
> +/* Next function should return an MCAP appropriate response code */

Ok, we don't see that. I'll change it too.

>  typedef uint8_t (* mcap_remote_mdl_conn_req_cb) (struct mcap_mcl
> *mcl,
>                          uint8_t mdepid, uint16_t mdlid,
>                          uint8_t *conf, gpointer data);
> 
> 
> []' s
> --Raul
> 

Thanks fore typo errors but I suggest to you work with latest patches I
sent 2 days ago.

Regards.

