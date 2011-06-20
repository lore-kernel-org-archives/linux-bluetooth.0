Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <yongli@qca.qualcomm.com>,
	Nami <nami.li@atheros.com>
Subject: [PATCH obexd 14/14] Fix compile error.
Date: Mon, 20 Jun 2011 17:45:00 +0800
Message-ID: <1308563100-18917-14-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/main.c b/test/main.c
index 37b307c..4bd8e19 100644
--- a/test/main.c
+++ b/test/main.c
@@ -256,7 +256,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}

-	obex = gw_obex_setup_fd(sk, target, target_len, NULL, &error);
+	obex = gw_obex_setup_fd(sk, target, target_len, NULL, &error,FDOBEX_MT_STREAM);
 	if (obex == NULL) {
 		fprintf(stderr, "Failed to create OBEX session\n");
 		close(sk);
--
1.7.1

