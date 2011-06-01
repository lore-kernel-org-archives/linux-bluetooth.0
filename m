Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 14:52:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 3/4] Coding style cleanup in sap server
Message-ID: <20110601115208.GC26952@dell.ger.corp.intel.com>
References: <1306838810-18325-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1306838810-18325-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306838810-18325-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Tue, May 31, 2011, Waldemar Rymarkiewicz wrote:
> ---
>  sap/server.c |   23 +++++++++++------------
>  1 files changed, 11 insertions(+), 12 deletions(-)

All four patches have been pushed upstream, but before that I fixed the
following issues with this patch:

> -	bt_io_get(io, BT_IO_RFCOMM, &gerr,
> -			BT_IO_OPT_SOURCE_BDADDR, &src,
> -			BT_IO_OPT_DEST_BDADDR, &dst,
> -			BT_IO_OPT_INVALID);
> +	bt_io_get(io, BT_IO_RFCOMM, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
> +			BT_IO_OPT_DEST_BDADDR, &dst, BT_IO_OPT_INVALID);
> +

Readability trumps strict coding style adherence here, so it's fine if
each op_opt is on its own line.

>  	if (!g_dbus_register_interface(connection, path, SAP_SERVER_INTERFACE,
> -				server_methods, server_signals, NULL,
> -				server, destroy_sap_interface)) {
> +			server_methods, server_signals, NULL, server,
> +			destroy_sap_interface)) {

The idea is to try to have each continuation line past the opening ( of
the g_dbus_register_interface function call if possible while keeping
the lines under 80 charcters, so the existing split is fine except that
it can be indented by one more tab.

Johan
