Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 29 Dec 2006 18:58:46 -0500
From: Tim Hentenaar <tim@hentenaar.com>
To: Patrik <patrik@yes.nu>
Message-ID: <20061229185846.46b1be0e@localhost>
In-Reply-To: <20061228080111.GA22179@texi.yes.nu>
References: <20061225053148.53825868@localhost>
	<20061225085856.GA26434@texi.yes.nu>
	<20061226030231.2b282145@localhost>
	<20061226094037.GB26434@texi.yes.nu>
	<20061226100915.6f983621@localhost>
	<20061228005747.659f5e4c@localhost>
	<20061228062157.GA18935@texi.yes.nu>
	<20061228013212.6249692a@localhost>
	<20061228080111.GA22179@texi.yes.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_bgxw=b4k9xU24v4ROpvr9gh"
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Logitech DiNovo Media LCD
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--MP_bgxw=b4k9xU24v4ROpvr9gh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 28 Dec 2006 09:01:11 +0100
Patrik <patrik@yes.nu> wrote:

> I'm going to reconfigure my diNovo for Bluetooth mode today or
> tomorrow. Please send me the patch and tell me what version to apply
> it against when you feel it's in "beta" stage or similar.

Attached is a patch against bluez-utils-3.8 as well as a simple python
script to demonstrate the DBUS calls to control the MediaPad. I've CC'd
this to the bluez-devel mailing list, to submit the patch for inclusion.

The only unimplemented [trivial] features are:
	* Calulator result -> clipboard
	* The damn indicator when you press the NAV button. 
	  (it does switch modes, however)

Notes: 
	* Users must have uinput and evdev enabled (for fakehid)
	* The media button is mapped to KEY_PHONE 
	* The "Special Characters" mentioned in the python script might
          be useful for displaying certain messages.
	
To hook into gaim, evolution, etc. I'm probably going to
use the bluetooth-applet from bluez-gnome (to avoid writing a completely
different applet, and for convienience).

> I would love to try it out and put it on the page whenever you feel
> it's ready for a wider audience.
> 
> Also, I really hope that Marcel will have it merged upstream if you
> submit it to him.

It's 100% solid at this point. Feel free to put it up on your
page, and to give me any feedback you might have :) I'll be putting it
up on my personal page shortly as well.

Tim

--MP_bgxw=b4k9xU24v4ROpvr9gh
Content-Type: text/x-patch; name=bluez-utils-3.8.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=bluez-utils-3.8.patch

diff -ru bluez-utils-3.8/hidd/dinovo.conf bluez-utils-3.8/hidd/dinovo.conf
--- /dev/null	2006-12-29 18:32:17.000000000 -0500
+++ bluez-utils-3.8/hidd/dinovo.conf	2006-12-29 18:31:09.000000000 -0500
@@ -0,0 +1,18 @@
+<!-- This configuration file specifies the required security policies
+     for the Logitech Dinovo MediaPad driver. -->
+
+<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
+ "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
+<busconfig>
+  <!-- ../system.conf have denied everything, so we just punch some holes -->
+
+  <policy user="root">
+    <allow own="com.hentenaar.Dinovo.MediaPad"/>
+  </policy>
+
+  <policy at_console="true">
+    <allow send_path="/com/hentenaar"/>
+    <allow send_destination="com.hentenaar.Dinovo.MediaPad" />
+    <allow receive_sender="com.hentenaar.Dinovo.MediaPad"/>
+  </policy>
+</busconfig>
diff -ru bluez-utils-3.8/hidd/fakehid.c bluez-utils-3.8/hidd/fakehid.c
--- bluez-utils-3.8/hidd/fakehid.c	2006-09-29 17:49:18.000000000 -0400
+++ bluez-utils-3.8/hidd/fakehid.c	2006-12-29 18:31:15.000000000 -0500
@@ -32,6 +32,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <signal.h>
+#include <time.h>
 #include <sys/poll.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -519,3 +520,374 @@
 
 	return 0;
 }
