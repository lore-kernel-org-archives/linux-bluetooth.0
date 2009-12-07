Return-Path: <cyrus@holtmann.org>
Message-ID: <4B1D01C9.3070305@gmail.com>
Date: Mon, 07 Dec 2009 14:23:21 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] HID: PTR_ERR return of wrong pointer in hidp_setup_hid()
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Return the PTR_ERR of the correct pointer.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 net/bluetooth/hidp/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 49d8495..eae872c 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -763,7 +763,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 
 	hid = hid_allocate_device();
 	if (IS_ERR(hid))
-		return PTR_ERR(session->hid);
+		return PTR_ERR(hid);
 
 	session->hid = hid;
 	session->req = req;
