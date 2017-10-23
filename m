Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ 0/8] Add argument texts to help command
Message-ID: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Date: Mon, 23 Oct 2017 17:05:23 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case first running a command on btmgmt, users may need to fail running
a command or run a command with the option --help since the command help
does not display whether or not any argument is needed.

These patches include to add argument texts to output of the command help.

ERAMOTO Masaya (8):
  tools/btmgmt: Fix inconsistency of usages and options
  tools/btmgmt: Fix segfault in interactive mode
  tools/btmgmt: Fix segfault with remote-oob --help
  tools/btmgmt: Add argument texts to help command
  tools/btmgmt: Replace with common usage function
  tools/btmgmt: Refactor for functions to parse setting
  tools/btmgmt: Change help message of some commands to usage
  tools/btmgmt: Use cmd_usage() for select command

 tools/btmgmt.c | 524 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 278 insertions(+), 246 deletions(-)

-- 
2.7.4

