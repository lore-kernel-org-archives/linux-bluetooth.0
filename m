Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-2?Q?RISK=D3?= Gergely <gergely@risko.hu>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Context Devel mailing list <context-devel@projects.maemo.org>
Subject: Re: [PATCH] Add introspection interface to the output of  introspection calls.
References: <87eiqq3ge7.fsf@bubble.risko.hu> <87k50hoee1.fsf@bubble.risko.hu>
	<2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com>
Date: Wed, 02 Sep 2009 20:48:19 +0300
In-Reply-To: <2d5a2c100909020746t63bcd89bj1b25d053a6f4f9ca@mail.gmail.com>
	(Luiz Augusto von Dentz's message of "Wed, 2 Sep 2009 11:46:15 -0300")
Message-ID: <87pra9nspo.fsf@bubble.risko.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, 2 Sep 2009 11:46:15 -0300, Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> Hi,
>
> On Wed, Sep 2, 2009 at 7:00 AM, RISKÓ Gergely<gergely@risko.hu> wrote:
>>
>> ---
>>  gdbus/object.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/gdbus/object.c b/gdbus/object.c
>> index 3186921..8091a95 100644
>> --- a/gdbus/object.c
>> +++ b/gdbus/object.c
>> @@ -156,6 +156,11 @@ static void generate_introspection_xml(DBusConnection *conn,
>>        gstr = g_string_new(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE);
>>
>>        g_string_append_printf(gstr, "<node name=\"%s\">\n", path);
>> +       g_string_append_printf(gstr, "\t<interface name=\"org.freedesktop.DBus.Introspectable\">\n");
>> +       g_string_append_printf(gstr, "\t\t<method name=\"Introspect\">\n");
>> +       g_string_append_printf(gstr, "\t\t\t<arg name=\"xml_data\" type=\"s\" direction=\"out\"/>\n");
>> +       g_string_append_printf(gstr, "\t\t</method>\n");
>> +       g_string_append_printf(gstr, "\t</interface>\n");
>>
>>        for (list = data->interfaces; list; list = list->next) {
>>                struct interface_data *iface = list->data;
>
> Im afraid this is on purpose, we don't export the introspectable
> interface because it is implicit you can only have the introspection
> data if the object export it so it is meaningless to export it again
> on the .xml. You can check with d-feet that most services does this in
> the same way.

Thanks for your reply, I appreciate it, however I don't agree after I
checked.  Probably some time ago this was the custom, but apparently it
changed.

About the other services on my home system:
22975@20:39 risko@bubble:~$ qdbus --system | grep -v '^:'
 org.freedesktop.Avahi
 org.freedesktop.Hal
 org.bluez
 org.freedesktop.ConsoleKit
org.freedesktop.DBus

22978@20:42 risko@bubble:~$ for i in `qdbus --system | grep -v '^:'` ; do QDBUS_DEBUG=1 qdbus --system $i 2>&1| grep -q '<interface.*Introspectable' || echo $i; done
org.bluez

So Avahi, Hal, ConsoleKit and even DBus itself exposes the introspection
API in the introspection API, the only exception is BlueZ.

And this issue is causing problems for QDBus users everywhere, not just
for me: https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/371299

The guy who handled the bug report even thought that BlueZ doesn't
support introspection because of this.

I still think that this is bad, because all of the other common services
behave the other way around and it is incompatible with some silly
implementations (QtDBus which I know of, probably others).

If there is any other research I can do, please say so, happy to help,
Gergely
