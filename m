Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/3] Use tester framework
Date: Thu, 01 Oct 2015 20:02:20 +0530
Message-id: <1443709943-29957-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove mainloop and use tester framework to
produces much better output.

Gowtham Anandha Babu (3):
  unit/test-hfp: Use tester framework
  unit/test-sdp: Use tester framework
  unit/test-uhid: Use tester framework

 unit/test-hfp.c  | 91 +++++++++++++++++++++++++++-----------------------------
 unit/test-sdp.c  | 91 +++++++++++++++++++++++++-------------------------------
 unit/test-uhid.c | 62 ++++++++++++++++----------------------
 3 files changed, 110 insertions(+), 134 deletions(-)

-- 
1.9.1

