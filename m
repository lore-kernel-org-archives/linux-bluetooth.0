Return-Path: <salyzyn@android.com>
From: Mark Salyzyn <salyzyn@android.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Salyzyn <salyzyn@android.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	security@kernel.org,
	kernel-team@android.com,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: Bluetooth: hidp: buffer overflow in hidp_process_report
Date: Tue, 31 Jul 2018 15:02:13 -0700
Message-Id: <20180731220225.159741-1-salyzyn@android.com>
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

CVE-2018-9363

The buffer length is unsigned at all layers, but gets cast to int and
checked in hidp_process_report and can lead to a buffer overflow.
Switch len parameter to unsigned int to resolve issue.

This affects 3.18 and newer kernels.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Fixes: a4b1b5877b514b276f0f31efe02388a9c2836728 ("HID: Bluetooth: hidp: make sure input buffers are big enough")
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: security@kernel.org
Cc: kernel-team@android.com
---
 net/bluetooth/hidp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 1036e4fa1ea2..3bba8f4b08a9 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -431,8 +431,8 @@ static void hidp_del_timer(struct hidp_session *session)
 		del_timer(&session->timer);
 }
 
-static void hidp_process_report(struct hidp_session *session,
-				int type, const u8 *data, int len, int intr)
+static void hidp_process_report(struct hidp_session *session, int type,
+				const u8 *data, unsigned int len, int intr)
 {
 	if (len > HID_MAX_BUFFER_SIZE)
 		len = HID_MAX_BUFFER_SIZE;
-- 
2.18.0.345.g5c9ce644c3-goog
