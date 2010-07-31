Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Remove __exit from rfcomm_cleanup_ttys()
Date: Sat, 31 Jul 2010 19:57:05 -0300
Message-Id: <1280617025-4001-1-git-send-email-gustavo@padovan.org>
In-Reply-To: <alpine.DEB.2.00.1007301330030.5809@linux-sea-02>
References: <alpine.DEB.2.00.1007301330030.5809@linux-sea-02>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

rfcomm_cleanup_ttys() is also called from rfcomm_init(), so it can't have
__exit.

Reported-by: Mat Martineau <mathewm@codeaurora.org>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/rfcomm/tty.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 026205c..befc3a5 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -1183,7 +1183,7 @@ int __init rfcomm_init_ttys(void)
 	return 0;
 }
 
-void __exit rfcomm_cleanup_ttys(void)
+void rfcomm_cleanup_ttys(void)
 {
 	tty_unregister_driver(rfcomm_tty_driver);
 	put_tty_driver(rfcomm_tty_driver);
-- 
1.7.1.1
