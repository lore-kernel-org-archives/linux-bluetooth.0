Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Sundstrom <sunkan@zappa.cx>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FA90A1E.5000505@zappa.cx>
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>
	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>
	 <3FA8F301.4000008@zappa.cx> <1068041709.1288.36.camel@pegasus>
	 <3FA90A1E.5000505@zappa.cx>
Content-Type: multipart/mixed; boundary="=-6R49aGDdqOPBxziQDl0y"
Message-Id: <1068162514.25166.90.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 07 Nov 2003 00:48:34 +0100


--=-6R49aGDdqOPBxziQDl0y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andreas,

> > this should be included in the mainstream kernel source, but the code
> > must be a little bit cleaned up. I will check this later and send you a
> > patch for testing. After that I'll forward it to the maintainer.
> > 
> I'll appreciate that, just let me know when you have gone over it and 
> I'll check that it works as expected.

here is my patch for it. I changed some stuff and left some stupid
things out. It is now switched on/off with "bluetooth:1"/"bluetooth:0"
and please check that I don't break the other stuff like fan or screen
brightness.

Regards

Marcel


--=-6R49aGDdqOPBxziQDl0y
Content-Disposition: attachment; filename=patch-toshiba-acpi-bluetooth
Content-Type: text/plain; name=patch-toshiba-acpi-bluetooth; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

===== drivers/acpi/toshiba_acpi.c 1.6 vs edited =====
--- 1.6/drivers/acpi/toshiba_acpi.c	Thu Aug 21 16:39:06 2003
+++ edited/drivers/acpi/toshiba_acpi.c	Thu Nov  6 16:05:26 2003
@@ -82,6 +82,7 @@
 #define HCI_VIDEO_OUT			0x001c
 #define HCI_HOTKEY_EVENT		0x001e
 #define HCI_LCD_BRIGHTNESS		0x002a
+#define HCI_BLUETOOTH			0x0056
 
 /* field definitions */
 #define HCI_LCD_BRIGHTNESS_BITS		3
@@ -90,6 +91,9 @@
 #define HCI_VIDEO_OUT_LCD		0x1
 #define HCI_VIDEO_OUT_CRT		0x2
 #define HCI_VIDEO_OUT_TV		0x4
+#define HCI_BLUETOOTH_ACTIVATE		0x0080
+#define HCI_BLUETOOTH_ATTACH		0x0040
+#define HCI_BLUETOOTH_DX		0x0001
 
 /* utility
  */
@@ -196,9 +200,9 @@
  */
 
 static acpi_status
-hci_write1(u32 reg, u32 in1, u32* result)
+hci_write1(u32 reg, u32 in1, u32 in2, u32* result)
 {
-	u32 in[HCI_WORDS] = { HCI_SET, reg, in1, 0, 0, 0 };
+	u32 in[HCI_WORDS] = { HCI_SET, reg, in1, in2, 0, 0 };
 	u32 out[HCI_WORDS];
 	acpi_status status = hci_raw(in, out);
 	*result = (status == AE_OK) ? out[0] : HCI_FAILURE;
@@ -206,9 +210,9 @@
 }
 
 static acpi_status
