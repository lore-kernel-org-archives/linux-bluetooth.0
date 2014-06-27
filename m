Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 06/10] android/health: Assign channel to user_data
Date: Fri, 27 Jun 2014 18:16:07 +0300
Message-Id: <1403882171-16308-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Assign channel for incoming connections when it is created.
---
 android/health.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/health.c b/android/health.c
index b7c24fd..9551408 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1213,6 +1213,9 @@ static struct health_channel *connect_channel(struct mcap_mcl *mcl,
 		channel = create_channel(app, mdepid, device);
 	}
 
+	/* Device is created here */
+	mcl->cb->user_data = channel;
+
 	return channel;
 }
 
-- 
1.8.3.2

