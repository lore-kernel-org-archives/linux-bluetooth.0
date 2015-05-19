Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/5] Use tester framework for unit-tests
Date: Tue, 19 May 2015 20:30:59 +0530
Message-id: <1432047664-23655-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Used the tester framework for unit-tests
to produce much better results.

Gowtham Anandha Babu (5):
  unit/test-ringbuf: Use tester framework
  unit/test-textfile: Use tester framework
  unit/test-queue: Use tester framework
  unit/test-lib: Use tester framework
  unit/test-uuid: Use tester framework

 Makefile.am          |   8 ++--
 unit/test-lib.c      | 106 +++++++++++++++++++++++++++++----------------------
 unit/test-queue.c    |  55 ++++++++++++++++----------
 unit/test-ringbuf.c  |  31 ++++++++-------
 unit/test-textfile.c |  49 +++++++++++-------------
 unit/test-uuid.c     |  52 ++++++++++++++-----------
 6 files changed, 170 insertions(+), 131 deletions(-)

-- 
1.9.1

