Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313698203-13201-3-git-send-email-padovan@profusion.mobi>
References: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
	<1313698203-13201-2-git-send-email-padovan@profusion.mobi>
	<1313698203-13201-3-git-send-email-padovan@profusion.mobi>
Date: Fri, 19 Aug 2011 10:13:16 +0300
Message-ID: <CABBYNZ+x_FjfZApEVTWNwacp_+0=aBLBW8wGA=-QJby5LcX5mQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] serial: use port->msg to track rfcomm connection procedure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Aug 18, 2011 at 11:10 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
>
> Use port->msg has the same effect of using port->io.
> ---
>  serial/port.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/serial/port.c b/serial/port.c
> index 3f041a6..bc4b4ea 100644
> --- a/serial/port.c
> +++ b/serial/port.c
> @@ -149,7 +149,7 @@ static int port_release(struct serial_port *port)
>        int err = 0;
>
>        if (port->id < 0) {
> -               if (port->io) {
> +               if (port->msg) {
>                        g_io_channel_shutdown(port->io, TRUE, NULL);
>                        g_io_channel_unref(port->io);
>                        port->io = NULL;

They may have the same effect but I would maintain the current one
since we are only using port->io and changing it to port->msg may be
unclear when reading the code without knowing the behavior.

-- 
Luiz Augusto von Dentz
