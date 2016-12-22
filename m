Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH 3/3] sixaxis: Set created devices trusted by default
Date: Wed, 21 Dec 2016 21:20:54 -0800
Message-Id: <1482384054-59718-4-git-send-email-juha.kuikka@synapse.com>
In-Reply-To: <1482384054-59718-1-git-send-email-juha.kuikka@synapse.com>
References: <1482384054-59718-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If user has enabled the sixaxis plugin and plugs a controller in,
it can be assumed they also want the controllers to be able to connect
automatically.
---
 plugins/sixaxis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 1fb2091..ba96b54 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -349,6 +349,7 @@ static bool setup_device(int fd, int index, struct btd_adapter *adapter)
 	btd_device_set_pnpid(device, devices[index].source, devices[index].vid,
 				devices[index].pid, devices[index].version);
 	btd_device_set_temporary(device, false);
+	btd_device_set_trusted(device, true);
 
 	return true;
 }
-- 
1.9.1

