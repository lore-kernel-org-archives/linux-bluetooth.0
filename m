Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v1 0/1] Add KeyboardDisplay IO Capability
Date: Mon, 16 Jan 2012 13:36:41 +0530
Message-ID: <1326701202-23977-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a rebased version of previous patch, incorporating
Johan's comments. This patch is dependent on Kernel
patch [PATCH v1 1/1] Bluetooth: Send correct response to IO
Capability Request. 

Hemant Gupta (1):
  Add KeyboardDisplay IO Capability

 plugins/hciops.c |    8 +++++++-
 src/adapter.c    |    3 +++
 2 files changed, 10 insertions(+), 1 deletions(-)

