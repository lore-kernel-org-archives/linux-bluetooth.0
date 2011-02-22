Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/3] Remove unneeded comma in the hcitool commands declaration
Date: Tue, 22 Feb 2011 18:42:05 -0300
Message-Id: <1298410927-9165-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcitool.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index d7a82cc..875e25e 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2563,8 +2563,8 @@ static struct {
 	{ "clkoff", cmd_clkoff, "Read clock offset"                    },
 	{ "clock",  cmd_clock,  "Read local or remote clock"           },
 	{ "lescan", cmd_lescan, "Start LE scan"                        },
-	{ "lecc",   cmd_lecc,   "Create a LE Connection",              },
-	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection",          },
+	{ "lecc",   cmd_lecc,   "Create a LE Connection"               },
+	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection"           },
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.4.1

