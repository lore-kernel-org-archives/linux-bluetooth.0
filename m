Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 0/3] Add basic commands to haltest
Date: Mon, 21 Oct 2013 16:02:13 +0200
Message-ID: <1382364136-13665-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

- Adds handling of Ctrl-c Ctrl-d as requested
- Prompted changed to includ space
- Added commands: quit exit help
- Added completion for help
- Terminal settings restored on exit

Jerzy Kasenberg (3):
  android: Add space in prompt in haltest
  android: Add handling of Ctrl-c to haltest
  android: Add help and quit to haltest

 android/client/haltest.c       |  151 ++++++++++++++++++++++++++++++++++------
 android/client/if-main.h       |    6 ++
 android/client/tabcompletion.c |  151 ++++++++++++++++++++++++++++------------
 android/client/terminal.c      |  100 ++++++++++++++++++--------
 4 files changed, 312 insertions(+), 96 deletions(-)

-- 
1.7.9.5

