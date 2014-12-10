Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  0/3] core: Fix ERROR CODES desc as per core_v4.2
Date: Wed, 10 Dec 2014 17:16:45 +0530
Message-id: <1418212008-8594-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Modified the error codes description as per core V4.2, Vol 2, Part D.
Provided fix for checkpatch errors.

Gowtham Anandha Babu (3):
  monitor/packet: Fix ERROR CODES as per core_v4.2
  parser/hci: Fix ERROR CODES as per core_v4.2
  monitor/packet: Fix possbile checkpatch errors

 monitor/packet.c   | 23 ++++++++++++-----------
 tools/parser/hci.c |  6 +++---
 2 files changed, 15 insertions(+), 14 deletions(-)

-- 
1.9.1

