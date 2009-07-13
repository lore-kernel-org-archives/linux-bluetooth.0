Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	=?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH 4/4] Add Sink role support to audio IPC.
Date: Mon, 13 Jul 2009 12:28:53 -0300
Message-Id: <1247498933-30609-5-git-send-email-jprvita@gmail.com>
In-Reply-To: <1247498933-30609-4-git-send-email-jprvita@gmail.com>
References: <1247498933-30609-1-git-send-email-jprvita@gmail.com>
 <1247498933-30609-2-git-send-email-jprvita@gmail.com>
 <1247498933-30609-3-git-send-email-jprvita@gmail.com>
 <1247498933-30609-4-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/unix.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/audio/unix.c b/audio/unix.c
index f241a83..2646302 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -882,6 +882,7 @@ static void start_open(struct audio_device *dev, struct unix_client *client)
 
 	switch (client->type) {
 	case TYPE_SINK:
+	case TYPE_SOURCE:
 		a2dp = &client->d.a2dp;
 
 		if (!a2dp->session)
@@ -957,6 +958,7 @@ static void start_config(struct audio_device *dev, struct unix_client *client)
 
 	switch (client->type) {
 	case TYPE_SINK:
+	case TYPE_SOURCE:
 		a2dp = &client->d.a2dp;
 
 		if (!a2dp->session)
@@ -1023,6 +1025,7 @@ static void start_resume(struct audio_device *dev, struct unix_client *client)
 
 	switch (client->type) {
 	case TYPE_SINK:
+	case TYPE_SOURCE:
 		a2dp = &client->d.a2dp;
 
 		if (!a2dp->session)
@@ -1091,6 +1094,7 @@ static void start_suspend(struct audio_device *dev, struct unix_client *client)
 
 	switch (client->type) {
 	case TYPE_SINK:
+	case TYPE_SOURCE:
 		a2dp = &client->d.a2dp;
 
 		if (!a2dp->session)
-- 
1.6.0.4

