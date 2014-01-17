Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android/A2DP: Notify when audio state change to suspend
Date: Fri, 17 Jan 2014 15:33:07 +0200
Message-Id: <1389965587-20066-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1389965587-20066-1-git-send-email-luiz.dentz@gmail.com>
References: <1389965587-20066-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 12a8a69..8ec03c8 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1007,6 +1007,8 @@ static gboolean sep_suspend_ind(struct avdtp *session,
 		return FALSE;
 	}
 
+	bt_audio_notify_state(setup, HAL_AUDIO_SUSPEND);
+
 	return TRUE;
 }
 
-- 
1.8.4.2

