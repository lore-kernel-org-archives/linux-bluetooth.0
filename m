Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH BlueZ 0/1] Add support for KeyboardDisplay IO Capability
Date: Mon, 26 Dec 2011 12:05:10 +0530
Message-ID: <1324881311-26211-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this patch if local device tries to set KeyboardDisplay IO
Capability, error is returned by BlueZ while registering the agent.

Hemant Gupta (1):
  Add KeyboardDisplay IO Capability.

 src/adapter.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