+
+/************************ Logitech Mediapad Driver ********************************
+ *     (C) 2006 Tim Hentenaar <tim@hentenaar.com>                                 *
+ *     Licensed under the GNU General Public License.                             *
+ *     The latest version of this work is available at http://hentenaar.com       *
+ *                                                                                *
+ *     Notes:                                                                     *
+ *		1) The i18n for the device isn't currently supported.              *
+ *			The way that the i18n works, is that when the device       *
+ *			connects, the Winblows app retrieves the respective        *
+ *			strings from the device and verifies/updates them.         *
+ *                                                                                *
+ *			Simple enough to do, but I'll worry about it later.        *
+ *		2) The '000' key actually sends 3 0's and is not a special key.    *
+ *		3) The "Copy calulator result to clipboard" requires an            *
+ *		   activation packet that I haven't isolated to date.              *
+ *              4) Git-R-Done!                                                    *
+ **********************************************************************************/
+
+struct mpcmd {
+	char    command[22];
+	uint8_t len;
+};
+
+struct mpcmd clscr[] = { /* Clear the screen */
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x10, 0x00, 0x01, 0x00 }, 8},										
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},										
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }, 21}, 
+	{{ 0xA2, 0x10, 0x00, 0x83, 0x11, 0x00, 0x00, 0x00 }, 8},										
+	{{ 0 }, 0}
+};
+
+struct mpcmd write_icons[] = { /* Set Icons (0 = off) */
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }, 21}
+};
+
+struct mpcmd write_ledspk[] = { /* LED / Speaker Control */
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x50, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x50, 0x00, 0x00, 0x00 }, 8},
+	{{ 0 }, 0}
+};
+
+struct mpcmd write_clock[] = { /* Set the clock */ 
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x31, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x32, 0x02, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x33, 0x00, 0x00, 0x00 }, 8},
+	{{ 0 }, 0}
+};
+
+struct mpcmd write_lcd[] = { /* Write text to the LCD */ 
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x01, 0x01, 0x01 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x22, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x23, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x24, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x25, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x26, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x27, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x28, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x83, 0x11, 0x00, 0x00, 0x00 }, 8},
+	{{ 0 }, 0}
+};
+#define N_LCDW_CMDS	14
+
+/* LCD Line Flags */
+#define LCD_LINE_DISPLAY	0x10
+#define LCD_LINE_SCROLL		0x20
+#define LCD_LINE_INIT		0x01
+#define LCD_2_BUFFERS		0x02
+#define LCD_3_BUFFERS		0x03
+
+/* Icons */
+#define LCD_ICON_EMAIL		0x01
+#define LCD_ICON_IM		0x02
+#define LCD_ICON_MUTE		0x04
+#define LCD_ICON_ALERT		0x08
+#define LCD_ICON_ON		0x01
+#define LCD_ICON_BLINK		0x02
+
+/* Speaker / LED */
+#define LCD_LOW_BEEP		0x01
+#define LCD_LONG_BEEP		0x02
+#define LCD_SHORT_BEEP		0x03
+
+/* Modes */
+#define MODE_NUM		0x00
+#define MODE_NAV		0x01
+
+#define inject_key(X,Y,Z) send_event(X,EV_KEY,Y,Z)
+
+#define DBUS_API_SUBJECT_TO_CHANGE
+#include <dbus/dbus.h>
+#include <syslog.h>
+
+#define dinovo_dbus_do_signal(X) \
+	db_msg = dbus_message_new_signal("/com/hentenaar/Dinovo/MediaPad/"X, "com.hentenaar.Dinovo.MediaPad", X); \
+	dbus_connection_send(db_conn,db_msg,NULL); dbus_connection_flush(db_conn); dbus_message_unref(db_msg); 
+
+#define dinovo_dbus_do_reply(X) \
+	db_msg_reply = dbus_message_new_method_return(X); dbus_connection_send(db_conn,db_msg_reply,NULL); dbus_connection_flush(db_conn); dbus_message_unref(db_msg_reply);
+
+static char *introspect_ret = 
+"<!DOCTYPE node PUBLIC \"-//freedesktop//DTD D-BUS Object Introspection 1.0//EN\" \"http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd\">\n"
+"        <node name=\"/com/hentenaar/Dinovo/MediaPad\">\n"
+"          <interface name=\"com.hentenaar.Dinovo.MediaPad\">\n"
+"            <method name=\"BlinkOrBeep\">\n"
+"              <!-- beep_type: 0 (none) | 1 (low beep) | 2 (beep-beep) | 3 (short beep)\n"
+"                   blink:     0 (no)   | 1 (yes) -->\n"
+"              <arg name=\"beep_type\" type=\"u\" direction=\"in\"/>\n"
+"              <arg name=\"blink\"     type=\"u\" direction=\"in\"/>\n"
+"           </method>\n"
+"            <method name=\"SetIndicator\">\n"
+"              <!-- indicator: 1 (email) | 2 (IM) | 4 (Mute) | 8 (Alert)\n"
+"                   show:      0 (hide)  | 1 (solid) | 2 (blink) -->\n"
+"              <arg name=\"indicator\" type=\"u\" direction=\"in\"/>\n"
+"              <arg name=\"show\"      type=\"u\" direction=\"in\"/>\n"
+"           </method>\n"
+"            <method name=\"SyncClock\" />\n"
+"            <method name=\"WriteText\">\n"
+"              <!-- Max Length: 144 -->\n"
+"              <arg name=\"text\" type=\"s\" direction=\"in\"/>\n"
+"           </method>\n"
+"         </interface>\n"
+"       </node>\n";
+
+static unsigned char translate_key(int mode, unsigned char key) {
+	switch(key) {
+		case 0x54: return KEY_KPSLASH;
+		case 0x55: return KEY_KPASTERISK;
+		case 0x56: return KEY_KPMINUS;
+		case 0x57: return KEY_KPPLUS;
+		case 0x58: return KEY_KPENTER;
+		case 0x59: return (mode != 0) ? KEY_OPEN      : KEY_1;
+		case 0x5a: return (mode != 0) ? KEY_LEFTMETA  : KEY_2;
+		case 0x5b: return (mode != 0) ? KEY_UNDO      : KEY_3;	/* Even though it should be KEY_CLOSE (non-existant) */
+		case 0x5c: return (mode != 0) ? KEY_LEFT      : KEY_4;
+		case 0x5d: return (mode != 0) ? KEY_DOWN      : KEY_5;
+		case 0x5e: return (mode != 0) ? KEY_RIGHT     : KEY_6;
+		case 0x5f: return (mode != 0) ? KEY_BACK      : KEY_7;
+		case 0x60: return (mode != 0) ? KEY_UP        : KEY_8;
+		case 0x61: return (mode != 0) ? KEY_FORWARD   : KEY_9;
+		case 0x62: return KEY_0;
+		case 0x63: return KEY_DOT;
+	}
+	return KEY_UNKNOWN;
+}
+
+static void clear_screen(int sock) {
+	int i = 0;
+	while (clscr[i].len != 0) { write(sock,clscr[i].command,clscr[i].len); i++; }
+}
+
+static void set_lcd_indicator(int sock, uint8_t indicator, int blink) {
+	struct mpcmd lcdwi; uint8_t on = (blink >= 1) ? ((blink == 2) ? LCD_ICON_BLINK : LCD_ICON_ON) : 0; int sel = 5;
+
+	if (sock < 4 || indicator == 0) return;
+	memcpy(&lcdwi,write_icons,sizeof(struct mpcmd));
+	while ((indicator & 1) == 0) { sel++; indicator >>= 1; }
+	while (indicator & 1) { lcdwi.command[sel++] = on; indicator >>= 1; }
+	write(sock,lcdwi.command,lcdwi.len);
+}
+
+static void beep_or_blink(int sock, uint8_t beep, uint8_t blink) {
+	struct mpcmd bbeep[3]; int i = 0;
+
+	if (sock < 4) return;
+	memcpy(bbeep,write_ledspk,sizeof(struct mpcmd)*3);
+
+	if (beep)  bbeep[1].command[5] = (beep & 3);
+	if (blink) bbeep[1].command[6] = 1;
+	while (bbeep[i].len != 0) { write(sock,bbeep[i].command,bbeep[i].len); i++; }
+}
+
+static void set_clock(int sock) {
+	struct mpcmd setclk[4]; struct tm tx; time_t tim = 0; int i = 0;
+
+	if (sock < 4) return;
+	memcpy(setclk,write_clock,sizeof(struct mpcmd)*4);
+	time(&tim); localtime_r(&tim,&tx);
+	setclk[0].command[5] = (char)(tx.tm_sec);
+	setclk[0].command[6] = (char)(tx.tm_min);
+	setclk[0].command[7] = (char)(tx.tm_hour);
+	setclk[1].command[6] = (char)(tx.tm_mday);
+	setclk[1].command[7] = (char)(tx.tm_mon);
+	setclk[2].command[5] = (char)(tx.tm_year - 100);
+	
+	while (setclk[i].len != 0) { write(sock,setclk[i].command,setclk[i].len); i++; }
+}
+
+
+static void write_lcd_text(int sock, char *text) {
+	char lines[16*9]; struct mpcmd *lcdw = NULL; uint32_t i = 0,z = 0,line = 0; uint8_t f1 = LCD_LINE_DISPLAY, f2 = LCD_LINE_DISPLAY, f3 = LCD_LINE_DISPLAY;
+
+	if (!text || sock < 4) return;
+	memset(lines,0x20,16*9); z = (strlen(text) > 16*9) ? 16*9 : strlen(text);
+	for (i=0;i<z;i+=16) {
+		line = i / 16;
+		memcpy(lines+(16*line),text+i,((z-i) < 16) ?  (z-i) : 16);
+	}
+
+	lcdw = malloc(sizeof(struct mpcmd)*N_LCDW_CMDS); 
+	memcpy(lcdw,write_lcd,sizeof(struct mpcmd)*N_LCDW_CMDS);
+	
+	/* Copy the line text */
+	memcpy(lcdw[3].command+5,lines,16);        
+	memcpy(lcdw[4].command+5,lines+(16*3),16);
+	memcpy(lcdw[5].command+5,lines+(16*6),16);
+	memcpy(lcdw[6].command+5,lines+16,16);
+	memcpy(lcdw[7].command+5,lines+(16*4),16);
+	memcpy(lcdw[8].command+5,lines+(16*7),16);
+	memcpy(lcdw[9].command+5,lines+(16*2),16);
+	memcpy(lcdw[10].command+5,lines+(16*5),16);
+	memcpy(lcdw[11].command+5,lines+(16*8),16);
+
+	/* Autoscrolling */
+	if (z > 16*3) { 
+		f1 |= LCD_LINE_SCROLL | LCD_2_BUFFERS; f2 |= LCD_LINE_SCROLL | LCD_2_BUFFERS; f3 |= LCD_LINE_SCROLL | LCD_2_BUFFERS;
+		if (z > 16*6) { f1 &= 0xF0; f1 |= LCD_3_BUFFERS; f2 &= 0xF0; f2 |= LCD_3_BUFFERS;  f3 &= 0xF0; f3 |= LCD_3_BUFFERS; }
+	}
+
+	lcdw[12].command[5] = f1;
+	lcdw[12].command[6] = f2;
+	lcdw[12].command[7] = f3;		
+	i = 0; while (lcdw[i].len != 0) { write(sock,lcdw[i].command,lcdw[i].len); i++; } free(lcdw);
+}		
+
+int logitech_mediapad(int sock) {
+	DBusMessage *db_msg, *db_msg_reply; DBusConnection *db_conn = NULL; DBusError db_err; DBusMessageIter db_args; dbus_uint32_t db_u1, db_u2;
+	char buf[25], *cwtmp; struct pollfd p; int fd = 0, mode = 0, discard_keyup = 0, prev_key = 0, icons = 0, on_dbus = 0, last_dbus_poll = 0, ln = 0;
+	memset(&p,0,sizeof(struct pollfd)); p.fd = sock; p.events = POLLIN | POLLHUP | POLLERR; 
+
+	setsid(); sleep(3); /* Give time for "Connected :-)" to go away */
+	openlog("dinovod",LOG_NDELAY | LOG_CONS | LOG_PID,LOG_DAEMON);
+
+	/* Register with uinput */
+	if ((fd = uinput_create("Logitech Mediapad - Bluetooth Remote Commander", 1, 0)) < 4) {
+		close(sock);
+		closelog();
+		return -1;
+	}
+
+	set_clock(sock); 
+	while (!__io_canceled) {
+		if (!on_dbus) {
+			if ((time(NULL) - last_dbus_poll) > 60) {
+				/* Get-on-D-Bus :P */
+				dbus_error_init(&db_err);
+				if (!(db_conn = dbus_bus_get(DBUS_BUS_SYSTEM,&db_err))) {
+					syslog(LOG_ERR,"Unable to connect to DBUS! Will retry in 60 sec. (%s)",db_err.message ? db_err.message : "Out of Memory?");
+				} else {
+					on_dbus = 1;
+
+					/* Set our name */
+					ln = dbus_bus_request_name(db_conn,"com.hentenaar.Dinovo.MediaPad",DBUS_NAME_FLAG_REPLACE_EXISTING,&db_err);
+					if (dbus_error_is_set(&db_err) || ln != DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER) {
+						on_dbus = 0; dbus_connection_unref(db_conn); db_conn = NULL;
+						if (ln == DBUS_REQUEST_NAME_REPLY_PRIMARY_OWNER) 
+							syslog(LOG_ERR,"Unable to own com.hentenaar.Dinovo.MediaPad! (%s)",db_err.message ? db_err.message : "No Error Message");
+						__io_canceled = 1; break; 
+					} else {
+						/* Send the "Connected" signal */
+						dinovo_dbus_do_signal("Connected");
+					}
+				}
+
+				last_dbus_poll = time(NULL);
+			}
+		} else {
+			/* Poll for DBUS messages */
+			dbus_connection_read_write(db_conn, 0);
+			if ((db_msg = dbus_connection_pop_message(db_conn))) {
+				if (dbus_message_is_signal(db_msg,DBUS_INTERFACE_LOCAL,"Disconnected")) {
+					dbus_connection_unref(db_conn);
+					on_dbus = 0; db_conn = NULL;
+				} else if (strlen(dbus_message_get_interface(db_msg)) == 35 && !strncmp(dbus_message_get_interface(db_msg),"org.freedesktop.DBus.Introspectable",35)) {
+					db_msg_reply = dbus_message_new_method_return(db_msg); 
+					dbus_message_iter_init_append(db_msg_reply,&db_args);
+					dbus_message_iter_append_basic(&db_args,DBUS_TYPE_STRING,&introspect_ret);
+					dbus_connection_send(db_conn,db_msg_reply,NULL); dbus_connection_flush(db_conn); dbus_message_unref(db_msg_reply);
+				} else if (dbus_message_is_method_call(db_msg,"com.hentenaar.Dinovo.MediaPad","BlinkOrBeep")) {
+					/* BlinkOrBeep(beep_type, blink) 
+					 * 	[beep_type := 0 (none) | 1 (low beep) | 2 (beep-beep) | 3 (short beep) ] 
+					 *	[blink     := 0 (no)   | 1 (yes) ]
+					 */
+					if (dbus_message_iter_init(db_msg,&db_args)) {
+						db_u1 = db_u2 = 0;
+						if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_UINT32)  dbus_message_iter_get_basic(&db_args,&db_u1);
+						if (dbus_message_iter_has_next(&db_args)) {
+							dbus_message_iter_next(&db_args);
+							if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_UINT32) dbus_message_iter_get_basic(&db_args,&db_u2);
+						}
+						beep_or_blink(sock,db_u1,db_u2);
+					}
+					dinovo_dbus_do_reply(db_msg);
+				} else if (dbus_message_is_method_call(db_msg,"com.hentenaar.Dinovo.MediaPad","WriteText")) {
+					/* WriteText(text) Max Length: 144 */ 
+					if (dbus_message_iter_init(db_msg,&db_args)) {
+						if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_STRING) {
+							dbus_message_iter_get_basic(&db_args,&cwtmp);
+							if (cwtmp && strlen(cwtmp) > 0) write_lcd_text(sock,cwtmp);
+						}
+					}
+					dinovo_dbus_do_reply(db_msg);
+				} else if (dbus_message_is_method_call(db_msg,"com.hentenaar.Dinovo.MediaPad","SetIndicator")) {
+					/* SetIndicator(indicator, blink) 
+					 *	[ indicator := see LCD_ICON_* above ]
+					 *	[ blink     := 0 (off) | 1 (on) | >= 2 (blink) ] 
+					 */ 
+					if (dbus_message_iter_init(db_msg,&db_args)) {
+						if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_UINT32) dbus_message_iter_get_basic(&db_args,&db_u1);
+						if (dbus_message_iter_has_next(&db_args)) {
+							dbus_message_iter_next(&db_args);
+							if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_UINT32) dbus_message_iter_get_basic(&db_args,&db_u2);
+						}
+						set_lcd_indicator(sock,db_u1,db_u2);
+					}
+					dinovo_dbus_do_reply(db_msg);
+				} else if (dbus_message_is_method_call(db_msg,"com.hentenaar.Dinovo.MediaPad","SyncClock")) {
+					/* SyncClock() */
+					set_clock(sock);
+					dinovo_dbus_do_reply(db_msg);
+				} 
+				dbus_message_unref(db_msg); 
+			}
+		}
+		
+		p.revents = 0; p.fd = sock;
+		if (poll(&p,1,1) < 0) { __io_canceled = 1; break; }
+		if (p.revents & POLLIN) {
+			if ((ln = read(p.fd, buf, sizeof(buf))) <= 0) { __io_canceled = 1; break; }
+			if (buf[1] == 0x03) { /* Special Keys */
+				/* e9 = vol up, ea = vol down, e2 = mute, b5 = ffwd, b6 = rew, b7 = stop, cd = play/pause */
+				if (buf[2] == (char)0x83 && buf[3] == 0x02) { clear_screen(p.fd); if (icons & LCD_ICON_MUTE) { icons = LCD_ICON_MUTE; set_lcd_indicator(p.fd, LCD_ICON_MUTE, 1); }}
+				if (buf[2] == (char)0x00 && buf[3] == 0x00) { if (prev_key != 0) { inject_key(fd,prev_key,0); prev_key = 0; } 
+									      if (discard_keyup) discard_keyup = 0; else mode = 0; }
+				if (buf[2] == (char)0x83 && buf[3] == 0x01) { prev_key = KEY_PHONE;        inject_key(fd,prev_key,1); } /* Media key */
+				if (buf[2] == (char)0xb5 && buf[3] == 0x00) { prev_key = KEY_NEXTSONG;     inject_key(fd,prev_key,1); discard_keyup = 1; }
+				if (buf[2] == (char)0xb6 && buf[3] == 0x00) { prev_key = KEY_PREVIOUSSONG; inject_key(fd,prev_key,1); discard_keyup = 1; }
+				if (buf[2] == (char)0xb7 && buf[3] == 0x00) { prev_key = KEY_STOP;         inject_key(fd,prev_key,1); }
+				if (buf[2] == (char)0xcd && buf[3] == 0x00) { prev_key = KEY_PLAYPAUSE;    inject_key(fd,prev_key,1); }
+				if (buf[2] == (char)0xe2 && buf[3] == 0x00) { prev_key = KEY_MUTE;         inject_key(fd,prev_key,1); 
+									     icons = ((icons & LCD_ICON_MUTE) != 0) ? (icons & ~LCD_ICON_MUTE) : (icons | LCD_ICON_MUTE); 
+									     set_lcd_indicator(p.fd, LCD_ICON_MUTE, ((icons & LCD_ICON_MUTE) != 0) ? 1 : 0); }
+				if (buf[2] == (char)0xe9 && buf[3] == 0x00) { prev_key = KEY_VOLUMEUP;     inject_key(fd,prev_key,1); 
+									     icons = (icons & ~LCD_ICON_MUTE); set_lcd_indicator(p.fd, LCD_ICON_MUTE, 0); }
+				if (buf[2] == (char)0xea && buf[3] == 0x00) { prev_key = KEY_VOLUMEDOWN;   inject_key(fd,prev_key,1); 
+									     icons = (icons & ~LCD_ICON_MUTE); set_lcd_indicator(p.fd, LCD_ICON_MUTE, 0); }
+			} else if (buf[1] == 0x01 && buf[2] == 0x00) {
+				if (buf[4] == 0x53 && buf[5] == 0x00) { mode = 1; prev_key = 0; } /* NAV key */
+				else if (buf[4] == 0x00 && buf[5] == 0x00 && prev_key != 0) inject_key(fd,prev_key,0);
+				else if (buf[4] != 0x00) { prev_key = translate_key(mode,buf[4] & 0x7f); inject_key(fd,prev_key,1); }
+			} else if (buf[1] == 0x11 && buf[2] == 0x0a) { /* Calculator Result */
+				//cwtmp = &buf[4]; while (*cwtmp && *cwtmp == 0x20) cwtmp++;
+				syslog(LOG_WARNING,"Got Calc result");
+			}
+		} 
+		usleep(20);
+	}
+
+	if (db_conn) { dinovo_dbus_do_signal("Disconnected"); dbus_connection_unref(db_conn); }
+	ioctl(fd, UI_DEV_DESTROY);
+	close(fd);
+	close(sock); 
+	closelog();
+	return 0;
+}
+
diff -ru bluez-utils-3.8/hidd/hidd.h bluez-utils-3.8/hidd/hidd.h
--- bluez-utils-3.8/hidd/hidd.h	2006-09-29 17:49:18.000000000 -0400
+++ bluez-utils-3.8/hidd/hidd.h	2006-12-29 18:31:36.000000000 -0500
@@ -32,3 +32,5 @@
 int headset_presenter(const bdaddr_t *src, const bdaddr_t *dst, uint8_t channel);
 int jthree_keyboard(const bdaddr_t *src, const bdaddr_t *dst, uint8_t channel);
 int celluon_keyboard(const bdaddr_t *src, const bdaddr_t *dst, uint8_t channel);
