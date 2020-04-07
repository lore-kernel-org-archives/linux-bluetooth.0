Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7379BC2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA39206BE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 19:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgDGTt3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:49:29 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:57660 "EHLO
        8.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDGTt3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 15:49:29 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2020 15:49:28 EDT
Received: from player159.ha.ovh.net (unknown [10.108.42.145])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2F49D993D2
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2020 21:44:05 +0200 (CEST)
Received: from labapart.com (mue-88-130-59-209.dsl.tropolys.de [88.130.59.209])
        (Authenticated sender: olivier@labapart.com)
        by player159.ha.ovh.net (Postfix) with ESMTPSA id D874F1130FF92;
        Tue,  7 Apr 2020 19:44:03 +0000 (UTC)
From:   Olivier Martin <olivier@labapart.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Olivier Martin <olivier@labapart.com>
Subject: [PATCH BlueZ v3] emulator: Fix command line parameters with optional argument
Date:   Tue,  7 Apr 2020 21:44:00 +0200
Message-Id: <20200407194400.5960-1-olivier@labapart.com>
X-Mailer: git-send-email 2.17.1
X-Ovh-Tracer-Id: 15565847689298013772
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudehgddufeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofestddtredtredttdenucfhrhhomhepqfhlihhvihgvrhcuofgrrhhtihhnuceoohhlihhvihgvrheslhgrsggrphgrrhhtrdgtohhmqeenucfkpheptddrtddrtddrtddpkeekrddufedtrdehledrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepohhlihhvihgvrheslhgrsggrphgrrhhtrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some parameters were missing the indication that additional
argument could be expected.
---
 emulator/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/emulator/main.c b/emulator/main.c
index 68c53488e..75cb79c7b 100644
--- a/emulator/main.c
+++ b/emulator/main.c
@@ -56,10 +56,12 @@ static void usage(void)
 	printf("options:\n"
 		"\t-S                    Create local serial port\n"
 		"\t-s                    Create local server sockets\n"
-		"\t-l [num]              Number of local controllers\n"
+		"\t-l[num]               Number of local controllers\n"
 		"\t-L                    Create LE only controller\n"
+		"\t-U[num]               Number of test LE controllers\n"
 		"\t-B                    Create BR/EDR only controller\n"
 		"\t-A                    Create AMP controller\n"
+		"\t-T[num]               Number of test AMP controllers\n"
 		"\t-h, --help            Show help options\n");
 }
 
@@ -97,7 +99,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "Ssl::LBAUTvh",
+		opt = getopt_long(argc, argv, "Ssl::LBAU::T::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
-- 
2.17.1

