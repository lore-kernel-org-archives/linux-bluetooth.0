Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] android/doc: Add socket-api.txt document
Date: Tue,  3 Dec 2013 17:53:11 +0200
Message-Id: <1386085993-22055-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Document describes how socket HAL is working.
---
 android/socket-api.txt | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 android/socket-api.txt

diff --git a/android/socket-api.txt b/android/socket-api.txt
new file mode 100644
index 0000000..9f622f9
--- /dev/null
+++ b/android/socket-api.txt
@@ -0,0 +1,61 @@
+Android Socket protocol for Bluetooth
+=====================================
+
+Since Android switched from BlueZ (where sockets where nicely implemented) to
+Bluedroid user space stack there is a need to emulate bluetooth sockets.
+
+Android Bluetooth Socket Hardware Abstraction Layer (HAL) bt_sock.h has
+only 2 functions:
+
+static btsock_interface_t sock_if = {
+	sizeof(sock_if),
+	sock_listen,
+	sock_connect
+};
+
+with following parameters:
+
+sock_listen(btsock_type_t type, const char *service_name,
+		const uint8_t *uuid, int chan, int *sock_fd, int flags)
+sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
+		const uint8_t *uuid, int chan, int *sock_fd, int flags)
+
+socket type RFCOMM is only supported at the moment. uuid and channel used
+to decide where to connect.
+
+sockfd is used to return socket fd to Android framework. It is used to inform
+framework when remote device is connected.
+
+listen()
+========
+
+Listens on RFCOMM socket, socket channel is either found based on uuid or
+channel parameter used directly. Returns sock_fd to Android framework.
+
+Through this sock_fd channel number as (int) needs to be written right after
+listen() succeeds.
+
+When remote device is connected to this socket we shall send accept signal
+through sock_fd
+
+connect()
+=========
+
+Connects to remote device specified in bd_addr parameter. Socket channel is
+found by SDP search of remote device by supplied uuid. Returns sock_fd to
+Android framework.
+
+Through this sock_fd channel number as (int) needs to be written right after
+connects() succeeds.
+
+When remote device is connected to this socket we shall send connect signal
+through sock_fd
+
+The format of connect/accept signal is shown below:
+
+struct hal_sock_connect_signal {
+	short   size;
+	uint8_t bdaddr[6];
+	int     channel;
+	int     status;
+} __attribute__((packed));
-- 
1.8.3.2

