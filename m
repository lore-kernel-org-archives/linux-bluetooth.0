Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [RFC 0/3] Expose AuthorizeGet opp
Date: Fri, 10 Jul 2015 20:41:49 +0530
Message-id: <1436541112-21844-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As similar to AuthorizePush, have created a method to authorize
incoming get request, so the user can select the file location at
runtime. Tested with PTS.

Gowtham Anandha Babu (3):
  doc/obex-agent-api: Add AuthorizeGet method
  test/obex: Add AuthorizeGet on Agent2 interface
  obexd/opp: Add support for authorizing GET request

 doc/obex-agent-api.txt | 30 ++++++++++++++++++++++++++++++
 obexd/plugins/opp.c    | 23 +++++++++++++++++++----
 obexd/src/manager.c    | 18 ++++++++++++------
 obexd/src/manager.h    |  2 +-
 test/simple-obex-agent | 27 +++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 11 deletions(-)

-- 
1.9.1

