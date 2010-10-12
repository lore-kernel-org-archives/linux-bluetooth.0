Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Fix possible use of uninitialized variables
Date: Tue, 12 Oct 2010 11:08:11 +0300
Message-Id: <1286870891-5862-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
References: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Using uninitialized value "hi" and "flags" in call to function
"OBEX_ObjectAddHeader".
---
 src/obex.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 41ba558..3e9f5b6 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -670,6 +670,9 @@ add_header:
 	case OBEX_HDR_APPARAM:
 		flags =  0;
 		break;
+	default:
+		error("read(): unkown header type %u", hi);
+		return -EIO;
 	}
 
 	OBEX_ObjectAddHeader(obex, obj, hi, hd, len, flags);
-- 
1.7.1

