Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 0/2] Style, typo and naming fixes
Date: Tue, 5 Nov 2013 10:56:20 +0100
Message-ID: <1383645382-3372-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset fixes obvious spelling errors.
It also changes adapter to bluetooth in help and comments.
Few white space errors also were fixed.

Jerzy Kasenberg (2):
  android/client: Fix style and typos
  android/client: Change adapter to bluetooth

 android/client/haltest.c       |    6 +++---
 android/client/history.c       |    3 +++
 android/client/if-main.h       |    2 +-
 android/client/tabcompletion.c |   21 +++++++++++++--------
 android/client/terminal.c      |   26 ++++++++++++++------------
 5 files changed, 34 insertions(+), 24 deletions(-)

-- 
1.7.9.5

