Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] mgmt-tester: Use proper type specifier for printing size_t
Date: Thu, 18 Sep 2014 12:33:51 +0200
Message-Id: <1411036431-21458-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix following error:

tools/mgmt-tester.c: In function ‘verify_ltk’:
tools/mgmt-tester.c:2633:19: error: format ‘%u’ expects argument of
    type ‘unsigned int’, but argument 3 has type
    ‘long unsigned int’ [-Werror=format=]
     sizeof(struct mgmt_ev_new_long_term_key));
                   ^
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 805bcbe..177b51b 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2629,7 +2629,7 @@ static bool verify_ltk(const void *param, uint16_t length)
 	const struct mgmt_ev_new_long_term_key *ev = param;
 
 	if (length != sizeof(struct mgmt_ev_new_long_term_key)) {
-		tester_warn("Invalid new ltk length %u != %u", length,
+		tester_warn("Invalid new ltk length %u != %zu", length,
 				sizeof(struct mgmt_ev_new_long_term_key));
 		return false;
 	}
-- 
1.9.3

