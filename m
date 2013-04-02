Return-Path: <cyrus@holtmann.org>
From: Alvaro Silva <alvaro.silva@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v2 00/13] Improvements on gatttool interactive interface
Date: Tue,  2 Apr 2013 19:31:17 -0400
Message-Id: <1364945490-17059-1-git-send-email-alvaro.silva@openbossa.org>
In-Reply-To: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
References: <1363905109-30839-1-git-send-email-alvaro.silva@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is the second version of the patches with improvements to
gatttool interactive interface.

As suggested, we rewrote the commit message for patch #03. We also
reordered the patches #02 and #03, so the check for destination
address is removed only after the appropriate check is added to
gatttool.c.

BR,
Alvaro Silva

Alvaro Silva (3):
  gatttool: Show connection state using color
  gatttool: Remove connecting message from prompt
  gatttool: Use error message prefixes consistently

Eder Ruiz Maria (9):
  gatttool: Remote address is mandatory for non-interactive gatttool
  gatttool: Remove check for bluetooth address parameter on
    gatt_connect()
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
 5 files changed, 249 insertions(+), 133 deletions(-)

-- 
1.7.9.5

