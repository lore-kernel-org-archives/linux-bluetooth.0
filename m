Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?b?xYF1a2Fzeg==?= Stelmach <stlman@poczta.fm>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?b?xYF1a2Fzeg==?= Stelmach <stlman@poczta.fm>
Subject: [PATCH] Fix off-by-one error in form factor detection.
Date: Wed, 27 Jul 2011 22:55:31 +0200
Message-Id: <1311800131-11121-1-git-send-email-stlman@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The keywords we are looking for are at odd positions.

Signed-off-by: Łukasz Stelmach <stlman@poczta.fm>
---
 plugins/formfactor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/formfactor.c b/plugins/formfactor.c
index 758d481..33a8b32 100644
--- a/plugins/formfactor.c
+++ b/plugins/formfactor.c
@@ -104,7 +104,7 @@ static int formfactor_probe(struct btd_adapter *adapter)
 		return 0;
 	}
 
-	formfactor = chassis_map[chassis_type * 2];
+	formfactor = chassis_map[chassis_type * 2 + 1];
 	if (formfactor != NULL) {
 		if (g_str_equal(formfactor, "laptop") == TRUE)
 			minor |= (1 << 2) | (1 << 3);
-- 
1.7.3.4


----------------------------------------------------------------
Najwieksza baza samochodow nowych i uzywanych
Sprawdz >> http://linkint.pl/f29e3
