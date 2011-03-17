Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCHv2 5/5] Add Exchange MTU in interactive gatttool
Date: Thu, 17 Mar 2011 10:55:20 -0400
Message-Id: <1300373720-14772-5-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
References: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/attrib/interactive.c b/attrib/interactive.c
index a9157e7..3fafb1e 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -362,6 +362,7 @@ static void cmd_disconnect(int argcp, char **argvp)
 
 	g_attrib_unref(attrib);
 	attrib = NULL;
+	opt_mtu = 0;
 
 	g_io_channel_shutdown(iochannel, FALSE, NULL);
 	g_io_channel_unref(iochannel);
@@ -654,6 +655,65 @@ static void cmd_sec_level(int argcp, char **argvp)
 	}
 }
 
+static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	uint16_t mtu;
+
+	if (status != 0) {
+		printf("Exchange MTU Request failed: %s\n",
+							att_ecode2str(status));
+		return;
+	}
+
+	if (!dec_mtu_resp(pdu, plen, &mtu)) {
+		printf("Protocol error\n");
+		return;
+	}
+
+	mtu = MIN(mtu, opt_mtu);
+	/* Set new value for MTU in client */
+	if (g_attrib_set_mtu(attrib, mtu))
+		printf("MTU was exchanged successfully: %d\n", mtu);
+	else
+		printf("Error exchanging MTU\n");
+}
+
+static void cmd_mtu(int argcp, char **argvp)
+{
+	if (conn_state != STATE_CONNECTED) {
+		printf("Command failed: not connected.\n");
+		return;
+	}
+
+	if (opt_psm) {
+		printf("Command failed: operation is only available for LE"
+							" transport.\n");
+		return;
+	}
+
+	if (argcp < 2) {
+		printf("Usage: mtu <value>\n");
+		return;
+	}
+
+	if (opt_mtu) {
+		printf("Command failed: MTU exchange can only occur once per"
+							" connection.\n");
+		return;
+	}
+
+	errno = 0;
+	opt_mtu = strtoll(argvp[1], NULL, 0);
+	if (errno != 0 || opt_mtu < ATT_DEFAULT_LE_MTU) {
+		printf("Invalid value. Minimum MTU size is %d\n",
+							ATT_DEFAULT_LE_MTU);
+		return;
+	}
+
+	gatt_exchange_mtu(attrib, opt_mtu, exchange_mtu_cb, NULL);
+}
+
 static struct {
 	const char *cmd;
 	void (*func)(int argcp, char **argvp);
@@ -684,6 +744,8 @@ static struct {
 		"Characteristic Value Write (No response)" },
 	{ "sec-level",		cmd_sec_level,	"[low | medium | high]",
 		"Set security level. Default: low" },
+	{ "mtu",		cmd_mtu,	"<value>",
+		"Exchange MTU for GATT/ATT" },
 	{ NULL, NULL, NULL}
 };
 
-- 
1.7.0.4

