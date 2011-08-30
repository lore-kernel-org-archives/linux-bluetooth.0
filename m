Return-Path: <cyrus@holtmann.org>
From: Pavel Raiskup <praiskup@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: ovasik@redhat.com
Subject: [PATCH 8/8] Removed dropping of the list head
Date: Tue, 30 Aug 2011 15:17:47 +0200
Message-Id: <1314710267-13633-1-git-send-email-praiskup@redhat.com>
In-Reply-To: <op.v0awmrh1h52hc0@dhcp-25-209.brq.redhat.com>
References: <op.v0awmrh1h52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

assigning sdp_list_append(0, ...) to "apseq" on line 2591 will
drop first item in list got by sdp_list_append three lines before.

Note: All bugs from this set was found by Coverity scan on bluez
package from Fedora. If there was somebody who could look on whole
coverity log, I'm able to send Coverity's plain-text results on
demand.

---
 tools/sdptool.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index aea4954..78c97ba 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -2588,7 +2588,7 @@ static int add_cip(sdp_session_t *session, svc_info_t *si)
 	proto[0] = sdp_list_append(0, &l2cap);
 	apseq = sdp_list_append(0, proto[0]);
 	proto[0] = sdp_list_append(proto[0], sdp_data_alloc(SDP_UINT16, &psm));
-	apseq = sdp_list_append(0, proto[0]);
+	apseq = sdp_list_append(apseq, proto[0]);
 
 	sdp_uuid16_create(&cmtp, CMTP_UUID);
 	proto[1] = sdp_list_append(0, &cmtp);
-- 
1.7.4.4

