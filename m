Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 3/7] client: Fix data growth if reconfiguring ad service
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Message-ID: <fecdf614-1877-5149-5931-49c0876576d4@jp.fujitsu.com>
Date: Fri, 16 Feb 2018 14:51:15 +0900
MIME-Version: 1.0
In-Reply-To: <1b7b4b83-e67a-c23a-8da3-9b86cc0b275e@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since commit 65eff5c2 ("client: Rename set-service to service"), data
are appended in every run of advertise service with data arguments as
below:

  [bluetooth]# service 1 1 2
  [bluetooth]# service
  UUID: SDP(1)
    01 02                                            ..
  [bluetooth]# service 1 1 2 3
  [bluetooth]# service
  UUID: SDP(1)
    01 02 01 02 03                                   .....
---
 client/advertising.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index e500a2e86..f1b08c0b6 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -549,6 +549,8 @@ void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
 		return;
 	}
 
+	ad_clear_service();
+
 	ad.service.uuid = g_strdup(argv[1]);
 	data = &ad.service.data;
 
-- 
2.14.1

