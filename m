Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv2 0/4] Add support for bonding callbacks and retrying
Date: Tue, 24 Jan 2012 10:47:54 -0800
Message-Id: <1327430878-23913-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the comments on the autopair plugin patches, I'm still
working on updating that but I wanted to submit the underlying core
changes necessary while I do so.

This adds plugin support for a callback called when bonding completes,
either successfully or fails, or is cancelled. In the success or failure
cases the callback may return TRUE, in which case the bonding is retried
after a short backoff period.

The (to be submitted) autopair plugin will use this to retry bonding if
a fixed PIN it provides fails, and ignore the subsequent attempt so that
the ordinary PIN handling (user agent, keyboard auto-generation, etc.)
happens.

The existing wiimote plugin could use this to try both of the possible
PINs (host address and peer address), etc.

Scott James Remnant (4):
  Add support for retrying a bonding
  plugin: Add bonding callback support for plugins
  bonding: retry if callback returns TRUE
  bonding: call plugin callback on cancellation

 src/adapter.c |    2 +-
 src/device.c  |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h  |    9 ++++++
 3 files changed, 97 insertions(+), 1 deletions(-)

-- 
1.7.7.3