+int logitech_mediapad(int sock);
+
diff -ru bluez-utils-3.8/hidd/main.c bluez-utils-3.8/hidd/main.c
--- bluez-utils-3.8/hidd/main.c	2006-09-29 17:49:18.000000000 -0400
+++ bluez-utils-3.8/hidd/main.c	2006-12-29 18:31:28.000000000 -0500
@@ -506,15 +506,22 @@
 		exit(1);
 	}
 
-	err = create_device(ctl, csk, isk, subclass, 1, 1, bootonly, encrypt, timeout);
-	if (err < 0) {
-		fprintf(stderr, "HID create error %d (%s)\n",
-						errno, strerror(errno));
-		close(isk);
-		sleep(1);
-		close(csk);
-		close(ctl);
-		exit(1);
+	if (!strcmp(req.name,"Logitech Bluetooth Mediapad")) {
+		if (!fork()) {
+			logitech_mediapad(isk);
+			close(ctl);
+			exit(0);
+		}
+	} else {
+		err = create_device(ctl, csk, isk, subclass, 1, 1, bootonly, encrypt, timeout);
+		if (err < 0) {
+			fprintf(stderr, "HID create error %d (%s)\n",errno, strerror(errno));
+			close(isk);
+			sleep(1);
+			close(csk);
+			close(ctl);
+			exit(1);
+		}
 	}
 }
 
