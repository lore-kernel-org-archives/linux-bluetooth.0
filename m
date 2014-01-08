Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 0/7] sixaxis: Don't mark USB plugged device as trusted
Date: Wed,  8 Jan 2014 01:02:21 +0100
Message-Id: <1389139348-3552-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This serie removes marking USB plugged sixaxis DS3 devices as trusted.
Now agent is asked for service authorization before device is connected
over BT. This is to address conserns about possibly crafted USB devices.

This is implemented in PATCH 1. Rest are fixes for bugs that were uncovered
due this change and client functionality that I've found missing while
testing this.

Comments and testing are welcome.

-- 
BR
Szymon Janc


Szymon Janc (7):
  sixaxis: Don't mark USB plugged device as trusted
  input: Fix crash on authorization reply with first sixaxis connection
  input: Fix check if device is sixaxis in auth_callback
  input: Fix connecting new trusted sixaxis device
  client: Add untrust command
  client: Add block command
  client: Add unblock command

 client/main.c           | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/sixaxis.c       |  1 -
 profiles/input/server.c | 37 ++++----------------
 3 files changed, 99 insertions(+), 32 deletions(-)

-- 
1.8.5.2

