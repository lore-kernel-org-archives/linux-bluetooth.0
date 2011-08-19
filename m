Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313698203-13201-5-git-send-email-padovan@profusion.mobi>
References: <1313698203-13201-1-git-send-email-padovan@profusion.mobi>
	<1313698203-13201-2-git-send-email-padovan@profusion.mobi>
	<1313698203-13201-3-git-send-email-padovan@profusion.mobi>
	<1313698203-13201-4-git-send-email-padovan@profusion.mobi>
	<1313698203-13201-5-git-send-email-padovan@profusion.mobi>
Date: Fri, 19 Aug 2011 10:34:56 +0300
Message-ID: <CABBYNZ+a9hQhqpDWc428RJZXyKCEJA--mX+886_HBGgyFKk+YA@mail.gmail.com>
Subject: Re: [PATCH 5/5] serial: Add support to Disconnect fd passing connections
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Aug 18, 2011 at 11:10 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> -       port_release(port);
> +       if (port->fd_passing == TRUE) {
> +               int sk = g_io_channel_unix_get_fd(port->io);
> +               shutdown(sk, SHUT_RDWR);
> +
> +               g_io_channel_unref(port->io);
> +               port->io = NULL;
> +       }

How about moving this code inside port_release? It is probably
necessary to always call shutdown if we really want to make sure the
port is release, so even if the sender disconnects from bus it doesn't
mean it has released its reference, the fd may be passed again
(unlikely but possible) to another process.

-- 
Luiz Augusto von Dentz
