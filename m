Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] tools/mcaptest: Minor style fix
Date: Tue, 10 Feb 2015 18:17:26 +0100
Message-Id: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add white lines between neighbouring bodys.
---
 tools/mcaptest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/mcaptest.c b/tools/mcaptest.c
index 42734eb..980d21a 100644
--- a/tools/mcaptest.c
+++ b/tools/mcaptest.c
@@ -286,6 +286,7 @@ static void create_mcl_cb(struct mcap_mcl *mcap_mcl, GError *err, gpointer data)
 	mcl = mcap_mcl_ref(mcap_mcl);
 	trigger_mdl_action(data_mode);
 }
+
 static void usage(void)
 {
 	printf("mcaptest - MCAP testing ver %s\n", VERSION);
@@ -320,6 +321,7 @@ static struct option main_options[] = {
 	{ "data_ch",		1, 0, 'D' },
 	{ 0, 0, 0, 0 }
 };
+
 int main(int argc, char *argv[])
 {
 	GError *err = NULL;
-- 
1.9.3

