Return-Path: <xerofoify@gmail.com>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	grzegorz.kolodziejczyk@tieto.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] bnep:Add error paths for failed function calls in the function bnep_ctrl_set_netfilter
Date: Tue, 29 Dec 2015 20:16:52 -0500
Message-Id: <1451438212-23552-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the proper error paths for when the calls to the function
bnep_send_rsp fail by returning a error code and if this arises jump
to a new goto label out where we directly return the error code to
the caller to signal this failure.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/bnep/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 1641367..8edfd75 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -103,6 +103,7 @@ static inline void bnep_set_default_proto_filter(struct bnep_session *s)
 static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len)
 {
 	int n;
+	int err = 0;
 
 	if (len < 2)
 		return -EILSEQ;
@@ -136,14 +137,19 @@ static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len
 		if (n == 0)
 			bnep_set_default_proto_filter(s);
 
-		bnep_send_rsp(s, BNEP_FILTER_NET_TYPE_RSP, BNEP_SUCCESS);
+		err = bnep_send_rsp(s, BNEP_FILTER_NET_TYPE_RSP, BNEP_SUCCESS);
+		if (err)
+			goto out;
 	} else {
-		bnep_send_rsp(s, BNEP_FILTER_NET_TYPE_RSP, BNEP_FILTER_LIMIT_REACHED);
+		err = bnep_send_rsp(s, BNEP_FILTER_NET_TYPE_RSP, BNEP_FILTER_LIMIT_REACHED);
+		if (err)
+			goto out;
 	}
 #else
-	bnep_send_rsp(s, BNEP_FILTER_NET_TYPE_RSP, BNEP_FILTER_UNSUPPORTED_REQ);
+	err = bnep_send_rsp(s, BNEP_FILTER_NET_TYPE_RSP, BNEP_FILTER_UNSUPPORTED_REQ);
 #endif
-	return 0;
+out:
+	return err;
 }
 
 static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
-- 
2.1.4
