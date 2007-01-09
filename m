Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 8 Jan 2007 23:38:13 -0500
From: Tim Hentenaar <tim@hentenaar.com>
To: "Glen Rolle" <g.len@gmx.de>
Message-ID: <20070108233813.5588d305@localhost>
In-Reply-To: <20070108221038.266790@gmx.net>
References: <20070108221038.266790@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP__53sIWw._.BI=dB3QKYP5bV"
Cc: Tjalfe <tjalfefisk@gmail.com>, bluez-devel@lists.sourceforge.net,
        patrik@yes.nu
Subject: [Bluez-devel] [Patch Update] Re: Logitech DiNovo Media LCD
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

--MP__53sIWw._.BI=dB3QKYP5bV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 08 Jan 2007 23:10:38 +0100
"Glen Rolle" <g.len@gmx.de> wrote:

> Hello!
> 
> First of all I want to thank you for your efforts developping the LCD
> communication stuff. I have been working on this since several weeks
> to no avail and it seems that my driver programming knowledge was not
> good enough.
> 
> I was working with your patch for several days now and have some
> comments and suggestions.

The thanks, as well as the comments are much appreciated. :)
 
> - When patching I had a problem with the makefile generated
> automatically. The DBUS tags you added in the patch were integrated
> as empty strings into the makefile. I had to place the correct
> contents manually. Don't know why this happened. (I use debian
> testing with bluez-utils 3.7)

You need to rebuild the Makefile.in from Makefile.am by running
automake in the bluez-utils directory after patching, before you run
configure. You might want to retry it with a fresh copy. 

> - I have extended the interface for the lcd and added following
> functions. I wanted to have more atomic control over the LCD.
> 
> -- WriteLine (line_number, scroll_mode, string)
> --- Write only a single line, so that you can set content and scroll
> mode separately for each line.

IMO, it's easier to have the driver auto-determine the scroll mode. 
This saves the programmer from having to deal with splitting up the
text.

> 
> -- SetScreenMode (mode)
> --- An easy way to switch between the 3-line display (0) and the
> clock display (1).

You can switch back to the clock display by pressing "Clear Screen",
and to the "3-line" mode by writing text. (This is so that alerts
persist until the user presses "Clear Screen.")

> 
> -- SendRawData (array_of_integers)
> --- Mainly for testing and debugging purpose, so that you can send
> commands to the LCD without having to recompile fakehid all the time.
> The raw data starts with 0x10 and 0x11 resp. The 0xA2 will be send
> automaticallay.

