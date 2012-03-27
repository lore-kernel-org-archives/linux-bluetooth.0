Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 0/8] Generic GATT client fixes
Date: Tue, 27 Mar 2012 16:43:41 -0400
Message-Id: <1332881029-1732-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These patches contain fixes (and two refactorings) found during our latest
round of tests.

Change since v1: rebased against latest upstream.



Anderson Lizardo (1):
  attrib: Attempt to remove attio callback on watcher exit

Claudio Takahasi (7):
  attrib: Centralize ATTIO connection management
  attrib: Discover Characteristics if already connected
  attrib: Move Characteristic Discovery reply to a new function
  attrib: Register only new characteristics found
  attrib: Fix missing Discovery reply when disconnected
  attrib: Fix missing D-Bus message unref on DiscoverCharacteristics
  gattrib: Protect GAttrib when there is a pending write

 attrib/client.c  |  152 +++++++++++++++++++++++++++++++++---------------------
 attrib/gattrib.c |   12 +++--
 2 files changed, 101 insertions(+), 63 deletions(-)

-- 
1.7.5.4

