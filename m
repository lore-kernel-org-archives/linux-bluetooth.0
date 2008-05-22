Return-Path: <cyrus@holtmann.org>
Message-ID: <01d801c8bc5a$027798d0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
Subject: Problems with returning Default Adapter in C-Glib-DBus code
Date: Thu, 22 May 2008 17:20:10 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01D4_01C8BC30.16C7E3F0"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.

------=_NextPart_000_01D4_01C8BC30.16C7E3F0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_01D5_01C8BC30.16C7E3F0"


------=_NextPart_001_01D5_01C8BC30.16C7E3F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Since upgrading to 3.32 (and possibly before), I have been having a =
problem with calling the new, experimental DefaultAdapter method against =
the "/".  When I do so, it properly returns the Adapter path "/hci0", =
but fails with the following error: Unregistered object at path '/hci0'.

Prior to this, I used to call what was effectively the old =
DefaultAdapter using the "/org/bluez" path and returning the old string =
version of the Adapter path, receiving "/org/bluez/hci0".

Output of my failing program is as follows (also, in =
DefaultAdapterOut.txt):

after dbus_g_proxy_new_for_name (dMgrObj)
 bus:       org.bluez
 path:      /
 interface: org.bluez.Manager
Failed to get DefaultAdapter: Unregistered object at path '/hci0'

At the same time, I called dbus-send to see if this was some more =
fundamental failure, but calls against both paths are successful, as =
shown in the following (DefaultAdapter.txt):

[dstockwell@freqonec001 ~]$ dbus-send --system --type=3Dmethod_call =
--print-reply --dest=3Dorg.bluez /org/bluez =
org.bluez.Manager.DefaultAdapter
method return sender=3D:1.12 -> dest=3D:1.22
   string "/org/bluez/hci0"
[dstockwell@freqonec001 ~]$ dbus-send --system --type=3Dmethod_call =
--print-reply --dest=3Dorg.bluez / org.bluez.Manager.DefaultAdapter
method return sender=3D:1.12 -> dest=3D:1.23
   object path "/hci0"

I have attached a cut-down version of the source, which I am compiling =
against KDE and MandrivaLinux.

MY SUSPICION is that the real problem is that I did not adjust my source =
application to use libgdbus, introduced in 3.32.  Specifically, given =
the following set of includes, which of these are replaced by gdbus.h?

#include <dbus/dbus.h>
#include <dbus/dbus-glib.h>
#include <dbus/dbus-glib-lowlevel.h>
#include <glib-object.h>

Any hints will be appreciated...

David Stockwell



------=_NextPart_001_01D5_01C8BC30.16C7E3F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD><FONT face=3DArial><FONT size=3D2>
<BODY>
<DIV>Since upgrading to 3.32 (and possibly before), I have been having a =
problem=20
with calling the new, experimental DefaultAdapter method against the =
"/".&nbsp;=20
When I do so, it properly returns the Adapter path "/hci0", but fails =
with the=20
following error: Unregistered object at path '/hci0'.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Prior to this, I used to call what was effectively the old =
DefaultAdapter=20
using the "/org/bluez" path and returning&nbsp;the old&nbsp;string =
version of=20
the Adapter path, receiving "/org/bluez/hci0".</DIV>
<DIV>&nbsp;</DIV>
<DIV>Output of my failing program is as follows (also, in=20
DefaultAdapterOut.txt):</DIV>
<DIV>&nbsp;</DIV>
<DIV>after dbus_g_proxy_new_for_name=20
(dMgrObj)<BR>&nbsp;bus:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
org.bluez<BR>&nbsp;path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/<BR>&nbsp;interface:=20
org.bluez.Manager<BR>Failed to get DefaultAdapter: <STRONG>Unregistered =
object=20
at path '/hci0'</STRONG><BR></DIV>
<DIV>At the same time, I called dbus-send to see if this was some more=20
fundamental failure, but calls against both paths are successful, as =
shown in=20
the following (DefaultAdapter.txt):</DIV>
<DIV>&nbsp;</DIV>
<DIV>[dstockwell@freqonec001 ~]$ dbus-send --system --type=3Dmethod_call =

