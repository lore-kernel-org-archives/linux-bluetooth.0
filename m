Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc: tedd.an@intel.com
Subject: [PATCH 0/3] Add common debug print functions and toggle option
Date: Tue, 22 May 2012 13:13 -0700
Message-ID: <2127339.hDnIl3oBeZ@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong AN <tedd.an@intel.com>

As per comments from the Marcel in my previous submission, he suggested to
have common debug functions that can be toggled with option, so other vendors
and manufacturer can use them for their convenience.

These patches add common debug print functions that displays the debug message
to stderr in uniform format "dbg: xxxx" and specific packet contents. And
these messages are enabled if '-d' is specified.


Tedd Ho-Jeong An (3):
  hciattach: add common debug print functions and toggle option
  hciattach: replace DBGPRINT macro with common debug print functions
  hciattach: add sleep option in the usage

 tools/hciattach.8       |    4 ++++
 tools/hciattach.c       |   36 ++++++++++++++++++++++++++++++++++--
 tools/hciattach.h       |    3 +++
 tools/hciattach_intel.c |   46 ++++++++++++++++------------------------------
 4 files changed, 57 insertions(+), 32 deletions(-)

-- 
1.7.9.5
