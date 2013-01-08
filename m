Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ] lib: Fix SDP_TEXT_STR16/SDP_URL_STR16 parsing
Date: Tue,  8 Jan 2013 19:05:25 -0400
Message-Id: <1357686325-29529-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357670608-19081-2-git-send-email-anderson.lizardo@openbossa.org>
References: <1357670608-19081-2-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sdp_extract_attr() uses the "size" parameter to return the number of
bytes consumed when parsing SDP Data Elements. This size is used to
advance a buffer pointer to parse next element.

This size was being incorrectly calculated for SDP_{TEXT,URL}_STR16 in
extract_str(), where the string length was added twice. The string
length is already added later in the function for {TEXT,URL}_STR{8,16}
by this statement:

*len += n;
---
 lib/sdp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index ca474cd..b87f392 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1176,7 +1176,7 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 		}
 		n = bt_get_be16(p);
 		p += sizeof(uint16_t);
-		*len += sizeof(uint16_t) + n;
+		*len += sizeof(uint16_t);
 		bufsize -= sizeof(uint16_t);
 		break;
 	default:
-- 
1.7.9.5

