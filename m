Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1449070602.4523.12.camel@tecnocode.co.uk>
References: <1449070602.4523.12.camel@tecnocode.co.uk>
Date: Fri, 4 Dec 2015 14:32:59 +0200
Message-ID: <CABBYNZJdJjU+kfMJd7XC4+6NoFDjRB9MtStNYmkG+FXVv8ed3g@mail.gmail.com>
Subject: Re: [PATCH] gdbus: Drop message replies if the sender requested no reply
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Philip Withnall <philip.withnall@collabora.co.uk>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Philip,

On Wed, Dec 2, 2015 at 5:36 PM, Philip Withnall
<philip.withnall@collabora.co.uk> wrote:
> If the sender flags a D-Bus message as not expecting a reply, it is
> against system bus policy to send a reply — sending one will result in
> errors being sent to us by dbus-daemon.
>
> Magically drop all replies to messages which request no reply.
>
> ofonod is one process which sends BlueZ messages which request no
> reply,
> when it is setting up a hands-free agent.
>
> This is not a complete fix. In an ideal world, the existing check for
> G_DBUS_METHOD_FLAG_NOREPLY would be dropped, as the server should be
> prepared to return a reply to every method, if the client requests and
> expects one — otherwise the client will time out. However, that’s a
> much
> bigger change with a much bigger risk of breaking things, so I’ll stick
> with this for now.
>
> Signed-off-by: Philip Withnall <philip.withnall@collabora.co.uk>
> Reviewed-by: Simon McVittie <simon.mcvittie@collabora.co.uk>
> ---
>  gdbus/object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 4cf2e2f..945dbdb 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -258,7 +258,8 @@ static DBusHandlerResult
> process_message(DBusConnection *connection,
>
>         reply = method->function(connection, message,
> iface_user_data);
>
> -       if (method->flags & G_DBUS_METHOD_FLAG_NOREPLY) {
> +       if (method->flags & G_DBUS_METHOD_FLAG_NOREPLY ||
> +           dbus_message_get_no_reply(message)) {
>                 if (reply != NULL)
>                         dbus_message_unref(reply);
>                 return DBUS_HANDLER_RESULT_HANDLED;
> --
> 2.5.0

I fixed the coding style and remove Signed-off-by/Reviewed-By as those
are not used in userspace.


-- 
Luiz Augusto von Dentz
