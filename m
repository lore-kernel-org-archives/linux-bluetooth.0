Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] Fix build error for hciemu
Date: Fri,  2 Dec 2011 14:20:15 -0400
Message-Id: <1322850015-395-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Error:

test/hciemu.c: In function 'create_snoop':
test/hciemu.c:155: error: 'S_IRUSR' undeclared (first use in this
function)
test/hciemu.c:155: error: (Each undeclared identifier is reported only
once
test/hciemu.c:155: error: for each function it appears in.)
test/hciemu.c:155: error: 'S_IWUSR' undeclared (first use in this
function)
test/hciemu.c:155: error: 'S_IRGRP' undeclared (first use in this
function)
test/hciemu.c:155: error: 'S_IROTH' undeclared (first use in this
function)
---
 test/hciemu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index 38918f5..f2879ba 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -40,6 +40,7 @@
 #include <sys/epoll.h>
 #include <sys/socket.h>
 #include <sys/resource.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
-- 
1.7.0.4

