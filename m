Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/avctp: Set uinput to invalid fd when creating session
Date: Mon, 24 Feb 2014 15:25:18 +0200
Message-Id: <1393248318-5188-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393248318-5188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393248318-5188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When AVCTP session was created uinput was zero which is valid file
descriptor and that was conflicting with socketpair() fds.
---
 android/avctp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/avctp.c b/android/avctp.c
index 1e414d1..9bfb191 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -1414,6 +1414,7 @@ struct avctp *avctp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 		return NULL;
 	}
 
+	session->uinput = -1;
 	session->control = control;
 	session->passthrough_id = avctp_register_pdu_handler(session,
 						AVC_OP_PASSTHROUGH,
-- 
1.8.3.2

