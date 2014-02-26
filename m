Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 01/17] monitor: Allow to modify epoll even events are the same
Date: Wed, 26 Feb 2014 02:57:12 +0100
Message-ID: <1393379848-4031-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
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

