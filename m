Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/5] monitor: Allow to modify epoll even events are the same
Date: Wed, 5 Mar 2014 10:22:37 +0100
Message-ID: <1394011361-9469-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is epsecially needed when we want to modify timer.
---
 monitor/mainloop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/monitor/mainloop.c b/monitor/mainloop.c
index 8c94bfe..7f97e65 100644
--- a/monitor/mainloop.c
+++ b/monitor/mainloop.c
@@ -222,9 +222,6 @@ int mainloop_modify_fd(int fd, uint32_t events)
 	if (!data)
 		return -ENXIO;
 
-	if (data->events == events)
-		return 0;
-
 	memset(&ev, 0, sizeof(ev));
 	ev.events = events;
 	ev.data.ptr = data;
-- 
1.8.4

