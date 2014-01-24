Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 0/2] Print bluetoothd messages in btmon
Date: Fri, 24 Jan 2014 19:41:50 -0200
Message-Id: <1390599712-1609-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

It is very common when debugging issues, specially users' problems to
ask for btmon logs and the accompaining bluetoothd logs. And depending
on the issue, it takes some time to relate the HCI/MGMT commands to
bluetoothd messages that help narrow down the problem.

This is just a proof of concept, to know if this will be generally
helpful. And so, it needs some improvements: sending bluetoothd the USR2
signal so debug is enabled, color support and better formatting.


Cheers,


Vinicius Costa Gomes (2):
  monitor: Add stubs for monitoring bluetoothd's journal entries
  monitor: Add support for printing bluetoothd messages

 Makefile.tools    |   3 +-
 configure.ac      |   7 +++
 monitor/journal.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/journal.h |  24 +++++++++++
 monitor/main.c    |  13 +++++-
 5 files changed, 171 insertions(+), 2 deletions(-)
 create mode 100644 monitor/journal.c
 create mode 100644 monitor/journal.h


--
1.8.5.3
