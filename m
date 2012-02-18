Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/8] ftp: Use ENOSYS to indicate not implemented function
Date: Sat, 18 Feb 2012 17:19:01 +0200
Message-Id: <1329578343-31663-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
References: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/ftp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 56cedb9..ff4b761 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -500,7 +500,7 @@ int ftp_action(struct obex_session *os, void *user_data)
 	case 0x01: /* Move/Rename Object */
 		return ftp_move(ftp, name, destname);
 	default:
-		return -EINVAL;
+		return -ENOSYS;
 	}
 }
 
-- 
1.7.7.6

