Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 10/22] dun: Fix using old-style initializers
Date: Fri, 10 Feb 2012 18:39:55 -0300
Message-Id: <1328910007-25604-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 compat/dun.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/dun.c b/compat/dun.c
index de98830..3f3a0d4 100644
--- a/compat/dun.c
+++ b/compat/dun.c
@@ -191,8 +191,8 @@ static int dun_create_tty(int sk, char *tty, int size)
 	int id, try = 30;
 
 	struct rfcomm_dev_req req = {
-		flags:   (1 << RFCOMM_REUSE_DLC) | (1 << RFCOMM_RELEASE_ONHUP),
-		dev_id:  -1
+		.flags = (1 << RFCOMM_REUSE_DLC) | (1 << RFCOMM_RELEASE_ONHUP),
+		.dev_id = -1
 	};
 
 	alen = sizeof(sa);
-- 
1.7.8.1

