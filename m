Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] monitor: show index only when -i is not specified
Date: Fri, 11 May 2012 13:18:52 -0300
Message-Id: <1336753132-8282-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1336753132-8282-3-git-send-email-gustavo@padovan.org>
References: <1336753132-8282-1-git-send-email-gustavo@padovan.org>
 <1336753132-8282-2-git-send-email-gustavo@padovan.org>
 <1336753132-8282-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/main.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index 6096441..f44cdf1 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -133,7 +133,11 @@ int main(int argc, char *argv[])
 	if(!filter_mask)
 		filter_mask = ~0L;
 
-	filter_mask |= PACKET_FILTER_SHOW_INDEX;
+	if (index >= 0)
+		filter_mask &= ~PACKET_FILTER_SHOW_INDEX;
+	else
+		filter_mask |= PACKET_FILTER_SHOW_INDEX;
+
 	filter_mask &= ~PACKET_FILTER_SHOW_DATE;
 	filter_mask |= PACKET_FILTER_SHOW_ACL_DATA;
 	filter_mask |= PACKET_FILTER_SHOW_SCO_DATA;
-- 
1.7.10.1

