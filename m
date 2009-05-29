Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 4/4 v2] bluetooth: Documentation for Marvell Bluetooth driver
Date: Fri, 29 May 2009 16:43:10 -0700
Message-Id: <1243640590-31666-4-git-send-email-bzhao@marvell.com>
In-Reply-To: <1243640590-31666-1-git-send-email-bzhao@marvell.com>
References: <1243640590-31666-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

add btmrvl.txt to Documentation/

This patch incorporates a lot of comments given by
Nicolas Pitre <nico@marvell.com>. Many thanks to Nicolas Pitre.

Signed-off-by: Rahul Tank <rahult@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 Documentation/00-INDEX   |    3 +-
 Documentation/btmrvl.txt |  119 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/btmrvl.txt

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index d05737a..6adf3aa 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -14,7 +14,6 @@ Following translations are available on the WWW:
 	- this file.
 ABI/
 	- info on kernel <-> userspace ABI and relative interface stability.
-
 BUG-HUNTING
 	- brute force method of doing binary search of patches to find bug.
 Changes
@@ -82,6 +81,8 @@ block/
 	- info on the Block I/O (BIO) layer.
 blockdev/
 	- info on block devices & drivers
+btmrvl.txt
+	- info on Marvell Bluetooth driver usage.
 cachetlb.txt
 	- describes the cache/TLB flushing interfaces Linux uses.
 cdrom/
diff --git a/Documentation/btmrvl.txt b/Documentation/btmrvl.txt
new file mode 100644
index 0000000..34916a4
--- /dev/null
+++ b/Documentation/btmrvl.txt
@@ -0,0 +1,119 @@
+=======================================================================
+		README for btmrvl driver
+=======================================================================
+
+
+All commands are used via debugfs interface.
+
+=====================
+Set/get driver configurations:
+
+Path:	/debug/btmrvl/config/
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
+		echo 0xff80 > /debug/btmrvl/config/gpiogap
+		echo 1 > /debug/btmrvl/config/hscfgcmd
+
+		# Use GPIO pin #3 to wake up the host and set GAP to 0xff:
+		echo 0x03ff >  /debug/btmrvl/config/gpiogap
+		echo 1 > /debug/btmrvl/config/hscfgcmd
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
+		echo 1 > /debug/btmrvl/config/psmode
+		echo 1 > /debug/btmrvl/config/pscmd
+
+		# Disable auto sleep mode
+		echo 0 > /debug/btmrvl/config/psmode
+		echo 1 > /debug/btmrvl/config/pscmd
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
+		echo 1 > /debug/btmrvl/config/hsmode
+		echo 1 > /debug/btmrvl/config/hscmd
+
+		# Wake up firmware
+		echo 0 > /debug/btmrvl/config/hsmode
+		echo 1 > /debug/btmrvl/config/hscmd
+
+
+======================
+Get driver status:
+
+Path:	/debug/btmrvl/status/
+
+Usage:
+	cat /debug/btmrvl/status/<args>
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

