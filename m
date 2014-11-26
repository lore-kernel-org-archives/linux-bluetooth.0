Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416999764-15300-1-git-send-email-rakesh.mk@samsung.com>
References: <1416999764-15300-1-git-send-email-rakesh.mk@samsung.com>
Date: Wed, 26 Nov 2014 16:16:11 +0200
Message-ID: <CABBYNZ+_oU6-VyZ-_3qiGB0cGTF-79PatRH+PVv+V8E4ZPUqPA@mail.gmail.com>
Subject: Re: [PATCH 1] obexd: Fix crash while session shutdown
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Rakesh M K <rakesh.mk@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 26, 2014 at 1:02 PM, Rakesh M K <rakesh.mk@samsung.com> wrote:
> g_str_equal has been used for the session path compare
> which is not NULL-safe. Used the g_strcmp0() for the NULL-Safe
> string comparision.
>
> *#0 strcmp (p1=0x0, p2=0x7105c "/org/bluez/obex/client/session0")
> *    at strcmp.c:38
> *#1  0xb6e0cd0a in g_str_equal (v1=<value optimized out>,
> *    v2=<value optimized out>) at ghash.c:1704
> *#2  0x000264d8 in find_session (connection=<value optimized out>,
> *    message=0x55b38, user_data=<value optimized out>)
> *    at obexd/client/manager.c:162
> *#3  remove_session (connection=<value optimized out>, message=0x55b38,
>     user_data=<value optimized out>) at obexd/client/manager.c:231
> ---
>  obexd/client/manager.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/obexd/client/manager.c b/obexd/client/manager.c
> index 8efe1f2..7ae111c 100644
> --- a/obexd/client/manager.c
> +++ b/obexd/client/manager.c
> @@ -157,7 +157,7 @@ static struct obc_session *find_session(const char *path)
>         for (l = sessions; l; l = l->next) {
>                 struct obc_session *session = l->data;
>
> -               if (g_str_equal(obc_session_get_path(session), path) == TRUE)
> +               if (g_strcmp0(obc_session_get_path(session), path) == 0)
>                         return session;
>         }
>
> --
> 1.7.9.5

Applied, thanks.


-- 
Luiz Augusto von Dentz
