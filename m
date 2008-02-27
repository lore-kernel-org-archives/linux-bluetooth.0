Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Feb 2008 15:49:10 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080227134910.GA26414@localhost>
References: <1204114452.25999.8.camel@greatbear>
MIME-Version: 1.0
In-Reply-To: <1204114452.25999.8.camel@greatbear>
Subject: Re: [Bluez-devel] [HFP][Patch] Plugin.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Alok,

Some comments below.

On Wed, Feb 27, 2008, Alok wrote:
> +	AC_ARG_ENABLE(plugin, AC_HELP_STRING([--enable-plugin], [enable telephony plugins]), [
> +		plugin_enable=${enableval}
> +	])
> +

Maybe --enable-hfp-plugin would be better since it's not clear what
plugin is in question.

> +if PLUGIN
> +plugindir = $(libdir)/bluetooth
> +
> +plugin_LTLIBRARIES = hfp_plugin_test.la
> +
> +hfp_plugin_test_la_SOURCES = hfp_plugin_test.c hfp_plugin.h
> +hfp_plugin_test_la_LDFLAGS = -module
> +hfp_plugin_test_la_LIBADD = @GLIB_LIBS@
> +hfp_plugin_test_la_CFLAGS = @GLIB_CFLAGS@
> +endif

Isn't there rist that these files get left out of "make dist" if you
didn't give --enable-plugin to configure?

> +int load_hfp_plugin(GKeyFile *config)
> +{
> +	gchar *str = NULL;
> +	GError *err = NULL;
> +	char filename[PATH_MAX];
> +
> +        str = g_key_file_get_string(config, "Headset", "Plugin", &err);

Incorrect indentation and missing check for config == NULL

> +	if (load_hfp_plugin(config) < 0)
> +		return -1;


I think we should keep the current policy that the audio service gets
run successfully with some sane set of defaults if there is no audio.conf
present in the filesystem. This change looks like it will make the audio
service fail either if audio.conf doesn't exist or if it doesn't contain
a Plugin entry.

> --- audio/unix.c	8 Feb 2008 17:43:48 -0000	1.64
> +++ audio/unix.c	26 Feb 2008 15:19:44 -0000
> @@ -36,10 +36,11 @@
>  
>  #include <bluetooth/bluetooth.h>
>  #include <bluetooth/sdp.h>
>  #include <dbus/dbus.h>
>  #include <glib.h>
> +#include <gmodule.h>

Why do you need to add this include since there are no other changes to
this file in your patch?

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
