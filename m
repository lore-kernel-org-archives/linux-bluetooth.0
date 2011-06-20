Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <yongli@qca.qualcomm.com>,
	Nami <nami.li@atheros.com>
Subject: [PATCH obexd 10/14] Add psm member in session_data struct.
Date: Mon, 20 Jun 2011 17:44:56 +0800
Message-ID: <1308563100-18917-10-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/session.c |    1 +
 client/session.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 client/session.h

diff --git a/client/session.c b/client/session.c
index 3db1c1d..8a6ee2c 100755
--- a/client/session.c
+++ b/client/session.c
@@ -561,6 +561,7 @@ struct session_data *session_create(const char *source,

 	session->refcount = 1;
 	session->channel = channel;
+	session->psm = psm;

 	session->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
 	if (session->conn == NULL) {
diff --git a/client/session.h b/client/session.h
old mode 100644
new mode 100755
index af79ac8..9180e75
--- a/client/session.h
+++ b/client/session.h
@@ -36,6 +36,7 @@ struct session_data {
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint8_t channel;
+	uint16_t psm;  /* GOEP v2.0 and later supprot OBEX over L2CAP */
 	char *service;		/* Service friendly name */
 	const char *target;	/* OBEX Target UUID */
 	int target_len;
--
1.7.1

