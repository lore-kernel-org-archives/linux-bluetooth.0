Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 2/2] avctp: Fix invalid file descriptor close
Date: Mon, 18 Feb 2013 21:34:43 +0530
Message-id: <1361203483-32117-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1361203483-32117-1-git-send-email-s.syam@samsung.com>
References: <1361203483-32117-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During avctp_confirm_cb(), if any error happens we set the session
state to AVCTP_STATE_DISCONNECTED, which inturn try to close fd 0.
---

I'm not sure about this fix in the latest upstream code,
but in the case of Bluez 4.101, I got the following
error log(with extra fd print) and this patch fixes the same.

audio/avctp.c:avctp_confirm_cb() AVCTP: incoming connect from BC:47:60:F5:88:89
Refusing unexpected connect from BC:47:60:F5:88:89
audio/avctp.c:avctp_set_state() AVCTP Disconnected
    audio/avctp.c:avctp_disconnected()
AVCTP: closing uinput[fd=0] for BC:47:60:F5:88:89


 profiles/audio/avctp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 13dd4c3..c276c52 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1201,6 +1201,7 @@ static struct avctp *avctp_get_internal(struct btd_device *device)
 	session->server = server;
 	session->device = btd_device_ref(device);
 	session->state = AVCTP_STATE_DISCONNECTED;
+	session->uinput = -1;
 
 	server->sessions = g_slist_append(server->sessions, session);
 
-- 
1.7.9.5

