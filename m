Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] btdev: Indicate support for 4.2 encryption commands
Date: Mon, 18 May 2015 12:41:37 +0300
Message-Id: <1431942097-21927-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1431942097-21927-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1431942097-21927-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Indicate btdev support for LE Generate DHKey and LE Read Local P-256
Public Key.
---
 emulator/btdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d9e38b5..7151e89 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -430,6 +430,10 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[28] |= 0x10;	/* LE Receiver Test */
 	btdev->commands[28] |= 0x20;	/* LE Transmitter Test */
 	btdev->commands[28] |= 0x40;	/* LE Test End */
+
+	/* Extra LE commands for >= 4.2 adapters */
+	btdev->commands[34] |= 0x02;	/* LE Read Local P-256 Public Key */
+	btdev->commands[34] |= 0x04;	/* LE Generate DHKey */
 }
 
 static void set_bredrle_commands(struct btdev *btdev)
-- 
2.1.4

