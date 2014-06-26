Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] android/health: Assign channel to user_data
Date: Thu, 26 Jun 2014 15:04:22 +0300
Message-Id: <1403784265-1455-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Assign channel for incoming connections when it is created.
---
 android/health.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/health.c b/android/health.c
index 7624790..6998913 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1202,6 +1202,9 @@ static struct health_channel *connect_channel(struct mcap_mcl *mcl,
 		channel = create_channel(app, mdepid, device);
 	}
 
+	/* Device is created here */
+	mcl->cb->user_data = channel;
+
 	return channel;
 }
 
-- 
1.8.3.2

