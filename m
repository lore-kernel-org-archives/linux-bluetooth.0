Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/35] android/avctp: Add avctp_send_browsing function
Date: Fri, 25 Apr 2014 11:38:42 +0300
Message-Id: <1398415152-22950-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to send responses over browsing channel.
---
 android/avctp.c | 12 ++++++++++++
 android/avctp.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/android/avctp.c b/android/avctp.c
index 94f84ad..7098fc2 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -1208,6 +1208,18 @@ int avctp_send_browsing_req(struct avctp *session,
 	return 0;
 }
 
+int avctp_send_browsing(struct avctp *session, uint8_t transaction,
+					const struct iovec *iov, int iov_cnt)
+{
+	struct avctp_channel *browsing = session->browsing;
+
+	if (browsing == NULL)
+		return -ENOTCONN;
+
+	return avctp_browsing_send(browsing, transaction, AVCTP_RESPONSE,
+								iov, iov_cnt);
+}
+
 static const char *op2str(uint8_t op)
 {
 	int i;
diff --git a/android/avctp.h b/android/avctp.h
index b395188..2b33858 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -172,6 +172,8 @@ int avctp_send_vendor(struct avctp *session, uint8_t transaction,
 int avctp_send_vendor_req(struct avctp *session, uint8_t code, uint8_t subunit,
 					const struct iovec *iov, int iov_cnt,
 					avctp_rsp_cb func, void *user_data);
+int avctp_send_browsing(struct avctp *session, uint8_t transaction,
+					const struct iovec *iov, int iov_cnt);
 int avctp_send_browsing_req(struct avctp *session,
 				const struct iovec *iov, int iov_cnt,
 				avctp_browsing_rsp_cb func, void *user_data);
-- 
1.9.0