-hci_read1(u32 reg, u32* out1, u32* result)
+hci_read1(u32 reg, u32* out1, u32 in2, u32* result)
 {
-	u32 in[HCI_WORDS] = { HCI_GET, reg, 0, 0, 0, 0 };
+	u32 in[HCI_WORDS] = { HCI_GET, reg, 0, in2, 0, 0 };
 	u32 out[HCI_WORDS];
 	acpi_status status = hci_raw(in, out);
 	*out1 = out[2];
@@ -264,7 +268,7 @@
 	u32 hci_result;
 	u32 value;
 
-	hci_read1(HCI_LCD_BRIGHTNESS, &value, &hci_result);
+	hci_read1(HCI_LCD_BRIGHTNESS, &value, 0, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		value = value >> HCI_LCD_BRIGHTNESS_SHIFT;
 		p += sprintf(p, "brightness:              %d\n", value);
@@ -286,7 +290,7 @@
 	if (snscanf(buffer, count, " brightness : %i", &value) == 1 &&
 			value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS) {
 		value = value << HCI_LCD_BRIGHTNESS_SHIFT;
-		hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
+		hci_write1(HCI_LCD_BRIGHTNESS, value, 0, &hci_result);
 		if (hci_result != HCI_SUCCESS)
 			return -EFAULT;
 	} else {
@@ -302,7 +306,7 @@
 	u32 hci_result;
 	u32 value;
 
-	hci_read1(HCI_VIDEO_OUT, &value, &hci_result);
+	hci_read1(HCI_VIDEO_OUT, &value, 0, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		int is_lcd = (value & HCI_VIDEO_OUT_LCD) ? 1 : 0;
 		int is_crt = (value & HCI_VIDEO_OUT_CRT) ? 1 : 0;
@@ -341,7 +345,7 @@
 		while ((buffer < buffer_end) && (*(buffer-1) != ';'));
 	} while (buffer < buffer_end);
 
-	hci_read1(HCI_VIDEO_OUT, &video_out, &hci_result);
+	hci_read1(HCI_VIDEO_OUT, &video_out, 0, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		int new_video_out = video_out;
 		if (lcd_out != -1)
@@ -365,7 +369,7 @@
 	u32 hci_result;
 	u32 value;
 
-	hci_read1(HCI_FAN, &value, &hci_result);
+	hci_read1(HCI_FAN, &value, 0, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		p += sprintf(p, "running:                 %d\n", (value > 0));
 		p += sprintf(p, "force_on:                %d\n", force_fan);
@@ -384,7 +388,7 @@
 
 	if (snscanf(buffer, count, " force_on : %i", &value) == 1 &&
 			value >= 0 && value <= 1) {
-		hci_write1(HCI_FAN, value, &hci_result);
+		hci_write1(HCI_FAN, value, 0, &hci_result);
 		if (hci_result != HCI_SUCCESS)
 			return -EFAULT;
 		else
@@ -403,7 +407,7 @@
 	u32 value;
 
 	if (!key_event_valid) {
-		hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+		hci_read1(HCI_SYSTEM_EVENT, &value, 0, &hci_result);
 		if (hci_result == HCI_SUCCESS) {
 			key_event_valid = 1;
 			last_key_event = value;
@@ -413,7 +417,7 @@
 			/* This is a workaround for an unresolved issue on
 			 * some machines where system events sporadically
 			 * become disabled. */
-			hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+			hci_write1(HCI_SYSTEM_EVENT, 1, 0, &hci_result);
 		} else {
 			p += sprintf(p, "ERROR\n");
 			goto end;
@@ -451,6 +455,57 @@
 	return p;
 }
 
+static char*
+read_bluetooth(char *p)
+{
+	u32 hci_result;
+	u32 value;
+
+	hci_read1(HCI_BLUETOOTH, &value, 0, &hci_result);
+	if (hci_result == HCI_SUCCESS) {
+		p += sprintf(p, "bluetooth_available:     %d\n", value);
+	} else {
+		p += sprintf(p, "ERROR\n");
+		goto end;
+	}
+
+	hci_read1(HCI_BLUETOOTH, &value, HCI_BLUETOOTH_DX, &hci_result);
+	if (hci_result == HCI_SUCCESS) {
+		p += sprintf(p, "wireless_switch:         %d\n", value);
+	} else {
+		p += sprintf(p, "ERROR\n");
+	}
+
+end:
+	return p;
+}
+
+static unsigned long 
+write_bluetooth(const char* buffer, unsigned long count)
+{
+	int value;
+	u32 hci_result;
+
+	if (snscanf(buffer, count, " bluetooth : %i", &value) == 1 &&
+			value >= 0 && value <= 1) {
+		hci_write1(HCI_BLUETOOTH, value, HCI_BLUETOOTH_ACTIVATE, &hci_result);
+		if (hci_result != HCI_SUCCESS)
+			return -EFAULT;
+
+		hci_write1(0, 0, 0, &hci_result);
+
+		hci_write1(HCI_BLUETOOTH, value, HCI_BLUETOOTH_ATTACH, &hci_result);
+		if (hci_result != HCI_SUCCESS);
+			return -EFAULT;
+
+		hci_write1(0, 0, 0, &hci_result);
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
 /* proc and module init
  */
 
@@ -458,12 +513,13 @@
 
 ProcItem proc_items[] =
 {
-	{ "lcd"		, read_lcd	, write_lcd	},
-	{ "video"	, read_video	, write_video	},
-	{ "fan"		, read_fan	, write_fan	},
-	{ "keys"	, read_keys	, write_keys	},
-	{ "version"	, read_version	, 0		},
-	{ 0		, 0		, 0		},
+	{ "lcd",	read_lcd,	write_lcd	},
+	{ "video",	read_video,	write_video	},
+	{ "fan",	read_fan,	write_fan	},
+	{ "keys",	read_keys,	write_keys	},
+	{ "version",	read_version,	0		},
+	{ "bluetooth",	read_bluetooth,	write_bluetooth	},
+	{ 0, 0, 0 },
 };
 
 static acpi_status
@@ -502,7 +558,7 @@
 	u32 hci_result;
 
 	/* simple device detection: try reading an HCI register */
-	hci_read1(HCI_LCD_BRIGHTNESS, &value, &hci_result);
+	hci_read1(HCI_LCD_BRIGHTNESS, &value, 0, &hci_result);
 	if (hci_result != HCI_SUCCESS)
 		return -ENODEV;
 
@@ -512,7 +568,7 @@
 	key_event_valid = 0;
 
 	/* enable event fifo */
-	hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+	hci_write1(HCI_SYSTEM_EVENT, 1, 0, &hci_result);
 
 	toshiba_proc_dir = proc_mkdir(PROC_TOSHIBA, acpi_root_dir);
 	if (!toshiba_proc_dir) {

--=-6R49aGDdqOPBxziQDl0y--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
