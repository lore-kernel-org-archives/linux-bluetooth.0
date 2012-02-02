Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328182441-14892-1-git-send-email-jaganath.k@samsung.com>
References: <1328182441-14892-1-git-send-email-jaganath.k@samsung.com>
Date: Thu, 2 Feb 2012 09:29:01 -0800
Message-ID: <CABBYNZJYyqtD+0c6YYALx8bON3A_S3bXH29K07OFJcq=ZrJCOw@mail.gmail.com>
Subject: Re: [PATCH obexd 3/4] irmc: Fix length parameter of strncpy
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Feb 2, 2012 at 3:34 AM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> ---
>  plugins/irmc.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/plugins/irmc.c b/plugins/irmc.c
> index 6f28e51..8344a47 100644
> --- a/plugins/irmc.c
> +++ b/plugins/irmc.c
> @@ -215,9 +215,9 @@ static void *irmc_connect(struct obex_session *os, int *err)
>         * For now lets used hostname and some 'random' value
>         */
>        gethostname(irmc->did, DID_LEN);
> -       strncpy(irmc->sn, "12345", DID_LEN);
> -       strncpy(irmc->manu, "obex", DID_LEN);
> -       strncpy(irmc->model, "mymodel", DID_LEN);
> +       strncpy(irmc->sn, "12345", sizeof(irmc->sn) - 1);
> +       strncpy(irmc->manu, "obex", sizeof(irmc->manu) - 1);
> +       strncpy(irmc->model, "mymodel", sizeof(irmc->model) - 1);

Not sure what is the point to use a fixed size array here? Does the
spec require it to be 18 bytes long?

-- 
Luiz Augusto von Dentz
