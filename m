Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] lib/sdp: Fix resource leak in sdp_get_supp_feat
Date: Wed, 12 Aug 2015 18:07:10 +0300
Message-Id: <1439392033-11822-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
References: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case dtd is unknow it would jump to fail without freeing what has
been allocated in subseq which is not appended to tseq so it could not
be freed.
---
 lib/sdp.c       | 1 +
 tools/sdptool.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 2107e28..155eca5 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4906,6 +4906,7 @@ int sdp_get_supp_feat(const sdp_record_t *rec, sdp_list_t **seqp)
 				length = 0;
 				break;
 			default:
+				sdp_list_free(subseq, free);
 				goto fail;
 			}
 
diff --git a/tools/sdptool.c b/tools/sdptool.c
index 039e67d..b1cbcfd 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -3327,7 +3327,6 @@ static int add_palmos(sdp_session_t *session, svc_info_t *si)
 
 	err = sdp_device_record_register(session, &interface, &record,
 							SDP_RECORD_PERSIST);
-
 	sdp_list_free(root, NULL);
 	sdp_list_free(svclass, NULL);
 
-- 
2.4.3

