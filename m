Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Mar 2014 10:49:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v5 09/16] gdbus: Add g_dbus_proxy_set_property_array
Message-ID: <20140321084928.GC5834@t440s.lan>
References: <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395174391-27251-10-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395174391-27251-10-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Mar 18, 2014, Claudio Takahasi wrote:
> This patch adds a new gdbus utility function to allow setting a property
> of fixed, and non-fixed values array.
> ---
>  gdbus/client.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  gdbus/gdbus.h  |  5 ++++
>  2 files changed, 90 insertions(+)
> 
> diff --git a/gdbus/client.c b/gdbus/client.c
> index 5193b6c..6fea3d9 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -727,6 +727,91 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
>  	return TRUE;
>  }
>  
> +gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
> +				const char *name, int type, const void *value,
> +				int size, GDBusResultFunction function,
> +				void *user_data, GDBusDestroyFunction destroy)

Would size_t make more sense for the size parameter? Can it be negative
(in which case maybe ssize_t)?

Johan
