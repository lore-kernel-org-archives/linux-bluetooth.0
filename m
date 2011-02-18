Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] telephony-ofono: fix not resetting network status and signal on modem removed
Date: Fri, 18 Feb 2011 18:24:01 +0200
Message-Id: <1298046241-8655-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1298046241-8655-1-git-send-email-luiz.dentz@gmail.com>
References: <1298046241-8655-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This prevent using status and signal from previous active modem
---
 audio/telephony-ofono.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index bc8fea2..0a7f0bd 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -1042,6 +1042,8 @@ static void modem_removed(const char *path)
 
 	g_free(net.operator_name);
 	net.operator_name = NULL;
+	net.status = NETWORK_REG_STATUS_NOSERV;
+	net.signals_bar = 0;
 
 	g_free(modem_obj_path);
 	modem_obj_path = NULL;
-- 
1.7.1

