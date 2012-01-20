Return-Path: <cyrus@holtmann.org>
From: Smriti Gupta <smriti.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>, <smritigupta2008@gmail.com>,
	Smriti Gupta <smriti.gupta@stericsson.com>
Subject: [PATCH BlueZ v2 0/1] Add provision for terminating an ATT connection
Date: Fri, 20 Jan 2012 17:24:25 +0530
Message-ID: <1327060466-17978-1-git-send-email-smriti.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch is updated version after incorporating Johan's comments.
In order to terminate any existing ATT connection from the client side
existing function device_request_disconnect has been updated.

Smriti Gupta (1):
  Add provision for terminating an ATT connection

 src/device.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

