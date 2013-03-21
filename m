Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH 00/13] Improvements on gatttool interactive interface
Date: Thu, 21 Mar 2013 18:31:36 -0400
Message-Id: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series implements some changes on gatttool in order to keep it
consistent with bluetoothctl approach, like colored prompt and not
breaking empty line upon pressing enter. In addition, some fixes were
made when displaying messages.

BR,
Alvaro Silva

Alvaro Silva (3):
  gatttool: Show connection state using color
  gatttool: Remove connecting message from prompt
  gatttool: Use error message prefixes consistently

Eder Ruiz Maria (9):
  gatttool: Remove programming error check
  gatttool: Remote address is mandatory for non-interactive gatttool
  gatttool: Use GError to propage error messages to caller
  gatttool: Fix issues with printf() and readline prompt
  gatttool: Replace more usages of printf() with rl_printf()
  gatttool: Use bluetoothctl behavior when pressing Enter on empty
    prompt
  gatttool: Use bluetoothctl strategy to handle standard input
  gatttool: Use bluetoothctl strategy for unix signal handling
  gatttool: Show info message when no primary service is found

Jefferson Delfes (1):
  gatttool: Fix memory leak after parsing input line

 Makefile.tools       |    3 +-
 attrib/gatttool.c    |   12 +-
 attrib/gatttool.h    |    3 +-
 attrib/interactive.c |  345 +++++++++++++++++++++++++++++++++-----------------
 attrib/utils.c       |   19 +--
 client/display.h     |    1 +
 6 files changed, 250 insertions(+), 133 deletions(-)

-- 
1.7.9.5

