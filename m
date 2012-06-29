Return-Path: <cyrus@holtmann.org>
Message-ID: <4FEE2CDF.7030806@coinfree.com>
Date: Fri, 29 Jun 2012 18:31:59 -0400
From: Neal Peacock <neal@coinfree.com>
Reply-To: neal@coinfree.com
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: UTF8 to UTF-8  name patch for obexd
Content-Type: multipart/mixed;
 boundary="------------030405010805090100050405"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030405010805090100050405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

My first post here so I hope I am doing this the right way.

This is a short patch for obexd to change the charset name passed into 
glib from UTF8 to UTF-8, which I think is the proper name.  I was 
working on an embedded system that didn't have the aliases setup to 
convert the names like typical desktops.  I was pulling my hair out 
trying to figure out how to add the charsets in glib until I realized I 
could just change the name in obexd and UTF-8 seems to be universally 
included unlike UTF8.

Thanks.

--
Neal Peacock


--------------030405010805090100050405
Content-Type: text/plain; charset=windows-1252;
 name="fix-UTFName.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix-UTFName.patch"

>From abe899bbdeac414610970cdcad31dc2d02463085 Mon Sep 17 00:00:00 2001
From: Neal Peacock <neal@coinfree.com>
Date: Fri, 29 Jun 2012 18:15:57 -0400
Subject: [PATCH] Changed UTF name to standard

---
 gobex/gobex-header.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
index 77dcc6e..56dd9b2 100644
--- a/gobex/gobex-header.c
+++ b/gobex/gobex-header.c
@@ -187,7 +187,7 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
 		}
 
 		header->v.string = g_convert((const char *) ptr, hdr_len - 5,
-						"UTF8", "UTF16BE",
+						"UTF-8", "UTF-16BE",
 						NULL, &str_len, &conv_err);
 		if (header->v.string == NULL) {
 			g_set_error(err, G_OBEX_ERROR,
-- 
1.7.2.5


--------------030405010805090100050405--
