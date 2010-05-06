Return-Path: <cyrus@holtmann.org>
Subject: Re: Detect invalid (i.e. non-UTF-8) device names and fix them
 during initialization phase
From: Fabian Greffrath <fabian@greffrath.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100505170202.3d6b1dcb@susi.home.s3e.de>
References: <4BE14458.1020908@greffrath.com>
	 <4BE14819.4080903@greffrath.com> <20100505170202.3d6b1dcb@susi.home.s3e.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 May 2010 16:42:44 +0200
Message-ID: <1273156964.25110.1.camel@vfrodo>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi bluez,

Am Mittwoch, den 05.05.2010, 17:02 +0200 schrieb Stefan Seyfried:
> Then it would probably good if you could send the patch against current
> git (even if it still applies cleanly) and in a format that "git am" can
> process directly. That makes it very easy for the maintainers to apply the
> code and in the same run makes sure you get proper attribution for your
> contribution ;)

I have reapplied my patch against current git, I have replaced the
obscure 249 in "char name[249];" by MAX_NAME_LENGTH as defined in
src/adapter.h and I am now posting it inline. Happy reviewing! ;)


>From 5447e55aeeda8a2307de0b7765abd8883c5f16a9 Mon Sep 17 00:00:00 2001
From: Fabian Greffrath <fabian+bluez@greffrath.com>
Date: Thu, 6 May 2010 16:37:43 +0200
Subject: [PATCH] Instantly fix non-UTF-8 local device names during device configuration phase

---
 plugins/hciops.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 05c3d4e..836c291 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -81,6 +81,7 @@ static void configure_device(int index)
 	struct hci_dev_info di;
 	uint16_t policy;
 	int dd, err;
+	char name[MAX_NAME_LENGTH + 1];
 
 	if (hci_devinfo(index, &di) < 0)
 		return;
@@ -96,6 +97,30 @@ static void configure_device(int index)
 		return;
 	}
 
+	if (hci_read_local_name(dd, sizeof(name), name, 1000) < 0) {
+		error("Can't read local name on hci%d: %s (%d)\n",
+						index, strerror(errno), errno);
+		return;
+	}
+
+	name[MAX_NAME_LENGTH] = '\0';
+
+	if (!g_utf8_validate(name, -1, NULL)) {
+		char *utf8_name;
+
+		utf8_name = g_convert(name, -1, "UTF-8", "ISO-8859-1", NULL, NULL, NULL);
+		if (utf8_name) {
+			debug("Fix invalid non-UTF-8 device name \"%s\" on hci%d to \"%s\"",
+							name, index, utf8_name);
+			if (hci_write_local_name(dd, utf8_name, 2000) < 0) {
+				error("Can't change local name on hci%d: %s (%d)\n",
+								index, strerror(errno), errno);
+				return;
+			}
+			g_free(utf8_name);
+		}
+	}
+
 	/* Set page timeout */
 	if ((main_opts.flags & (1 << HCID_SET_PAGETO))) {
 		write_page_timeout_cp cp;
-- 
1.7.1



