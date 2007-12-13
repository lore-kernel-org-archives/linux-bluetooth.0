Return-Path: <cyrus@holtmann.org>
Message-ID: <47613E47.10305@access-company.com>
Date: Thu, 13 Dec 2007 15:14:31 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------090106070102060801070809"
Subject: [Bluez-devel] plugin tries
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
--------------090106070102060801070809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

alok,

This is my first try to implement a plugin that would handle hfp the ALP 
way.


Makefile.am is modified to build a library from hf_plugin_alp.*.

main.c reads a string containing the path of the library.
device.h is modified to keep a pointer to a plugin instance.
hf_plugin.c|h wraps plugin loading and calls (see the init func).
hf_plugin_alp.c|h are the plugin itself.


all this probably won't build...

Frederic

--------------090106070102060801070809
Content-Type: text/x-csrc;
 name="hf_plugin_alp.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hf_plugin_alp.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2007       Access Systems Inc. <http://www.access-company.com>
 *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <fcntl.h>
#include <glib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <dbus/dbus-glib.h>
#include <dbus/dbus-glib-lowlevel.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>

#include "device.h"
#include "manager.h"
#include "headset.h"
#include "hf_plugin.h"
#include "hf_plugin_alp.h"

/***********************************************************************
 *
 *	Methods implementation
 *
 ***********************************************************************/


/***********************************************************************
 *
 *	DBUS Method Handler
 *
 ***********************************************************************/

///////////////////////////////////////////////////////////////////////////////
static DBusHandlerResult dbus_handler_HSHF_func(DBusConnection * connection, DBusMessage * message, void *user_data)
///////////////////////////////////////////////////////////////////////////////
{
	UNUSED_PARAMETER(user_data);

	if (dbus_message_is_signal(message, DBUS_INTERFACE_LOCAL, "Disconnected")) {
		dbus_connection_unref(connection);
		connection = NULL;
	}
	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
}

int hf_plugin_alp_init(void** pag)
{
	int result;
	DBusError error;

	*pag = NULL;

	dbus_error_init(&error);

	g_message("%s [%s %s] starting ...", __FUNCTION__, __DATE__, __TIME__);
	connection = dbus_bus_get(DBUS_BUS_SYSTEM, &error);
	if (connection == NULL)
	{
		g_critical("hshfgd: *** Failed to open connection to activating message bus: %s", error.message);
		goto failed;
	}

	g_message("hshfgd: Register object path");
	if (!dbus_connection_register_object_path(connection, hshfserver_object_path, &dbus_vtable_hshfserver, NULL))
	{
		g_critical("hshfgd: *** Failed to register object path");
		goto failed;
	}

	g_message("hshfgd: Acquire service: " HSHF_SERVICE_NAME);
	result = dbus_bus_request_name(connection, HSHF_SERVICE_NAME, 0, &error);
	if (dbus_error_is_set(&error))
	{
		g_critical("hshfgd: *** Failed to acquire service: %s", error.message);
		goto failed;
	}

	dbus_error_free(&error);

	return 0;

	failed:
		dbus_error_free(&error);

	return -ENOTCONN;
}

void hf_plugin_alp_exit(void* ag)
{
	g_message("%s [%s %s] exiting ...", __FUNCTION__, __DATE__, __TIME__);
}


void hf_plugin_alp_state_changed(int state, int type)
{
	gchar *stateP = NULL;
	gchar *profileP;

	g_message("%s", __FUNCTION__);

	switch (state)
	{
		case HEADSET_STATE_DISCONNECTED:
			stateP = HSHF_DISCONNECTED;
			break;
		case HEADSET_STATE_CONNECT_IN_PROGRESS:
			stateP = HSHF_CONNECTING;
			break;
		case HEADSET_STATE_CONNECTED:
			stateP = HSHF_CONNECTED;
			break;
		case HEADSET_STATE_PLAY_IN_PROGRESS:
			stateP = HSHF_AUDIO_CONNECTING;
			break;
		case HEADSET_STATE_PLAYING:
			stateP = HSHF_AUDIO_CONNECTED;
			break;
		default:
			stateP = HSHF_DISCONNECTED;
	}
	switch (type)
	{
		case SVC_HEADSET:
			profileP = HEADSET_PROFILE;
			break;
		case SVC_HANDSFREE:
			profileP = HANDSFREE_PROFILE;
			break;
		default:
			profileP = NO_PROFILE;
	}
	if(connection && hshfclient_name && hshfclient_object_path)
	{
		g_message("%s", __FUNCTION__);

		DBusMessage* msg = dbus_message_new_method_call(hshfclient_name, hshfclient_object_path, HSHFCLIENT_INTERFACE_NAME, "StateChange");
		if(msg) {
			if (dbus_message_append_args (msg,
						G_TYPE_STRING, stateP,
						G_TYPE_STRING, profileP,
						G_TYPE_UCHAR, 0,
						DBUS_TYPE_INVALID)) {
				// In case this gets fired off after we've disconnected.
				if (dbus_connection_get_is_connected (connection)) {
					dbus_connection_send (connection, msg, NULL);
				}
			}
			dbus_message_unref(msg);
		}

	}
}




