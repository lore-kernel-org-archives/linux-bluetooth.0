Return-Path: <cyrus@holtmann.org>
Date: Fri, 18 May 2012 14:38:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Fix A2DP Sink/Source recognition
Message-ID: <20120518113811.GA1375@x220.P-661HNU-F1>
References: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chanyeol,

On Fri, May 18, 2012, chanyeol.park@samsung.com wrote:
> From: Chan-yeol Park <chanyeol.park@samsung.com>
> 
> ---
>  audio/a2dp.c     |    8 ++++----
>  audio/audio.conf |    2 +-
>  audio/manager.c  |    4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/audio/a2dp.c b/audio/a2dp.c
> index cc8f139..145dcf6 100644
> --- a/audio/a2dp.c
> +++ b/audio/a2dp.c
> @@ -1406,9 +1406,9 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
>  		g_clear_error(&err);
>  	} else {
>  		if (strstr(str, "Sink"))
> -			source = TRUE;
> -		if (strstr(str, "Source"))
>  			sink = TRUE;
> +		if (strstr(str, "Source"))
> +			source = TRUE;
>  		if (strstr(str, "Socket"))
>  			socket = TRUE;
>  		g_free(str);
> @@ -1421,9 +1421,9 @@ int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
>  		g_clear_error(&err);
>  	} else {
>  		if (strstr(str, "Sink"))
> -			source = FALSE;
> -		if (strstr(str, "Source"))
>  			sink = FALSE;
> +		if (strstr(str, "Source"))
> +			source = FALSE;
>  		if (strstr(str, "Socket"))
>  			socket = FALSE;
>  		g_free(str);

This doesn't look right to me. The config file values have (for
historical reasons) been referring to the remote device object D-Bus
interface names whereas these gboolean variables are used to determine
what kind of local stream endpoints need to be registered. So having
e.g. support for "Source" on a remote device requires registering a
local sink stream endpoint.

Johan
