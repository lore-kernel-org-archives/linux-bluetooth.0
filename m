Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] mesh: Fix crash while reading input parameters
Date: Fri,  8 Dec 2017 15:12:30 -0200
Message-Id: <20171208171230.11069-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

read_input_parameters skips the command argument thus arg[0] shall be
considerer the fist argument.
---
 mesh/config-client.c | 5 ++++-
 mesh/onoff-model.c   | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/mesh/config-client.c b/mesh/config-client.c
index 7aabe6ce7..3d618b6a6 100644
--- a/mesh/config-client.c
+++ b/mesh/config-client.c
@@ -229,10 +229,13 @@ static uint32_t read_input_parameters(int argc, char *argv[])
 {
 	uint32_t i;
 
+	if (!argc)
+		return 0;
+
 	--argc;
 	++argv;
 
-	if (!argc || argv[1][0] == '\0')
+	if (!argc || argv[0][0] == '\0')
 		return 0;
 
 	memset(parms, 0xff, sizeof(parms));
diff --git a/mesh/onoff-model.c b/mesh/onoff-model.c
index 9c8869414..fc0d64617 100644
--- a/mesh/onoff-model.c
+++ b/mesh/onoff-model.c
@@ -152,10 +152,13 @@ static uint32_t read_input_parameters(int argc, char *argv[])
 {
 	uint32_t i;
 
+	if (!argc)
+		return 0;
+
 	--argc;
 	++argv;
 
-	if (!argc || argv[1][0] == '\0')
+	if (!argc || argv[0][0] == '\0')
 		return 0;
 
 	memset(parms, 0xff, sizeof(parms));
-- 
2.13.6

