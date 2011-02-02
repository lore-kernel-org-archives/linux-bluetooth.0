Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110201090352.GA5278@jh-x301>
References: <1296150752-27142-2-git-send-email-sheldon.demario@openbossa.org>
	<1296494878-27221-1-git-send-email-sheldon.demario@openbossa.org>
	<20110201090352.GA5278@jh-x301>
Date: Wed, 2 Feb 2011 15:53:12 -0300
Message-ID: <AANLkTik7+J-2KwvkOdOzpbxKmrPwDivVje2KsfpQUp=-@mail.gmail.com>
Subject: Re: [PATCH 2/6 v2] Add an interactive mode to gatttool
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: Sheldon Demario <sheldon.demario@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 1, 2011 at 6:03 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Mon, Jan 31, 2011, Sheldon Demario wrote:
>> +static gboolean cmd_connect(gpointer cmd)
>> +{
>> +     const char **c = (const char **) cmd;
>> +     if (conn_state != STATE_DISCONNECTED)
>
> Missing line after the variable declaration and unnecessary explicit
> type-cast (no need for void pointers). However why does this function
> take a gpointer to begin with? I'd imagine the most convenient thing to
> give the command handlers either a char* with the entire command line or
> a pre-parsed argc + argv with the help of g_shell_parse_argv.

I am trying to avoid duplicate the callbacks already used on
gatttool. The callbacks called from command line and those called from
interactive prompt are the same, that's why they use gpointer as
parameter.

>
>> +     if (c[1] != NULL) {
>
> Now that's just ugly. Much better if you use g_shell_parse_argv and then
> you can use the usual getopt to separate switches from mandatory
> parameters, etc.

Using the usual getopt means that the user will type "-" in each
parameter? It seems bad for a interactive prompt.
I agree with you that this is a ugly line, but is the simpler way to
do that without create another callback to do the same thing that in
"non interactive" mode.

>
>> +static struct {
>> +     char *cmd;
>
> I suppose this should be const char *
>
>> +     gboolean (*func)(gpointer cmd);
>
> As I mentioned, instead of gpointer do char * or then (what I'd prefer)
> simply argc + argv.
>
>> +     char *param;
>
> Again, const
>
>> +     char *desc;
>
> Same here.
>
>> +} commands[] = {
>> +     { "connect",    cmd_connect,    "<bdaddr>",     "Connect"},
>> +     { "disconnect", cmd_disconnect, NULL,           "Disconnect"},
>> +     { "characteristics",    characteristics,        NULL,
>> +                                             "Characteristcs Discovery"},
>> +     { NULL, NULL, NULL, NULL}
>> +};
>
> Where's the "help" command? That's the first one I'd expect to be
> implemented. Also, ctrl-d and "exit" should work from the start as ways
> of exiting the program.
>
>> +static void parse_line(char *line_read)
>> +{
>> +     char **command;
>> +     int j;
>
> Why j and not i?
>
>> +static int do_interactive(void)
>
> Didn't I tell you to do all the interactive stuff away from the main
> gatttool.c file? There should only be the parsing of command line
> parameters and a call to the interactive .c file in the case of
> interactive mode.

The approach will be similar to the first suggestion sent to the ML,
except the binary that it will be only one. I gonna split the
functions based on your comments and see if we reach a consensus
between code re-use and cleanness.

Sheldon.

>
> Johan
>
