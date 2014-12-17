Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 0/2] rfcomm: Add Test command decoding implementation
Date: Wed, 17 Dec 2014 17:29:43 +0530
Message-id: <1418817585-26816-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for decoding RFCOMM Test command in
monitor and tools/parser.

Gowtham Anandha Babu (2):
  monitor/rfcomm: Add support for decoding Test command
  parser/rfcomm: Add support for decoding Test command

 monitor/rfcomm.c      | 19 +++++++++++++++++++
 tools/parser/rfcomm.c | 12 +++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
1.9.1

