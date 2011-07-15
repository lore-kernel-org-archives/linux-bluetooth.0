Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1310729911-12075-1-git-send-email-arkadiusz.lichwa@tieto.com>
References: <1310729911-12075-1-git-send-email-arkadiusz.lichwa@tieto.com>
Date: Fri, 15 Jul 2011 15:13:44 +0300
Message-ID: <CABBYNZL1-GBi+DUHVR+WsnFDsLwDVYCvsbXPw0kMtDZ3Fcjhsw@mail.gmail.com>
Subject: Re: [PATCH] Fix mem leak in sap plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arek Lichwa <arkadiusz.lichwa@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 15, 2011 at 2:38 PM, Arek Lichwa <arkadiusz.lichwa@tieto.com> wrote:
> When dropping rfcomm channel to sap server, the component's channel
> cleanup process doesn't release assigned glib channel resources.
> ---
>  sap/server.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/sap/server.c b/sap/server.c
> index c55aa6e..8bd8fe1 100644
> --- a/sap/server.c
> +++ b/sap/server.c
> @@ -1122,7 +1122,6 @@ static void sap_io_destroy(void *data)
>                                conn->state == SAP_STATE_GRACEFUL_DISCONNECT)
>                        sap_disconnect_req(NULL, 1);
>
> -               conn->io = NULL;
>                sap_conn_remove(conn);
>        }
>  }
> --
> 1.7.6

It doesn't seems this release any memory, maybe the problem is not a
memory leak but an invalid access to freed memory?

-- 
Luiz Augusto von Dentz
