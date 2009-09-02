Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <87k50hoee1.fsf@bubble.risko.hu>
References: <87eiqq3ge7.fsf@bubble.risko.hu> <87k50hoee1.fsf@bubble.risko.hu>
Date: Wed, 2 Sep 2009 11:46:15 -0300
Message-ID: <2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com>
Subject: Re: [PATCH] Add introspection interface to the output of
	introspection calls.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?RISK=D3_Gergely?= <gergely@risko.hu>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 2, 2009 at 7:00 AM, RISKÓ Gergely<gergely@risko.hu> wrote:
>
> ---
>  gdbus/object.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 3186921..8091a95 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -156,6 +156,11 @@ static void generate_introspection_xml(DBusConnection *conn,
>        gstr = g_string_new(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE);
>
>        g_string_append_printf(gstr, "<node name=\"%s\">\n", path);
> +       g_string_append_printf(gstr, "\t<interface name=\"org.freedesktop.DBus.Introspectable\">\n");
> +       g_string_append_printf(gstr, "\t\t<method name=\"Introspect\">\n");
> +       g_string_append_printf(gstr, "\t\t\t<arg name=\"xml_data\" type=\"s\" direction=\"out\"/>\n");
> +       g_string_append_printf(gstr, "\t\t</method>\n");
> +       g_string_append_printf(gstr, "\t</interface>\n");
>
>        for (list = data->interfaces; list; list = list->next) {
>                struct interface_data *iface = list->data;

Im afraid this is on purpose, we don't export the introspectable
interface because it is implicit you can only have the introspection
data if the object export it so it is meaningless to export it again
on the .xml. You can check with d-feet that most services does this in
the same way.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
