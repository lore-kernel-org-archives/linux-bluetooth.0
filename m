Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 00/19] Initial RFCOMM support in bthost
Date: Fri, 10 Jan 2014 10:18:10 +0100
Message-Id: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds initial support from rfcomm connection in bthost.
With these patches bthost can accept incoming RFCOMM connections
and create outgoing RFCOMM connections. Also rfcomm-tester is
introduced with few basic test cases. monitor/rfcomm.h is created
for proper handling rfcomm signaling.

Comments are welcome

Marcin Kraglak (19):
  tools/rfcomm-tester: Initial version of rfcomm-tester
  tools/rfcomm-tester: Add basic rfcomm test case
  monitor: Add rfcomm.h to tree
  emulator/bthost: Add initial rfcomm handling
  emulator/bthost: Add method to create rfcomm server
  emulator/bthost: Add recv_sabm imnplementation
  monitor: Add mcc structs and types to rfcomm.h
  emulator/bthost: Add rfcomm_mcc_recv stub
  emulator/bthost: Add recv_pn implementation
  emulator/bthost: Service msc frames
  emulator/bthost: Implement recv_disc rfcomm frame in bthost
  tools/rfcomm-tester: Implement client test case
  tools/rfcomm-tester: Add Connection refused client test case
  emulator/bthost: Implement bthost_connect_rfcomm
  emulator/bthost: Ad implementation of rfcomm_ua_recv
  emulator/bthost: Add implementation to PN RSP
  emulator/bthost: Call rfcomm_connect_cb when connected
  tools/rfcomm-tester: Add RFCOMM server test case
  tools/rfcomm-tester: Add RFCOMM server negative test case

 .gitignore            |   1 +
 Makefile.tools        |  13 +-
 emulator/bthost.c     | 436 +++++++++++++++++++++++++++++++++++++-
 emulator/bthost.h     |  11 +
 monitor/rfcomm.h      |  79 +++++++
 tools/rfcomm-tester.c | 564 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1102 insertions(+), 2 deletions(-)
 create mode 100644 monitor/rfcomm.h
 create mode 100644 tools/rfcomm-tester.c

-- 
1.8.3.1

