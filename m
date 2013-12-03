Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386063385-31263-1-git-send-email-luiz.dentz@gmail.com>
References: <1386063385-31263-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 3 Dec 2013 07:24:11 -0400
Message-ID: <CAJdJm_M5nf5L-efYVtY-4UYT2S4JRypGKYgu7PoVOz9DFxBS6g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/AVCTP: Fix crash
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Dec 3, 2013 at 5:36 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -1488,7 +1488,7 @@ static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
>         tmp = g_slist_copy(chan->processed);
>
>         /* Find first unused transaction id */
> -       for (l = tmp; l; l = l->next) {
> +       for (l = tmp; l; l = g_slist_next(l)) {

Are you sure this fixes the problem? AFAIK g_list_next() will still
access invalid memory unless the "next" pointer is saved *before* the
current entry is freed. See e.g. remove_temp_devices() in
src/adapter.c.

>                 struct avctp_pending_req *req = l->data;
>
>                 if (req->transaction == chan->transaction) {

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
