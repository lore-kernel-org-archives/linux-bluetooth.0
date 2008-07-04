Return-Path: <cyrus@holtmann.org>
Message-ID: <062301c8de19$144dc990$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Fri, 4 Jul 2008 16:01:04 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0620_01C8DDEF.29666DC0"
Subject: [Bluez-devel] Creating a 4.x org.bluez.Agent (with BUG)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0620_01C8DDEF.29666DC0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Over the last few days, I have developed an Agent to implement the
org.bluez.Agent interface, so that I can test the new BT2.1-compatible
Simple Secure Pairing (SSP).

I am developing in C/C++ with Glib and libgdbus, which provides the
functions and structures for method and signal definition and especially
provides for DBus introspection.  Also, I expected to develop this as a
separate process, much like the old passkey-agent.  I found that when I
did this, however, the new agent was never found by my application,
calling the Adapter.CreatePairedDevice method.  When I tested with the
hcid/simple-agent, that Python-based agent worked well.  I would like to
share the reasons for this...

1) When first testing the agent as a separate process, I figured I had
to tie that agent to the org.bluez well-known name.  The only way I
could find to do that was to connect to the Session bus (not the System
bus), and provide "org.bluez" as the name of the bus in the session.  I
used this to test the functioning of the agent with dbus-send.  However,
when I tried calling CreatePairedDevice from my application, it did not
find the agent; the error message in syslog indicated that Method
RequestPinCode with signature "o" was not found.

2) Knowing that hcid uses the System bus, I then tried to connect with
the System bus, referencing the "org.bluez" well-known connection name.
However, the connection was rejected because (as we all know) hcid owns
that name, and only one object can own a name at a time (and hcid was
not going to give it up!).

3) I connected the agent with the System bus leaving the service name
NULL, so the agent object was assigned a "unique connection name",
something like :1.56 (changes each time).  I was able to introspect the
object, and to invoke some of the methods using dbus-send, so long as I
addressed the System bus (--system) and set the destination with that
unique connection name (--dest =:1.56).  I also went down a path of
calling RegisterAgent from within the external Agent; this worked
properly in the sense that DBus was happy with it, the Agent was still
reachable from dbus-send, etc.

4) I attempted to connect with the registered Agent using
Adapter.CreatePairedDevice, the Agent was not connected to.  The reason
for this is that CreatePairedDevice explicitly uses its own "unique
connection name" to the System bus as the "bus name", and assumes that
the Object Path will be found on that bus name.  Which is only the case
if the Agent code is contained within the same process as the rest of
the application; the application calling CreatePairedDevice.

BUG-> If there is no object with that path for the unique connection
name, the code at hcid/agent.c agent_create (line 190) should throw an
error, perhaps .DoesNotExist...  What actually happens is that the code
just creates that path and attempts to call it during pairing; throwing
no error (except for the DBus error that shows up in the syslog).
Authentication then fails with no accurate indication as to why.

5) I attempted to register the Agent within the application using
Adapter.RegisterAgent.  However, again RegisterAgent assumes that the
bus name to be used is its own unique connection name; it does not
search for the object among other connections to the System bus, nor is
there any way to pass in a well-known name or a unique connection name.

BUG-> (actually, the same bug) As with CreatePairedDevice, if there is
no object with that path for the unique connection name, RegisterAgent
should throw an error.

6) Finally, I very slightly revamped my Agent code, changed the sub main
to a callable subroutine from my main application and integrated it into
the mainloop of the application.  All now works well, because the
application and the Agent are in the same process and share the same
connection to the System bus.

YOU MAY ASK, why did I not integrate the Agent code into the main
application in the first place?

The first reason is that it was not clear that this is what I needed to
do.  Although I did receive a hint about this from Johan Hedburg
(thanks!), I expected the agent should be a separate process, much like
the 3.x passkey-agent and auth-agent.

Second, depending on the application requirements, the agent may require
entry of a pincode or passkey (in my case, I am using SSP-JustWorks, so
human entry should not be needed).  Depending on the requirements, the
Agent should not hang up the main application waiting for human
interaction.  (That said, you could non-block the IO and multi-thread
the whole thing...).

Third, I just felt that putting the Agent in another process is a
somewhat more modular way to handle security, authorization and pairing.

Fourth, because it was there (the challenge of figuring this out,
learning more about DBus, GLib and the whole mess).

To that end, and in the interest of sharing, I am submitting my agent
code as a skeleton...  To react to RequestPinCode and RequestPasskey, I
have hardcoded values... I compile with C++ and use cout and string
because I am lazy (in this experimental phase); converting to standard
C, or to popping up a dialog, is trivial.  And I throw no errors (e.g.,
.Reject), nor do I really do anything with respect to actual
authorization, etc.  In other words,  it's just a start, designed to
allow me to see the interaction with the Agent during pairing,
especially with SSP.

