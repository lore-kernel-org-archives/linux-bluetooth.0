Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/3] tools: Fix hex2hcd compilation error
Date: Wed, 14 May 2014 21:49:09 +0200
Message-Id: <1400096949-18895-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1400096949-18895-1-git-send-email-szymon.janc@gmail.com>
References: <1400096949-18895-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix following with GCC version 4.8.2 (Debian 4.8.2-21):

tools/hex2hcd.c: In function ‘main’:
tools/hex2hcd.c:118:19: error: comparison between signed and
  unsigned integer expressions [-Werror=sign-compare]
     for (i = 0; i < hex_to_int(rbuf + 1); i++) {
                   ^
cc1: all warnings being treated as errors
---
 tools/hex2hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
index c5e5e1f..d9b5d3b 100644
--- a/tools/hex2hcd.c
+++ b/tools/hex2hcd.c
@@ -70,10 +70,10 @@ static int check_hex_line(const char *str, unsigned int len)
 
 int main(int argc, char *argv[])
 {
-	unsigned int addr = 0;
+	unsigned int i, addr = 0;
 	FILE *ifp, *ofp;
 	char *rbuf;
-	ssize_t len, i;
+	ssize_t len;
 	size_t buflen;
 
 	if (argc != 3) {
-- 
2.0.0.rc2

