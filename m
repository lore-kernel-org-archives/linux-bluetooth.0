Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/4] l2test: add option to use SOCK_STREAM
Date: Tue, 30 Mar 2010 15:53:26 -0300
Message-Id: <1269975209-10044-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/l2test.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 714604a..bfffab2 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -1046,6 +1046,7 @@ static void usage(void)
 		"\t[-F fcs] use CRC16 check (default = 1)\n"
 		"\t[-R] reliable mode\n"
 		"\t[-G] use connectionless channel (datagram)\n"
+		"\t[-U] use sock stream\n"
 		"\t[-A] request authentication\n"
 		"\t[-E] request encryption\n"
 		"\t[-S] secure connection\n"
@@ -1060,7 +1061,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt=getopt(argc,argv,"rdscuwmnxyzpb:i:P:I:O:B:N:L:W:C:D:X:F:RGAESMT")) != EOF) {
+	while ((opt=getopt(argc,argv,"rdscuwmnxyzpb:i:P:I:O:B:N:L:W:C:D:X:F:RGUAESMT")) != EOF) {
 		switch(opt) {
 		case 'r':
 			mode = RECV;
@@ -1199,6 +1200,10 @@ int main(int argc, char *argv[])
 			socktype = SOCK_DGRAM;
 			break;
 
+		case 'U':
+			socktype = SOCK_STREAM;
+			break;
+
 		case 'T':
 			timestamp = 1;
 			break;
-- 
1.6.4.4