diff -ru bluez-utils-3.8/hidd/Makefile.am bluez-utils-3.8/hidd/Makefile.am
--- bluez-utils-3.8/hidd/Makefile.am	2006-09-21 17:28:45.000000000 -0400
+++ bluez-utils-3.8/hidd/Makefile.am	2006-12-29 18:31:03.000000000 -0500
@@ -1,15 +1,19 @@
+if CONFIGFILES
+dbusdir = $(sysconfdir)/dbus-1/system.d
+dbus_DATA = dinovo.conf
+endif
 
 bin_PROGRAMS = hidd
 
 hidd_SOURCES = main.c hidd.h sdp.c uinput.h fakehid.c
-hidd_LDADD = @BLUEZ_LIBS@ -lm $(top_builddir)/common/libhelper.a
+hidd_LDADD = @BLUEZ_LIBS@ @DBUS_LIBS@ -lm $(top_builddir)/common/libhelper.a
 
-AM_CFLAGS = @BLUEZ_CFLAGS@
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common
 
 man_MANS = hidd.1
 
-EXTRA_DIST = $(man_MANS) fakehid.txt
+EXTRA_DIST = $(man_MANS) fakehid.txt dinovo.conf
 
 MAINTAINERCLEANFILES = Makefile.in

--MP_bgxw=b4k9xU24v4ROpvr9gh
Content-Type: text/x-python; name=dinovo-dbus-test.py
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dinovo-dbus-test.py