Questions, comments?  Feel free...

David Stockwell
Frequency One

------=_NextPart_000_0620_01C8DDEF.29666DC0
Content-Type: application/octet-stream;
	name="bluez_agent.cpp"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bluez_agent.cpp"

/************************************************************************=
***
 *   Copyright (C) 2008 by David Stockwell   *
 *   dstockwell@frequency-one.com   *
 *                                                                       =
  *
 *   This program is free software; you can redistribute it and/or =
modify  *
 *   it under the terms of the GNU General Public License as published =
by  *
 *   the Free Software Foundation; either version 2 of the License, or   =
  *
 *   (at your option) any later version.                                 =
  *
 *                                                                       =
  *
 *   This program is distributed in the hope that it will be useful,     =
  *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of      =
  *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       =
  *
 *   GNU General Public License for more details.                        =
  *
 *                                                                       =
  *
 *   You should have received a copy of the GNU General Public License   =
  *
 *   along with this program; if not, write to the                       =
  *
 *   Free Software Foundation, Inc.,                                     =
  *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.           =
  *
 =
*************************************************************************=
**/


#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <string>
#include <iostream>
#include <cstdlib>
#include <stdlib.h>

#include "gdbus.h"

#include <dbus/dbus-glib.h>
#include <dbus/dbus-glib-lowlevel.h>
#include <glib-object.h>

using namespace std;

static	GMainLoop	*mainLoop=3DNULL;

static	DBusMessage *agent_authorize(DBusConnection *conn,
						DBusMessage *msg, void *data)
{
	char *objectPath =3D (char *) malloc(128);
	char *objectUUID =3D (char *) malloc(128);

	if (dbus_message_get_args(msg, NULL,
			DBUS_TYPE_OBJECT_PATH, &objectPath,
			DBUS_TYPE_STRING, &objectUUID,
			DBUS_TYPE_INVALID) =3D=3D FALSE) {
//		free(objectPath);
//		free(objectUUID);
		return NULL;
	}
	cout << "Authorize received..." << objectPath << "-" << objectUUID << =
endl;

//	free(objectPath);
//	free(objectUUID);

	DBusMessage *reply =3D dbus_message_new_method_return(msg);
	if (!reply) return NULL;

	return reply;
}

static	DBusMessage *agent_cancel(DBusConnection *conn,
						DBusMessage *msg, void *data)
{
	cout << "Cancel received..." << endl;

	DBusMessage *reply =3D dbus_message_new_method_return(msg);
	if (!reply) return NULL;

	return reply;
}

static	DBusMessage *agent_confirm_mode_change(DBusConnection *conn,
						DBusMessage *msg, void *data)
{
	char *mode =3D (char *) malloc(128);

	if (dbus_message_get_args(msg, NULL,
			DBUS_TYPE_STRING, &mode,
			DBUS_TYPE_INVALID) =3D=3D FALSE) {
//		free(mode);
		return NULL;
	}
	cout << "ConfirmModeChange received..." << mode << endl;

//	free(mode);
	DBusMessage *reply =3D dbus_message_new_method_return(msg);
	if (!reply) return NULL;

	return reply;
}

static	DBusMessage *agent_display_passkey(DBusConnection *conn,
						DBusMessage *msg, void *data)
{
	char *objectPath =3D (char *) malloc(128);
	uint passKey;
	short entered;

	if (dbus_message_get_args(msg, NULL,
			DBUS_TYPE_OBJECT_PATH, &objectPath,
			DBUS_TYPE_UINT32, &passKey,
			DBUS_TYPE_BYTE, &entered,
			DBUS_TYPE_INVALID) =3D=3D FALSE) {
//		free(objectPath);
		return NULL;
	}
	cout << "DisplayPasskey received..." << objectPath << "-" <<  passKey =
<< "-" << entered << endl;

//	free(objectPath);

	DBusMessage *reply =3D dbus_message_new_method_return(msg);
	if (!reply) return NULL;

	return reply;
}

static	DBusMessage *agent_release(DBusConnection *conn,
						DBusMessage *msg, void *data)
{
	cout << "Release received...exiting" << endl;

	DBusMessage *reply =3D dbus_message_new_method_return(msg);
	if (!reply) return NULL;

	g_main_loop_quit(mainLoop);
	return reply;
}

static	DBusMessage *agent_request_confirmation(DBusConnection *conn,
						DBusMessage *msg, void *data)
{
	char *objectPath =3D (char *) malloc(128);
	uint passKey;

	if (dbus_message_get_args(msg, NULL,
			DBUS_TYPE_OBJECT_PATH, &objectPath,
			DBUS_TYPE_UINT32, &passKey,
			DBUS_TYPE_INVALID) =3D=3D FALSE) {
//		free(objectPath);
		return NULL;
	}
	cout << "RequestConfirmation received..." << objectPath << "-" <<  =
passKey << endl;

//	free(objectPath);

	DBusMessage *reply =3D dbus_message_new_method_return(msg);
	if (!reply) return NULL;

	return reply;
}

