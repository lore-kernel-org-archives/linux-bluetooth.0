Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Feb 2011 16:13:38 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Add an initial interactive mode to gatttool
Message-ID: <20110214181338.GG2597@joana>
References: <20110209212642.GA11368@jh-x301>
 <1297696040-16453-2-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297696040-16453-2-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

* Sheldon Demario <sheldon.demario@openbossa.org> [2011-02-14 12:07:19 -0300]:

> Mode required to allow better GATT procedures control. Some scenarios
> require sequential commands without disconnection and delay between
> operations. It is also desirable to change some connection parameters
> of an active connection.
> ---
>  Makefile.am          |    8 ++-
>  attrib/gatttool.c    |    9 ++++
>  attrib/gatttool.h    |   24 +++++++++
>  attrib/interactive.c |  128 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  configure.ac         |    1 +
>  5 files changed, 168 insertions(+), 2 deletions(-)
>  create mode 100644 attrib/gatttool.h
>  create mode 100644 attrib/interactive.c
> 
> diff --git a/Makefile.am b/Makefile.am
> index e6639a7..11f990b 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -175,12 +175,16 @@ builtin_sources += plugins/service.c
>  endif
>  
>  if ATTRIBPLUGIN
> +
> +if READLINE

Is that really needed? You already checked for READLINE in ./configure at
this point.

>  bin_PROGRAMS += attrib/gatttool
>  
>  attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
>  			  attrib/gattrib.c btio/btio.c \
> -			  src/glib-helper.h src/glib-helper.c
> -attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@
> +			  src/glib-helper.h src/glib-helper.c \
> +			  attrib/gatttool.h attrib/interactive.c
> +attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @READLINE_LIBS@
> +endif
>  
>  builtin_modules += attrib
>  builtin_sources += attrib/main.c \
> diff --git a/attrib/gatttool.c b/attrib/gatttool.c
> index 8e8ed8e..d663eb5 100644
> --- a/attrib/gatttool.c
> +++ b/attrib/gatttool.c
> @@ -42,6 +42,7 @@
>  #include "gattrib.h"
>  #include "glib-helper.h"
>  #include "gatt.h"
> +#include "gatttool.h"
>  
>  /* Minimum MTU for L2CAP connections over BR/EDR */
>  #define ATT_MIN_MTU_L2CAP 48
> @@ -63,6 +64,7 @@ static gboolean opt_listen = FALSE;
>  static gboolean opt_char_desc = FALSE;
>  static gboolean opt_le = FALSE;
>  static gboolean opt_char_write = FALSE;
> +static gboolean opt_interactive = FALSE;
>  static GMainLoop *event_loop;
>  static gboolean got_error = FALSE;
>  
> @@ -537,6 +539,8 @@ static GOptionEntry gatt_options[] = {
>  		"Listen for notifications and indications", NULL },
>  	{ "le", 0, 0, G_OPTION_ARG_NONE, &opt_le,
>  		"Use Bluetooth Low Energy transport", NULL },
> +	{ "interactive", 'I', G_OPTION_FLAG_IN_MAIN, G_OPTION_ARG_NONE,
> +		&opt_interactive, "Use interactive mode", NULL },
>  	{ NULL },
>  };
>  
> @@ -594,6 +598,11 @@ int main(int argc, char *argv[])
>  		g_error_free(gerr);
>  	}
>  
> +	if (opt_interactive) {
> +		interactive();
> +		goto done;
> +	}
> +
>  	if (opt_primary)
>  		callback = primary;
>  	else if (opt_characteristics)
> diff --git a/attrib/gatttool.h b/attrib/gatttool.h
> new file mode 100644
> index 0000000..ed5d9d6
> --- /dev/null
> +++ b/attrib/gatttool.h
> @@ -0,0 +1,24 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2011  Nokia Corporation
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +int interactive(void);
> diff --git a/attrib/interactive.c b/attrib/interactive.c
> new file mode 100644
> index 0000000..0653609
> --- /dev/null
> +++ b/attrib/interactive.c
> @@ -0,0 +1,128 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2011  Nokia Corporation
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +#include <strings.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <glib.h>
> +
> +#include <readline/readline.h>
> +#include <readline/history.h>
> +
> +#include "gatttool.h"
> +
> +static GMainLoop *event_loop;
> +
> +static void cmd_help(int argcp, char **argvp);

Just move cmd_help() up to avoid this.

> +
> +static void cmd_exit(int argcp, char **argvp)
> +{
> +	rl_callback_handler_remove();
> +	g_main_loop_quit(event_loop);
> +}
> +
> +static struct {
> +	const char *cmd;
> +	void (*func)(int argcp, char **argvp);
> +	const char *desc;
> +} commands[] = {
> +	{ "help",	cmd_help,	"Show this help"},
> +	{ "exit",	cmd_exit,	"Exit interactive mode"},
> +	{ NULL, NULL, NULL}
> +};
> +
> +static void cmd_help(int argcp, char **argvp)
> +{
> +	int i;
> +
> +	for (i = 0; commands[i].cmd; i++)
> +		printf("%-12s\t%s\n", commands[i].cmd, commands[i].desc);
> +}
> +
> +static void parse_line(char *line_read)
> +{
> +	gchar **argvp;
> +	int argcp;
> +	int i;
> +
> +	if (line_read == NULL) {
> +		printf("\n");
> +		cmd_exit(0, NULL);
> +		return;
> +	}
> +
> +	line_read = g_strstrip(line_read);
> +
> +	if (*line_read == '\0')
> +		return;
> +
> +	add_history(line_read);
> +
> +	g_shell_parse_argv(line_read, &argcp, &argvp, NULL);
> +
> +	for (i = 0; commands[i].cmd; i++)
> +		if (strcasecmp(commands[i].cmd, argvp[0]) == 0)
> +			break;
> +
> +	if (commands[i].cmd)
> +		commands[i].func(argcp, argvp);
> +	else
> +		printf("%s: command not found\n", argvp[0]);
> +
> +	g_strfreev(argvp);
> +}
> +
> +static gboolean prompt_read(GIOChannel *chan, GIOCondition cond,
> +							gpointer user_data)
> +{
> +	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
> +		g_io_channel_unref(chan);
> +		return FALSE;
> +	}
> +
> +	rl_callback_read_char();
> +
> +	return TRUE;
> +}
> +
> +int interactive(void)
> +{
> +	GIOChannel *pchan;
> +	gint events;
> +
> +	event_loop = g_main_loop_new(NULL, FALSE);
> +
> +	pchan = g_io_channel_unix_new(fileno(stdin));
> +	g_io_channel_set_close_on_unref(pchan, TRUE);

Please add a blank line here.

-- 
Gustavo F. Padovan
http://profusion.mobi
