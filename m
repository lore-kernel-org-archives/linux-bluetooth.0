Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 0/2] Fix debug messages logging from non-built-in plugins
Date: Wed, 3 Aug 2011 17:30:50 +0200
Message-ID: <1312385452-9770-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

This is a second version, much simpler. Uses dlsym() to locate __debug
section both in external plugin and main binary. Thanks to this we have
common path for all debug messages.

Also added dummy external plugin for test purposes.

Some comments about it:
__start___debug and __stop___debug symbols must be produced explicite
with -usymbol linker flag (see [1]) if not referenced in code directly.


Comments welcome.

[1] http://lists.gnu.org/archive/html/bug-binutils/2007-11/msg00088.html

Szymon Janc (2):
  Fix debug messages logging from non-built-in plugins
  Add external dummy plugin for testing

 Makefile.am              |   12 ++++++++++-
 acinclude.m4             |    6 +++++
 plugins/external-dummy.c |   42 +++++++++++++++++++++++++++++++++++++++
 src/bluetooth.ver        |    2 +
 src/log.c                |   49 ++++++++++++++++++++++++++++++++++++---------
 src/log.h                |    2 +
 src/plugin.c             |    8 +++++-
 7 files changed, 108 insertions(+), 13 deletions(-)
 create mode 100644 plugins/external-dummy.c

-- 
on behalf of ST-Ericsson

