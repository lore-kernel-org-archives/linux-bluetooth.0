Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337940693-3417-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1337940693-3417-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Fri, 25 May 2012 13:35:52 +0300
Message-ID: <CABBYNZ+HiG58wPbXkgikR_7m9APwQLYn4E6VhzBdcbmSVPGc6Q@mail.gmail.com>
Subject: Re: [PATCH obexd v1 03/16] client: Add progress property to transfer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, May 25, 2012 at 1:11 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:

> +static void transfer_notify_progress(struct obc_transfer *transfer)
> +{
> +       gint64 now;
> +       gint64 notify;
> +
> +       DBG("Transfer %p progress: %lu bytes", transfer, transfer->transferred);
> +
> +       if (transfer->path == NULL)
> +               return;
> +
> +       if (transfer->transferred == transfer->transferred_dbus)
> +               return;
> +
> +       now = g_get_monotonic_time();
> +       notify = transfer->transferred_dbus_time +
> +                                               TRANSFER_PROGRESS_PERIOD * 1000;
> +
> +       if ((transfer->transferred != transfer->size) && (now < notify))
> +               return;
> +
> +       transfer->transferred_dbus = transfer->transferred;
> +       transfer->transferred_dbus_time = now;
> +
> +       obex_dbus_signal_property_changed(transfer->conn,
> +                                               transfer->path,
> +                                               TRANSFER_INTERFACE, "Progress",
> +                                               DBUS_TYPE_INT64,
> +                                               &transfer->transferred_dbus);
> +}

I would suggest doing it in a different manner using
g_timeout_add_seconds and storing the id, so you just need to know if
the timer is running by checking the id, if there is no timer running
you start it, if there is you just update the bytes transferred and
wait the timeout to be fired where you emit the signal. If in the
meantime the transfer is completed you just have to cleanup using
g_source_remove, this should be simpler because you don't have to
bother how much time has passed on every packet.

-- 
Luiz Augusto von Dentz
