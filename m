Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Off-by-one(two) error in form factor detection
Date: Tue, 16 Aug 2011 11:43:55 +0200
Cc: "ovasik@redhat.com" <ovasik@redhat.com>
MIME-Version: 1.0
From: "Pavel Raiskup" <praiskup@redhat.com>
Message-ID: <op.v0avzhpah52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Indexing of chassis_map array has to be done like that:
     chassis_map[chassis_type * 2 - 1]

because if not, everything is shifted by one. When (e.g.) chassis_type
is 0x04 result should be "Low Profile Desktop" =>  "desktop" (not a
"Pizza Box" => "server"). Lets see the 2.6.1 document on:

http://www.dmtf.org/standards/smbios
---
  plugins/formfactor.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/formfactor.c b/plugins/formfactor.c
index 33a8b32..3b31927 100644
--- a/plugins/formfactor.c
+++ b/plugins/formfactor.c
@@ -104,7 +104,7 @@ static int formfactor_probe(struct btd_adapter  
*adapter)
  		return 0;
  	}

-	formfactor = chassis_map[chassis_type * 2 + 1];
+	formfactor = chassis_map[chassis_type * 2 - 1];
  	if (formfactor != NULL) {
  		if (g_str_equal(formfactor, "laptop") == TRUE)
  			minor |= (1 << 2) | (1 << 3);
-- 
1.7.4.4
