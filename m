Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 00/12] client: Polishing D-Bus API
Date: Mon, 21 May 2012 11:07:02 +0200
Message-Id: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patchset includes a first set of D-Bus changes as part of a bigger API rewrite in obex-client. The original API proposal started around 6 months ago ([1]) and it has later been discussed and modified several times.

This first series proposes some minor refactoring of the existing APIs. The most relevant part, regarding the removal of the agent, is left for a later discussion.

[1] http://marc.info/?l=linux-bluetooth&m=132189357404237&w=2

Mikel Astiz (12):
  client-doc: Wrap OPP into specific session type
  client: Use constant instead of NULL variable
  client: Wrap OPP into specific session type
  client-test: Update to wrapped OPP session type
  client-doc: Replace SendFiles with SendFile
  client: Replace SendFiles with SendFile
  client-test: Replace SendFiles with SendFile
  client-doc: Move GetCapabilities to session API
  client: Move GetCapabilities to session API
  client-doc: Replace parameter dict with conventional ones
  client: Replace parameter dict with conventional ones
  client-test: Replace CreateSession parameter dict

 client/manager.c             |  406 ++---------------------------------------
 client/opp.c                 |  205 +++++++++++++++++++++-
 client/session.c             |   68 +++++++
 doc/client-api.txt           |   69 ++++---
 test/exchange-business-cards |    9 +-
 test/ftp-client              |    3 +-
 test/get-capabilities        |   15 +-
 test/list-folders            |    2 +-
 test/map-client              |    3 +-
 test/pbap-client             |    2 +-
 test/pull-business-card      |    8 +-
 test/send-files              |   85 ++--------
 12 files changed, 370 insertions(+), 505 deletions(-)

-- 
1.7.7.6

