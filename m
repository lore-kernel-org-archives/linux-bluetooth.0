Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Solve compilation warning usin gcc 4.5.0
Date: Wed, 11 Aug 2010 15:06:32 +0200
Message-Id: <1281531992-10976-1-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <201008111455.41381.santoscadenas@gmail.com>
References: <201008111455.41381.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index c8aba53..24db448 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -437,7 +437,7 @@ static void avctp_set_state(struct control *control, avctp_state_t new_state)
 {
 	GSList *l;
 	struct audio_device *dev = control->dev;
-	avdtp_session_state_t old_state = control->state;
+	avctp_state_t old_state = control->state;
 	gboolean value;
 
 	switch (new_state) {
-- 
1.7.2

