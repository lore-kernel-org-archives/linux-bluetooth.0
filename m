Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 14:36:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash when HDP first reliable channel is nil
Message-ID: <20120327113651.GF14481@x220>
References: <1331938389-4856-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1331938389-4856-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

On Fri, Mar 16, 2012, Elvis Pfützenreuter wrote:
> Congruent to health_channel_destroy(), the "/" path is returned by MainChannel
> property of HealthDevice when the first reliable channel is nil.
> 
> An empty path provokes the following error:
> 
> process xxxs: arguments to dbus_message_iter_append_basic() were incorrect,
> assertion "_dbus_check_is_valid_path (*string_p)" failed in file
> ../../dbus/dbus-message.c line 2539.  This is normally a bug in some
> application using the D-Bus library.
> ---
>  health/hdp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/health/hdp.c b/health/hdp.c
> index 812352f..eba438a 100644
> --- a/health/hdp.c
> +++ b/health/hdp.c
> @@ -2077,7 +2077,7 @@ static DBusMessage *device_get_properties(DBusConnection *conn,
>  	if (device->fr != NULL)
>  		path = g_strdup(device->fr->path);
>  	else
> -		path = g_strdup("");
> +		path = g_strdup("/");
>  	dict_append_entry(&dict, "MainChannel", DBUS_TYPE_OBJECT_PATH, &path);
>  	g_free(path);
>  	dbus_message_iter_close_container(&iter, &dict);

Would it maybe make more sense to simply not include this property in
the property list if device->fr is NULL? (after all, there's nothing
interesting to be found at "/" from a HDP perspective)

Johan
