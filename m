Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for retrieving messages in fractions
Date: Tue,  5 Mar 2013 12:12:58 +0100
Message-Id: <1362481981-7813-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Changelog v2:
- Change interface org.bluez.obex.Message2
- Document FractionDeliver parameter

Christian Fetzer (3):
  obexd: Move Message.Get parameter attachment into dictionary
  test: Adapt map-client interface org.bluez.obex.Message2
  obexd: Add support for retrieving messages in fractions

 doc/obex-api.txt   |  36 +++++++++++-
 obexd/client/map.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 test/map-client    |   2 +-
 3 files changed, 186 insertions(+), 16 deletions(-)

-- 
1.8.1.4

