Return-Path: <cyrus@holtmann.org>
From: Vladimir Davydov <vladimir.davydov@promwad.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hciattach: Fix the timeout handling code
Date: Wed, 30 Jun 2010 14:41:24 +0300
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Sergey Kovalev <sergey.kovalev@promwad.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201006301441.25119.vladimir.davydov@promwad.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vladimir Davydov <vladimir.davydov@promwad.com>

The variable 'retries' should be defined as static, or it will be always 0.

Signed-off-by: Vladimir Davydov <vladimir.davydov@promwad.com>

---
 tools/hciattach.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index b13db1b..e772b6f 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -326,7 +326,8 @@ static int bcsp_max_retries = 10;
 static void bcsp_tshy_sig_alarm(int sig)
 {
 	unsigned char bcsp_sync_pkt[10] = 
{0xc0,0x00,0x41,0x00,0xbe,0xda,0xdc,0xed,0xed,0xc0};
-	int len, retries = 0;
+	int len;
+	static int retries = 0;
 
 	if (retries < bcsp_max_retries) {
 		retries++;
@@ -343,7 +344,8 @@ static void bcsp_tshy_sig_alarm(int sig)
 static void bcsp_tconf_sig_alarm(int sig)
 {
 	unsigned char bcsp_conf_pkt[10] = 
{0xc0,0x00,0x41,0x00,0xbe,0xad,0xef,0xac,0xed,0xc0};
-	int len, retries = 0;
+	int len;
+	static int retries = 0;
 
 	if (retries < bcsp_max_retries){
 		retries++;
-- 
1.6.4.2

-- 
Vladimir Davydov
Senior Developer
Promwad Innovation Company
Web: www.promwad.com
22, Olshevskogo St.,
220073, Minsk,
BELARUS
Phone/Fax: +375 (17) 312–1246
E-mail: vladimir.davydov@promwad.com
Skype: v_davydov