--------------090106070102060801070809
Content-Type: text/x-chdr;
 name="hf_plugin_alp.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hf_plugin_alp.h"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2007       Access Systems Inc. <http://www.access-company.com>
 *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

--------------090106070102060801070809
Content-Type: text/x-csrc;
 name="hf_plugin.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hf_plugin.c"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2007       Access Systems Inc. <http://www.access-company.com>
 *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <errno.h>
#include <string.h>

#include "hf_plugin.h"
#include "logging.h"

struct hf_service {
	int (*ag_state_changed_cb)(int state);
	int (*ag_indicate_call_cb)(int incoming);
	int (*ag_set_indicator_cb)(hf_indicator_t indicator, int value);
	int (*ag_cancel_call_cb)();
	int (*ag_event_cb)(int event, void *param);
};

struct hf_ag {
	struct hf_service service;
	void *handle;
	void *data;
	int (* init)(void **plg);
	void (* exit)(void *plg);
	void (* state_changed)(int state, int type);
};

void* hf_plugin_init(char* filename)
{
	struct hf_ag *plg;
	char funcname[512];
	char *basename, *dot;

	if(!filename || !*filename)
		return NULL;

	plg = malloc(sizeof(struct hf_ag));
	if(!plg)
		return NULL;

	memset(plg, 0, sizeof(struct hf_ag));

	info("%s(%s)", __FUNCTION__, filename);

	plg->handle = dlopen (filename, RTLD_NOW);
	if(!plg->handle)
		goto failed;

	basename = strrchr(filename, '/');
	if(basename)
		basename++;
	else
		basename = filename;

	if(strncmp(basename, "lib", 3)==0)
		basename += 3;

	dot = strrchr(basename, '.');
	if(dot)
		*dot = '\0';

	sprintf(funcname, "%s_exit", basename);
	debug("loading func %s", funcname);
	plg->exit = dlsym(plg->handle, funcname);
	if(!plg->exit)
		goto failed;

	sprintf(funcname, "%s_init", basename);
	debug("loading func %s", funcname);
	plg->init = dlsym(plg->handle, funcname);
	if(!plg->init)
		goto failed;

	sprintf(funcname, "%s_state_changed", basename);
	debug("loading func %s", funcname);
	plg->state_changed = dlsym(plg->handle, funcname);
	if(!plg->state_changed)
		goto failed;

	if(plg->init(&plg->data)<0)
		goto failed;

	debug("%s successful", funcname);

	return plg;

  failed:
	error("plugin load failed (error:%s, dlerror:%s)", strerror(errno), dlerror());
	hf_plugin_exit(plg);

	return NULL;
}

void hf_plugin_exit(void *plugin)
{
	struct hf_ag *plg = (struct hf_ag*)plugin;

	info("%s", __FUNCTION__);

	if(!plg)
		return;

	if(plg->exit)
		plg->exit(plg->data);

	if(plg->handle)
		dlclose (plg->handle); 

	free(plg);
}

void hf_plugin_state_changed(void *plugin, int state, int type)
{
	struct hf_ag *plg = (struct hf_ag*)plugin;

	info("%s(%d, %d)", __FUNCTION__, state, type);

	if(plg->state_changed)
		plg->state_changed(state, type);
}



--------------090106070102060801070809
Content-Type: text/x-chdr;
 name="hf_plugin.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hf_plugin.h"

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2007       Access Systems Inc. <http://www.access-company.com>
 *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#include <stdint.h>

