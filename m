Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 0/6] Several minor fixes
Date: Thu, 16 Feb 2012 15:00:28 +0100
Message-Id: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This third version fixes a mistake in the previous proposal, as pointed out by Johan.

The rest remains the same and has been acked by Luiz.

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

