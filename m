Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v3 0/2] Fix debug messages logging from non-built-in plugins
Date: Thu, 11 Aug 2011 15:10:14 +0200
Message-ID: <1313068216-16802-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Main change is to make stuff 'automatic' in order to minimize linker cruft
in autotools files.

This implementation suffers only one limitation: at least 1 entry must
exist in __debug section in order to link plugin. Possible solution to 
this is to add dummy entry.
But this might be not a big issue as current implementation suffers same
problem: bluetoothd will not link if DBG macro would be empty and it is
very unlikely to have plugin with no debug messages at all.

Comments are welcome.


Szymon Janc (2):
  Add external dummy plugin for testing
  Fix debug messages logging from non-built-in plugins

 Makefile.am              |    7 +++++++
 plugins/external-dummy.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 src/log.c                |   38 +++++++++++++++++++++++++++++++-------
 src/log.h                |    8 ++++++++
 src/plugin.h             |   15 +++++++++++++++
 5 files changed, 103 insertions(+), 7 deletions(-)
 create mode 100644 plugins/external-dummy.c

-- 
on behalf of ST-Ericsson

