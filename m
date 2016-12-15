Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Mansour <mansour@oxplot.com>
Date: Thu, 15 Dec 2016 11:39:50 +1100
Message-ID: <CAPV0TS59VAWtdZWtvnz6zUa_YC7K0r3aakqLQUttkG8yODWZ+g@mail.gmail.com>
Subject: [PATCH] Uncomment section headers in config file
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a config key under [Policy] section is uncommented right now, it's
assumed to be in [General] section because [Policy] line is commented
out and it won't work.

Signed-off-by: Mansour Behabadi <mansour@oxplot.com>
---
 src/main.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.conf b/src/main.conf
index d9cd9e0..9d1c029 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -71,7 +71,7 @@
 # Defaults to "off"
 # Privacy = off

-#[Policy]
+[Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
 # to be reconnected to in case of a link loss (link supervision
-- 
2.10.2
