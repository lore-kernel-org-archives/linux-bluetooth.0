Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 3/6] android: Minor fix to Android Bluetooth Audio protocol API doc
Date: Mon, 30 Dec 2013 11:17:24 +0100
Message-ID: <1388398647-25420-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make picture consistent with example below it.

---
 android/audio-ipc-api.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
index 4983ad7..5140d77 100644
--- a/android/audio-ipc-api.txt
+++ b/android/audio-ipc-api.txt
@@ -5,12 +5,12 @@ The audio plugin happen to be in a different socket but all the rules for
 HAL socket apply here as well, the abstract socket name is
 "\0bluez_audio_socket" (tentative):
 
-	.--Android--.                             .---Audio---.
-	|  daemon   |                             |   Plugin  |
+	.---Audio---.                             .--Android--.
+	|  Plugin   |                             |   Daemon  |
 	|           |          Command            |           |
-	|           | <-------------------------- |           |
-	|           |                             |           |
 	|           | --------------------------> |           |
+	|           |                             |           |
+	|           | <-------------------------- |           |
 	|           |          Response           |           |
 	|           |                             |           |
 	|           |                             |           |
-- 
1.8.4

