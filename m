Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 23:30:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] SAP: Fix not unregistering dummy interface on exit
Message-ID: <20120503203028.GA21259@x220.P-661HNU-F1>
References: <1336056083-21126-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336056083-21126-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, May 03, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Dummy interface is registered on plugin init and is never unregistered
> ---
>  sap/sap-dummy.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
> index acdec77..3060dde 100644
> --- a/sap/sap-dummy.c
> +++ b/sap/sap-dummy.c
> @@ -340,6 +340,8 @@ int sap_init(void)
>  
>  void sap_exit(void)
>  {
> +	g_dbus_unregister_interface(connection, SAP_DUMMY_PATH, SAP_DUMMY_IFACE);
> +
>  	dbus_connection_unref(connection);
>  	connection = NULL;
>  }

Applied, but I had to first fix the line you're adding since it was over
80 characters.

Johan
