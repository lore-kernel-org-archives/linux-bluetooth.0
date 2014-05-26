Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 11/26] android/hal-audio: Allow to return 0 from get_presets
Date: Mon, 26 May 2014 15:16:37 +0200
Message-ID: <1401110212-11526-12-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes legal to return 0 from get_presets which is useful to
inform HAL core that codec is not initialized properly and codec should
not be used (it has no caps and no presets).
---
 android/hal-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 416a3ad..1ab4b01 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -315,6 +315,9 @@ static int ipc_open_cmd(const struct audio_codec *codec)
 	cmd->codec = codec->type;
 	cmd->presets = codec->get_presets(cmd->preset, &cmd_len);
 
+	if (!cmd->presets)
+		return 0;
+
 	cmd_len += sizeof(*cmd);
 
 	result = audio_ipc_cmd(AUDIO_SERVICE_ID, AUDIO_OP_OPEN, cmd_len, cmd,
-- 
1.9.3

