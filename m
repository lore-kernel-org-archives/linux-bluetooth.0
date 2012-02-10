Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 18/22] adaptername: Fix clang warning related to unaligned memory access
Date: Fri, 10 Feb 2012 18:40:03 -0300
Message-Id: <1328910007-25604-19-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/adaptername.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index e154e92..a2f9c8f 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -241,7 +241,7 @@ static gboolean handle_inotify_cb(GIOChannel *channel, GIOCondition cond,
 
 	i = 0;
 	while (i < len) {
-		struct inotify_event *pevent = (struct inotify_event *) &buf[i];
+		struct inotify_event *pevent = (void *) &buf[i];
 
 		/* check that it's ours */
 		if (pevent->len && pevent->name != NULL &&
-- 
1.7.8.1

