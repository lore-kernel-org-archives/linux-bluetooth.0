Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/14] shared/shell: Disable bt_shell_prompt_input in noninteractive mode
Date: Mon, 26 Feb 2018 17:53:28 +0200
Message-Id: <20180226155336.25875-7-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Only the input given as argument shall be processed, all the rest shall
be ignored.
---
 src/shared/shell.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 7f726c2dd..bf07d034f 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -417,6 +417,9 @@ void bt_shell_hexdump(const unsigned char *buf, size_t len)
 void bt_shell_prompt_input(const char *label, const char *msg,
 			bt_shell_prompt_input_func func, void *user_data)
 {
+	if (!data.init || data.mode)
+		return;
+
 	/* Normal use should not prompt for user input to the value a second
 	 * time before it releases the prompt, but we take a safe action. */
 	if (data.saved_prompt)
-- 
2.14.3

