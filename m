Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JCcDbPiu"
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9409E1720
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 02:17:19 -0800 (PST)
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 457B4660739E
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 10:17:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702030638;
	bh=kM7O943Thov/g30dxW9Y+mZbj3gxNq+70yAStmUfGzY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JCcDbPiuUnS0dPrQmmfg00QZ/rgcEPiuh7y+Cexy1w+549XKDXfGk1jxOTWZ/Ud8b
	 6gmZQjdLbgHQ9BEW9nA8I/8Js56mS7vCRIm6GUWYHFDygsQedG6Y/CFfCz7kAwztGj
	 oZp/rNSviNrJXWRVSaoImxp7yspEaHFWVNcLROd6B3yNdxQatkRvw/hXKdBSLQ5bCS
	 UDlmjtTYz0ou5GSOuaj16aa/FjPGwYt3pppBCMN9QKuV0pO7OAz57xsb/EIai4aEwb
	 ze6fDEF4hocflbl7ZOrZfLPWqR2m3mrPHbdGoF7/XWZSP1Jao3ye42oD+aQMPqzupa
	 yMS205SX500Tw==
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3] tools: avtest: Add reject-code option
Date: Fri,  8 Dec 2023 11:17:11 +0100
Message-Id: <20231208101711.624001-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208090013.620051-1-frederic.danis@collabora.com>
References: <20231208090013.620051-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some PTS tests like A2DP/SNK/AVP/BI-03-C, A2DP/SNK/AVP/BI-08-C , …
request some specific rejection code to pass.
This commit adds an option to specify the rejection code during
AVDTP_SET_CONFIGURATION rejection.

E.g. "avtest --reject setconf --reject-code 195" to reject setconf with
INVALID_SAMPLING_FREQUENCY code.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 tools/avtest.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/avtest.c b/tools/avtest.c
index ca37b3b46..5ac3418aa 100644
--- a/tools/avtest.c
+++ b/tools/avtest.c
@@ -188,7 +188,8 @@ static void dump_buffer(const unsigned char *buf, int len)
 }
 
 static void process_avdtp(int srv_sk, int sk, unsigned char reject,
-								int fragment)
+								int fragment,
+								int reject_code)
 {
 	unsigned char buf[672];
 	ssize_t len;
@@ -284,7 +285,8 @@ static void process_avdtp(int srv_sk, int sk, unsigned char reject,
 			if (reject == AVDTP_SET_CONFIGURATION) {
 				hdr->message_type = AVDTP_MSG_TYPE_REJECT;
 				buf[2] = buf[4];
-				buf[3] = 0x13; /* SEP In Use */
+				buf[3] = reject_code ? reject_code :
+							0x13; /* SEP In Use */
 				printf("Rejecting set configuration command\n");
 				len = write(sk, buf, 4);
 			} else {
@@ -443,7 +445,8 @@ static int set_minimum_mtu(int sk)
 	return 0;
 }
 
-static void do_listen(const bdaddr_t *src, unsigned char reject, int fragment)
+static void do_listen(const bdaddr_t *src, unsigned char reject, int fragment,
+							int reject_code)
 {
 	struct sockaddr_l2 addr;
 	socklen_t optlen;
@@ -483,7 +486,7 @@ static void do_listen(const bdaddr_t *src, unsigned char reject, int fragment)
 			continue;
 		}
 
-		process_avdtp(sk, nsk, reject, fragment);
+		process_avdtp(sk, nsk, reject, fragment, reject_code);
 
 		if (media_sock >= 0) {
 			close(media_sock);
@@ -709,6 +712,7 @@ static void usage(void)
 	printf("Options:\n"
 		"\t--device <hcidev>    HCI device\n"
 		"\t--reject <command>   Reject command\n"
+		"\t--reject-code <code> Reject code to use\n"
 		"\t--send <command>     Send command\n"
 		"\t--preconf            Configure stream before actual command\n"
 		"\t--wait <N>           Wait N seconds before exiting\n"
@@ -720,6 +724,7 @@ static struct option main_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "device",	1, 0, 'i' },
 	{ "reject",	1, 0, 'r' },
+	{ "reject-code",	1, 0, 'R' },
 	{ "send",	1, 0, 's' },
 	{ "invalid",	1, 0, 'f' },
 	{ "preconf",	0, 0, 'c' },
@@ -764,12 +769,12 @@ int main(int argc, char *argv[])
 	unsigned char cmd = 0x00;
 	bdaddr_t src, dst;
 	int opt, mode = MODE_NONE, sk, invalid = 0, preconf = 0, fragment = 0;
-	int avctp = 0, wait_before_exit = 0;
+	int avctp = 0, wait_before_exit = 0, reject_code = 0;
 
 	bacpy(&src, BDADDR_ANY);
 	bacpy(&dst, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:r:s:f:hcFCw:",
+	while ((opt = getopt_long(argc, argv, "+i:r:s:f:hcFCw:R:",
 						main_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'i':
@@ -809,6 +814,10 @@ int main(int argc, char *argv[])
 			wait_before_exit = atoi(optarg);
 			break;
 
+		case 'R':
+			reject_code = atoi(optarg);
+			break;
+
 		case 'h':
 		default:
 			usage();
@@ -826,7 +835,7 @@ int main(int argc, char *argv[])
 
 	switch (mode) {
 	case MODE_REJECT:
-		do_listen(&src, cmd, fragment);
+		do_listen(&src, cmd, fragment, reject_code);
 		break;
 	case MODE_SEND:
 		sk = do_connect(&src, &dst, avctp, fragment);
-- 
2.34.1

