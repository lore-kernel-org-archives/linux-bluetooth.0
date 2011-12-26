Return-Path: <cyrus@holtmann.org>
From: smriti <smriti.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>, smriti <smriti.gupta@stericsson.com>
Subject: [RFC BlueZ 0/1] Add provision for terminating an ATT connection 
Date: Mon, 26 Dec 2011 15:46:09 +0530
Message-ID: <1324894570-15226-1-git-send-email-smriti.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The disconnect function was needed in order to terminate any existing
ATT connection from the client side. 

smriti (1):
  Add provision for terminating an ATT connection

 src/device.c |   14 ++++++++++++++
 src/device.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

