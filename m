Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Florian Grandel <fgrandel@gmail.com>
Subject: [BlueZ v2 0/3] Minor improvements to the docs and mgmt API tests
Date: Sun,  5 Apr 2015 21:11:25 +0200
Message-Id: <1428261088-14121-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428259165-10021-3-git-send-email-fgrandel@gmail.com>
References: <1428259165-10021-3-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1 -> v2: found more instances of misleading test messages

Florian Grandel (3):
  doc: fix minor typos
  tools: fix misleading test output
  tools: add read adv features success tests

 doc/coding-style.txt          |  2 +-
 doc/maintainer-guidelines.txt |  2 +-
 doc/test-coverage.txt         |  2 +-
 tools/mgmt-tester.c           | 37 +++++++++++++++++++++++++++++++++----
 4 files changed, 36 insertions(+), 7 deletions(-)

-- 
1.9.1

