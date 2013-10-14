Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 17/22] unit: Add more test cases for the at parser
Date: Mon, 14 Oct 2013 10:34:33 +0200
Message-Id: <1381739678-16260-18-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds unit tests for AT commands required by HFP to establish
SLC.
---
 unit/test-blueatchat.c |  522 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 521 insertions(+), 1 deletion(-)

diff --git a/unit/test-blueatchat.c b/unit/test-blueatchat.c
index ae10ff7..e0cd23b 100644
--- a/unit/test-blueatchat.c
+++ b/unit/test-blueatchat.c
@@ -78,6 +78,24 @@ static void tc_blueat_ok(struct blueat_fixture *fix, gconstpointer test_data)
 	/* one ok command should be found */
 	g_assert_cmpint(called, ==, 1);
 }
+
+static bool tc_blueat_error_cb(GSList *data)
+{
+	called += 1;
+	g_message("ERROR callback");
+	g_assert(!data);
+	return true;
+}
+static void tc_blueat_error(struct blueat_fixture *fix, gconstpointer test_data)
+{
+	fix->msg = "\r\nERROR\r\n";
+
+	g_main_loop_run(fix->loop);
+
+	/* one error command should be found */
+	g_assert_cmpint(called, ==, 1);
+}
+
 static void tc_blueat_garbagemix(struct blueat_fixture *fix,
 					gconstpointer test_data)
 {
@@ -120,6 +138,28 @@ static void tc_blueat_atbrsf(struct blueat_fixture *fix,
 	g_assert_cmpint(called, ==, 1);
 }
 
+static bool tc_blueat_brsf_cb(GSList *data)
+{
+	called += 1;
+	g_message("+BRSF: callback");
+
+	g_assert(data);
+	g_assert(data->data);
+	g_assert_cmpint(*(int *)data->data, ==, 192);
+
+	return true;
+}
+static void tc_blueat_brsf(struct blueat_fixture *fix, gconstpointer test_data)
+{
+	/* Define test case */
+	fix->msg = "\r\n+BRSF: 192\r\n";
+
+	g_main_loop_run(fix->loop);
+
+	/* 1 callback should be called */
+	g_assert_cmpint(called, ==, 1);
+}
+
 static void tc_blueat_garbage(struct blueat_fixture *fix,
 					gconstpointer test_data)
 {
@@ -178,6 +218,383 @@ static void tc_blueat_cnum(struct blueat_fixture *fix, gconstpointer test_data)
 	g_assert_cmpint(called, ==, 1);
 }
 
+static bool tc_blueat_atchld_t_cb(GSList *data)
+{
+	called += 1;
+	g_message("AT+CHLD=? callback");
+	g_assert(!data);
+	return true;
+}
+static void tc_blueat_atchld_t(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\nAT+CHLD=?\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
+static bool tc_blueat_atchld_cb(GSList *data)
+{
+	called += 1;
+	g_message("AT+CHLD= callback");
+	g_assert(data);
+	g_assert(data->data);
+	g_assert_cmpint(*(int *)data->data, ==, 3);
+
+	return true;
+}
+static void tc_blueat_atchld(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\nAT+CHLD=3\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
+static bool tc_blueat_chld_cb(GSList *data)
+{
+	GSList *item = NULL;
+
+	called += 1;
+	g_message("+CHLD: callback");
+
+	g_assert(data);
+	item = g_slist_reverse(data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 1);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 1);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(char *)item->data, ==, 'x');
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 2);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 2);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(char *)item->data, ==, 'x');
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 3);
+
+	return true;
+}
+static void tc_blueat_chld(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\n+CHLD: (0,1,1x,2,2x,3)\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
+static bool tc_blueat_atcind_r_cb(GSList *data)
+{
+	called += 1;
+	g_message("AT+CIND? callback");
+
+	g_assert(!data);
+	return true;
+}
+static void tc_blueat_atcind_r(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\nAT+CIND?\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
+static bool tc_blueat_atcind_t_cb(GSList *data)
+{
+	called += 1;
+	g_message("AT+CIND=? callback");
+	g_assert(!data);
+	return true;
+}
+static void tc_blueat_atcind_t(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\nAT+CIND=?\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
+static bool tc_blueat_cind1_cb(GSList *data)
+{
+	GSList *item = NULL;
+	int values[] = { 1, 1, 0, 0, 5, 0, 0 };
+	int unsigned i;
+
+	called += 1;
+	g_message("1+CIND: callback");
+
+	g_assert(data);
+	item = g_slist_reverse(data);
+
+	for (i = 0; i < sizeof(values) / sizeof(int); ++i) {
+		g_assert(item);
+		g_assert(item->data);
+		g_assert_cmpint(*(int *)item->data, ==, values[i]);
+		item = g_slist_next(item);
+	}
+	/* We declared 20 parameters in descriptor so there can be more data.
+	 * but of course not in this case, because we know what we have sent.
+	 */
+	if (item)
+		for (; i < 19; ++i) {
+			g_assert(item->data == NULL);
+			item = g_slist_next(item);
+		}
+	/* there should be no more data */
+	g_assert(!item);
+	return true;
+}
+static void tc_blueat_cind1(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\n+CIND: 1,1,0,0,5,0,0\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
+static bool tc_blueat_cind2_cb(GSList *data)
+{
+	GSList *item = NULL;
+
+	called += 1;
+	g_message("2+CIND: callback");
+	g_assert(data);
+
+	item = g_slist_reverse(data);
+
+	g_assert(item);
+	g_assert(item->data);
+	g_assert((char *)item->data);
+	g_assert_cmpint(strcmp(item->data, "Voice Mail"), ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 1);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(strcmp((char *)item->data, "service"), ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 1);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(strcmp((char *)item->data, "call"), ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 1);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(strcmp((char *)item->data, "Roam"), ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 2);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(strcmp((char *)item->data, "signal"), ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 5);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(strcmp((char *)item->data, "callsetup"), ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 3);
+
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(strcmp((char *)item->data, "smsfull"), ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 1);
+
+	g_assert((item = g_slist_next(item)) == NULL);
+	return true;
+}
+static void tc_blueat_cind2(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\n+CIND: (\"Voice Mail\",(0,1)),(\"service\",(0,1)),"
+			"(\"call\",(0,1)),(\"Roam\",(0-2)),(\"signal\",(0-5)),"
+			"(\"callsetup\",(0-3)),(\"smsfull\",(0,1))\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
+static bool tc_blueat_atcmer_cb(GSList *data)
+{
+	GSList *item = NULL;
+
+	called += 1;
+	g_message("AT+CMER= callback");
+	g_assert(data);
+	item = g_slist_reverse(data);
+
+	/* Check for data "ou,ou,ou,ou*" */
+	g_assert(item);
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 3);
+
+	/* no second parameter because its optional */
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data == NULL);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 1);
+	return true;
+}
+static void tc_blueat_atcmer(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\nAT+CMER=3,,0,1\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
+static bool tc_blueat_ciev_cb(GSList *data)
+{
+	GSList *item = NULL;
+
+	called += 1;
+	g_message("+CIEV: callback");
+	g_assert(data);
+	item = g_slist_reverse(data);
+
+	g_assert(item);
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 3);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 0);
+	return true;
+}
+static void tc_blueat_ciev(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\n+CIEV: 3,0\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
+static bool tc_blueat_atbac_cb(GSList *data)
+{
+	GSList *item = NULL;
+
+	called += 1;
+	g_message("AT+BAC= callback");
+	g_assert(data);
+	item = g_slist_reverse(data);
+
+	/* Check returned data "u,ou,ou,ou,ou,ou,ou" */
+
+	g_assert(item);
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 1);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 2);
+
+	g_assert((item = g_slist_next(item)));
+	g_assert(item->data);
+	g_assert_cmpint(*(int *)item->data, ==, 12);
+
+	/* According to descriptor there should be 4 nulls but not
+	 * if there was no more data - of course there wont be any here
+	 */
+	item = g_slist_next(item);
+	if (item) {
+		g_assert(item->data == NULL);
+		g_assert((item = g_slist_next(item))->data == NULL);
+		g_assert((item = g_slist_next(item))->data == NULL);
+		g_assert((item = g_slist_next(item))->data == NULL);
+	}
+
+	/* there should be no more data */
+	g_assert(!item);
+	return true;
+}
+static void tc_blueat_atbac(struct blueat_fixture *fix,
+				gconstpointer test_data)
+{
+	fix->msg = "\r\nAT+BAC=1,2,12\r\n";
+
+	g_main_loop_run(fix->loop);
+	g_assert_cmpint(called, ==, 1);
+}
+
 /******************************************************************************
  * Parser configuration and command registration
  ******************************************************************************/
@@ -193,8 +610,72 @@ static struct blueatchat_config cfg = {
 static struct blueatchat_cmd_descriptor commands[] = {
 	/* recognised command | syntax descriptor   |   callback */
 	{"OK",		NULL,				tc_blueat_ok_cb},
-	{"AT+BRSF=",	"u",				tc_blueat_atbrsf_cb},
+	{"ERROR",	NULL,				tc_blueat_error_cb},
+	{"NO CARRIER",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"BUSY",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"NO ANSWER",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"DELAYED",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"BLACKLISTED",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"RING",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"ATA",		NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+CCWA=",	"ou",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+CCWA: ",	"s,ou*",	/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+CHLD=?",	NULL,				tc_blueat_atchld_t_cb},
+	{"AT+CHLD=",	"u",				tc_blueat_atchld_cb},
+	{"+CHLD: ",	"(ou,ou,ouc,ou,ouc,ou)",	tc_blueat_chld_cb},
+	{"AT+CHUP",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"+CHUP",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+CIND?",	NULL,				tc_blueat_atcind_r_cb},
+	{"AT+CIND=?",	NULL,				tc_blueat_atcind_t_cb},
+	{"+CIND: ",	"ou,ou,ou,ou,ou,ou,ou,ou,ou,ou,"
+			"ou,ou,ou,ou,ou,ou,ou,ou,ou,ou", tc_blueat_cind1_cb},
+	{"+CIND: ",	"(q,(u-u))o,(q,(u-u))o,(q,(u-u))"
+			"o,(q,(u-u))o,(q,(u-u))o,(q,(u-u))"
+			"o,(q,(u-u))o,(q,(u-u))o,(q,(u-u))"
+			"o,(q,(u-u))o,(q,(u-u))o,(q,(u-u))"
+			"o,(q,(u-u))o,(q,(u-u))o,(q,(u-u))"
+			"o,(q,(u-u))o,(q,(u-u))o,(q,(u-u))"
+			"o,(q,(u-u))o,(q,(u-u))",	tc_blueat_cind2_cb},
+	{"AT+CLCC",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"+CLCC: ",	"u,u,u,u,u,os,ou*",/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+COPS=",	"ou,ou,os*",	/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+COPS?",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"+COPS: ",	"u,ou,os*",	/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+CMEE=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+CMEE ERROR: ",	"u",	/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+CLIP=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+CLIP: ",	"q,u*",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+CMER=",	"ou,ou,ou,ou*",			tc_blueat_atcmer_cb},
+	{"+CIEV: ",	"u,u",				tc_blueat_ciev_cb},
+	{"AT+VTS=",	"c",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+CNUM=?",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+CNUM",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
 	{"+CNUM: ",	"oq,q,u,ou,u*",			tc_blueat_cnum_cb},
+	{"ATD>",	"q",		/*TODO*/	tc_blueat_unknown_cb},
+	{"ATD",		"s",		/*TODO*/	tc_blueat_unknown_cb},
+	/* Bluetooth cpecific */
+	{"AT+BIA=",	"ou,ou,ou,ou,ou,ou,ou,ou,ou,ou,"
+			"ou,ou,ou,ou,ou,ou,ou,ou,ou,ou", tc_blueat_unknown_cb},
+	{"AT+BINP=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+BINP: ",	"q*",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+BLDN=",	NULL,		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+BVRA=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+BVRA: ",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+BRSF=",	"u",				tc_blueat_atbrsf_cb},
+	{"+BRSF: ",	"u",				tc_blueat_brsf_cb},
+	{"AT+NREC=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+VGM=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+VGM:",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+VGS=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+VGS: ",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+BSIR: ",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+BTRH=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+BTRH: ",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+BCC=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+BCS=",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"+BCS: ",	"u",		/*TODO*/	tc_blueat_unknown_cb},
+	{"AT+BAC=",	"u,ou,ou,ou,ou,ou,ou",		tc_blueat_atbac_cb},
+	/* used lastly if no other command matches */
 	{NULL,		"s",				tc_blueat_unknown_cb},
 };
 
@@ -327,8 +808,47 @@ int main(int argc, char **argv)
 	g_test_add("/blueatchat/garbage", struct blueat_fixture, 0,
 				blueat_fix_setup, tc_blueat_garbage,
 				blueat_fix_teardown);
+	g_test_add("/blueatchat/error", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_error,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/brsf", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_brsf,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/atchld_test", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_atchld_t,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/atchld", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_atchld,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/chld", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_chld,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/brsf", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_brsf,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/atcind_request", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_atcind_r,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/atcind_test", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_atcind_t,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/atcmer", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_atcmer,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/ciev", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_ciev,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/atbac", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_atbac,
+				blueat_fix_teardown);
 	g_test_add("/blueatchat/cnum", struct blueat_fixture, 0,
 				blueat_fix_setup, tc_blueat_cnum,
 				blueat_fix_teardown);
+	g_test_add("/blueatchat/cind_1", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_cind1,
+				blueat_fix_teardown);
+	g_test_add("/blueatchat/cind_2", struct blueat_fixture, 0,
+				blueat_fix_setup, tc_blueat_cind2,
+				blueat_fix_teardown);
 	return g_test_run();
 }
-- 
1.7.9.5

