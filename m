Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] adapter: Fix checking if LE device is discoverable
Date: Fri, 21 Mar 2014 17:34:09 +0100
Message-Id: <1395419649-15647-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395419649-15647-1-git-send-email-szymon.janc@tieto.com>
References: <1395419649-15647-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Kernel is not adding flags field to EIR if none of flags is set.
---
 src/adapter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ac756c1..ee3358d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4300,8 +4300,8 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	/* Avoid creating LE device if it's not discoverable */
 	if (bdaddr_type != BDADDR_BREDR &&
-			!(eir_data.flags &
-				(EIR_FLAG_LIM_DISC | EIR_FLAG_GEN_DISC))) {
+				(eir_data.flags < 0 || !(eir_data.flags &
+				(EIR_FLAG_LIM_DISC | EIR_FLAG_GEN_DISC)))) {
 		eir_data_free(&eir_data);
 		return;
 	}
-- 
1.8.3.2

