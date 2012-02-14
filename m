Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 0/6] Several minor fixes
Date: Tue, 14 Feb 2012 15:47:03 +0100
Message-Id: <1329230829-27046-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This second series includes the patches acked in the previous proposal (patches 1, 4, 5, 6) and the reviewed patches 2 and 3.

Patch 2 now considers the possibility of unreferencing the session inside the transfer callback.

Patch 3 now follows more strictly the glib convention on error reporting parameters.

Mikel Astiz (6):
  client: fix memory leak in obc_session_put
  client: fix unreported error case
  client: fix incorrect error check
  client: fix pbap select when same path given twice
  client: queue transfers in ftp sessions
  client: queue transfers in pbap sessions

 client/ftp.c     |   39 ++++---------
 client/pbap.c    |  176 ++++++++++++++++++++++++------------------------------
 client/session.c |   22 ++++++-
 3 files changed, 109 insertions(+), 128 deletions(-)

-- 
1.7.6.5

