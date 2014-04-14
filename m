Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/profile: Fix regression when registering for client only
Date: Mon, 14 Apr 2014 15:40:02 +0300
Message-Id: <1397479202-3632-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1397479202-3632-1-git-send-email-luiz.dentz@gmail.com>
References: <1397479202-3632-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This got introduced with PCE that register a record for PBAP client, but
it end up causing a regression where all profiles that have records would
be probed as if server was enabled as well.

Note that is was possible to register PBAP client with PCE record, in
that case Role option should be omitted so both server and client role
are enabled by default which does not affect PBAP server component since
it uses a different UUID, in fact the correct form to add PCE record is
probably to register as server only.
---
 src/profile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/profile.c b/src/profile.c
index f065235..f30f4f6 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -2209,7 +2209,7 @@ static struct ext_profile *create_ext(const char *owner, const char *path,
 	p->local_uuid = ext->service ? ext->service : ext->uuid;
 	p->remote_uuid = ext->remote_uuid;
 
-	if (ext->enable_server || ext->record || ext->get_record) {
+	if (ext->enable_server) {
 		p->adapter_probe = ext_adapter_probe;
 		p->adapter_remove = ext_adapter_remove;
 	}
-- 
1.9.0

