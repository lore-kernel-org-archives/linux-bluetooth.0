Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 11/47] android/hal-sco: Add remote address parameter in Get SCO fd command
Date: Tue,  4 Nov 2014 10:18:34 +0200
Message-Id: <1415089150-18798-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/sco-ipc-api.txt | 2 +-
 android/sco-msg.h       | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/sco-ipc-api.txt b/android/sco-ipc-api.txt
index 17372fe..27d5ef2 100644
--- a/android/sco-ipc-api.txt
+++ b/android/sco-ipc-api.txt
@@ -32,6 +32,6 @@ SCO Audio Service (ID 0)
 
 	Opcode 0x01 - Get SCO fd command
 
-		Command parameters: <none>
+		Command parameters: Remote address (6 octets)
 		Response parameters: MTU (2 octets)
 				     File descriptor (inline)
diff --git a/android/sco-msg.h b/android/sco-msg.h
index 74f25b8..d1b13d7 100644
--- a/android/sco-msg.h
+++ b/android/sco-msg.h
@@ -31,6 +31,10 @@ static const char BLUEZ_SCO_SK_PATH[] = "\0bluez_sco_socket";
 #define SCO_OP_STATUS			IPC_OP_STATUS
 
 #define SCO_OP_GET_FD			0x01
+struct sco_cmd_get_fd {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 struct sco_rsp_get_fd {
 	uint16_t mtu;
 } __attribute__((packed));
-- 
1.9.1

