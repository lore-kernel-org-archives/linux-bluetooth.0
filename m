Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] Fix empty parameter list in usage() declaration
Date: Wed, 18 May 2011 08:42:47 +0200
Message-ID: <1305700967-13217-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1305700967-13217-1-git-send-email-szymon.janc@tieto.com>
References: <1305700967-13217-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbctester.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sbc/sbctester.c b/sbc/sbctester.c
index b1e3608..c08c22a 100644
--- a/sbc/sbctester.c
+++ b/sbc/sbctester.c
@@ -245,7 +245,7 @@ static int check_absolute_diff(SNDFILE * sndref, SF_INFO * infosref,
 	return verdict;
 }
 
-static void usage()
+static void usage(void)
 {
 	printf("SBC conformance test ver %s\n", VERSION);
 	printf("Copyright (c) 2007-2010  Marcel Holtmann\n");
-- 
on behalf of ST-Ericsson

