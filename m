Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, sunil.a.kumar@intel.com,
	rashmi.g.nair@intel.com, prashant.khanzode@intel.com,
	luiz.von.dentz@intel.com,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ] AVCTP: return not-implemented for unknown passthrough
Date: Tue, 28 Feb 2012 11:20:17 -0300
Message-Id: <1330438817-23824-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <CABBYNZL32nUYXTXTM1gCmRhGms5qGpW2uibyT5j5gDBow8Akiw@mail.gmail.com>
References: <CABBYNZL32nUYXTXTM1gCmRhGms5qGpW2uibyT5j5gDBow8Akiw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avctp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 5bd5db1..1d425eb 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -235,9 +235,12 @@ static size_t handle_panel_passthrough(struct avctp *session,
 		break;
 	}
 
-	if (key_map[i].name == NULL)
+	if (key_map[i].name == NULL) {
 		DBG("AV/C: unknown button 0x%02X %s",
 						operands[0] & 0x7F, status);
+		*code = AVC_CTYPE_NOT_IMPLEMENTED;
+		return 0;
+	}
 
 done:
 	*code = AVC_CTYPE_ACCEPTED;
-- 
1.7.9.2

