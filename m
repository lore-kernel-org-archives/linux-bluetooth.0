Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382000128-23762-8-git-send-email-luiz.dentz@gmail.com>
References: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
	<1382000128-23762-8-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 17 Oct 2013 06:57:29 -0400
Message-ID: <CAJdJm_MNvbK7XaLaapeE_rR4fTxsENjoNouBqx2eLXBOkaTfsQ@mail.gmail.com>
Subject: Re: [RFC 7/9] android: Fix building with local cutils/log.h
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 17, 2013 at 4:55 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> android/hal_bt_sock.c: In function 'btsock_listen_rfcomm':
> android/hal_bt_sock.c:30:47: error: expected ')' before '__func__'
>   ALOGD(__func__);

You can implement ALOGD() using vfprintf() (just like DBG(), but which
uses vsyslog() instead) and avoid this commit.

> ---
>  android/hal_bluetooth.c | 52 ++++++++++++++++++++++++-------------------------
>  android/hal_bt_sock.c   |  2 +-
>  2 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
> index 9bb9dcf..cf8f3ae 100644
> --- a/android/hal_bluetooth.c
> +++ b/android/hal_bluetooth.c
> @@ -44,7 +44,7 @@ static bool start_bt_daemon(void)
>  {
>         int tries = 40; /* wait 4 seconds for completion */
>
> -       ALOGD(__func__);
> +       ALOGD("%s",__func__);

In any case, several lines here are missing the space after ",".

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