void *hf_plugin_init(char *filename);
void hf_plugin_exit(void *plugin);
void hf_plugin_state_changed(void *plugin, int state, int type);


--------------090106070102060801070809
Content-Type: text/x-patch;
 name="hfp_plugin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hfp_plugin.patch"

Index: headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.143
diff -u -r1.143 headset.c
--- headset.c	23 Oct 2007 17:17:47 -0000	1.143
+++ headset.c	13 Dec 2007 11:14:47 -0000
@@ -56,6 +56,7 @@
 #include "manager.h"
 #include "error.h"
 #include "headset.h"
+#include "hf_plugin.h"
 
 #define RING_INTERVAL 3000
 
@@ -172,15 +173,23 @@
 static headset_event_t parse_headset_event(const char *buf, char *rsp,
 						int rsp_len)
 {
-	printf("Received: %s\n", buf);
+	debug("Received: %s", buf);
 
-	/* Return an error if this is not a proper AT command */
-	if (strncmp(buf, "AT", 2)) {
-		snprintf(rsp, rsp_len, "\r\nERROR\r\n");
-		return HEADSET_EVENT_INVALID;
+	if (!strncmp(buf, "+", 1)) {
+		buf += 1;
+		goto parse_at_event;
+	}
+	
+	if (!strncmp(buf, "AT", 2)) {
+		buf += 2;
+		goto parse_at_command;
 	}
 
-	buf += 2;
+	/* Return an error if this is not a proper AT command */
+	snprintf(rsp, rsp_len, "\r\nERROR\r\n");
+	return HEADSET_EVENT_INVALID;
+
+parse_at_command:
 
 	if (!strncmp(buf, "+CKPD", 5)) {
 		snprintf(rsp, rsp_len, "\r\nOK\r\n");
@@ -188,10 +197,52 @@
 	} else if (!strncmp(buf, "+VG", 3)) {
 		snprintf(rsp, rsp_len, "\r\nOK\r\n");
 		return HEADSET_EVENT_GAIN;
-	} else {
-		snprintf(rsp, rsp_len, "\r\nERROR\r\n");
-		return HEADSET_EVENT_UNKNOWN;
+	} else if (!strncmp(buf, "A", 1)) {
+		snprintf(rsp, rsp_len, "\r\nOK\r\n");
+		return HEADSET_EVENT_CALL_ANSWERED;
+	} else if (!strncmp(buf, "D", 1)) {
+		snprintf(rsp, rsp_len, "\r\nOK\r\n");
+		return HEADSET_EVENT_DIAL_NUMBER;
+	} else if (!strncmp(buf, "H", 1)) {
+		snprintf(rsp, rsp_len, "\r\nOK\r\n");
+		return HEADSET_EVENT_CALL_HANGUP;
+	} else if (!strncmp(buf, "+BRSF=", 6)) {
+		snprintf(rsp, rsp_len, "\r\n+BRSF:127\r\n");
+		snprintf(rsp+strlen(rsp), rsp_len-strlen(rsp), "\r\nOK\r\n");
+		return HEADSET_EVENT_BRSF;
+	} else if (!strncmp(buf, "+CIND=?", 7)) {
+		snprintf(rsp, rsp_len, "\r\n+CIND:\r\n");
+		snprintf(rsp+strlen(rsp), rsp_len-strlen(rsp), "\r\nOK\r\n");
+		return HEADSET_EVENT_CIND_TEST;
+	} else if (!strncmp(buf, "+CIND", 5)) {
+		snprintf(rsp, rsp_len, "\r\n+CIND:\r\n");
+		snprintf(rsp+strlen(rsp), rsp_len-strlen(rsp), "\r\nOK\r\n");
+		return HEADSET_EVENT_CIND_READ;
+	} else if (!strncmp(buf, "+CMER=", 6)) {
+		snprintf(rsp, rsp_len, "\r\nOK\r\n");
+		return HEADSET_EVENT_CMER;
+	} else if (!strncmp(buf, "+CHLD=?", 7)) {
+		snprintf(rsp, rsp_len, "\r\n+CHLD: 1,2,3,4,1x,2\r\n");
+		snprintf(rsp+strlen(rsp), rsp_len-strlen(rsp), "\r\nOK\r\n");
+		return HEADSET_EVENT_CHLD_TEST;
+	}
+
+	return HEADSET_EVENT_UNKNOWN;
+
+parse_at_event:
+
+	if (!strncmp(buf, "VGS", 3)) {
+		snprintf(rsp, rsp_len, "\r\nOK\r\n");
+		return HEADSET_EVENT_SPEAKER_VOLUME;
 	}
+
+	if (!strncmp(buf, "VGM", 3)) {
+		snprintf(rsp, rsp_len, "\r\nOK\r\n");
+		return HEADSET_EVENT_MICROPHONE_VOLUME;
+	}
+
+	/* Just ignore, no error */
+	return HEADSET_EVENT_INVALID;
 }
 
 static void close_sco(struct device *device)
@@ -261,7 +312,6 @@
 	case HEADSET_EVENT_GAIN:
 		hs_signal_gain_setting(device, &hs->buf[hs->data_start] + 2);
 		break;
-
 	case HEADSET_EVENT_KEYPRESS:
 		if (hs->ring_timer) {
 			g_source_remove(hs->ring_timer);
@@ -274,6 +324,79 @@
 						DBUS_TYPE_INVALID);
 		break;
 
+	case HEADSET_EVENT_STATE_CHANGE:
+		debug("HEADSET_EVENT_STATE_CHANGE");
+		hf_plugin_state_changed(device->plugin, device->headset->state, device->headset->type);
+		break;
+	case HEADSET_EVENT_REMOTE_VOLUME:
+		debug("HEADSET_EVENT_REMOTE_VOLUME");
+		break;
+	case HEADSET_EVENT_SUPPORTED_FEATURES:
+		debug("HEADSET_EVENT_SUPPORTED_FEATURES");
+		break;
+	case HEADSET_EVENT_SPEAKER_VOLUME:
+		hs_signal_gain_setting(device, &hs->buf[hs->data_start] + 0);
+		break;
+	case HEADSET_EVENT_MICROPHONE_VOLUME:
+		hs_signal_gain_setting(device, &hs->buf[hs->data_start] + 0);
+		break;
+	case HEADSET_EVENT_CALL_ANSWERED:
+		debug("HEADSET_EVENT_CALL_ANSWERED");
+		break;
+	case HEADSET_EVENT_CALL_HANGUP:
+		debug("HEADSET_EVENT_CALL_HANGUP");
+		break;
+	case HEADSET_EVENT_DIAL_NUMBER:
+		debug("HEADSET_EVENT_DIAL_NUMBER");
+		break;
+	case HEADSET_EVENT_DIAL_MEMORY:
+		debug("HEADSET_EVENT_DIAL_MEMORY");
+		break;
+	case HEADSET_EVENT_CALL_HOLD:
+		debug("HEADSET_EVENT_CALL_HOLD");
+		break;
+	case HEADSET_EVENT_DTMF:
+		debug("HEADSET_EVENT_DTMF");
+		break;
+	case HEADSET_EVENT_GET_PHONE_NUMBER:
+		debug("HEADSET_EVENT_GET_PHONE_NUMBER");
+		break;
+	case HEADSET_EVENT_DIAL_LAST_NUMBER:
+		debug("HEADSET_EVENT_DIAL_LAST_NUMBER");
+		break;
+	case HEADSET_EVENT_VOICE_RECOGNITION:
+		debug("HEADSET_EVENT_VOICE_RECOGNITION");
+		break;
+	case HEADSET_EVENT_ECNR:
+		debug("HEADSET_EVENT_ECNR");
+		break;
+	case HEADSET_EVENT_RESPONSE_HOLD:
+		debug("HEADSET_EVENT_RESPONSE_HOLD");
+		break;
+	case HEADSET_EVENT_LIST_CURRENT_CALLS:
+		debug("HEADSET_EVENT_LIST_CURRENT_CALLS");
+		break;
+	case HEADSET_EVENT_COMMAND:
+		debug("HEADSET_EVENT_COMMAND");
+		break;
+	case HEADSET_EVENT_BRSF:
+		debug("HEADSET_EVENT_BRSF");
+		break;
+	case HEADSET_EVENT_CIND_TEST:
+		debug("HEADSET_EVENT_CIND_TEST");
+		break;
+	case HEADSET_EVENT_CIND_READ:
+		debug("HEADSET_EVENT_CIND_READ");
+		break;
+	case HEADSET_EVENT_CMER:
+		debug("HEADSET_EVENT_CMER");
+		if(device->headset->type == SVC_HEADSET)
+			headset_set_state(device, HEADSET_STATE_CONNECTED);
+		break;
+	case HEADSET_EVENT_CHLD_TEST:
+		debug("HEADSET_EVENT_CHLD_TEST");
+		break;
+
 	case HEADSET_EVENT_INVALID:
 	case HEADSET_EVENT_UNKNOWN:
 	default:
@@ -546,7 +669,8 @@
 	hs->rfcomm = chan;
 	c->io = NULL;
 
-	headset_set_state(device, HEADSET_STATE_CONNECTED);
+	if(device->headset->type == SVC_HEADSET)
+		headset_set_state(device, HEADSET_STATE_CONNECTED);
 
 	debug("%s: Connected to %s", device->path, hs_address);
 
@@ -571,9 +695,10 @@
 	g_slist_foreach(hs->pending, (GFunc) pending_connect_failed, device);
 	g_slist_free(hs->pending);
 	hs->pending = NULL;
-	if (hs->rfcomm)
-		headset_set_state(device, HEADSET_STATE_CONNECTED);
-	else
+	if (hs->rfcomm) {
+		if(device->headset->type == SVC_HEADSET)
+			headset_set_state(device, HEADSET_STATE_CONNECTED);
+	} else
 		headset_set_state(device, HEADSET_STATE_DISCONNECTED);
 
 	return FALSE;
@@ -1593,6 +1718,8 @@
 		break;
 	}
 
