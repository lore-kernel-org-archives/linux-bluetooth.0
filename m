Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jun 2012 10:39:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] gdbus: Fix removal of filter after last
 filter_data
Message-ID: <20120628073950.GB32563@x220>
References: <CABBYNZ+oS3tGhYVY01uE6gfuzmA94TqV3YybgHdG83pCMzW8vA@mail.gmail.com>
 <1340639082-10347-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340639082-10347-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Jun 25, 2012, Lucas De Marchi wrote:
> If there's a signal watch that's also watching for name
> (data->name_watch) currently we are trying to remove the message_filter
> twice since we may have the following call chain:
> 
> filter_data_remove_callback()
>   filter_data_free()
>     g_dbus_remove_watch()
>       filter_data_remove_callback()
> 	filter_data_free()
>         dbus_connection_remove_filter()
>   dbus_connection_remove_filter()
> 
> Because of this we can't currently watch for signals passing the bus
> name. After this patch we don't have this issue anymore.
> 
> We fix it by removing the filter before calling filter_data_free() if we
> are the last filter_data and thus avoid calling
> dbus_connection_remove_filter() twice.
> ---
>  gdbus/watch.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

I've applied this first patch to bluez.git and obexd.git. I ignored the
other too since the telephony drivers and the maemo6 plugin are just
about to be removed from the tree in preparation for BlueZ 5.

Johan
