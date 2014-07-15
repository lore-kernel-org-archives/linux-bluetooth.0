Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] monitor: Exit with error if failed to open file for writing
Date: Tue, 15 Jul 2014 12:30:36 +0200
Message-Id: <1405420237-12054-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/control.c | 4 +++-
 monitor/control.h | 2 +-
 monitor/main.c    | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 9e30d38..879e195 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -996,9 +996,11 @@ void control_server(const char *path)
 	server_fd = fd;
 }
 
-void control_writer(const char *path)
+bool control_writer(const char *path)
 {
 	btsnoop_file = btsnoop_create(path, BTSNOOP_TYPE_MONITOR);
+
+	return !!btsnoop_file;
 }
 
 void control_reader(const char *path)
diff --git a/monitor/control.h b/monitor/control.h
index 8de4c6c..28f16db 100644
--- a/monitor/control.h
+++ b/monitor/control.h
@@ -24,7 +24,7 @@
 
 #include <stdint.h>
 
-void control_writer(const char *path);
+bool control_writer(const char *path);
 void control_reader(const char *path);
 void control_server(const char *path);
 int control_tracing(void);
diff --git a/monitor/main.c b/monitor/main.c
index d4e8e6d..f0922eb 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -198,8 +198,10 @@ int main(int argc, char *argv[])
 		return EXIT_SUCCESS;
 	}
 
-	if (writer_path)
-		control_writer(writer_path);
+	if (writer_path && !control_writer(writer_path)) {
+		printf("Failed to open '%s'\n", writer_path);
+		return EXIT_FAILURE;
+	}
 
 	if (ellisys_server)
 		ellisys_enable(ellisys_server, ellisys_port);
-- 
1.9.1