+	hf_plugin_state_changed(dev->plugin, dev->headset->state, dev->headset->type);
+
 	debug("State changed %s: %s -> %s", dev->path, str_state[hs->state],
 		str_state[state]);
 	hs->state = state;
Index: headset.h
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.h,v
retrieving revision 1.31
diff -u -r1.31 headset.h
--- headset.h	23 Oct 2007 17:17:47 -0000	1.31
+++ headset.h	13 Dec 2007 11:14:47 -0000
@@ -31,7 +31,33 @@
 	HEADSET_EVENT_KEYPRESS,
 	HEADSET_EVENT_GAIN,
 	HEADSET_EVENT_UNKNOWN,
-	HEADSET_EVENT_INVALID
+	HEADSET_EVENT_INVALID,
+
+
+	HEADSET_EVENT_BRSF,
+	HEADSET_EVENT_CIND_READ,
+	HEADSET_EVENT_CIND_TEST,
+	HEADSET_EVENT_CMER,
+	HEADSET_EVENT_CHLD_TEST,
+	HEADSET_EVENT_CHLD,
+	HEADSET_EVENT_STATE_CHANGE,
+	HEADSET_EVENT_REMOTE_VOLUME,
+	HEADSET_EVENT_SUPPORTED_FEATURES,
+	HEADSET_EVENT_SPEAKER_VOLUME,
+	HEADSET_EVENT_MICROPHONE_VOLUME,
+	HEADSET_EVENT_CALL_ANSWERED,
+	HEADSET_EVENT_CALL_HANGUP,
+	HEADSET_EVENT_DIAL_NUMBER,
+	HEADSET_EVENT_DIAL_MEMORY,
+	HEADSET_EVENT_CALL_HOLD,
+	HEADSET_EVENT_DTMF,
+	HEADSET_EVENT_GET_PHONE_NUMBER,
+	HEADSET_EVENT_DIAL_LAST_NUMBER,
+	HEADSET_EVENT_VOICE_RECOGNITION,
+	HEADSET_EVENT_ECNR,
+	HEADSET_EVENT_RESPONSE_HOLD,
+	HEADSET_EVENT_LIST_CURRENT_CALLS,
+	HEADSET_EVENT_COMMAND,
 } headset_event_t;
 
 typedef enum {
Index: manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/manager.c,v
retrieving revision 1.80
diff -u -r1.80 manager.c
--- manager.c	24 Oct 2007 21:22:40 -0000	1.80
+++ manager.c	13 Dec 2007 11:14:47 -0000
@@ -62,6 +62,7 @@
 #include "sink.h"
 #include "control.h"
 #include "manager.h"
+#include "hf_plugin.h"
 
 typedef enum {
 	HEADSET	= 1 << 0,
@@ -94,6 +95,8 @@
 	void *cb_data;
 };
 
+static void* plugin = NULL;
+
 static DBusConnection *connection = NULL;
 
 static struct device *default_hs = NULL;
@@ -121,7 +124,7 @@
 	snprintf(path, sizeof(path) - 1,
 			"%s/device%d", AUDIO_MANAGER_PATH, device_id++);
 
-	return device_register(connection, path, bda);
+	return device_register(connection, path, bda, plugin);
 }
 
 static void destroy_device(struct device *device)
