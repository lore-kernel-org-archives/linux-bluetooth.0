Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 4/6] android: Keep stream_out example in the API doc
Date: Mon, 30 Dec 2013 11:17:25 +0100
Message-ID: <1388398647-25420-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/audio-ipc-api.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
index 5140d77..c2d23d9 100644
--- a/android/audio-ipc-api.txt
+++ b/android/audio-ipc-api.txt
@@ -27,11 +27,11 @@ HAL socket apply here as well, the abstract socket name is
 	call dev->open_output_stream()      --> command 0x03
 	return dev->open_output_stream()    <-- response 0x03
 
-	call stream_in->read()              --> command 0x05
-	return stream_in->read()            <-- response 0x05
+	call stream_out->write()            --> command 0x05
+	return stream_out->write()          <-- response 0x05
 
-	call stream_in->common.standby()    --> command 0x06
-	return  stream_in->common.standby() <-- response 0x06
+	call stream_out->common.standby()   --> command 0x06
+	return stream_out->common.standby() <-- response 0x06
 
 	call dev->close_output_stream()     --> command 0x04
 	return dev->close_output_stream()   <-- response 0x04
@@ -39,6 +39,8 @@ HAL socket apply here as well, the abstract socket name is
 	call dev->close()                   --> command 0x02
 	return dev->close()                 <-- response 0x02
 
+Note: Similar applies to stream in scenario.
+
 Identifier: "audio" (BT_AUDIO_ID)
 
 	Opcode 0x00 - Error response
-- 
1.8.4

