Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH v5 2/2] Make unit test compatible with GLIB v2.28
Date: Tue, 24 Jan 2017 11:52:44 -0800
Message-Id: <1485287564-16879-3-git-send-email-brian.gix@intel.com>
In-Reply-To: <1485287564-16879-1-git-send-email-brian.gix@intel.com>
References: <1485287564-16879-1-git-send-email-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-midi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/unit/test-midi.c b/unit/test-midi.c
index d318b07..3995c86 100644
--- a/unit/test-midi.c
+++ b/unit/test-midi.c
@@ -282,8 +282,12 @@ static void compare_events(const snd_seq_event_t *ev1,
 		                ev2->data.control.value);
 		break;
 	case SND_SEQ_EVENT_SYSEX:
-		g_assert_cmpmem(ev1->data.ext.ptr, ev1->data.ext.len,
-		                ev2->data.ext.ptr, ev2->data.ext.len);
+		g_assert_cmpint(ev1->data.ext.len,
+		                ==,
+		                ev2->data.ext.len);
+		g_assert(memcmp(ev1->data.ext.ptr,
+		                ev2->data.ext.ptr,
+		                ev2->data.ext.len) == 0);
 		break;
 	default:
 		g_assert_not_reached();
-- 
1.9.1