@@ -1531,10 +1534,13 @@
 	uint8_t chan = DEFAULT_HS_AG_CHANNEL;
 	sdp_buf_t buf;
 
+	info("Enabling headset server (hs=%d,hf=%d)", enabled->headset, enabled->gateway);
+
 	if (!(enabled->headset || enabled->gateway))
 		return 0;
 
 	hs_server = server_socket(&chan);
+
 	if (!hs_server)
 		return -1;
 
@@ -1558,6 +1564,8 @@
 	if (no_hfp)
 		return 0;
 
+	info("Enabling handsfree server");
+	
 	chan = DEFAULT_HF_AG_CHANNEL;
 
 	hf_server = server_socket(&chan);
@@ -1581,6 +1589,7 @@
 	g_io_add_watch(hf_server, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 						(GIOFunc) ag_io_cb, NULL);
 
+	info("servers enabled");
 	return 0;
 }
 
@@ -1608,10 +1617,12 @@
 }
 
 int audio_init(DBusConnection *conn, struct enabled_interfaces *enable,
-		gboolean no_hfp, gboolean sco_hci, int source_count)
+		gboolean no_hfp, gboolean sco_hci, int source_count, char* plugin_path)
 {
 	int sinks, sources;
 
+	plugin = hf_plugin_init(plugin_path);
+
 	connection = dbus_connection_ref(conn);
 
 	enabled = enable;
@@ -1662,6 +1673,7 @@
 
 void audio_exit(void)
 {
+
 	server_exit();
 
 	dbus_connection_destroy_object_path(connection, AUDIO_MANAGER_PATH);
@@ -1669,6 +1681,8 @@
 	dbus_connection_unref(connection);
 
 	connection = NULL;
+
+	hf_plugin_exit(plugin);
 }
 
 struct device *manager_default_device(void)
Index: manager.h
===================================================================
RCS file: /cvsroot/bluez/utils/audio/manager.h,v
retrieving revision 1.30
diff -u -r1.30 manager.h
--- manager.h	23 Oct 2007 17:17:47 -0000	1.30
+++ manager.h	13 Dec 2007 11:14:47 -0000
@@ -38,7 +38,7 @@
 typedef void (*create_dev_cb_t) (struct device *dev, void *user_data);
 
 int audio_init(DBusConnection *conn, struct enabled_interfaces *enabled,
-		gboolean no_hfp, gboolean sco_hci, int source_count);
+		gboolean no_hfp, gboolean sco_hci, int source_count, char* plugin_path);
 
 void audio_exit(void);
 
