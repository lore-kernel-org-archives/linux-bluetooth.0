Return-Path: <shapiroc@google.com>
MIME-Version: 1.0
In-Reply-To: <5A47203A-A671-4854-9EAB-B09B15AF7680@holtmann.org>
References: <20170630172920.1968-1-shapiroc@chromium.org> <5A47203A-A671-4854-9EAB-B09B15AF7680@holtmann.org>
From: Charles Shapiro <shapiroc@google.com>
Date: Fri, 30 Jun 2017 11:52:15 -0600
Message-ID: <CALM0h1mVYSMRrW1Cgf_4Kp9fUieMDajawpXL2X7tDdZbpSsBhQ@mail.gmail.com>
Subject: Re: [PATCH] Support to change set file via arg
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: multipart/alternative; boundary="94eb2c0b10fae594b905533113d9"
List-ID: <linux-bluetooth.vger.kernel.org>

--94eb2c0b10fae594b905533113d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For ChromeOS, we're working towards having a single build/image based on a
reference board that then supports multiple models created by OEMs.

Some of the bluetooth config differs on a per model basis, so we need to
have multiple *.conf files ship on the actual image.

We then modify the init script to check the model at runtime and pass the
appropriate *.conf file to bluetoothd when it is started.

On Fri, Jun 30, 2017 at 11:42 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Shapiro,
>
> > Currently, there is an expectation of the main.conf file at a specific
> > location.  This prevents system builds that support more than one
> > platform.
> >
> > This adds support so the main.conf file can be specified as a command
> > line arg instead, so systems can manage multiple conf files as necessar=
y
> > and pass the appropriate conf file when the daemon is started.
> >
> > Signed-off-by: C Shapiro <shapiroc@chromium.org>
> > ---
> > src/bluetoothd.8.in |  4 ++++
> > src/main.c          | 12 +++++++++++-
> > 2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
> > index 97ef3ec94..d61dcc5b3 100644
> > --- a/src/bluetoothd.8.in
> > +++ b/src/bluetoothd.8.in
> > @@ -27,6 +27,10 @@ Print bluetoothd options and exit.
> > Enable logging in foreground. Directs log output to the controlling
> terminal \
> > in addition to syslog.
> > .TP
> > +.B -f, --configfile
> > +Specifies an explicit config file path instead of relying on the
> default path \
> > +(@CONFIGDIR@/main.conf) for the config file.
> > +.TP
> > .B -d, --debug=3D<file1>:<file2>:...
> > Sets how much information bluetoothd sends to the log destination
> (usually \
> > syslog's "daemon" facility). If the file options are omitted, then
> debugging \
> > diff --git a/src/main.c b/src/main.c
> > index bcc1e6fae..87bdb66cb 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -490,6 +490,7 @@ static guint setup_signalfd(void)
> > static char *option_debug =3D NULL;
> > static char *option_plugin =3D NULL;
> > static char *option_noplugin =3D NULL;
> > +static char *option_configfile =3D NULL;
> > static gboolean option_compat =3D FALSE;
> > static gboolean option_detach =3D TRUE;
> > static gboolean option_version =3D FALSE;
> > @@ -505,6 +506,9 @@ static void free_options(void)
> >
> >       g_free(option_noplugin);
> >       option_noplugin =3D NULL;
> > +
> > +     g_free(option_configfile);
> > +     option_configfile =3D NULL;
> > }
> >
> > static void disconnect_dbus(void)
> > @@ -577,6 +581,9 @@ static GOptionEntry options[] =3D {
> >                               "Specify plugins to load", "NAME,..," },
> >       { "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
> >                               "Specify plugins not to load", "NAME,..."
> },
> > +     { "configfile", 'f', 0, G_OPTION_ARG_STRING, &option_configfile,
> > +                             "Specify an explicit path to the config
> file",
> > +                             "FILE=E2=80=9D},
>
> I am failing to understand why this is needed. What problem are you tryin=
g
> to solve here? Can you give an example.
>
> Regards
>
> Marcel
>
>

--94eb2c0b10fae594b905533113d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">For ChromeOS, we&#39;re working towards having a single bu=
ild/image based on a reference board that then supports multiple models cre=
ated by OEMs.<div><br></div><div>Some of the bluetooth config differs on a =
per model basis, so we need to have multiple *.conf files ship on the actua=
l image.</div><div><br></div><div>We then modify the init script to check t=
he model at runtime and pass the appropriate *.conf file to bluetoothd when=
 it is started.</div></div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Fri, Jun 30, 2017 at 11:42 AM, Marcel Holtmann <span dir=3D"lt=
r">&lt;<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">marcel@holt=
mann.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Shapi=
ro,<br>
<div><div class=3D"h5"><br>
&gt; Currently, there is an expectation of the main.conf file at a specific=
<br>
&gt; location.=C2=A0 This prevents system builds that support more than one=
<br>
&gt; platform.<br>
&gt;<br>
&gt; This adds support so the main.conf file can be specified as a command<=
br>
&gt; line arg instead, so systems can manage multiple conf files as necessa=
ry<br>
&gt; and pass the appropriate conf file when the daemon is started.<br>
&gt;<br>
&gt; Signed-off-by: C Shapiro &lt;<a href=3D"mailto:shapiroc@chromium.org">=
shapiroc@chromium.org</a>&gt;<br>
&gt; ---<br>
&gt; src/<a href=3D"http://bluetoothd.8.in" rel=3D"noreferrer" target=3D"_b=
lank">bluetoothd.8.in</a> |=C2=A0 4 ++++<br>
&gt; src/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 +++++++++++-<br>
&gt; 2 files changed, 15 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/src/<a href=3D"http://bluetoothd.8.in" rel=3D"noreferrer"=
 target=3D"_blank">bluetoothd.8.in</a> b/src/<a href=3D"http://bluetoothd.8=
.in" rel=3D"noreferrer" target=3D"_blank">bluetoothd.8.in</a><br>
&gt; index 97ef3ec94..d61dcc5b3 100644<br>
&gt; --- a/src/<a href=3D"http://bluetoothd.8.in" rel=3D"noreferrer" target=
=3D"_blank">bluetoothd.8.in</a><br>
&gt; +++ b/src/<a href=3D"http://bluetoothd.8.in" rel=3D"noreferrer" target=
=3D"_blank">bluetoothd.8.in</a><br>
&gt; @@ -27,6 +27,10 @@ Print bluetoothd options and exit.<br>
&gt; Enable logging in foreground. Directs log output to the controlling te=
rminal \<br>
&gt; in addition to syslog.<br>
&gt; .TP<br>
&gt; +.B -f, --configfile<br>
&gt; +Specifies an explicit config file path instead of relying on the defa=
ult path \<br>
&gt; +(@CONFIGDIR@/main.conf) for the config file.<br>
&gt; +.TP<br>
&gt; .B -d, --debug=3D&lt;file1&gt;:&lt;file2&gt;:...<br>
&gt; Sets how much information bluetoothd sends to the log destination (usu=
ally \<br>
&gt; syslog&#39;s &quot;daemon&quot; facility). If the file options are omi=
tted, then debugging \<br>
&gt; diff --git a/src/main.c b/src/main.c<br>
&gt; index bcc1e6fae..87bdb66cb 100644<br>
&gt; --- a/src/main.c<br>
&gt; +++ b/src/main.c<br>
&gt; @@ -490,6 +490,7 @@ static guint setup_signalfd(void)<br>
&gt; static char *option_debug =3D NULL;<br>
&gt; static char *option_plugin =3D NULL;<br>
&gt; static char *option_noplugin =3D NULL;<br>
&gt; +static char *option_configfile =3D NULL;<br>
&gt; static gboolean option_compat =3D FALSE;<br>
&gt; static gboolean option_detach =3D TRUE;<br>
&gt; static gboolean option_version =3D FALSE;<br>
&gt; @@ -505,6 +506,9 @@ static void free_options(void)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(option_noplugin);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0option_noplugin =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0g_free(option_configfile);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0option_configfile =3D NULL;<br>
&gt; }<br>
&gt;<br>
&gt; static void disconnect_dbus(void)<br>
&gt; @@ -577,6 +581,9 @@ static GOptionEntry options[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Specify plugins to load&quot=
;, &quot;NAME,..,&quot; },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;noplugin&quot;, &#39;P&#39;, 0, G_OP=
TION_ARG_STRING, &amp;option_noplugin,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Specify plugins not to load&=
quot;, &quot;NAME,...&quot; },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ &quot;configfile&quot;, &#39;f&#39;, 0, G_OPTIO=
N_ARG_STRING, &amp;option_configfile,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Specify an explicit path to the co=
nfig file&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;FILE=E2=80=9D},<br>
<br>
</div></div>I am failing to understand why this is needed. What problem are=
 you trying to solve here? Can you give an example.<br>
<br>
Regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Marcel<br>
<br>
</font></span></blockquote></div><br></div>

--94eb2c0b10fae594b905533113d9--