This could be useful under certain circumstances, however, there's
really no need at this point to send raw data to the mediapad, because
the functionality is quite complete (With the exception of the Nav
indicator and the Calculator -> Clipboard, of course (I know how it
works sending the data back (I've got code in place in the driver), but
I can't seem to isolate the init packet.)) 

> It might be useful to split some of your funtions e. g. the WriteText
> into a "initScreen" part and the text display. (This would remove the
> flashing display when sending new text with WriteText.)

If you look at the code that writes the text out to the display, it
handles the scrolling of the display automatically (for simplicity.)

I do concur that a WriteLine() function would be helpful, so I've added the following (based on your suggestions):

	WriteLine(lineno, text) 
	WriteLineBin(lineno, chars)
	WriteTextBin(lineno, chars)

> - hidd is not always initialized correctly. You can connect the
> MediaPad on two different ways. First is to run hidd --search and
> press the connect button on the MediaPad. This is a bit ugly compared
> to the second method but correctly initializes your DBus-interface
> (and does not show the NAV-led) The second method is to just press a
> key on the MediaPad. It will connect and will be visible to hidd, but
> the connection method in hidd is not run and therefore the
> DBUS-interface is not available. (But the NAV-led works) I think this
> is not a problem with the work you done, but maybe it helps us to
> improve the usage of the MediaPad.

The "second method" is because hidd passes the connection into the
kernel's bluetooth HID driver (which should really be in userspace,
IMHO) - and thus is "never heard from again."

> As a conclusion I would like to suggest that we have one or two more
> reviews on the code and then resend it to the bluez-devel list and
> confirm that it is working. Then we could share some better code and
> the confirmation seems to be neccessary to make the maintainer
> include a patch. (Some kind of approval by other users?)

Attached is an patch against my previous version, for both the python
script, and the driver. I've CC'd this to the list. FYI, I'll be
updating the patch on my website here shortly.

Pardon my nit-picking, however, I did notice a couple bugs in the
patch you attached: 

> + +struct mpcmd {
> +	char    command[22];
> +	uint8_t len;
> +};
> +

> +/*
> + * Send raw data to the MediaPad
> + * The data does not require the 0xa2 at the beginning
> + */
> +static void send_raw_data(int sock, char *data, int length) {
> +	struct mpcmd lcdwi; 
> +	if (!data || sock < 4) return;
> +	memcpy(&lcdwi,write_raw,sizeof(struct mpcmd));
> +	int i;
> +	for (i = 0; i < length; i++) {
> +		lcdwi.command[i + 1] = data[i];

		This will cause a segfault by writing past the end of
		lcdwi.command if (i+1) > 22, or by reading beyond the
		end of data if i is beyond the end of data.

> +	}
> +
> +	write(sock,lcdwi.command,length+1);

		Again, another potential segfault (if length + 1 > 22)

> +}

Regards,

Tim
--MP__53sIWw._.BI=dB3QKYP5bV
Content-Type: text/x-patch; name=bluez-utils-3.8-new.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=bluez-utils-3.8-new.patch

--- bluez-utils-3.8/hidd/fakehid.c	2006-12-29 18:37:41.000000000 -0500
+++ bluez-utils-3.8/hidd/fakehid.c	2007-01-08 23:13:46.000000000 -0500
@@ -522,20 +522,25 @@
 }
 
 /************************ Logitech Mediapad Driver ********************************
- *     (C) 2006 Tim Hentenaar <tim@hentenaar.com>                                 *
+ *     (C) 2006-2007 Tim Hentenaar <tim@hentenaar.com>                            *
  *     Licensed under the GNU General Public License.                             *
  *     The latest version of this work is available at http://hentenaar.com       *
  *                                                                                *
+ *     Updates:                                                                   *
+ *     		Thanks to Glen Rolle for suggesting the single-line write         *
+ *     		mode, and for showing me a better method for writing chars        *
+ *     		>= 0x80 from python.
+ *                                                                                *
  *     Notes:                                                                     *
- *		1) The i18n for the device isn't currently supported.              *
- *			The way that the i18n works, is that when the device       *
- *			connects, the Winblows app retrieves the respective        *
- *			strings from the device and verifies/updates them.         *
+ *		1) The i18n for the device isn't currently supported.             *
+ *			The way that the i18n works, is that when the device      *
+ *			connects, the Winblows app retrieves the respective       *
+ *			strings from the device and verifies/updates them.        *
  *                                                                                *
- *			Simple enough to do, but I'll worry about it later.        *
- *		2) The '000' key actually sends 3 0's and is not a special key.    *
- *		3) The "Copy calulator result to clipboard" requires an            *
- *		   activation packet that I haven't isolated to date.              *
+ *			Simple enough to do, but I'll worry about it later.       *
+ *		2) The '000' key actually sends 3 0's and is not a special key.   *
+ *		3) The "Copy calulator result to clipboard" requires an           *
+ *		   activation packet that I haven't isolated to date.             *
  *              4) Git-R-Done!                                                    *
  **********************************************************************************/
 
@@ -586,7 +591,21 @@
 	{{ 0xA2, 0x10, 0x00, 0x83, 0x11, 0x00, 0x00, 0x00 }, 8},
 	{{ 0 }, 0}
 };
+
+struct mpcmd write_lcd_single[] = { /* Write a single line of text to the LCD */ 
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x10, 0x10, 0x10 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x81, 0x10, 0x00, 0x00, 0x00 }, 8},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x11, 0x00, 0x82, 0x22, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20 }, 21},
+	{{ 0xA2, 0x10, 0x00, 0x80, 0x12, 0x10, 0x10, 0x10 }, 8},
+	{{ 0xA2, 0x10, 0x00, 0x83, 0x11, 0x00, 0x00, 0x00 }, 8},
+	{{ 0 }, 0}
+};
+
 #define N_LCDW_CMDS	14