Index: main.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/main.c,v
retrieving revision 1.28
diff -u -r1.28 main.c
--- main.c	24 Oct 2007 20:02:53 -0000	1.28
+++ main.c	13 Dec 2007 11:14:47 -0000
@@ -45,15 +45,16 @@
 static gboolean disable_hfp = TRUE;
 static gboolean sco_hci = TRUE;
 static int source_count = 1;
+static char plugin_path[256] =  {0};
 
 static GMainLoop *main_loop = NULL;
 
 static struct enabled_interfaces enabled = {
-	.headset	= TRUE,
+	.headset	= FALSE,
 	.gateway	= FALSE,
 	.sink		= TRUE,
 	.source		= FALSE,
-	.control	= FALSE,
+	.control	= TRUE,
 	.target		= FALSE,
 };
 
@@ -144,6 +145,16 @@
 	} else
 		disable_hfp = no_hfp;
 
+	str = g_key_file_get_string(keyfile, "Headset", "HFPPluginPath", &err);
+	if (err) {
+		debug("%s: %s", file, err->message);
+		g_error_free(err);
+		err = NULL;
+	} else {
+		strncpy(plugin_path, str, sizeof(plugin_path)-1);
+		g_free(str);
+	}
+
 	str = g_key_file_get_string(keyfile, "A2DP", "SourceCount", &err);
 	if (err) {
 		debug("%s: %s", file, err->message);
@@ -154,8 +165,9 @@
 		g_free(str);
 	}
 