--print-reply --dest=3Dorg.bluez /org/bluez=20
org.bluez.Manager.DefaultAdapter<BR>method return sender=3D:1.12 -&gt;=20
dest=3D:1.22<BR>&nbsp;&nbsp; string =
"/org/bluez/hci0"<BR>[dstockwell@freqonec001=20
~]$ dbus-send --system --type=3Dmethod_call --print-reply =
--dest=3Dorg.bluez /=20
org.bluez.Manager.DefaultAdapter<BR>method return sender=3D:1.12 -&gt;=20
dest=3D:1.23<BR>&nbsp;&nbsp; object path "/hci0"</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have attached a cut-down version of the source, which I am =
compiling=20
against KDE and MandrivaLinux.</DIV>
<DIV>&nbsp;</DIV>
<DIV><STRONG>MY SUSPICION</STRONG> is that the real problem is that I =
did not=20
adjust my source application to use libgdbus, introduced in 3.32.&nbsp;=20
Specifically, given the following set of includes, which of these are =
replaced=20
by gdbus.h?</DIV>
<DIV>&nbsp;</DIV>
<DIV>#include &lt;dbus/dbus.h&gt;<BR>#include=20
&lt;dbus/dbus-glib.h&gt;<BR>#include=20
&lt;dbus/dbus-glib-lowlevel.h&gt;<BR>#include =
&lt;glib-object.h&gt;<BR></DIV>
<DIV>Any hints will be appreciated...</DIV>
<DIV>&nbsp;</DIV>
<DIV>David Stockwell</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR>&nbsp;</DIV></BODY></HTML></FONT></FONT>

------=_NextPart_001_01D5_01C8BC30.16C7E3F0--

------=_NextPart_000_01D4_01C8BC30.16C7E3F0
Content-Type: application/octet-stream;
	name="DefaultAdapter.cpp"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="DefaultAdapter.cpp"

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <string>
#include <iostream>
#include <cstdlib>
#include <vector>

// #define DBUS_API_SUBJECT_TO_CHANGE

#include <stdlib.h>
#include <dbus/dbus.h>
#include <dbus/dbus-glib.h>
#include <dbus/dbus-glib-lowlevel.h>
#include <glib-object.h>

using namespace std;

static	GMainLoop *mainLoop=3DNULL;
static	DBusGConnection	*dBusG =3D NULL;
static	GError		*dError=3DNULL;
static	DBusGProxy	*dMgrObj=3DNULL;

static void run_mainLoop() {
	GMainContext *ctx;
	ctx=3Dg_main_loop_get_context(mainLoop);
	while (g_main_context_pending(ctx))
		g_main_context_iteration(ctx, FALSE);
}

int main(int argc, char *argv[])
{
	char	*servicePath =3D (char *) malloc(32);

	g_type_init();
	g_log_set_always_fatal(G_LOG_LEVEL_WARNING);
	mainLoop=3Dg_main_loop_new(NULL, FALSE);

	dBusG=3Ddbus_g_bus_get(DBUS_BUS_SYSTEM, &dError);
	if (dError!=3DNULL) {
		cout << "Connection to System Bus failed: " << dError->message << =
endl;
		g_error_free(dError);
		return	EXIT_FAILURE;
	}

	run_mainLoop();

	dbus_g_connection_flush(dBusG);

//	registerMarshallers();

	dMgrObj=3Ddbus_g_proxy_new_for_name(dBusG, "org.bluez", "/", =
"org.bluez.Manager");
	cout << "after dbus_g_proxy_new_for_name (dMgrObj)" << endl;
	cout << " bus:       " << dbus_g_proxy_get_bus_name(dMgrObj) << endl;
	cout << " path:      " << dbus_g_proxy_get_path(dMgrObj) << endl;
	cout << " interface: " << dbus_g_proxy_get_interface(dMgrObj) << endl;
	initManagerSignals(dBusG, dMgrObj);

/*
	Now, identify the Default Adapter path and establish a proxy to the =
org.bluez.Adapter interface for that Adapter
*/

	if (dbus_g_proxy_call(dMgrObj, "DefaultAdapter", &dError, =
G_TYPE_INVALID, G_TYPE_OBJECT, &servicePath, G_TYPE_INVALID)) {
		cout << "DefaultAdapter is " << servicePath << endl;
	} else {
		if (dError!=3DNULL) {
			cout << "Failed to get DefaultAdapter: " << dError->message << endl;
			g_error_free(dError);
			return	EXIT_FAILURE;
		}
	}
}
------=_NextPart_000_01D4_01C8BC30.16C7E3F0
Content-Type: text/plain;
	name="DefaultAdapterOut.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="DefaultAdapterOut.txt"

after dbus_g_proxy_new_for_name (dMgrObj)
 bus:       org.bluez
 path:      /
 interface: org.bluez.Manager
Failed to get DefaultAdapter: Unregistered object at path '/hci0'

------=_NextPart_000_01D4_01C8BC30.16C7E3F0
Content-Type: text/plain;
	name="DefaultAdapter.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="DefaultAdapter.txt"

[dstockwell@freqonec001 ~]$ dbus-send --system --type=3Dmethod_call =
--print-reply --dest=3Dorg.bluez /org/bluez =
org.bluez.Manager.DefaultAdapter
method return sender=3D:1.12 -> dest=3D:1.22
   string "/org/bluez/hci0"
[dstockwell@freqonec001 ~]$ dbus-send --system --type=3Dmethod_call =
--print-reply --dest=3Dorg.bluez / org.bluez.Manager.DefaultAdapter
method return sender=3D:1.12 -> dest=3D:1.23
   object path "/hci0"

------=_NextPart_000_01D4_01C8BC30.16C7E3F0--
