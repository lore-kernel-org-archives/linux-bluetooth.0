Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH obexd 1/3] Fix white space related coding style issues for gdbus
Date: Mon, 27 Jun 2011 03:26:04 +0530
Message-Id: <1309125366-29016-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

- corrected the space before '{'
---
 gdbus/object.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index d17a101..8bc12f5 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -76,7 +76,7 @@ static void print_arguments(GString *gstr, const char *sig,
 
 		/* Gather enough data to have a single complete type */
 		for (len = 0; len < (sizeof(type) - 1) && sig[i]; len++, i++) {
-			switch (sig[i]){
+			switch (sig[i]) {
 			case '(':
 				struct_level++;
 				break;
-- 
1.7.4.1