-	debug("Config options: DisableHFP=%s, SCORouting=%s, SourceCount=%d",
+	debug("Config options: DisableHFP=%s, HFPPluginPath=%s, SCORouting=%s, SourceCount=%d",
 			disable_hfp ? "true" : "false",
+			plugin_path,
 			sco_hci ? "HCI" : "PCM", source_count);
 
 	g_key_file_free(keyfile);
@@ -196,7 +208,7 @@
 	}
 
 	if (audio_init(conn, &enabled, disable_hfp, sco_hci,
-				source_count) < 0) {
+				source_count, plugin_path) < 0) {
 		error("Audio init failed!");
 		exit(1);
 	}
Index: Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/audio/Makefile.am,v
retrieving revision 1.40
diff -u -r1.40 Makefile.am
--- Makefile.am	25 Oct 2007 10:33:03 -0000	1.40
+++ Makefile.am	13 Dec 2007 11:14:47 -0000
@@ -13,10 +13,18 @@
 bluetoothd_service_audio_SOURCES = main.c \
 	manager.h manager.c headset.h headset.c ipc.h unix.h unix.c \
 	error.h error.c device.h device.c gateway.h gateway.c \
+	hf_plugin.c \
 	sink.c sink.h avdtp.c avdtp.h a2dp.c a2dp.h control.c control.h
 
 bluetoothd_service_audio_LDADD = $(top_builddir)/common/libhelper.a \
-				@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
+				@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@ -ldl
+
+hf_plugin_alpdir = $(libdir)
+hf_plugin_alp_LTLIBRARIES = libhf_plugin_alp.la 
+libhf_plugin_alp_la_SOURCES = hf_plugin_alp.c
+libhf_plugin_alp_la_LDFLAGS = -module -avoid-version -export-dynamic
+libhf_plugin_alp_la_LIBADD = @GLIB_LIBS@ @DBUS_LIBS@ @DBUS_GLIB_LIBS@
+libhf_plugin_alp_la_CFLAGS = @GLIB_CFLAGS@ @DBUS_CFLAGS@ @DBUS_GLIB_CFLAGS@
 
 if ALSA
 alsadir = $(libdir)/alsa-lib
Index: device.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/device.c,v
retrieving revision 1.24
diff -u -r1.24 device.c
--- device.c	25 Oct 2007 10:38:47 -0000	1.24
+++ device.c	13 Dec 2007 11:14:47 -0000
@@ -273,7 +273,7 @@
 }
 
 struct device *device_register(DBusConnection *conn,
-					const char *path, bdaddr_t *bda)
+					const char *path, bdaddr_t *bda, void* plugin)
 {
 	struct device *dev;
 	bdaddr_t src;
@@ -310,6 +310,7 @@
 		return NULL;
 	}
 
+	dev->plugin = plugin;
 	dev->name = get_dev_name(conn, dev->adapter_path, bda);
 	dev->path = g_strdup(path);
 	bacpy(&dev->dst, bda);
Index: device.h
===================================================================
RCS file: /cvsroot/bluez/utils/audio/device.h,v
retrieving revision 1.15
diff -u -r1.15 device.h
--- device.h	25 Oct 2007 10:38:47 -0000	1.15
+++ device.h	13 Dec 2007 11:14:47 -0000
@@ -60,6 +60,7 @@
 	bdaddr_t store;
 	bdaddr_t src;
 	bdaddr_t dst;
+	void* plugin;
 
 	struct headset *headset;
 	struct gateway *gateway;
@@ -70,7 +71,7 @@
 };
 
 struct device *device_register(DBusConnection *conn,
-					const char *path, bdaddr_t *bda);
+					const char *path, bdaddr_t *bda, void* plugin);
 
 int device_store(struct device *device, gboolean is_default);
 

--------------090106070102060801070809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--------------090106070102060801070809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------090106070102060801070809--
