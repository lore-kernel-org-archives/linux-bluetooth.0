Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] monitor: Fix minimum size for variable length events
Date: Wed,  4 Feb 2015 21:14:08 +0100
Message-Id: <1423080848-7611-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those could lead to reading invalid memory if frames were corrupted.
---
 monitor/packet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index ba58d84..56a315b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8204,7 +8204,7 @@ static const struct event_data event_table[] = {
 	{ 0x01, "Inquiry Complete",
 				inquiry_complete_evt, 1, true },
 	{ 0x02, "Inquiry Result",
-				inquiry_result_evt, 1, false },
+				inquiry_result_evt, 8, false },
 	{ 0x03, "Connect Complete",
 				conn_complete_evt, 11, true },
 	{ 0x04, "Connect Request",
@@ -8238,7 +8238,7 @@ static const struct event_data event_table[] = {
 	{ 0x12, "Role Change",
 				role_change_evt, 8, true },
 	{ 0x13, "Number of Completed Packets",
-				num_completed_packets_evt, 1, false },
+				num_completed_packets_evt, 5, false },
 	{ 0x14, "Mode Change",
 				mode_change_evt, 6, true },
 	{ 0x15, "Return Link Keys",
@@ -8268,7 +8268,7 @@ static const struct event_data event_table[] = {
 	{ 0x21, "Flow Specification Complete",
 				flow_spec_complete_evt, 22, true },
 	{ 0x22, "Inquiry Result with RSSI",
-				inquiry_result_with_rssi_evt, 1, false },
+				inquiry_result_with_rssi_evt, 8, false },
 	{ 0x23, "Read Remote Extended Features",
 				remote_ext_features_complete_evt, 13, true },
 	{ 0x2c, "Synchronous Connect Complete",
@@ -8278,7 +8278,7 @@ static const struct event_data event_table[] = {
 	{ 0x2e, "Sniff Subrating",
 				sniff_subrating_evt, 11, true },
 	{ 0x2f, "Extended Inquiry Result",
-				ext_inquiry_result_evt, 1, false },
+				ext_inquiry_result_evt, 8, false },
 	{ 0x30, "Encryption Key Refresh Complete",
 				encrypt_key_refresh_complete_evt, 3, true },
 	{ 0x31, "IO Capability Request",
@@ -8322,7 +8322,7 @@ static const struct event_data event_table[] = {
 	{ 0x47, "Flow Specification Modify Complete",
 				flow_spec_modify_complete_evt, 3, true },
 	{ 0x48, "Number of Completed Data Blocks",
-				num_completed_data_blocks_evt, 3, false },
+				num_completed_data_blocks_evt, 9, false },
 	{ 0x49, "AMP Start Test" },
 	{ 0x4a, "AMP Test End" },
 	{ 0x4b, "AMP Receiver Report" },
-- 
1.9.3

