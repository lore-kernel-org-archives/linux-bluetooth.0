Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] tools/l2test: Sort options alphabetically
Date: Mon,  1 Jun 2015 11:27:06 +0200
Message-Id: <1433150827-17629-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1433150827-17629-1-git-send-email-szymon.janc@tieto.com>
References: <1433150827-17629-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2test has many options and sorting them will make it easier to find
unused one.
---
 tools/l2test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index dac98f9..55955d8 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -1343,8 +1343,8 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt(argc, argv, "rdscuwmntqxyzpb:a:"
-		"i:P:I:O:J:B:N:L:W:C:D:X:F:Q:Z:Y:H:K:V:RUGAESMTe:")) != EOF) {
+	while ((opt = getopt(argc, argv, "a:b:cde:i:mnpqrstuwxyz"
+		"AB:C:D:EF:GH:I:J:K:L:MN:O:P:Q:RSTUV:W:X:Y:Z:")) != EOF) {
 		switch (opt) {
 		case 'r':
 			mode = RECV;
-- 
1.9.3

