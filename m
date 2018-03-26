Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 6/6] shared/mainloop: Fix overwriting exit status
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Message-ID: <37718a67-5607-6335-553b-4c94e0ee7457@jp.fujitsu.com>
Date: Mon, 26 Mar 2018 17:31:13 +0900
MIME-Version: 1.0
In-Reply-To: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since mainloop_run() overwrites the exit_status variable even if having
called mainloop_{quit,exit_*}(), such as in case executing btmgmt with
an invalid command, it is initialized in declaration.
---
 src/shared/mainloop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/shared/mainloop.c b/src/shared/mainloop.c
index 09c46a79a..e6ab9c43d 100644
--- a/src/shared/mainloop.c
+++ b/src/shared/mainloop.c
@@ -42,7 +42,7 @@
 
 static int epoll_fd;
 static int epoll_terminate;
-static int exit_status;
+static int exit_status = EXIT_SUCCESS;
 
 struct mainloop_data {
 	int fd;
@@ -141,8 +141,6 @@ int mainloop_run(void)
 		}
 	}
 
-	exit_status = EXIT_SUCCESS;
-
 	while (!epoll_terminate) {
 		struct epoll_event events[MAX_EPOLL_EVENTS];
 		int n, nfds;
-- 
2.14.1

