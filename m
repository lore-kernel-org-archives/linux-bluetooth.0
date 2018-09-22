Return-Path: <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, netdev@vger.kernel.org,
 "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
 "Kees Cook" <keescook@chromium.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-bluetooth@vger.kernel.org, kernel-team@android.com,
 security@kernel.org,
 "Johan Hedberg" <johan.hedberg@gmail.com>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "Mark Salyzyn" <salyzyn@android.com>
Date: Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.858007707@decadent.org.uk>
Subject: [PATCH 3.16 21/63] Bluetooth: hidp: buffer overflow in
 hidp_process_report
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Salyzyn <salyzyn@android.com>

commit 7992c18810e568b95c869b227137a2215702a805 upstream.

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
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bluetooth/hidp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -429,8 +429,8 @@ static void hidp_del_timer(struct hidp_s
 		del_timer(&session->timer);
 }
 
-static void hidp_process_report(struct hidp_session *session,
-				int type, const u8 *data, int len, int intr)
+static void hidp_process_report(struct hidp_session *session, int type,
+				const u8 *data, unsigned int len, int intr)
 {
 	if (len > HID_MAX_BUFFER_SIZE)
 		len = HID_MAX_BUFFER_SIZE;
