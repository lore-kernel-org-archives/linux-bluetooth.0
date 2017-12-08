Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix crash while reading input parameters
Date: Fri,  8 Dec 2017 14:38:05 -0200
Message-Id: <20171208163805.6130-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

read_input_parameters skips the command argument thus arg[0] shall be
considerer the fist argument.
---
 mesh/config-client.c | 2 +-
 mesh/onoff-model.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 7aabe6ce7..da2c79b05 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -232,7 +232,7 @@ static uint32_t read_input_parameters(int argc, char *argv[])
 	--argc;
 	++argv;
 
-	if (!argc || argv[1][0] == '\0')
+	if (!argc || argv[0][0] == '\0')
 		return 0;
 
 	memset(parms, 0xff, sizeof(parms));
diff --git a/mesh/onoff-model.c b/mesh/onoff-model.c
index 9c8869414..2a9860f61 100644
--- a/mesh/onoff-model.c
+++ b/mesh/onoff-model.c
@@ -155,7 +155,7 @@ static uint32_t read_input_parameters(int argc, char *argv[])
 	--argc;
 	++argv;
 
-	if (!argc || argv[1][0] == '\0')
+	if (!argc || argv[0][0] == '\0')
 		return 0;
 
 	memset(parms, 0xff, sizeof(parms));
-- 
2.13.6

