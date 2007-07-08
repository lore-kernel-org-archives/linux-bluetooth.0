Return-Path: <cijoml@volny.cz>
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net, patrik@yes.nu, marcel@holtmann.org
Subject: bluez-users-3.12 diNovo MediaPad patch
Date: Sun, 8 Jul 2007 22:53:58 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_m7UkGXFOLzyxFoD"
Message-Id: <200707082253.58471.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

--Boundary-00=_m7UkGXFOLzyxFoD
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I updated patch to get diNovo MediaPad work with latest bluez-utils.

After patch please call:

autoconf && aclocal && automake && configure && make

Marcel when will be added support for this device into mainstream?

See ya!

Michal

--Boundary-00=_m7UkGXFOLzyxFoD
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="bluez-utils-3.12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-utils-3.12.patch"

diff -uprN bluez-utils-3.12/hidd/dinovo.conf bluez-utils-3.12-edited/hidd/dinovo.conf
--- bluez-utils-3.12/hidd/dinovo.conf	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-3.12-edited/hidd/dinovo.conf	2007-07-07 18:15:44.000000000 +0200
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
diff -uprN bluez-utils-3.12/hidd/fakehid.c bluez-utils-3.12-edited/hidd/fakehid.c
--- bluez-utils-3.12/hidd/fakehid.c	2007-02-18 04:34:50.000000000 +0100
+++ bluez-utils-3.12-edited/hidd/fakehid.c	2007-07-07 18:30:02.000000000 +0200
@@ -32,6 +32,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <signal.h>
+#include <time.h>
 #include <sys/poll.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -49,6 +50,8 @@
 #include "ppoll.h"
 #endif
 
+#include <dbus/dbus.h>
+
 static volatile sig_atomic_t __io_canceled = 0;
 
 static void sig_hup(int sig)
@@ -667,3 +670,528 @@ int celluon_keyboard(const bdaddr_t *src
 
 	return 0;
 }
