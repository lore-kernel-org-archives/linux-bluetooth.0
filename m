Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 0/8] Improve user experience
Date: Fri, 8 Nov 2013 13:48:22 +0100
Message-ID: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset works towards improving user interface.
- Command line parsing (--help, --version, --no-init)
- All interfaces are now initialized at start by default
- --no-init allows to disable this initialization
- pin_request_cb will now present prompt and send reply
- ssp_request_cb will now present prompt and sent reply

As part of adding those features terminal.c was restructured.
Big switch inside terminal_process_char was distributed between
number of small functions. This work was necessary due to input
handling of prompted data.

Version print may need to be changed according to bluez culture. 

Jerzy Kasenberg (8):
  android/client: Export get_interface_method
  android/client: Add NELEM macro for count elements
  android/client: Initialize all interfaces at start
  android/client: Add command line arguments
  android/client: Split terminal_process_char
  android/client: Add prompting for answer
  android/client: Add pin handling for bind
  android/client: Add ssp key confirmation helper

 android/client/haltest.c       |  102 ++++++-
 android/client/if-bt.c         |   46 +++
 android/client/if-main.h       |    4 +
 android/client/tabcompletion.c |    2 +-
 android/client/terminal.c      |  605 +++++++++++++++++++++++++++-------------
 android/client/terminal.h      |    5 +-
 6 files changed, 567 insertions(+), 197 deletions(-)

-- 
1.7.9.5

