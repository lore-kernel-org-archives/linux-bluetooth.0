Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/14] obexd: Return "error" for unknown status in status2str
Date: Fri, 4 Oct 2013 11:05:32 +0200
Message-ID: <1380877538-22614-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
References: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This can happend only if there is a bug in obexd code.
This fix following buld error:

  CC     obexd/src/obexd-manager.o
obexd/src/manager.c: In function ‘status2str’:
obexd/src/manager.c:292:1: error: control reaches end of non-void
    function [-Werror=return-type]
---
 obexd/src/manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 00f3537..cec8a39 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -287,6 +287,7 @@ static const char *status2str(uint8_t status)
 	case TRANSFER_STATUS_COMPLETE:
 		return "complete";
 	case TRANSFER_STATUS_ERROR:
+	default:
 		return "error";
 	}
 }
-- 
1.8.4