+
+/************************ Logitech Mediapad Driver ********************************
+ *     (C) 2006-2007 Tim Hentenaar <tim@hentenaar.com>                            *
+ *     Licensed under the GNU General Public License.                             *
+ *     The latest version of this work is available at http://hentenaar.com       *
+ *                                                                                *
+ *     Updates:                                                                   *
+ *     		Thanks to Glen Rolle for suggesting the single-line write         *
+ *     		mode, and for showing me a better method for writing chars        *
+ *     		>= 0x80 from python.
+ *                                                                                *
+ *     Notes:                                                                     *
+ *		1) The i18n for the device isn't currently supported.             *
+ *			The way that the i18n works, is that when the device      *
+ *			connects, the Winblows app retrieves the respective       *
+ *			strings from the device and verifies/updates them.        *
+ *                                                                                *
+ *			Simple enough to do, but I'll worry about it later.       *
+ *		2) The '000' key actually sends 3 0's and is not a special key.   *
+ *		3) The "Copy calulator result to clipboard" requires an           *
+ *		   activation packet that I haven't isolated to date.             *
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
+
+struct mpcmd write_lcd_single[] = { /* Write a single line of text to the LCD */ 
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x22, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x83, 0x11, 0x00, 0x00, 0x00 }, 8},
+	{{ 0 }, 0}
+};
+
+struct mpcmd write_num[] = { /* Set Numlock */
+	{{ 0xA2, 0x01, 0x00 }, 3}
+};
+
+#define N_LCDW_CMDS	14
+#define N_LCDS_CMDS	8
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
+/* #include <dbus/dbus.h> */
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
+"            <method name=\"WriteLine\">\n"
+"              <!-- Max Length: 48 -->\n"
+"              <arg name=\"lineno\" type=\"u\" direction=\"in\"/>\n"
+"              <arg name=\"text\"   type=\"s\" direction=\"in\"/>\n"
+"           </method>\n"
+"            <method name=\"WriteTextBin\">\n"
+"              <!-- Max Length: 144 -->\n"
+"              <arg name=\"text\" type=\"ai\" direction=\"in\"/>\n"
+"           </method>\n"
+"            <method name=\"WriteLineBin\">\n"
+"              <!-- Max Length: 48 -->\n"
+"              <arg name=\"lineno\" type=\"u\"  direction=\"in\"/>\n"
+"              <arg name=\"text\"   type=\"ai\" direction=\"in\"/>\n"
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
+		case 0x59: return KEY_1;
+		case 0x5a: return (mode != 0) ? KEY_DOWN      : KEY_2;
+		case 0x5b: return KEY_3;	
+		case 0x5c: return (mode != 0) ? KEY_LEFT      : KEY_4;
+		case 0x5d: return KEY_5;
+		case 0x5e: return (mode != 0) ? KEY_RIGHT     : KEY_6;
+		case 0x5f: return KEY_7;
+		case 0x60: return (mode != 0) ? KEY_UP        : KEY_8;
+		case 0x61: return KEY_9;
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
+static void set_numlock(int sock, char mode) {
+	struct mpcmd lcdnum; 
+	
+	if (sock < 4) return;
+	memcpy(&lcdnum,write_num,sizeof(struct mpcmd));
+	lcdnum.command[2] = mode;
+	write(sock,lcdnum.command,lcdnum.len);
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
+static void write_lcd_line(int sock, char *text, int lineno) {
+	char lines[16*3]; struct mpcmd *lcdw = NULL; uint32_t i = 0,z = 0,line = 0; uint8_t f = LCD_LINE_DISPLAY;
+
+	if (!text || sock < 4) return; lineno = (lineno > 3) ? 3 : (lineno <= 0) ? 1 : lineno;
+	memset(lines,0x20,16*3); z = (strlen(text) > 16*3) ? 16*3 : strlen(text);
+	for (i=0;i<z;i+=16) {
+		line = i / 16;
+		memcpy(lines+(16*line),text+i,((z-i) < 16) ?  (z-i) : 16);
+	}
+
+	lcdw = malloc(sizeof(struct mpcmd)*N_LCDS_CMDS); 
+	memcpy(lcdw,write_lcd_single,sizeof(struct mpcmd)*N_LCDS_CMDS);
+	
+	/* Copy the line text */
+	memcpy(lcdw[3].command+5,lines,16);        
+	memcpy(lcdw[4].command+5,lines+16,16);
+	memcpy(lcdw[5].command+5,lines+(16*2),16);
+
+	/* Adjust the buffer numbers */
+	*(lcdw[3].command+4) = 0x20 + 3*(lineno-1);
+	*(lcdw[4].command+4) = 0x21 + 3*(lineno-1);
+	*(lcdw[5].command+4) = 0x22 + 3*(lineno-1);
+
+	/* Adjust flags */
+	if (z > 16) {
+		f |= LCD_LINE_SCROLL | LCD_2_BUFFERS;
+		if (z > 16*2) { f &= 0xF0; f |= LCD_3_BUFFERS; }
+	}
+
+	/* Write the text */
+	lcdw[1].command[4 + lineno] = LCD_LINE_INIT;
+	lcdw[6].command[4 + lineno] = f;
+	i = 0; while (lcdw[i].len != 0) { write(sock,lcdw[i].command,lcdw[i].len); i++; } free(lcdw);
+}		
+
+int logitech_mediapad(int sock) {
+	DBusMessage *db_msg, *db_msg_reply; DBusConnection *db_conn = NULL; DBusError db_err; DBusMessageIter db_args,db_sub; dbus_uint32_t db_u1, db_u2, db_u3;
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
+				} else if (dbus_message_is_method_call(db_msg,"com.hentenaar.Dinovo.MediaPad","WriteLine")) {
+					/* WriteLine(lineno, text) Max Length: 48 */ 
+					if (dbus_message_iter_init(db_msg,&db_args)) {
+						if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_UINT32) dbus_message_iter_get_basic(&db_args,&db_u1);
+						if (dbus_message_iter_has_next(&db_args)) {
+							dbus_message_iter_next(&db_args);
+							if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_STRING) {
+								dbus_message_iter_get_basic(&db_args,&cwtmp);
+								if (cwtmp && strlen(cwtmp) > 0) write_lcd_line(sock,cwtmp,db_u1);
+							}
+						}
+					}
+					dinovo_dbus_do_reply(db_msg);
+				} else if (dbus_message_is_method_call(db_msg,"com.hentenaar.Dinovo.MediaPad","WriteTextBin")) {
+					/* WriteTextBin(chars) Max Length: 144 */ 
+					if (dbus_message_iter_init(db_msg,&db_args)) {
+						if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_ARRAY) {
+							dbus_message_iter_recurse(&db_args,&db_sub);
+							if ((cwtmp = malloc(1+(16*9)))) {
+								memset(cwtmp,0,1+(16*9));
+								for (db_u1=0;db_u1<=16*9;db_u1++) {
+									dbus_message_iter_get_basic(&db_sub,&db_u2);
+									cwtmp[db_u1] = (char)db_u2;
+									if (dbus_message_iter_has_next(&db_sub)) dbus_message_iter_next(&db_sub);
+									else break;
+								} 
+								if (db_u1 > 0) write_lcd_text(sock,cwtmp); 
+								free(cwtmp);
+							}
+						}
+					}
+					dinovo_dbus_do_reply(db_msg);
+				} else if (dbus_message_is_method_call(db_msg,"com.hentenaar.Dinovo.MediaPad","WriteLineBin")) {
+					/* WriteLineBin(lineno, chars) Max Length: 48 */ 
+					if (dbus_message_iter_init(db_msg,&db_args)) {
+						if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_UINT32) dbus_message_iter_get_basic(&db_args,&db_u1);
+						if (dbus_message_iter_has_next(&db_args)) {
+							dbus_message_iter_next(&db_args);
+							if (dbus_message_iter_get_arg_type(&db_args) == DBUS_TYPE_ARRAY) {
+								dbus_message_iter_recurse(&db_args,&db_sub);
+								if ((cwtmp = malloc(1+(16*3)))) {
+									memset(cwtmp,0,1+(16*3));
+									for (db_u3=0;db_u3<=16*3;db_u3++) {
+										dbus_message_iter_get_basic(&db_sub,&db_u2);
+										cwtmp[db_u3] = (char)db_u2;
+										if (dbus_message_iter_has_next(&db_sub)) dbus_message_iter_next(&db_sub);
+										else break;
+									} 
+									if (db_u3 > 0) write_lcd_line(sock,cwtmp,db_u1); free(cwtmp);
+								}
+							}
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
+			syslog(LOG_WARNING, "Got mode %d - key_up %d - prev %d - key %x | %x %x %x %x : %x %x %x %x : %x %x %x", mode, discard_keyup, prev_key, buf[0], buf[1], buf[2], buf[3], buf[4], buf[5], buf[6], buf[7], buf[8], buf[9], buf[10], buf[11]);
+			if (buf[1] == 0x03) { /* Special Keys */
+				/* e9 = vol up, ea = vol down, e2 = mute, b5 = ffwd, b6 = rew, b7 = stop, cd = play/pause */
+				if (buf[2] == (char)0x83 && buf[3] == 0x02) { clear_screen(p.fd); if (icons & LCD_ICON_MUTE) { icons = LCD_ICON_MUTE; set_lcd_indicator(p.fd, LCD_ICON_MUTE, 1); }}
+				if (buf[2] == (char)0x00 && buf[3] == 0x00)
+				{/*
+					if (prev_key != 0) {
+						inject_key(fd,prev_key,0);
+						prev_key = 0;
+					} 
+					if (discard_keyup)
+						discard_keyup = 0;
+					else {
+						//mode = 0;
+					}
+				*/}
+				if (buf[2] == (char)0x83 && buf[3] == 0x01) { prev_key = KEY_PHONE;        inject_key(fd,prev_key,1); } /* Media key */
+				if (buf[2] == (char)0xb5 && buf[3] == 0x00) { prev_key = KEY_NEXTSONG;     inject_key(fd,prev_key,1); discard_keyup = 1; }
+				if (buf[2] == (char)0xb6 && buf[3] == 0x00) { prev_key = KEY_PREVIOUSSONG; inject_key(fd,prev_key,1); discard_keyup = 1; }
+				if (buf[2] == (char)0xb7 && buf[3] == 0x00) { prev_key = KEY_STOP;         inject_key(fd,prev_key,1); }
+				if (buf[2] == (char)0xcd && buf[3] == 0x00) { prev_key = KEY_PLAYPAUSE;    inject_key(fd,prev_key,1); }
+				if (buf[2] == (char)0xe2 && buf[3] == 0x00) { prev_key = KEY_MUTE;         inject_key(fd,prev_key,1); 
+									     icons ^= LCD_ICON_MUTE; set_lcd_indicator(p.fd, LCD_ICON_MUTE, ((icons & LCD_ICON_MUTE) != 0) ? 1 : 0); }
+				if (buf[2] == (char)0xe9 && buf[3] == 0x00) { prev_key = KEY_VOLUMEUP;     inject_key(fd,prev_key,1); 
+									     icons = (icons & ~LCD_ICON_MUTE); set_lcd_indicator(p.fd, LCD_ICON_MUTE, 0); }
+				if (buf[2] == (char)0xea && buf[3] == 0x00) { prev_key = KEY_VOLUMEDOWN;   inject_key(fd,prev_key,1); 
+									     icons = (icons & ~LCD_ICON_MUTE); set_lcd_indicator(p.fd, LCD_ICON_MUTE, 0); }
+				if (buf[2] == (char)0x24 && buf[3] == 0x02) { prev_key = KEY_BACK;         inject_key(fd,prev_key,1); }
+				if (buf[2] == (char)0x25 && buf[3] == 0x02) { prev_key = KEY_FORWARD;      inject_key(fd,prev_key,1); }
+			} else if (buf[1] == 0x01 && buf[2] == 0x00) {
+				if (buf[4] == 0x53 && buf[5] == 0x00) {
+					mode ^= 1;
+					prev_key = 0;
+					set_numlock(sock, mode ^ 1);
+				} /* NAV key */
+				else if (buf[4] == 0x00 && buf[5] == 0x00 && prev_key != 0) { inject_key(fd,prev_key,0); }
+				else if (buf[4] != 0x00) { prev_key = translate_key(mode,buf[4] & 0x7f); inject_key(fd,prev_key,1); }
+			} else if (buf[1] == 0x01 && buf[2] == 0x08) {
+				prev_key = KEY_LEFTMETA;	inject_key(fd,prev_key,1);
+			} else if (buf[1] == 0x01 && buf[2] == 0x04) {
+				if (buf[4] == (char)0x3d) { prev_key = KEY_CLOSE;      inject_key(fd,prev_key,1); }
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
diff -uprN bluez-utils-3.12/hidd/hidd.h bluez-utils-3.12-edited/hidd/hidd.h
--- bluez-utils-3.12/hidd/hidd.h	2007-01-28 21:16:47.000000000 +0100
+++ bluez-utils-3.12-edited/hidd/hidd.h	2007-07-07 18:15:44.000000000 +0200
@@ -32,3 +32,5 @@ int epox_presenter(const bdaddr_t *src, 
 int headset_presenter(const bdaddr_t *src, const bdaddr_t *dst, uint8_t channel);
 int jthree_keyboard(const bdaddr_t *src, const bdaddr_t *dst, uint8_t channel);
 int celluon_keyboard(const bdaddr_t *src, const bdaddr_t *dst, uint8_t channel);
+int logitech_mediapad(int sock);
+
diff -uprN bluez-utils-3.12/hidd/main.c bluez-utils-3.12-edited/hidd/main.c
--- bluez-utils-3.12/hidd/main.c	2007-05-09 08:40:42.000000000 +0200
+++ bluez-utils-3.12-edited/hidd/main.c	2007-07-07 18:15:44.000000000 +0200
@@ -519,15 +519,22 @@ connect:
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
 
diff -uprN bluez-utils-3.12/hidd/Makefile bluez-utils-3.12-edited/hidd/Makefile
--- bluez-utils-3.12/hidd/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-3.12-edited/hidd/Makefile	2007-07-07 18:34:07.000000000 +0200
@@ -0,0 +1,614 @@
+# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# hidd/Makefile.  Generated from Makefile.in by configure.
+
+# Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
+# 2003, 2004, 2005  Free Software Foundation, Inc.
+# This Makefile.in is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
+# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
+# PARTICULAR PURPOSE.
+
+
+
+
+srcdir = .
+top_srcdir = ..
+
+pkgdatadir = $(datadir)/bluez-utils
+pkglibdir = $(libdir)/bluez-utils
+pkgincludedir = $(includedir)/bluez-utils
+top_builddir = ..
+am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
+INSTALL = /usr/bin/install -c
+install_sh_DATA = $(install_sh) -c -m 644
+install_sh_PROGRAM = $(install_sh) -c
+install_sh_SCRIPT = $(install_sh) -c
+INSTALL_HEADER = $(INSTALL_DATA)
+transform = $(program_transform_name)
+NORMAL_INSTALL = :
+PRE_INSTALL = :
+POST_INSTALL = :
+NORMAL_UNINSTALL = :
+PRE_UNINSTALL = :
+POST_UNINSTALL = :
+build_triplet = i686-pc-linux-gnu
+host_triplet = i686-pc-linux-gnu
+bin_PROGRAMS = hidd$(EXEEXT)
+subdir = hidd
+DIST_COMMON = $(srcdir)/Makefile.am $(srcdir)/Makefile.in
+ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
+am__aclocal_m4_deps = $(top_srcdir)/acinclude.m4 \
+	$(top_srcdir)/configure.in
+am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
+	$(ACLOCAL_M4)
+mkinstalldirs = $(install_sh) -d
+CONFIG_HEADER = $(top_builddir)/config.h
+CONFIG_CLEAN_FILES =
+am__installdirs = "$(DESTDIR)$(bindir)" "$(DESTDIR)$(man1dir)" \
+	"$(DESTDIR)$(dbusdir)"
+binPROGRAMS_INSTALL = $(INSTALL_PROGRAM)
+PROGRAMS = $(bin_PROGRAMS)
+am__hidd_SOURCES_DIST = main.c hidd.h sdp.c fakehid.c
+am_hidd_OBJECTS = main.$(OBJEXT) sdp.$(OBJEXT) \
+	fakehid.$(OBJEXT)
+hidd_OBJECTS = $(am_hidd_OBJECTS)
+hidd_DEPENDENCIES = $(top_builddir)/common/libhelper.a
+DEFAULT_INCLUDES = -I. -I$(srcdir) -I$(top_builddir)
+depcomp = $(SHELL) $(top_srcdir)/depcomp
+am__depfiles_maybe = depfiles
+COMPILE = $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
+	$(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS)
+LTCOMPILE = $(LIBTOOL) --tag=CC --mode=compile $(CC) $(DEFS) \
+	$(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) \
+	$(AM_CFLAGS) $(CFLAGS)
+CCLD = $(CC)
+LINK = $(LIBTOOL) --tag=CC --mode=link $(CCLD) $(AM_CFLAGS) $(CFLAGS) \
+	$(AM_LDFLAGS) $(LDFLAGS) -o $@
+SOURCES = $(hidd_SOURCES)
+DIST_SOURCES = $(am__hidd_SOURCES_DIST)
+man1dir = $(mandir)/man1
+NROFF = nroff
+MANS = $(man_MANS)
+am__vpath_adj_setup = srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`;
+am__vpath_adj = case $$p in \
+    $(srcdir)/*) f=`echo "$$p" | sed "s|^$$srcdirstrip/||"`;; \
+    *) f=$$p;; \
+  esac;
+am__strip_dir = `echo $$p | sed -e 's|^.*/||'`;
+dbusDATA_INSTALL = $(INSTALL_DATA)
+DATA = $(dbus_DATA)
+ETAGS = etags
+CTAGS = ctags
+DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
+ACLOCAL = ${SHELL} /usr/src/dinovo/bluez-utils-3.12/missing --run aclocal-1.9
+ALSA_CFLAGS = -I/usr/include/alsa  
+ALSA_FALSE = #
+ALSA_LIBS = -lasound -lm -ldl -lpthread  
+ALSA_TRUE = 
+AMDEP_FALSE = #
+AMDEP_TRUE = 
+AMTAR = ${SHELL} /usr/src/dinovo/bluez-utils-3.12/missing --run tar
+AR = ar
+AUDIOSERVICE_FALSE = 
+AUDIOSERVICE_TRUE = #
+AUTOCONF = ${SHELL} /usr/src/dinovo/bluez-utils-3.12/missing --run autoconf
+AUTOHEADER = ${SHELL} /usr/src/dinovo/bluez-utils-3.12/missing --run autoheader
+AUTOMAKE = ${SHELL} /usr/src/dinovo/bluez-utils-3.12/missing --run automake-1.9
+AVCTRL_FALSE = 
+AVCTRL_TRUE = #
+AWK = mawk
+BCCMD_FALSE = 
+BCCMD_TRUE = #
+BLUEZ_CFLAGS = -I/usr/local/include  
+BLUEZ_LIBS = -L/usr/local/lib -lbluetooth  
+CC = gcc
+CCDEPMODE = depmode=gcc3
+CFLAGS = -Wall -O2 -D_FORTIFY_SOURCE=2
+CONFIGFILES_FALSE = #
+CONFIGFILES_TRUE = 
+CPP = gcc -E
+CPPFLAGS = 
+CUPS_FALSE = 
+CUPS_TRUE = #
+CYGPATH_W = echo
+DBUS_CFLAGS = -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include  
+DBUS_GLIB_CFLAGS = 
+DBUS_GLIB_LIBS = 
+DBUS_LIBS = -ldbus-1  
+DEFS = -DHAVE_CONFIG_H
+DEPDIR = .deps
+DFUTOOL_FALSE = 
+DFUTOOL_TRUE = #
+ECHO = echo
+ECHOSERVICE_FALSE = 
+ECHOSERVICE_TRUE = #
+ECHO_C = 
+ECHO_N = -n
+ECHO_T = 
+EGREP = /bin/grep -E
+EXEEXT = 
+EXPAT_FALSE = #
+EXPAT_TRUE = 
+GLIB_CFLAGS = -I$(top_srcdir)/eglib
+GLIB_FALSE = 
+GLIB_LIBS = $(top_builddir)/eglib/libeglib.la
+GLIB_TRUE = #
+GREP = /bin/grep
+HAL_CFLAGS = 
+HAL_FALSE = 
+HAL_LIBS = 
+HAL_TRUE = #
+HCID_FALSE = #
+HCID_TRUE = 
+HID2HCI_FALSE = #
+HID2HCI_TRUE = 
+HIDD_FALSE = #
+HIDD_TRUE = 
+INITSCRIPTS_FALSE = 
+INITSCRIPTS_TRUE = #
+INOTIFY_FALSE = 
+INOTIFY_TRUE = #
+INPUTSERVICE_FALSE = 
+INPUTSERVICE_TRUE = #
+INSTALL_DATA = ${INSTALL} -m 644
+INSTALL_PROGRAM = ${INSTALL}
+INSTALL_SCRIPT = ${INSTALL}
+INSTALL_STRIP_PROGRAM = ${SHELL} $(install_sh) -c -s
+LDFLAGS = 
+LEX = flex
+LEXLIB = -lfl
+LEX_OUTPUT_ROOT = lex.yy
+LIBOBJS = 
+LIBS = 
+LIBTOOL = $(SHELL) $(top_builddir)/libtool
+LN_S = ln -s
+LTLIBOBJS = 
+MAINT = #
+MAINTAINER_MODE_FALSE = 
+MAINTAINER_MODE_TRUE = #
+MAKEINFO = ${SHELL} /usr/src/dinovo/bluez-utils-3.12/missing --run makeinfo
+MANPAGES_FALSE = #
+MANPAGES_TRUE = 
+NETWORKSERVICE_FALSE = 
+NETWORKSERVICE_TRUE = #
+OBEX_FALSE = 
+OBEX_TRUE = #
+OBJEXT = o
+OPENOBEX_CFLAGS = 
+OPENOBEX_LIBS = 
+OPENSYNC_CFLAGS = 
+OPENSYNC_LIBS = 
+PACKAGE = bluez-utils
+PACKAGE_BUGREPORT = 
+PACKAGE_NAME = 
+PACKAGE_STRING = 
+PACKAGE_TARNAME = 
+PACKAGE_VERSION = 
+PAND_FALSE = #
+PAND_TRUE = 
+PATH_SEPARATOR = :
+PCMCIARULES_FALSE = 
+PCMCIARULES_TRUE = #
+PKG_CONFIG = /usr/bin/pkg-config
+RANLIB = ranlib
+SBC_CFLAGS = -I$(top_srcdir)/sbc
+SBC_LIBS = $(top_builddir)/sbc/libsbc.la
+SDPD_FALSE = #
+SDPD_TRUE = 
+SERIALSERVICE_FALSE = 
+SERIALSERVICE_TRUE = #
+SET_MAKE = 
+SHELL = /bin/sh
+STRIP = strip
+SYNCSERVICE_FALSE = 
+SYNCSERVICE_TRUE = #
+TEST_FALSE = 
+TEST_TRUE = #
+USB_CFLAGS =  
+USB_FALSE = #
+USB_LIBS = -lusb  
+USB_TRUE = 
+VERSION = 3.12
+YACC = bison -y
+YFLAGS = 
+ac_ct_CC = gcc
+am__fastdepCC_FALSE = #
+am__fastdepCC_TRUE = 
+am__include = include
+am__leading_dot = .
+am__quote = 
+am__tar = ${AMTAR} chof - "$$tardir"
+am__untar = ${AMTAR} xf -
+bindir = ${exec_prefix}/bin
+build = i686-pc-linux-gnu
+build_alias = 
+build_cpu = i686
+build_os = linux-gnu
+build_vendor = pc
+datadir = ${datarootdir}
+datarootdir = ${prefix}/share
+docdir = ${datarootdir}/doc/${PACKAGE}
+dvidir = ${docdir}
+exec_prefix = ${prefix}
+host = i686-pc-linux-gnu
+host_alias = 
+host_cpu = i686
+host_os = linux-gnu
+host_vendor = pc
+htmldir = ${docdir}
+includedir = ${prefix}/include
+infodir = ${datarootdir}/info
+install_sh = /usr/src/dinovo/bluez-utils-3.12/install-sh
+libdir = /usr/local/lib
+libexecdir = /lib
+localedir = ${datarootdir}/locale
+localstatedir = /var
+mandir = ${datarootdir}/man
+mkdir_p = mkdir -p --
+oldincludedir = /usr/include
+pdfdir = ${docdir}
+prefix = /usr/local
+program_transform_name = s,x,x,
+psdir = ${docdir}
+sbindir = ${exec_prefix}/sbin
+sharedstatedir = ${prefix}/com
+sysconfdir = /etc
+target_alias = 
+dbusdir = $(sysconfdir)/dbus-1/system.d
+dbus_DATA = dinovo.conf
+hidd_SOURCES = main.c hidd.h sdp.c fakehid.c
+hidd_LDADD = -L/usr/local/lib -lbluetooth   -ldbus-1   -lm $(top_builddir)/common/libhelper.a
+AM_CFLAGS = -I/usr/local/include   -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include  
+INCLUDES = -I$(top_srcdir)/common
+man_MANS = hidd.1
+EXTRA_DIST = hidd.1 fakehid.txt dinovo.conf
+MAINTAINERCLEANFILES = Makefile.in
+all: all-am
+
+.SUFFIXES:
+.SUFFIXES: .c .lo .o .obj
+$(srcdir)/Makefile.in: # $(srcdir)/Makefile.am  $(am__configure_deps)
+	@for dep in $?; do \
+	  case '$(am__configure_deps)' in \
+	    *$$dep*) \
+	      cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh \
+		&& exit 0; \
+	      exit 1;; \
+	  esac; \
+	done; \
+	echo ' cd $(top_srcdir) && $(AUTOMAKE) --gnu  hidd/Makefile'; \
+	cd $(top_srcdir) && \
+	  $(AUTOMAKE) --gnu  hidd/Makefile
+.PRECIOUS: Makefile
+Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
+	@case '$?' in \
+	  *config.status*) \
+	    cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh;; \
+	  *) \
+	    echo ' cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__depfiles_maybe)'; \
+	    cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__depfiles_maybe);; \
+	esac;
+
+$(top_builddir)/config.status: $(top_srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
+	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
+
+$(top_srcdir)/configure: # $(am__configure_deps)
+	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
+$(ACLOCAL_M4): # $(am__aclocal_m4_deps)
+	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
+install-binPROGRAMS: $(bin_PROGRAMS)
+	@$(NORMAL_INSTALL)
+	test -z "$(bindir)" || $(mkdir_p) "$(DESTDIR)$(bindir)"
+	@list='$(bin_PROGRAMS)'; for p in $$list; do \
+	  p1=`echo $$p|sed 's/$(EXEEXT)$$//'`; \
+	  if test -f $$p \
+	     || test -f $$p1 \
+	  ; then \
+	    f=`echo "$$p1" | sed 's,^.*/,,;$(transform);s/$$/$(EXEEXT)/'`; \
+	   echo " $(INSTALL_PROGRAM_ENV) $(LIBTOOL) --mode=install $(binPROGRAMS_INSTALL) '$$p' '$(DESTDIR)$(bindir)/$$f'"; \
+	   $(INSTALL_PROGRAM_ENV) $(LIBTOOL) --mode=install $(binPROGRAMS_INSTALL) "$$p" "$(DESTDIR)$(bindir)/$$f" || exit 1; \
+	  else :; fi; \
+	done
+
+uninstall-binPROGRAMS:
+	@$(NORMAL_UNINSTALL)
+	@list='$(bin_PROGRAMS)'; for p in $$list; do \
+	  f=`echo "$$p" | sed 's,^.*/,,;s/$(EXEEXT)$$//;$(transform);s/$$/$(EXEEXT)/'`; \
+	  echo " rm -f '$(DESTDIR)$(bindir)/$$f'"; \
+	  rm -f "$(DESTDIR)$(bindir)/$$f"; \
+	done
+
+clean-binPROGRAMS:
+	@list='$(bin_PROGRAMS)'; for p in $$list; do \
+	  f=`echo $$p|sed 's/$(EXEEXT)$$//'`; \
+	  echo " rm -f $$p $$f"; \
+	  rm -f $$p $$f ; \
+	done
+hidd$(EXEEXT): $(hidd_OBJECTS) $(hidd_DEPENDENCIES) 
+	@rm -f hidd$(EXEEXT)
+	$(LINK) $(hidd_LDFLAGS) $(hidd_OBJECTS) $(hidd_LDADD) $(LIBS)
+
+mostlyclean-compile:
+	-rm -f *.$(OBJEXT)
+
+distclean-compile:
+	-rm -f *.tab.c
+
+include ./$(DEPDIR)/fakehid.Po
+include ./$(DEPDIR)/main.Po
+include ./$(DEPDIR)/sdp.Po
+
+.c.o:
+	if $(COMPILE) -MT $@ -MD -MP -MF "$(DEPDIR)/$*.Tpo" -c -o $@ $<; \
+	then mv -f "$(DEPDIR)/$*.Tpo" "$(DEPDIR)/$*.Po"; else rm -f "$(DEPDIR)/$*.Tpo"; exit 1; fi
+#	source='$<' object='$@' libtool=no \
+#	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) \
+#	$(COMPILE) -c $<
+
+.c.obj:
+	if $(COMPILE) -MT $@ -MD -MP -MF "$(DEPDIR)/$*.Tpo" -c -o $@ `$(CYGPATH_W) '$<'`; \
+	then mv -f "$(DEPDIR)/$*.Tpo" "$(DEPDIR)/$*.Po"; else rm -f "$(DEPDIR)/$*.Tpo"; exit 1; fi
+#	source='$<' object='$@' libtool=no \
+#	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) \
+#	$(COMPILE) -c `$(CYGPATH_W) '$<'`
+
+.c.lo:
+	if $(LTCOMPILE) -MT $@ -MD -MP -MF "$(DEPDIR)/$*.Tpo" -c -o $@ $<; \
+	then mv -f "$(DEPDIR)/$*.Tpo" "$(DEPDIR)/$*.Plo"; else rm -f "$(DEPDIR)/$*.Tpo"; exit 1; fi
+#	source='$<' object='$@' libtool=yes \
+#	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) \
+#	$(LTCOMPILE) -c -o $@ $<
+
+mostlyclean-libtool:
+	-rm -f *.lo
+
+clean-libtool:
+	-rm -rf .libs _libs
+
+distclean-libtool:
+	-rm -f libtool
+uninstall-info-am:
+install-man1: $(man1_MANS) $(man_MANS)
+	@$(NORMAL_INSTALL)
+	test -z "$(man1dir)" || $(mkdir_p) "$(DESTDIR)$(man1dir)"
+	@list='$(man1_MANS) $(dist_man1_MANS) $(nodist_man1_MANS)'; \
+	l2='$(man_MANS) $(dist_man_MANS) $(nodist_man_MANS)'; \
+	for i in $$l2; do \
+	  case "$$i" in \
+	    *.1*) list="$$list $$i" ;; \
+	  esac; \
+	done; \
+	for i in $$list; do \
+	  if test -f $(srcdir)/$$i; then file=$(srcdir)/$$i; \
+	  else file=$$i; fi; \
+	  ext=`echo $$i | sed -e 's/^.*\\.//'`; \
+	  case "$$ext" in \
+	    1*) ;; \
+	    *) ext='1' ;; \
+	  esac; \
+	  inst=`echo $$i | sed -e 's/\\.[0-9a-z]*$$//'`; \
+	  inst=`echo $$inst | sed -e 's/^.*\///'`; \
+	  inst=`echo $$inst | sed '$(transform)'`.$$ext; \
+	  echo " $(INSTALL_DATA) '$$file' '$(DESTDIR)$(man1dir)/$$inst'"; \
+	  $(INSTALL_DATA) "$$file" "$(DESTDIR)$(man1dir)/$$inst"; \
+	done
+uninstall-man1:
+	@$(NORMAL_UNINSTALL)
+	@list='$(man1_MANS) $(dist_man1_MANS) $(nodist_man1_MANS)'; \
+	l2='$(man_MANS) $(dist_man_MANS) $(nodist_man_MANS)'; \
+	for i in $$l2; do \
+	  case "$$i" in \
+	    *.1*) list="$$list $$i" ;; \
+	  esac; \
+	done; \
+	for i in $$list; do \
+	  ext=`echo $$i | sed -e 's/^.*\\.//'`; \
+	  case "$$ext" in \
+	    1*) ;; \
+	    *) ext='1' ;; \
+	  esac; \
+	  inst=`echo $$i | sed -e 's/\\.[0-9a-z]*$$//'`; \
+	  inst=`echo $$inst | sed -e 's/^.*\///'`; \
+	  inst=`echo $$inst | sed '$(transform)'`.$$ext; \
+	  echo " rm -f '$(DESTDIR)$(man1dir)/$$inst'"; \
+	  rm -f "$(DESTDIR)$(man1dir)/$$inst"; \
+	done
+install-dbusDATA: $(dbus_DATA)
+	@$(NORMAL_INSTALL)
+	test -z "$(dbusdir)" || $(mkdir_p) "$(DESTDIR)$(dbusdir)"
+	@list='$(dbus_DATA)'; for p in $$list; do \
+	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
+	  f=$(am__strip_dir) \
+	  echo " $(dbusDATA_INSTALL) '$$d$$p' '$(DESTDIR)$(dbusdir)/$$f'"; \
+	  $(dbusDATA_INSTALL) "$$d$$p" "$(DESTDIR)$(dbusdir)/$$f"; \
+	done
+
+uninstall-dbusDATA:
+	@$(NORMAL_UNINSTALL)
+	@list='$(dbus_DATA)'; for p in $$list; do \
+	  f=$(am__strip_dir) \
+	  echo " rm -f '$(DESTDIR)$(dbusdir)/$$f'"; \
+	  rm -f "$(DESTDIR)$(dbusdir)/$$f"; \
+	done
+
+ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
+	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
+	unique=`for i in $$list; do \
+	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
+	  done | \
+	  $(AWK) '    { files[$$0] = 1; } \
+	       END { for (i in files) print i; }'`; \
+	mkid -fID $$unique
+tags: TAGS
+
+TAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
+		$(TAGS_FILES) $(LISP)
+	tags=; \
+	here=`pwd`; \
+	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
+	unique=`for i in $$list; do \
+	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
+	  done | \
+	  $(AWK) '    { files[$$0] = 1; } \
+	       END { for (i in files) print i; }'`; \
+	if test -z "$(ETAGS_ARGS)$$tags$$unique"; then :; else \
+	  test -n "$$unique" || unique=$$empty_fix; \
+	  $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
+	    $$tags $$unique; \
+	fi
+ctags: CTAGS
+CTAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
+		$(TAGS_FILES) $(LISP)
+	tags=; \
+	here=`pwd`; \
+	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
+	unique=`for i in $$list; do \
+	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
+	  done | \
+	  $(AWK) '    { files[$$0] = 1; } \
+	       END { for (i in files) print i; }'`; \
+	test -z "$(CTAGS_ARGS)$$tags$$unique" \
+	  || $(CTAGS) $(CTAGSFLAGS) $(AM_CTAGSFLAGS) $(CTAGS_ARGS) \
+	     $$tags $$unique
+
+GTAGS:
+	here=`$(am__cd) $(top_builddir) && pwd` \
+	  && cd $(top_srcdir) \
+	  && gtags -i $(GTAGS_ARGS) $$here
+
+distclean-tags:
+	-rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags
+
+distdir: $(DISTFILES)
+	@srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`; \
+	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's|.|.|g'`; \
+	list='$(DISTFILES)'; for file in $$list; do \
+	  case $$file in \
+	    $(srcdir)/*) file=`echo "$$file" | sed "s|^$$srcdirstrip/||"`;; \
+	    $(top_srcdir)/*) file=`echo "$$file" | sed "s|^$$topsrcdirstrip/|$(top_builddir)/|"`;; \
+	  esac; \
+	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
+	  dir=`echo "$$file" | sed -e 's,/[^/]*$$,,'`; \
+	  if test "$$dir" != "$$file" && test "$$dir" != "."; then \
+	    dir="/$$dir"; \
+	    $(mkdir_p) "$(distdir)$$dir"; \
+	  else \
+	    dir=''; \
+	  fi; \
+	  if test -d $$d/$$file; then \
+	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
+	      cp -pR $(srcdir)/$$file $(distdir)$$dir || exit 1; \
+	    fi; \
+	    cp -pR $$d/$$file $(distdir)$$dir || exit 1; \
+	  else \
+	    test -f $(distdir)/$$file \
+	    || cp -p $$d/$$file $(distdir)/$$file \
+	    || exit 1; \
+	  fi; \
+	done
+check-am: all-am
+check: check-am
+all-am: Makefile $(PROGRAMS) $(MANS) $(DATA)
+installdirs:
+	for dir in "$(DESTDIR)$(bindir)" "$(DESTDIR)$(man1dir)" "$(DESTDIR)$(dbusdir)"; do \
+	  test -z "$$dir" || $(mkdir_p) "$$dir"; \
+	done
+install: install-am
+install-exec: install-exec-am
+install-data: install-data-am
+uninstall: uninstall-am
+
+install-am: all-am
+	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am
+
+installcheck: installcheck-am
+install-strip:
+	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
+	  install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
+	  `test -z '$(STRIP)' || \
+	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
+mostlyclean-generic:
+
+clean-generic:
+
+distclean-generic:
+	-test -z "$(CONFIG_CLEAN_FILES)" || rm -f $(CONFIG_CLEAN_FILES)
+
+maintainer-clean-generic:
+	@echo "This command is intended for maintainers to use"
+	@echo "it deletes files that may require special tools to rebuild."
+	-test -z "$(MAINTAINERCLEANFILES)" || rm -f $(MAINTAINERCLEANFILES)
+clean: clean-am
+
+clean-am: clean-binPROGRAMS clean-generic clean-libtool mostlyclean-am
+
+distclean: distclean-am
+	-rm -rf ./$(DEPDIR)
+	-rm -f Makefile
+distclean-am: clean-am distclean-compile distclean-generic \
+	distclean-libtool distclean-tags
+
+dvi: dvi-am
+
+dvi-am:
+
+html: html-am
+
+info: info-am
+
+info-am:
+
+install-data-am: install-dbusDATA install-man
+
+install-exec-am: install-binPROGRAMS
+
+install-info: install-info-am
+
+install-man: install-man1
+
+installcheck-am:
+
+maintainer-clean: maintainer-clean-am
+	-rm -rf ./$(DEPDIR)
+	-rm -f Makefile
+maintainer-clean-am: distclean-am maintainer-clean-generic
+
+mostlyclean: mostlyclean-am
+
+mostlyclean-am: mostlyclean-compile mostlyclean-generic \
+	mostlyclean-libtool
+
+pdf: pdf-am
+
+pdf-am:
+
+ps: ps-am
+
+ps-am:
+
+uninstall-am: uninstall-binPROGRAMS uninstall-dbusDATA \
+	uninstall-info-am uninstall-man
+
+uninstall-man: uninstall-man1
+
+.PHONY: CTAGS GTAGS all all-am check check-am clean clean-binPROGRAMS \
+	clean-generic clean-libtool ctags distclean distclean-compile \
+	distclean-generic distclean-libtool distclean-tags distdir dvi \
+	dvi-am html html-am info info-am install install-am \
+	install-binPROGRAMS install-data install-data-am \
+	install-dbusDATA install-exec install-exec-am install-info \
+	install-info-am install-man install-man1 install-strip \
+	installcheck installcheck-am installdirs maintainer-clean \
+	maintainer-clean-generic mostlyclean mostlyclean-compile \
+	mostlyclean-generic mostlyclean-libtool pdf pdf-am ps ps-am \
+	tags uninstall uninstall-am uninstall-binPROGRAMS \
+	uninstall-dbusDATA uninstall-info-am uninstall-man \
+	uninstall-man1
+
+# Tell versions [3.59,3.63) of GNU make to not export all variables.
+# Otherwise a system limit (for SysV at least) may be exceeded.
+.NOEXPORT:
diff -uprN bluez-utils-3.12/hidd/Makefile.am bluez-utils-3.12-edited/hidd/Makefile.am
--- bluez-utils-3.12/hidd/Makefile.am	2007-05-15 10:06:17.000000000 +0200
+++ bluez-utils-3.12-edited/hidd/Makefile.am	2007-07-07 18:20:12.000000000 +0200
@@ -1,13 +1,16 @@
+if CONFIGFILES
+dbusdir = $(sysconfdir)/dbus-1/system.d
+dbus_DATA = dinovo.conf
+endif
 
 if HIDD
 bin_PROGRAMS = hidd
 
 hidd_SOURCES = main.c hidd.h sdp.c fakehid.c
-
-hidd_LDADD = @BLUEZ_LIBS@ -lm $(top_builddir)/common/libhelper.a
+hidd_LDADD = @BLUEZ_LIBS@ @DBUS_LIBS@ -lm $(top_builddir)/common/libhelper.a
 endif
 
-AM_CFLAGS = @BLUEZ_CFLAGS@
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@
 
 INCLUDES = -I$(top_srcdir)/common
 
@@ -17,6 +20,6 @@ man_MANS = hidd.1
 endif
 endif
 
-EXTRA_DIST = hidd.1 fakehid.txt
+EXTRA_DIST = hidd.1 fakehid.txt dinovo.conf
 
 MAINTAINERCLEANFILES = Makefile.in
diff -uprN bluez-utils-3.12/hidd/Makefile.in bluez-utils-3.12-edited/hidd/Makefile.in
--- bluez-utils-3.12/hidd/Makefile.in	2007-06-24 01:01:12.000000000 +0200
+++ bluez-utils-3.12-edited/hidd/Makefile.in	2007-07-07 18:33:33.000000000 +0200
@@ -14,6 +14,7 @@
 
 @SET_MAKE@
 
+
 srcdir = @srcdir@
 top_srcdir = @top_srcdir@
 VPATH = @srcdir@
@@ -47,7 +48,8 @@ am__configure_deps = $(am__aclocal_m4_de
 mkinstalldirs = $(install_sh) -d
 CONFIG_HEADER = $(top_builddir)/config.h
 CONFIG_CLEAN_FILES =
-am__installdirs = "$(DESTDIR)$(bindir)" "$(DESTDIR)$(man1dir)"
+am__installdirs = "$(DESTDIR)$(bindir)" "$(DESTDIR)$(man1dir)" \
+	"$(DESTDIR)$(dbusdir)"
 binPROGRAMS_INSTALL = $(INSTALL_PROGRAM)
 PROGRAMS = $(bin_PROGRAMS)
 am__hidd_SOURCES_DIST = main.c hidd.h sdp.c fakehid.c
@@ -71,6 +73,14 @@ DIST_SOURCES = $(am__hidd_SOURCES_DIST)
 man1dir = $(mandir)/man1
 NROFF = nroff
 MANS = $(man_MANS)
+am__vpath_adj_setup = srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`;
+am__vpath_adj = case $$p in \
+    $(srcdir)/*) f=`echo "$$p" | sed "s|^$$srcdirstrip/||"`;; \
+    *) f=$$p;; \
+  esac;
+am__strip_dir = `echo $$p | sed -e 's|^.*/||'`;
+dbusDATA_INSTALL = $(INSTALL_DATA)
+DATA = $(dbus_DATA)
 ETAGS = etags
 CTAGS = ctags
 DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
@@ -127,6 +137,7 @@ GLIB_CFLAGS = @GLIB_CFLAGS@
 GLIB_FALSE = @GLIB_FALSE@
 GLIB_LIBS = @GLIB_LIBS@
 GLIB_TRUE = @GLIB_TRUE@
+GREP = @GREP@
 HAL_CFLAGS = @HAL_CFLAGS@
 HAL_FALSE = @HAL_FALSE@
 HAL_LIBS = @HAL_LIBS@
@@ -188,7 +199,6 @@ SBC_CFLAGS = @SBC_CFLAGS@
 SBC_LIBS = @SBC_LIBS@
 SDPD_FALSE = @SDPD_FALSE@
 SDPD_TRUE = @SDPD_TRUE@
-SED = @SED@
 SERIALSERVICE_FALSE = @SERIALSERVICE_FALSE@
 SERIALSERVICE_TRUE = @SERIALSERVICE_TRUE@
 SET_MAKE = @SET_MAKE@
@@ -204,11 +214,8 @@ USB_LIBS = @USB_LIBS@
 USB_TRUE = @USB_TRUE@
 VERSION = @VERSION@
 YACC = @YACC@
-ac_ct_AR = @ac_ct_AR@
+YFLAGS = @YFLAGS@
 ac_ct_CC = @ac_ct_CC@
-ac_ct_RANLIB = @ac_ct_RANLIB@
-ac_ct_STRIP = @ac_ct_STRIP@
-ac_pt_PKG_CONFIG = @ac_pt_PKG_CONFIG@
 am__fastdepCC_FALSE = @am__fastdepCC_FALSE@
 am__fastdepCC_TRUE = @am__fastdepCC_TRUE@
 am__include = @am__include@
@@ -223,33 +230,42 @@ build_cpu = @build_cpu@
 build_os = @build_os@
 build_vendor = @build_vendor@
 datadir = @datadir@
+datarootdir = @datarootdir@
+docdir = @docdir@
+dvidir = @dvidir@
 exec_prefix = @exec_prefix@
 host = @host@
 host_alias = @host_alias@
 host_cpu = @host_cpu@
 host_os = @host_os@
 host_vendor = @host_vendor@
+htmldir = @htmldir@
 includedir = @includedir@
 infodir = @infodir@
 install_sh = @install_sh@
 libdir = @libdir@
 libexecdir = @libexecdir@
+localedir = @localedir@
 localstatedir = @localstatedir@
 mandir = @mandir@
 mkdir_p = @mkdir_p@
 oldincludedir = @oldincludedir@
+pdfdir = @pdfdir@
 prefix = @prefix@
 program_transform_name = @program_transform_name@
+psdir = @psdir@
 sbindir = @sbindir@
 sharedstatedir = @sharedstatedir@
 sysconfdir = @sysconfdir@
 target_alias = @target_alias@
+@CONFIGFILES_TRUE@dbusdir = $(sysconfdir)/dbus-1/system.d
+@CONFIGFILES_TRUE@dbus_DATA = dinovo.conf
 @HIDD_TRUE@hidd_SOURCES = main.c hidd.h sdp.c fakehid.c
-@HIDD_TRUE@hidd_LDADD = @BLUEZ_LIBS@ -lm $(top_builddir)/common/libhelper.a
-AM_CFLAGS = @BLUEZ_CFLAGS@
+@HIDD_TRUE@hidd_LDADD = @BLUEZ_LIBS@ @DBUS_LIBS@ -lm $(top_builddir)/common/libhelper.a
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@
 INCLUDES = -I$(top_srcdir)/common
 @HIDD_TRUE@@MANPAGES_TRUE@man_MANS = hidd.1
-EXTRA_DIST = hidd.1 fakehid.txt
+EXTRA_DIST = hidd.1 fakehid.txt dinovo.conf
 MAINTAINERCLEANFILES = Makefile.in
 all: all-am
 
@@ -401,6 +417,23 @@ uninstall-man1:
 	  echo " rm -f '$(DESTDIR)$(man1dir)/$$inst'"; \
 	  rm -f "$(DESTDIR)$(man1dir)/$$inst"; \
 	done
+install-dbusDATA: $(dbus_DATA)
+	@$(NORMAL_INSTALL)
+	test -z "$(dbusdir)" || $(mkdir_p) "$(DESTDIR)$(dbusdir)"
+	@list='$(dbus_DATA)'; for p in $$list; do \
+	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
+	  f=$(am__strip_dir) \
+	  echo " $(dbusDATA_INSTALL) '$$d$$p' '$(DESTDIR)$(dbusdir)/$$f'"; \
+	  $(dbusDATA_INSTALL) "$$d$$p" "$(DESTDIR)$(dbusdir)/$$f"; \
+	done
+
+uninstall-dbusDATA:
+	@$(NORMAL_UNINSTALL)
+	@list='$(dbus_DATA)'; for p in $$list; do \
+	  f=$(am__strip_dir) \
+	  echo " rm -f '$(DESTDIR)$(dbusdir)/$$f'"; \
+	  rm -f "$(DESTDIR)$(dbusdir)/$$f"; \
+	done
 
 ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
 	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
@@ -479,9 +512,9 @@ distdir: $(DISTFILES)
 	done
 check-am: all-am
 check: check-am
-all-am: Makefile $(PROGRAMS) $(MANS)
+all-am: Makefile $(PROGRAMS) $(MANS) $(DATA)
 installdirs:
-	for dir in "$(DESTDIR)$(bindir)" "$(DESTDIR)$(man1dir)"; do \
+	for dir in "$(DESTDIR)$(bindir)" "$(DESTDIR)$(man1dir)" "$(DESTDIR)$(dbusdir)"; do \
 	  test -z "$$dir" || $(mkdir_p) "$$dir"; \
 	done
 install: install-am
@@ -529,7 +562,7 @@ info: info-am
 
 info-am:
 
-install-data-am: install-man
+install-data-am: install-dbusDATA install-man
 
 install-exec-am: install-binPROGRAMS
 
@@ -557,7 +590,8 @@ ps: ps-am
 
 ps-am:
 
-uninstall-am: uninstall-binPROGRAMS uninstall-info-am uninstall-man
+uninstall-am: uninstall-binPROGRAMS uninstall-dbusDATA \
+	uninstall-info-am uninstall-man
 
 uninstall-man: uninstall-man1
 
@@ -565,14 +599,15 @@ uninstall-man: uninstall-man1
 	clean-generic clean-libtool ctags distclean distclean-compile \
 	distclean-generic distclean-libtool distclean-tags distdir dvi \
 	dvi-am html html-am info info-am install install-am \
-	install-binPROGRAMS install-data install-data-am install-exec \
-	install-exec-am install-info install-info-am install-man \
-	install-man1 install-strip installcheck installcheck-am \
-	installdirs maintainer-clean maintainer-clean-generic \
-	mostlyclean mostlyclean-compile mostlyclean-generic \
-	mostlyclean-libtool pdf pdf-am ps ps-am tags uninstall \
-	uninstall-am uninstall-binPROGRAMS uninstall-info-am \
-	uninstall-man uninstall-man1
+	install-binPROGRAMS install-data install-data-am \
+	install-dbusDATA install-exec install-exec-am install-info \
+	install-info-am install-man install-man1 install-strip \
+	installcheck installcheck-am installdirs maintainer-clean \
+	maintainer-clean-generic mostlyclean mostlyclean-compile \
+	mostlyclean-generic mostlyclean-libtool pdf pdf-am ps ps-am \
+	tags uninstall uninstall-am uninstall-binPROGRAMS \
+	uninstall-dbusDATA uninstall-info-am uninstall-man \
+	uninstall-man1
 
 # Tell versions [3.59,3.63) of GNU make to not export all variables.
 # Otherwise a system limit (for SysV at least) may be exceeded.

--Boundary-00=_m7UkGXFOLzyxFoD--
