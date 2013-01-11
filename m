Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Christian Fetzer <christian.fetzer@bmw-carit.de>
Subject: [PATCH 4/8] obexd: Fix FILTER_ALL in MAP client to set 16 bit
Date: Fri, 11 Jan 2013 16:55:53 +0100
Message-Id: <1357919757-10334-5-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

The MAP specification defines ParameterMask as a bitmask of 32 bit / 4 bytes.
For the lower 16 bit the specification defines parameters, the higher 16 bit
remain reserved for future use. Therefore FILTER_ALL is set to 0x0000FFFF.
(Reserved bits have to be set to 0)

In addition this fixes the issue that ListFilterFields didn't show all fields.
---
 obexd/client/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index afb5f9a..cea9369 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -75,7 +75,7 @@ static const char * const filter_list[] = {
 };
 
 #define FILTER_BIT_MAX	15
-#define FILTER_ALL	0xFF
+#define FILTER_ALL	0x0000FFFF
 
 #define STATUS_READ 0
 #define STATUS_DELETE 1
-- 
1.8.1

