Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329143945-4934-3-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329143945-4934-3-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 14 Feb 2012 11:16:06 +0200
Message-ID: <CABBYNZK+AD+62MRVwaRqSxEuu81DO7KETkPzX8dP=R6WUHpDFg@mail.gmail.com>
Subject: Re: [PATCH obexd 3/6] client: fix incorrect error check
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Feb 13, 2012 at 4:39 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Previous statement always returned success.
> ---
>  client/pbap.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/client/pbap.c b/client/pbap.c
> index 4910536..c58557d 100644
> --- a/client/pbap.c
> +++ b/client/pbap.c
> @@ -301,7 +301,7 @@ static gboolean pbap_setpath(struct pbap_data *pbap, const char *location,
>        }
>
>        obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap, err);
> -       if (err != NULL) {
> +       if (*err == NULL) {
>                g_free(pbap->path);
>                pbap->path = path;
>                return TRUE;
> --
> 1.7.6.5

Nice catch, ack.

-- 
Luiz Augusto von Dentz
