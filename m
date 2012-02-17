Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v4 0/6] Several minor fixes
Date: Fri, 17 Feb 2012 13:55:30 +0100
Message-Id: <1329483336-25853-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This fourth version fixes some style-issues (patches 2 and 3) and removes a potential warning due to a missing 'static' keyword.

Mikel Astiz (6):
  client: fix memory leak in obc_session_put
  client: fix unreported error case
  client: fix incorrect error check
  client: fix pbap select when same path given twice
  client: queue transfers in ftp sessions
  client: queue transfers in pbap sessions

 client/ftp.c     |   39 ++++---------
 client/pbap.c    |  176 ++++++++++++++++++++++++------------------------------
 client/session.c |   23 ++++++-
 3 files changed, 109 insertions(+), 129 deletions(-)

-- 
1.7.6.5

