Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309210781-2674-7-git-send-email-dmitriy.paliy@nokia.com>
References: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
	<1309210781-2674-7-git-send-email-dmitriy.paliy@nokia.com>
Date: Tue, 28 Jun 2011 10:59:47 +0300
Message-ID: <BANLkTikKq-9=+v9pnpg_wau0RqzwNYP4SA@mail.gmail.com>
Subject: Re: [PATCH 6/6] Code clean-up: remove unnecessary brackets
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitriy Paliy <dmitriy.paliy@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jun 28, 2011 at 12:39 AM, Dmitriy Paliy <dmitriy.paliy@gmail.com> wrote:
> ---
>  client/session.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index d8e3bf2..ae7e213 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -241,9 +241,8 @@ static void session_free(struct session_data *session)
>        if (session->path)
>                session_unregistered(session);
>
> -       if (session->conn) {
> +       if (session->conn)
>                dbus_connection_unref(session->conn);
> -       }
>
>        if (session->conn_system)
>                dbus_connection_unref(session->conn_system);
> --
> 1.7.4.1
>
>

This patch is fine, but I would like to suggest that we only include
in the series patches that depend on each other, this one we could
quickly apply without looking into the others. Btw, we started using
project names on the subject prefix to help identifying what project
the patch is for, you can do that by editing the .git/config where you
cloned the repository adding the following:

[format]
	subjectprefix = PATCH obexd


-- 
Luiz Augusto von Dentz
