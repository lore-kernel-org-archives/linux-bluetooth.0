Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix another sdp-xml bug
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1237895709.14805.722.camel@cookie.hadess.net>
References: <1237895709.14805.722.camel@cookie.hadess.net>
Content-Type: multipart/mixed; boundary="=-hj1rjUeJTnsEIIXM7bJr"
Date: Tue, 24 Mar 2009 12:03:24 +0000
Message-Id: <1237896204.14805.731.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-hj1rjUeJTnsEIIXM7bJr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2009-03-24 at 11:55 +0000, Bastien Nocera wrote:
> Spotted by Luiz, another invalid memory access when trying to read past
> the end of a string that's not nul-terminated.
> 
> strndup to the rescue.

Never mind, previous patch was off by one. Corrected patch attached.

--=-hj1rjUeJTnsEIIXM7bJr
Content-Disposition: attachment; filename="0001-Fix-invalid-memory-access-when-dealing-with-URLs.patch"
Content-Type: text/x-patch; name="0001-Fix-invalid-memory-access-when-dealing-with-URLs.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 0606404a81cc73e7a1ee90da9641a6a87c8f6f43 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 24 Mar 2009 11:46:18 +0000
Subject: [PATCH] Fix invalid memory access when dealing with URLs

Just like strings attributes, URLs might not be NUL-terminated.
Make sure we don't read past the end of the allocated memory when
copying them.
---
 common/sdp-xml.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/common/sdp-xml.c b/common/sdp-xml.c
index 608de76..18473d0 100644
--- a/common/sdp-xml.c
+++ b/common/sdp-xml.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
@@ -323,11 +324,17 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 	case SDP_URL_STR8:
 	case SDP_URL_STR16:
 	case SDP_URL_STR32:
+	{
+		char *strBuf;
+
 		appender(data, indent);
 		appender(data, "<url value=\"");
-		appender(data, value->val.str);
+		strBuf = strndup(value->val.str, value->unitSize - 1);
+		appender(data, strBuf);
+		free(strBuf);
 		appender(data, "\" />\n");
 		break;
+	}
 
 	case SDP_SEQ8:
 	case SDP_SEQ16:
-- 
1.6.0.6


--=-hj1rjUeJTnsEIIXM7bJr--

