Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/4] Move common client code to bt_shell
Date: Fri, 22 Sep 2017 00:59:58 -0400
Message-Id: <20170922050002.24002-1-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is first part of moving common code of client and meshctl to shared
directory. Next steps would be:
 - functions for switching between menus (needed for meshctl)
 - display functions
 - common support for history


Marcin Kraglak (4):
  shared/bt_shell: Add initial implementation
  client: Use bt_shell to process commands.
  shared/bt_shell: Add bt_shell_completion
  client: Use bt_shell_completion

 Makefile.tools        |   3 +-
 client/main.c         |  93 +++---------------------------
 src/shared/bt_shell.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bt_shell.h |  43 ++++++++++++++
 4 files changed, 204 insertions(+), 87 deletions(-)
 create mode 100644 src/shared/bt_shell.c
 create mode 100644 src/shared/bt_shell.h

-- 
2.13.5