#!/usr/bin/env python

import dbus

# Indicators
LCD_ICON_EMAIL = 1
LCD_ICON_IM    = 2
LCD_ICON_MUTE  = 4
LCD_ICON_ALARM = 8

# Indicator States
LCD_ICON_OFF   = 0
LCD_ICON_ON    = 1
LCD_ICON_BLINK = 2

# LCD Beep Codes
LCD_DONT_BEEP  = 0
LCD_BEEP_DEEP  = 1
LCD_BEEP_SHORT = 2
LCD_BEEP_LONG  = 3

# LCD LED States
LCD_LED_OFF    = 0
LCD_LED_BLINK  = 1

# Special Characters (which might be useful)
#	Note: In the interest of i18n, it's worth mentioning that the majority of Cyrillic characters are at
#	      0x80 - 0x8f. The ones that overlap with Greek are in the 0x90 - 0x9f range, along with various
#	      Symbols (heart, 8th note, 16th node, alarm bell, etc.)
#
#	For Cyrillic, the messages work fine on Winblows, which means that the LCD uses the ASCII character set
#       modified as it would be for KOI8-R.

SMALL_TRIANGLE_RIGHT = "\x03"
SMALL_TRIANGLE_LEFT  = "\x04"
LARGE_TRIANGLE_RIGHT = "\x10"
LARGE_TRIANGLE_LEFT  = "\x11"
QUOTE_UP             = "\x12"
QUOTE_DOWN           = "\x13"
SMALL_TRIANGLES_UP   = "\x14"
SMALL_TRIANGLES_DOWN = "\x15"
BULLET               = "\x16"
RETURN_SYMBOL        = "\x17"
ARROW_UP             = "\x18"
ARROW_DOWN           = "\x19"
ARROW_RIGHT          = "\x1a"
ARROW_LEFT           = "\x1b"
LEQUAL               = "\x1c"
GEQUAL               = "\x1d"
LARGE_TRIANGLE_UP    = "\x1e"
LARGE_TRIANGLE_DOWN  = "\x1f"

bus = dbus.SystemBus()
obj = bus.get_object("com.hentenaar.Dinovo.MediaPad", "/com/hentenaar/Dinovo/MediaPad")
intf = dbus.Interface(obj, "com.hentenaar.Dinovo.MediaPad")

intf.SetIndicator(LCD_ICON_ALARM,LCD_ICON_BLINK)
intf.BlinkOrBeep(LCD_BEEP_SHORT,LCD_LED_OFF)
intf.WriteText(" -------------- "
               "| Dinovo Linux |"
	       " -------------- ")


--MP_bgxw=b4k9xU24v4ROpvr9gh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--MP_bgxw=b4k9xU24v4ROpvr9gh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--MP_bgxw=b4k9xU24v4ROpvr9gh--
