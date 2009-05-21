Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 4/4] bluetooth: Documentation for Marvell Bluetooth driver
Date: Wed, 20 May 2009 17:35:41 -0700
Message-Id: <1242866141-22325-4-git-send-email-bzhao@marvell.com>
In-Reply-To: <1242866141-22325-1-git-send-email-bzhao@marvell.com>
References: <1242866141-22325-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

add bt_mrvl.txt to Documentation/bluetooth

This patch incorporates a lot of comments given by
Nicolas Pitre <nico@marvell.com>. Many thanks to Nicolas Pitre.

Signed-off-by: Rahul Tank <rahult@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 Documentation/bluetooth/00-INDEX    |    4 +
 Documentation/bluetooth/bt_mrvl.txt |  135 +++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/bluetooth/00-INDEX
 create mode 100644 Documentation/bluetooth/bt_mrvl.txt

diff --git a/Documentation/bluetooth/00-INDEX b/Documentation/bluetooth/00-INDEX
new file mode 100644
index 0000000..2d39fa3
--- /dev/null
+++ b/Documentation/bluetooth/00-INDEX
@@ -0,0 +1,4 @@
+00-INDEX
+	- this file
+bt_mrvl.txt
+	- info on Marvell Bluetooth driver usage.
diff --git a/Documentation/bluetooth/bt_mrvl.txt b/Documentation/bluetooth/bt_mrvl.txt
new file mode 100644
index 0000000..d8ca36e
--- /dev/null
+++ b/Documentation/bluetooth/bt_mrvl.txt
@@ -0,0 +1,135 @@
+=======================================================================
+		README for bt_mrvl driver
+=======================================================================
+
+
+All commands are used via debugfs interface.
+
+=====================
+Set/get driver configurations:
+
+Path:	/debug/bt_mrvl/config/
+
+drvdbg=[n]
+	This command is used to set the bit masks of driver debug messages.
+
+	bit 0:  MSG  		PRINTM(MSG,...)
+	bit 1:  FATAL		PRINTM(FATAL,...)
+	bit 2:  ERROR		PRINTM(ERROR,...)
+	bit 3:  CMD		PRINTM(CMD,...)
+	bit 27: DATA		DBG_HEXDUMP(DBG_DATA,...)
+	bit 28: ENTRY		PRINTM(ENTRY,...), ENTER(), LEAVE()
+	bit 29: WARN 		PRINTM(WARN,...)
+	bit 30: INFO 		PRINTM(INFO,...)
+
+	Usage:
+		# Enable MSG, FATAL, ERROR debug messages:
+		echo 0x7 > /debug/bt_mrvl/config/drvdbg
+
+gpiogap=[n]
+hscfgcmd
+	These commands are used to configure the host sleep parameters.
+	bit 8:0  -- Gap
+	bit 16:8 -- GPIO
+
+	where GPIO is the pin number of GPIO used to wake up the host.
+	It could be any valid GPIO pin# (e.g. 0-7) or 0xff (SDIO interface
+	wakeup will be used instead).
+
+	where Gap is the gap in milli seconds between wakeup signal and
+	wakeup event, or 0xff for special host sleep setting.
+
+	Usage:
+		# Use SDIO interface to wake up the host and set GAP to 0x80:
+		echo 0xff80 > /debug/bt_mrvl/config/gpiogap
+		echo 1 > /debug/bt_mrvl/config/hscfgcmd
+
+		# Use GPIO pin #3 to wake up the host and set GAP to 0xff:
+		echo 0x03ff >  /debug/bt_mrvl/config/gpiogap
+		echo 1 > /debug/bt_mrvl/config/hscfgcmd
+
+psmode=[n]
+pscmd
+	These commands are used to enable/disable auto sleep mode
+
+	where the option is:
+			1 	-- Enable auto sleep mode
+			0 	-- Disable auto sleep mode
+
+	Usage:
+		# Enable auto sleep mode
+		echo 1 > /debug/bt_mrvl/config/psmode
+		echo 1 > /debug/bt_mrvl/config/pscmd
+
+		# Disable auto sleep mode
+		echo 0 > /debug/bt_mrvl/config/psmode
+		echo 1 > /debug/bt_mrvl/config/pscmd
+
+
+hsmode=[n]
+hscmd
+	These commands are used to enable host sleep or wake up firmware
+
+	where the option is:
+			1	-- Enable host sleep
+			0	-- Wake up firmware
+
+	Usage:
+		# Enable host sleep
+		echo 1 > /debug/bt_mrvl/config/hsmode
+		echo 1 > /debug/bt_mrvl/config/hscmd
+
+		# Wake up firmware
+		echo 0 > /debug/bt_mrvl/config/hsmode
+		echo 1 > /debug/bt_mrvl/config/hscmd
+
+
+======================
+Get driver status:
+
+Path:	/debug/bt_mrvl/status/
+
+Usage:
+	cat /debug/bt_mrvl/status/<args>
+
+where the args are:
+
+curpsmode
+	This command displays current auto sleep status.
+
+psstate
+	This command display the power save state.
+
+hsstate
+	This command display the host sleep state.
+
+txdnldrdy
+	This command displays the value of Tx download ready flag.
+
+
+=====================
+
+Use hcitool to issue raw hci command, refer to hcitool manual
+
+	Usage: Hcitool cmd <ogf> <ocf> [Parameters]
+
+	Interface Control Command
+	hcitool cmd 0x3f 0x5b 0xf5 0x01 0x00    --Enable All interface
+	hcitool cmd 0x3f 0x5b 0xf5 0x01 0x01    --Enable Wlan interface
+	hcitool cmd 0x3f 0x5b 0xf5 0x01 0x02    --Enable BT interface
+	hcitool cmd 0x3f 0x5b 0xf5 0x00 0x00    --Disable All interface
+	hcitool cmd 0x3f 0x5b 0xf5 0x00 0x01    --Disable Wlan interface
+	hcitool cmd 0x3f 0x5b 0xf5 0x00 0x02    --Disable BT interface
+
+=======================================================================
+
+
+SD8688 firmware:
+
+/lib/firmware/sd8688_helper.bin
+/lib/firmware/sd8688.bin
+
+
+The images can be downloaded from:
+
+git.infradead.org/users/dwmw2/linux-firmware.git/libertas/
-- 
1.5.3.6

