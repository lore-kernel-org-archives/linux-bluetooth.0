Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1497262768-4988-1-git-send-email-nsathish41@gmail.com>
References: <1497262768-4988-1-git-send-email-nsathish41@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Jun 2017 11:29:47 +0300
Message-ID: <CABBYNZKKpTHXCGb+rgs2iywvu90P234GGUmHMp=ZONqgSvN=1A@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ 1/2] obexd/map: Do not send parent folder in dummy
To: Sathish N <nsathish41@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sathish,

On Mon, Jun 12, 2017 at 1:19 PM,  <nsathish41@gmail.com> wrote:
> From: Sathish Narasimman <sathish.narasimman@intel.com>
>
> In messages-dummy it is not necessary to add parent folder in the
> response to folder-lisintg. when tested with some carkit the present
> method is not working when navigating to different folders. so removing
> it.
> ---
>  obexd/plugins/messages-dummy.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
> index 765f08d..33056e2 100644
> --- a/obexd/plugins/messages-dummy.c
> +++ b/obexd/plugins/messages-dummy.c
> @@ -155,16 +155,6 @@ static void return_folder_listing(struct folder_listing_data *fld, GSList *list)
>         uint16_t num = 0;
>         uint16_t offs = 0;
>
> -       /* XXX: This isn't really documented for MAP. I need to take a look how
> -        * other implementations choose to deal with parent folder.
> -        */
> -       if (session->cwd[0] != 0 && fld->offset == 0) {
> -               num++;
> -               fld->callback(session, -EAGAIN, 0, "..", fld->user_data);
> -       } else {
> -               offs++;
> -       }
> -
>         for (cur = list; offs < fld->offset; offs++) {
>                 cur = cur->next;
>                 if (cur == NULL)
> --
> 2.7.4

Applied, thanks.

-- 
Luiz Augusto von Dentz
