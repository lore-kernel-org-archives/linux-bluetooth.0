Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH 03/13] gatttool: Remote address is mandatory for non-interactive gatttool
Date: Thu, 21 Mar 2013 18:31:39 -0400
Message-Id: <1363905109-30839-4-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

For gatttool non-interactive mode, command line parameter with
bluetooth remote address is mandatory.
---
 attrib/gatttool.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 29e3261..1dd0c35 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -603,6 +603,12 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 
+	if (opt_dst == NULL) {
+		g_print("Remote Bluetooth address required\n");
+		got_error = TRUE;
+		goto done;
+	}
+
 	chan = gatt_connect(opt_src, opt_dst, opt_dst_type, opt_sec_level,
 					opt_psm, opt_mtu, connect_cb);
 	if (chan == NULL) {
-- 
1.7.9.5

