Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FAB6E18.2070601@zappa.cx>
From: Andreas Sundstrom <sunkan@zappa.cx>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>	 <3FA8F301.4000008@zappa.cx> <1068041709.1288.36.camel@pegasus>	 <3FA90A1E.5000505@zappa.cx> <1068162514.25166.90.camel@pegasus>
In-Reply-To: <1068162514.25166.90.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------030102050004010904040905"
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
Date: Fri, 07 Nov 2003 11:04:08 +0100

This is a multi-part message in MIME format.
--------------030102050004010904040905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
 > Hi Andreas,
 >
 >
 >>>this should be included in the mainstream kernel source, but the code
 >>>must be a little bit cleaned up. I will check this later and send you a
 >>>patch for testing. After that I'll forward it to the maintainer.
 >>>
 >>
 >>I'll appreciate that, just let me know when you have gone over it and
 >>I'll check that it works as expected.
 >
 >
 > here is my patch for it. I changed some stuff and left some stupid
 > things out. It is now switched on/off with "bluetooth:1"/"bluetooth:0"
 > and please check that I don't break the other stuff like fan or screen
 > brightness.

Ok, first of all I want to say that it works ok for me. I have tried
everything except the "keys" proc entry.

However, I would like to change the behaviour a bit, to behave more
like the other proc entries and more like it was before your rework.
First I'd like a user friendly way of finding out if BT is really
enabled, and second I think you should be able to guess what to "echo" 
into the proc entry.

To enable fan running all the time you use, "echo force_on:1 > fan"
lcd brightness is set through "echo brightness:1 > lcd"

The output from "cat fan lcd" is:
brightness:              6
brightness_levels:       8
running:                 0
force_on:                0

Which means that when you have learnd how they function you should be
able to guess what to do with the bluetooth entry if it for example
looked like this:
#cat bluetooth
bluetooth_available:     15
wireless_switch:         512
bluetooth_on:            0

I have here changed the parameter to echo into "bluetooth" from
bluetooth to bluetooth_on, and added an entry that shows the status of
it. This makes it easy to guess that "echo bluetooth_on:1 > bluetooth"
should enable the device if you know how the other entris work.
Without this you want be able to guess that "bluetooth:1/0" is used
for enabling/disabling the device.

I have attached two patches, one is against "stock" 2.6.0-test9 and the
other is against your previous version on a patched 2.6.0-test9

I had to do some trial and error guessing the value 576, I don't
understand why it changed from 512 as it was in the patch I used
earlier. Maybe you understand and maybe it all should be done totally
different, but you should be able to understand what I want to do and
implement it in a prettier way if thats needed.

Please look at this and give me some feedback on your thoughts about it.

/Andreas

--------------030102050004010904040905
Content-Type: text/plain;
 name="patch-2.6.0-test9-toshiba-acpi-bt-mh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.0-test9-toshiba-acpi-bt-mh.patch"

--- tmp/linux-2.6.0-test9-mh/drivers/acpi/toshiba_acpi.c	2003-11-07 10:38:39.971763024 +0100
+++ linux-2.6.0-test9/drivers/acpi/toshiba_acpi.c	2003-11-07 10:07:39.629578024 +0100
@@ -469,8 +469,12 @@
 	}
 
 	hci_read1(HCI_BLUETOOTH, &value, HCI_BLUETOOTH_DX, &hci_result);
-	if (hci_result == HCI_SUCCESS) {
+	if (hci_result == HCI_SUCCESS && value > 576) {
 		p += sprintf(p, "wireless_switch:         %d\n", value);
+		p += sprintf(p, "bluetooth_on:            1\n");
+	} else if (hci_result == HCI_SUCCESS) {
+		p += sprintf(p, "wireless_switch:         %d\n", value);
+		p += sprintf(p, "bluetooth_on:            0\n");
 	} else {
 		p += sprintf(p, "ERROR\n");
 	}
@@ -485,7 +489,7 @@
 	int value;
 	u32 hci_result;
 
-	if (snscanf(buffer, count, " bluetooth : %i", &value) == 1 &&
+	if (snscanf(buffer, count, " bluetooth_on : %i", &value) == 1 &&
 			value >= 0 && value <= 1) {
 		hci_write1(HCI_BLUETOOTH, value, HCI_BLUETOOTH_ACTIVATE, &hci_result);
 		if (hci_result != HCI_SUCCESS)

--------------030102050004010904040905
Content-Type: text/plain;
 name="patch-2.6.0-test9-toshiba-acpi-bt-stock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.0-test9-toshiba-acpi-bt-stock.patch"

--- tmp/linux-2.6.0-test9-stock/drivers/acpi/toshiba_acpi.c	2003-10-25 20:42:52.000000000 +0200
+++ linux-2.6.0-test9/drivers/acpi/toshiba_acpi.c	2003-11-07 10:07:39.629578024 +0100
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
@@ -450,6 +454,61 @@
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
+	if (hci_result == HCI_SUCCESS && value > 576) {
+		p += sprintf(p, "wireless_switch:         %d\n", value);
+		p += sprintf(p, "bluetooth_on:            1\n");
+	} else if (hci_result == HCI_SUCCESS) {
+		p += sprintf(p, "wireless_switch:         %d\n", value);
+		p += sprintf(p, "bluetooth_on:            0\n");
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
 
@@ -457,12 +516,13 @@
 
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
@@ -501,7 +561,7 @@
 	u32 hci_result;
 
 	/* simple device detection: try reading an HCI register */
-	hci_read1(HCI_LCD_BRIGHTNESS, &value, &hci_result);
+	hci_read1(HCI_LCD_BRIGHTNESS, &value, 0, &hci_result);
 	if (hci_result != HCI_SUCCESS)
 		return -ENODEV;
 
@@ -511,7 +571,7 @@
 	key_event_valid = 0;
 
 	/* enable event fifo */
-	hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
+	hci_write1(HCI_SYSTEM_EVENT, 1, 0, &hci_result);
 
 	toshiba_proc_dir = proc_mkdir(PROC_TOSHIBA, acpi_root_dir);
 	if (!toshiba_proc_dir) {

--------------030102050004010904040905--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
