Return-Path: <cyrus@holtmann.org>
Message-ID: <1343797305.1803.80.camel@aeonflux>
Subject: Re: [PATCH 1/1] build: Remove gstreamer pkg config warning
From: Marcel Holtmann <marcel@holtmann.org>
To: chanyeol.park@samsung.com
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 31 Jul 2012 22:01:45 -0700
In-Reply-To: <1343797204-1202-1-git-send-email-chanyeol.park@samsung.com>
References: <1343797204-1202-1-git-send-email-chanyeol.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> From: Chan-yeol Park <chanyeol.park@samsung.com>
> 
> GSTREAMER is not mandatory option when bluez build.
> ---
>  acinclude.m4 |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/acinclude.m4 b/acinclude.m4
> index 6505ad3..6e3eb83 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -106,8 +106,9 @@ AC_DEFUN([AC_PATH_GLIB], [
>  ])
>  
>  AC_DEFUN([AC_PATH_GSTREAMER], [
> -	PKG_CHECK_MODULES(GSTREAMER, gstreamer-0.10 >= 0.10.30 gstreamer-plugins-base-0.10, gstreamer_found=yes,
> -				AC_MSG_WARN(GStreamer library version 0.10.30 or later is required);gstreamer_found=no)
> +	PKG_CHECK_MODULES(GSTREAMER,
> +                        gstreamer-0.10 >= 0.10.30 gstreamer-plugins-base-0.10,
> +                        gstreamer_found=yes, gstreamer_found=no)
>  	AC_SUBST(GSTREAMER_CFLAGS)
>  	AC_SUBST(GSTREAMER_LIBS)
>  	GSTREAMER_PLUGINSDIR=`$PKG_CONFIG --variable=pluginsdir gstreamer-0.10`

as discussed during the BlueZ meeting, we will be removing GStreamer
support for BlueZ and submit it GStreamer. The prerequisite of the
standalone SBC library has been released yesterday. 

So NAK on this patch since soon it will not be needed anymore.

Regards

Marcel


