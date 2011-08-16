Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Date: Tue, 16 Aug 2011 11:45:37 +0200
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "ovasik@redhat.com" <ovasik@redhat.com>
Subject: [PATCH 2/8] Missing comma
MIME-Version: 1.0
From: "Pavel Raiskup" <praiskup@redhat.com>
Message-ID: <op.v0av2bteh52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Missing comma in static array chassis_map definition between
"Blade" and "Blade Enclosure" field.

Typing error fixed.

---
  plugins/formfactor.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/formfactor.c b/plugins/formfactor.c
index 3b31927..0e19ac6 100644
--- a/plugins/formfactor.c
+++ b/plugins/formfactor.c
@@ -73,10 +73,10 @@ static const char *chassis_map[] = {
  	"Rack Mount Chassis",    "unknown",
  	"Sealed-case PC",        "unknown",
  	"Multi-system",          "unknown",
-	"CompactPCI",            "unknonw",
+	"CompactPCI",            "unknown",
  	"AdvancedTCA",           "unknown",
  	"Blade",                 "server",
-	"Blade Enclosure"        "unknown", /* 0x1D */
+	"Blade Enclosure",       "unknown", /* 0x1D */
  	NULL
  };

-- 
1.7.4.4
