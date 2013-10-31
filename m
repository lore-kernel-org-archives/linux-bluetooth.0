Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1383233152-15040-5-git-send-email-szymon.janc@tieto.com>
References: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
	<1383233152-15040-5-git-send-email-szymon.janc@tieto.com>
Date: Thu, 31 Oct 2013 20:27:00 +0200
Message-ID: <CABBYNZKFoBBZLCbbm6ceNLozKtXY7SrdnqWE+Ogju5_pGhn1Ug@mail.gmail.com>
Subject: Re: [PATCH 5/5] android: Pass found uuids to remote_device_properties_cb
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Oct 31, 2013 at 5:25 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> From: Marcin Kraglak <marcin.kraglak@tieto.com>
>
> Change-Id: I21221033cf3510113b4014bdacb64e25b7d16ba9

Im not sure where this came from but it probably doesn't mean anything to us.

> ---
>  android/adapter.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/android/adapter.c b/android/adapter.c
> index 48e5e95..3d3cd72 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -1242,9 +1242,89 @@ static void browse_req_free(struct browse_req *req)
>         g_free(req);
>  }
>
> +static void fill_uuids(GSList *list, void *buf)
> +{
> +       int i, len = g_slist_length(list);
> +
> +       for (i = 0; i < len; i++) {
> +               memcpy(buf, g_slist_nth_data(list, i), sizeof(uint128_t));

Ok, this is highly inefficient since afaik g_slist_nth_data will
iterate in the list for every index, please use g_slist_foreach or
iterate with g_slist_next or ->next.



-- 
Luiz Augusto von Dentz
