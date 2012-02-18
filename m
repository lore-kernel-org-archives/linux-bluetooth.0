Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 7/8] core: Use ENOSYS to indicate not implemented function
Date: Sat, 18 Feb 2012 17:19:02 +0200
Message-Id: <1329578343-31663-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
References: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/opp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/opp.c b/plugins/opp.c
index d9b68b2..fa3ee91 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -120,7 +120,7 @@ static int opp_chkput(struct obex_session *os, void *user_data)
 	int err;
 
 	if (obex_get_size(os) == OBJECT_SIZE_DELETE)
-		return -EINVAL;
+		return -ENOSYS;
 
 	t = obex_get_name(os);
 	if (t != NULL && !is_filename(t))
-- 
1.7.7.6

