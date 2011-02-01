Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Feb 2011 11:03:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/6 v2] Add an interactive mode to gatttool
Message-ID: <20110201090352.GA5278@jh-x301>
References: <1296150752-27142-2-git-send-email-sheldon.demario@openbossa.org>
 <1296494878-27221-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296494878-27221-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 31, 2011, Sheldon Demario wrote:
> +static gboolean cmd_connect(gpointer cmd)
> +{
> +	const char **c = (const char **) cmd;
> +	if (conn_state != STATE_DISCONNECTED)

Missing line after the variable declaration and unnecessary explicit
type-cast (no need for void pointers). However why does this function
take a gpointer to begin with? I'd imagine the most convenient thing to
give the command handlers either a char* with the entire command line or
a pre-parsed argc + argv with the help of g_shell_parse_argv.

> +	if (c[1] != NULL) {

Now that's just ugly. Much better if you use g_shell_parse_argv and then
you can use the usual getopt to separate switches from mandatory
parameters, etc.

> +static struct {
> +	char *cmd;

I suppose this should be const char *

> +	gboolean (*func)(gpointer cmd);

As I mentioned, instead of gpointer do char * or then (what I'd prefer)
simply argc + argv.

> +	char *param;

Again, const

> +	char *desc;

Same here.

> +} commands[] = {
> +	{ "connect",	cmd_connect,	"<bdaddr>",	"Connect"},
> +	{ "disconnect",	cmd_disconnect,	NULL,		"Disconnect"},
> +	{ "characteristics",	characteristics,	NULL,
> +						"Characteristcs Discovery"},
> +	{ NULL, NULL, NULL, NULL}
> +};

Where's the "help" command? That's the first one I'd expect to be
implemented. Also, ctrl-d and "exit" should work from the start as ways
of exiting the program.

> +static void parse_line(char *line_read)
> +{
> +	char **command;
> +	int j;

Why j and not i?

> +static int do_interactive(void)

Didn't I tell you to do all the interactive stuff away from the main
gatttool.c file? There should only be the parsing of command line
parameters and a call to the interactive .c file in the case of
interactive mode.

Johan
