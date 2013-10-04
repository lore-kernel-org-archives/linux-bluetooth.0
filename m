Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/14] client/transfer: Return "error" for unknown status in status2str
Date: Fri, 4 Oct 2013 11:05:35 +0200
Message-ID: <1380877538-22614-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This can happen only if there is a bug in obexd code.
This fix following build error:

  CC     obexd/client/obexd-transfer.o
obexd/client/transfer.c: In function ‘status2str’:
obexd/client/transfer.c:277:1: error: control reaches end of non-void
    function [-Werror=return-type]
---
 obexd/client/transfer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 99a17e9..5a8d4f2 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -272,6 +272,7 @@ static const char *status2str(uint8_t status)
 	case TRANSFER_STATUS_COMPLETE:
 		return "complete";
 	case TRANSFER_STATUS_ERROR:
+	default:
 		return "error";
 	}
 }
-- 
1.8.4

