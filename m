Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/4] Some small bluetooth.c cleanups and fixes
Date: Fri, 4 Mar 2011 19:34:01 +0100
Message-ID: <1299263645-25329-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Along with "[PATCH] Simplify bachk function" these patches make bluetooth.c
a little nicer.

BR,
Szymon Janc
on behalf of ST-Ericsson

Szymon Janc (4):
  Simplify ba2oui function
  Simplify ba2str function
  Fix str2ba behaviour on malformed bt address
  Make strtoba use str2ba for string conversion

 lib/bluetooth.c |   44 +++++++++++++++-----------------------------
 1 files changed, 15 insertions(+), 29 deletions(-)

