Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Mar 2010 12:12:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] Set voice_call.watch in correct way
Message-ID: <20100325101223.GA25089@jh-x301>
References: <1269534610-1138-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1269534610-1138-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

On Thu, Mar 25, 2010, Forrest Zhao wrote:
> It was set wrongly to device_watch.
> ---
>  audio/telephony-ofono.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
> index c19e6ee..45c3905 100644
> --- a/audio/telephony-ofono.c
> +++ b/audio/telephony-ofono.c
> @@ -850,7 +850,7 @@ static gboolean handle_vcmanager_property_changed(DBusConnection *conn,
>  			vc_new = g_new0(struct voice_call, 1);
>  			vc_new->obj_path = g_strdup(vc_obj_path);
>  			calls = g_slist_append(calls, vc_new);
> -			device_watch = g_dbus_add_signal_watch(connection,
> +			vc_new->watch = g_dbus_add_signal_watch(connection,
>  					NULL, vc_obj_path,
>  					OFONO_VC_INTERFACE,
>  					"PropertyChanged",

Pushed upstream. Thanks.

Johan