static	DBusMessage *agent_request_passkey(DBusConnection *conn,
						DBusMessage *msg, void *data)
{
	char *objectPath =3D (char *) malloc(128);
	uint passKey =3D 0000;			// For Testing Only

	if (dbus_message_get_args(msg, NULL,
			DBUS_TYPE_OBJECT_PATH, &objectPath,
			DBUS_TYPE_INVALID) =3D=3D FALSE) {
//		free(objectPath);
		return NULL;
	}
	cout << "RequestPasskey received..." << objectPath << endl;

//	free(objectPath);

	DBusMessage *reply =3D dbus_message_new_method_return(msg);
	if (!reply) return NULL;

	if (!dbus_message_append_args(reply, DBUS_TYPE_UINT32, passKey, =
DBUS_TYPE_INVALID)) {
		dbus_message_unref(reply);
		return NULL;
	}
	return reply;
}

static	DBusMessage *agent_request_pincode(DBusConnection *conn,
						DBusMessage *msg, void *data)
{
	char *objectPath =3D (char *) malloc(128);
	const char * pinCode =3D "Bluez";		// For testing only...

	if (dbus_message_get_args(msg, NULL,
			DBUS_TYPE_OBJECT_PATH, &objectPath,
			DBUS_TYPE_INVALID) =3D=3D FALSE) {
//		free(objectPath);
		return NULL;
	}
	cout << "RequestPinCode received..." << objectPath << endl;

//	free(objectPath);

	DBusMessage *reply =3D dbus_message_new_method_return(msg);
	if (!reply) return NULL;

	if (!dbus_message_append_args(reply, DBUS_TYPE_STRING, &pinCode, =
DBUS_TYPE_INVALID)) {
		dbus_message_unref(reply);
		return NULL;
	}
	return reply;
}

/* from doc/agent-api.txt BlueZ 4.0 API */

static	GDBusMethodTable agent_methods[] =3D {
	{ "Authorize",		"os",	"",	agent_authorize			},
	{ "Cancel",		"",	"",	agent_cancel			},
	{ "ConfirmModeChange",	"s",	"",	agent_confirm_mode_change	},
	{ "DisplayPasskey",	"ouy",	"",	agent_display_passkey		},
	{ "Release",		"",	"",	agent_release			},
	{ "RequestConfirmation","ou",	"",	agent_request_confirmation	},
	{ "RequestPasskey",	"o",	"u",	agent_request_passkey		},
	{ "RequestPinCode",	"o",	"s",	agent_request_pincode		},
	{ }
};

/* Note that there are no signals defined.  If an answer is not =
positive, an error is thrown. */

int	agent_install(DBusGConnection *dBusG, string agentObjectPath)
{
	DBusError	dError;

	DBusConnection	*dBus=3Ddbus_g_connection_get_connection(dBusG);
	dbus_error_init(&dError);
/*
	With the connection to a the System Bus, register the object for the =
Agent, then register the interface.
*/
	if (g_dbus_register_object(dBus, agentObjectPath.c_str())) {
		cout << "AgentPath " << agentObjectPath << " REGISTERED" << endl;
	} else {
		cout << "Failed to register AgentPath: " << agentObjectPath;
		if (dbus_error_is_set(&dError)) {
			cout << dError.message;
			dbus_error_free(&dError);
		}
		cout << endl;
		return EXIT_FAILURE;
	}

	if (g_dbus_register_interface(dBus, agentObjectPath.c_str(), =
"org.bluez.Agent",
			agent_methods, NULL, NULL, NULL, NULL)) {
		cout << "AgentInterface for " << agentObjectPath << " REGISTERED" << =
endl;
	} else {
		cout << "Failed to register interface for Agent: " << agentObjectPath;
		if (dbus_error_is_set(&dError)) {
			cout << dError.message;
			dbus_error_free(&dError);
		}
		cout << endl;
		return EXIT_FAILURE;
	}

	return	EXIT_SUCCESS;
}

int	agent_uninstall(DBusGConnection *dBusG, string agentObjectPath)
{
	DBusConnection	*dBus=3Ddbus_g_connection_get_connection(dBusG);

	g_dbus_unregister_interface(dBus, agentObjectPath.c_str(), =
"org.bluez.Agent");
	g_dbus_unregister_object(dBus, agentObjectPath.c_str());
	g_dbus_cleanup_connection(dBus);
	return	EXIT_SUCCESS;
}

------=_NextPart_000_0620_01C8DDEF.29666DC0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
------=_NextPart_000_0620_01C8DDEF.29666DC0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_0620_01C8DDEF.29666DC0--
