Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FABB9DE.9020005@zappa.cx>
From: Andreas Sundstrom <sunkan@zappa.cx>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>	 <3FA8F301.4000008@zappa.cx> <1068041709.1288.36.camel@pegasus>	 <3FA90A1E.5000505@zappa.cx> <1068162514.25166.90.camel@pegasus>	 <3FAB6E18.2070601@zappa.cx> <1068204314.25163.104.camel@pegasus>	 <3FAB8332.7080602@zappa.cx> <1068205278.25167.108.camel@pegasus>	 <3FAB8963.9070600@zappa.cx> <1068207133.25163.117.camel@pegasus>
In-Reply-To: <1068207133.25163.117.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------040105070103030908050000"
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
Date: Fri, 07 Nov 2003 16:27:26 +0100

This is a multi-part message in MIME format.
--------------040105070103030908050000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> So you should make a table with all possible combinations and fill in
> the values (in hex) for it. This is what I need to see which bit gets
> toggled and which not.
I think you will like this patch. I hope the registers is the same for 
all Toshiba notebooks, but that can probably not be assured before it is 
implemented in stock kernel so users will test it.

/Andreas

--------------040105070103030908050000
Content-Type: text/plain;
 name="patch-2.6.0-test9-toshiba-acpi-bt-stock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.0-test9-toshiba-acpi-bt-stock.patch"

--- tmp/linux-2.6.0-test9-stock/drivers/acpi/toshiba_acpi.c	2003-10-25 20:42:52.000000000 +0200
+++ linux-2.6.0-test9/drivers/acpi/toshiba_acpi.c	2003-11-07 16:21:39.174442800 +0100
@@ -81,6 +81,7 @@
 #define HCI_VIDEO_OUT			0x001c
 #define HCI_HOTKEY_EVENT		0x001e
 #define HCI_LCD_BRIGHTNESS		0x002a
+#define HCI_BLUETOOTH			0x0056
 
 /* field definitions */
 #define HCI_LCD_BRIGHTNESS_BITS		3
@@ -89,6 +90,9 @@
 #define HCI_VIDEO_OUT_LCD		0x1
 #define HCI_VIDEO_OUT_CRT		0x2
 #define HCI_VIDEO_OUT_TV		0x4
+#define HCI_BLUETOOTH_ACTIVATE		0x0080
+#define HCI_BLUETOOTH_ATTACH		0x0040
+#define HCI_BLUETOOTH_DX		0x0001
 
 /* utility
  */
@@ -195,9 +199,9 @@
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
@@ -205,9 +209,9 @@
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
@@ -263,7 +267,7 @@
 	u32 hci_result;
 	u32 value;
 
-	hci_read1(HCI_LCD_BRIGHTNESS, &value, &hci_result);
+	hci_read1(HCI_LCD_BRIGHTNESS, &value, 0, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		value = value >> HCI_LCD_BRIGHTNESS_SHIFT;
 		p += sprintf(p, "brightness:              %d\n", value);
@@ -285,7 +289,7 @@
 	if (snscanf(buffer, count, " brightness : %i", &value) == 1 &&
 			value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS) {
 		value = value << HCI_LCD_BRIGHTNESS_SHIFT;
-		hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
+		hci_write1(HCI_LCD_BRIGHTNESS, value, 0, &hci_result);
 		if (hci_result != HCI_SUCCESS)
 			return -EFAULT;
 	} else {
@@ -301,7 +305,7 @@
 	u32 hci_result;
 	u32 value;
 
-	hci_read1(HCI_VIDEO_OUT, &value, &hci_result);
+	hci_read1(HCI_VIDEO_OUT, &value, 0, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		int is_lcd = (value & HCI_VIDEO_OUT_LCD) ? 1 : 0;
 		int is_crt = (value & HCI_VIDEO_OUT_CRT) ? 1 : 0;
@@ -340,7 +344,7 @@
 		while ((buffer < buffer_end) && (*(buffer-1) != ';'));
 	} while (buffer < buffer_end);
 
-	hci_read1(HCI_VIDEO_OUT, &video_out, &hci_result);
+	hci_read1(HCI_VIDEO_OUT, &video_out, 0, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		int new_video_out = video_out;
 		if (lcd_out != -1)
@@ -364,7 +368,7 @@
 	u32 hci_result;
 	u32 value;
 
-	hci_read1(HCI_FAN, &value, &hci_result);
+	hci_read1(HCI_FAN, &value, 0, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
 		p += sprintf(p, "running:                 %d\n", (value > 0));
 		p += sprintf(p, "force_on:                %d\n", force_fan);
@@ -383,7 +387,7 @@
 
 	if (snscanf(buffer, count, " force_on : %i", &value) == 1 &&
 			value >= 0 && value <= 1) {
-		hci_write1(HCI_FAN, value, &hci_result);
+		hci_write1(HCI_FAN, value, 0, &hci_result);
 		if (hci_result != HCI_SUCCESS)
 			return -EFAULT;
 		else
@@ -402,7 +406,7 @@
 	u32 value;
 
 	if (!key_event_valid) {
-		hci_read1(HCI_SYSTEM_EVENT, &value, &hci_result);
+		hci_read1(HCI_SYSTEM_EVENT, &value, 0, &hci_result);
 		if (hci_result == HCI_SUCCESS) {
 			key_event_valid = 1;
 			last_key_event = value;
@@ -412,7 +416,7 @@
 			/* This is a workaround for an unresolved issue on
 			 * some machines where system events sporadically
 			 * become disabled. */
-			hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+			hci_write1(HCI_SYSTEM_EVENT, 1, 0, &hci_result);
 		} else {
 			p += sprintf(p, "ERROR\n");
 			goto end;
@@ -450,6 +454,58 @@
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
+		p += sprintf(p, "wireless_switch:         %d\n", value & 1);
+		p += sprintf(p, "bluetooth_on:            %d\n", (value & 128) == 128);
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
+	if (snscanf(buffer, count, " bluetooth_on : %i", &value) == 1 &&
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
 
@@ -457,12 +513,13 @@
 
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
@@ -501,7 +558,7 @@
 	u32 hci_result;
 
 	/* simple device detection: try reading an HCI register */
-	hci_read1(HCI_LCD_BRIGHTNESS, &value, &hci_result);
+	hci_read1(HCI_LCD_BRIGHTNESS, &value, 0, &hci_result);
 	if (hci_result != HCI_SUCCESS)
 		return -ENODEV;
 
@@ -511,7 +568,7 @@
 	key_event_valid = 0;
 
 	/* enable event fifo */
-	hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+	hci_write1(HCI_SYSTEM_EVENT, 1, 0, &hci_result);
 
 	toshiba_proc_dir = proc_mkdir(PROC_TOSHIBA, acpi_root_dir);
 	if (!toshiba_proc_dir) {

--------------040105070103030908050000--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
