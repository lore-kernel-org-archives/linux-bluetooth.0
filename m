Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 2/4] tools/smp-tester: Remove unused variable.
Date: Mon,  4 May 2015 16:28:12 -0700
Message-Id: <1430782094-18396-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1430782094-18396-1-git-send-email-armansito@chromium.org>
References: <1430782094-18396-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes three unused variables from tools/smp-tester.c.
---
 tools/smp-tester.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index ab77b24..c44dc2d 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -326,13 +326,6 @@ static const struct smp_data smp_server_nval_req_3_test = {
 	.req_count = G_N_ELEMENTS(srv_nval_req_2),
 };
 
-static const uint8_t smp_nval_req_4[] = { 0xff, 0xff };
-static const uint8_t smp_nval_req_4_rsp[] = { 0x05, 0x07 };
-
-static const struct smp_req_rsp srv_nval_req_3[] = {
-	{ smp_nval_req_4, sizeof(smp_nval_req_4), NULL, 0 },
-};
-
 static const uint8_t smp_basic_req_1[] = {	0x01,	/* Pairing Request */
 						0x03,	/* NoInputNoOutput */
 						0x00,	/* OOB Flag */
@@ -455,8 +448,6 @@ static const uint8_t smp_sc_rsp_1[] = {	0x02,	/* Pairing Response */
 
 static const uint8_t smp_sc_pk[65] = { 0x0c };
 
-static const uint8_t smp_sc_failed_rsp_1[] = { 0x05, 0x08 };
-
 static const struct smp_req_rsp cli_sc_req_2[] = {
 	{ NULL, 0, smp_sc_req_1, sizeof(smp_sc_req_1) },
 	{ smp_sc_rsp_1, sizeof(smp_sc_rsp_1), smp_sc_pk, sizeof(smp_sc_pk) },
-- 
2.2.0.rc0.207.ga3a616c

