Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50E03F0D.6020605@gmail.com>
References: <50E03F0D.6020605@gmail.com>
Date: Sun, 30 Dec 2012 16:28:58 +0200
Message-ID: <CABBYNZJTCf9eiVm10SoLRDQ870ayt00Eiz=szXEb1fhktWyHcQ@mail.gmail.com>
Subject: Re: SEGFAULT in obexd manager.c:find_session
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Zawiejski <dragmz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Sun, Dec 30, 2012 at 3:18 PM, Marcin Zawiejski <dragmz@gmail.com> wrote:
> Hi, I think there is a bug in obexd in manager.c:find_session function.
>
> What happens here is a segfault when manager.c:find_session calls
> g_str_equal(obc_session_get_path(session), path). This is caused by the
> sessions list having a session with a NULL path.
>
> Basically when I call manager.c:create_session, the session created there is
> added to sessions list but it has a NULL path until the
> manager.c:create_callback is called.
>
> However the manager.c:create_callback is not called at all if the remote
> device refuses the connection. So when manager.c:find_session is called, it
> actually calls the g_str_equal(NULL, path) causing the segfault.
>
> This might be simply fixed by modifying the manager.c:find_session to check
> for a NULL session path before calling g_str_equal(...).
>
> The problem is reproducible by having two sessions, with one awaiting
> connection and another one with an active file transfer. When the file
> transfer errors and I call org.bluez.obex.Client1 RemoveSession then the
> obexd segfaults since the session awaiting connection has a NULL path.
>
> I'm not sure if the session with a NULL path should be on the sessions list
> or not. If its okay, then here's a simple patch for the
> manager.c:find_session function:
>
> ---
> diff --git a/obexd/client/manager.c b/obexd/client/manager.c
> index 8f62a30..28b890c 100644
> --- a/obexd/client/manager.c
> +++ b/obexd/client/manager.c
> @@ -142,8 +142,9 @@ static struct obc_session *find_session(const char
> *path)
>
>         for (l = sessions; l; l = l->next) {
>                 struct obc_session *session = l->data;
> +               const char *session_path = obc_session_get_path(session);
>
> -               if (g_str_equal(obc_session_get_path(session), path) ==
> TRUE)
> +               if (session_path != NULL && g_str_equal(session_path, path)
> == TRUE)
>                         return session;
>         }
> ---

You can use g_strcmp0 which checks for NULL, gonna take a look why the
session path is NULL perhaps we should not even add to the session
list until the connection completes and it is properly registered.


--
Luiz Augusto von Dentz