+#define N_LCDS_CMDS	8
 
 /* LCD Line Flags */
 #define LCD_LINE_DISPLAY	0x10
@@ -646,6 +665,20 @@
 "              <!-- Max Length: 144 -->\n"
 "              <arg name=\"text\" type=\"s\" direction=\"in\"/>\n"
 "           </method>\n"
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
 "         </interface>\n"
 "       </node>\n";
 
@@ -713,7 +746,6 @@
 	while (setclk[i].len != 0) { write(sock,setclk[i].command,setclk[i].len); i++; }
 }
 
-
 static void write_lcd_text(int sock, char *text) {
 	char lines[16*9]; struct mpcmd *lcdw = NULL; uint32_t i = 0,z = 0,line = 0; uint8_t f1 = LCD_LINE_DISPLAY, f2 = LCD_LINE_DISPLAY, f3 = LCD_LINE_DISPLAY;
 
@@ -748,10 +780,44 @@
 	lcdw[12].command[6] = f2;
 	lcdw[12].command[7] = f3;		
 	i = 0; while (lcdw[i].len != 0) { write(sock,lcdw[i].command,lcdw[i].len); i++; } free(lcdw);
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
+	i = 0; while (lcdw[i].len != 0) { write(sock,lcdw[i].command,lcdw[i].len); i++; } free(lcdw);
 }		
 
 int logitech_mediapad(int sock) {
-	DBusMessage *db_msg, *db_msg_reply; DBusConnection *db_conn = NULL; DBusError db_err; DBusMessageIter db_args; dbus_uint32_t db_u1, db_u2;
+	DBusMessage *db_msg, *db_msg_reply; DBusConnection *db_conn = NULL; DBusError db_err; DBusMessageIter db_args,db_sub; dbus_uint32_t db_u1, db_u2, db_u3;
 	char buf[25], *cwtmp; struct pollfd p; int fd = 0, mode = 0, discard_keyup = 0, prev_key = 0, icons = 0, on_dbus = 0, last_dbus_poll = 0, ln = 0;
 	memset(&p,0,sizeof(struct pollfd)); p.fd = sock; p.events = POLLIN | POLLHUP | POLLERR; 
 
@@ -827,6 +893,60 @@
 						}
 					}
 					dinovo_dbus_do_reply(db_msg);
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
 				} else if (dbus_message_is_method_call(db_msg,"com.hentenaar.Dinovo.MediaPad","SetIndicator")) {
 					/* SetIndicator(indicator, blink) 
 					 *	[ indicator := see LCD_ICON_* above ]

--MP__53sIWw._.BI=dB3QKYP5bV
Content-Type: text/x-patch; name=dinovo-py.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=dinovo-py.patch

--- dinovo-dbus-test.py	2006-12-29 18:47:42.000000000 -0500
+++ dinovo-dbus-test.py	2007-01-08 23:17:08.000000000 -0500
@@ -1,4 +1,6 @@
 #!/usr/bin/env python
+# -*- coding: utf8 -*-
+# vim: set fileencoding=3Dutf8 :
=20
 import dbus
=20
@@ -24,12 +26,20 @@
 LCD_LED_BLINK  =3D 1
=20
 # Special Characters (which might be useful)
-#	Note: In the interest of i18n, it's worth mentioning that the majority o=
f Cyrillic characters are at
-#	      0x80 - 0x8f. The ones that overlap with Greek are in the 0x90 - 0x=
9f range, along with various
-#	      Symbols (heart, 8th note, 16th node, alarm bell, etc.)
-#
-#	For Cyrillic, the messages work fine on Winblows, which means that the L=
CD uses the ASCII character set
-#       modified as it would be for KOI8-R.
+# Cyrillic / Greek:
+#	=D0=90 =3D 'A'		=D0=B1 =3D 0x9b	=D0=91 =3D 0x80 	=D0=93 =3D 0x92=09
+#	=D0=94 =3D 0x81	=D0=95 =3D 'E'		=D0=96 =3D 0x82	=D0=97 =3D 0x83
+#	=D0=98 =3D 0x84	=D0=99 =3D 0x85 	=D0=9A =3D 'K'		=D0=9B =3D 0x86
+#	=D0=9C =3D 'M'		=D0=9D =3D 'H'		=D0=9E =3D 'O'		=D0=9F =3D 0x87=09
+#	=D0=A0 =3D 'P'		=D0=A1 =3D 'C'		=D0=A2 =3D 'T'		=D0=A3 =3D 0x88
+#	=D0=A4 =3D 0x99	=D0=A5 =3D 'X'		=D0=A6 =3D 0x89	=D0=A7 =3D 0x8a
+#	=D0=A8 =3D 0x8b	=D0=A9 =3D 0x8c	=D0=AB =3D 0x8e	=D0=AD =3D 0x8f
+#	=D0=AE =3D		=D0=AF =3D		=D1=8F =3D		=D0=AC =3D 0x8d=09
+#	=D1=8C =3D		=D1=84 =3D 0xd8	=D1=91 =3D 0xeb
+#	=CE=B1 =3D 0x90	=D0=BF =3D 0x93	=CE=A3 =3D 0x94	=CF=83 =3D 0x95
+#	=CF=84 =3D 0x97	=CE=A9 =3D 0x9a	=CE=B5 =3D 0x9e=09
+# Latin Extended: 0xc0 - 0xff
+# German ss-Set: =C3=9F =3D 0xdf
=20
 SMALL_TRIANGLE_RIGHT =3D "\x03"
 SMALL_TRIANGLE_LEFT  =3D "\x04"
@@ -49,6 +59,32 @@
 GEQUAL               =3D "\x1d"
 LARGE_TRIANGLE_UP    =3D "\x1e"
 LARGE_TRIANGLE_DOWN  =3D "\x1f"
+EIGHTH_NOTE	     =3D "\x91"
+SIXTEENTH_NOTE	     =3D "\x96"
+BELL		     =3D "\x98"
+INFINITY	     =3D "\x9b"
+HEART		     =3D "\x9c"
+MATH_UNITY	     =3D "\x9f"
+PAUSE		     =3D "\xa0"
+UNKNOWN1             =3D "\xa1"
+CENTS		     =3D "\xa2"
+POUNDS		     =3D "\xa3"
+YEN		     =3D "\xa5"
+PIPE		     =3D "\xa6" # |
+SECTION		     =3D "\xa7"
+UMLAUT		     =3D "\xa8"
+C_INVERSE	     =3D "\xa9"
+UNKNOWN_2	     =3D "\xaa"
+DOUBLE_ARROWS_LEFT   =3D "\xab" # <<
+R_INVERSE	     =3D "\xae"=20
+SQUARED		     =3D "\xb2"
+CUBED                =3D "\xb3"
+DOUBLE_ARROWS_RIGHT  =3D "\xbb" # >>
+ONE_FOURTH	     =3D "\xbc"
+ONE_HALF             =3D "\xbd"
+THREE_FOURTHS        =3D "\xbe"
+SPANISH_QMARK	     =3D "\xbf"
+
=20
 bus =3D dbus.SystemBus()
 obj =3D bus.get_object("com.hentenaar.Dinovo.MediaPad", "/com/hentenaar/Di=
novo/MediaPad")
@@ -59,4 +95,7 @@
 intf.WriteText(" -------------- "
                "| Dinovo Linux |"
 	       " -------------- ")
+#intf.WriteTextBin([0x83, ord('A'), ord('K'), ord('A'), ord('T')])
+#intf.WriteLineBin(2,[0xf6,0xf7,0xf8,0xf9,0xfa,0xfb,0xfc,0xfd,0xfe,0xff])
+#intf.WriteLine(3,"Git-R-Done")
=20

--MP__53sIWw._.BI=dB3QKYP5bV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--MP__53sIWw._.BI=dB3QKYP5bV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--MP__53sIWw._.BI=dB3QKYP5bV--
