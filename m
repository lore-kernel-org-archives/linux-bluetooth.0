Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/22] Bluetooth AT chat module
Date: Mon, 14 Oct 2013 10:34:16 +0200
Message-Id: <1381739678-16260-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This serie of patches introduces AT chat module which is meant to be
used by the Handsfree Profile for receiving and sending AT commands and
results. As of now it is only used by unit tests.

Patches contain:
  *circular buffer implementation
  *unit tests for the circular buffer
  *AT chat module skeleton
  *basic AT commands parser
  *unit tests for the AT command parser

Jakub Tyszkowski (22):
  cbuffer: Circular buffer initial implementation
  unit: Add basic tests for the circular buffer implementation
  cbuffer: Add direct access to buffer's memory
  unit: Add test case for cbuffer's manual mode
  cbuffer: Add methods for browsing through data
  unit: Add test cases for cbuffer memory acess routines
  cbuffer: Add seek and check routines
  unit: Add test cases for cbuffer seek, check, get_length
  blueatchat: Add bluetooth at chat module skeleton
  blueatchat: Use circullar buffer as data storage
  cbuffer: Add discard method
  unit: Add test case for cbuffer's discard
  blueatchat: Buffered data sanity check
  blueatchat: Add basic parsing capability
  blueatchat: Add functions for parsing data sent with the commands
  unit: Add basic unit test for the blueatchat module
  unit: Add more test cases for the at parser
  blueatchat: Add more data parsing functionality
  blueatchat: Extend API for sending AT commands
  unit: Circular buffer overflow test
  gitignore: Add curcular buffer unit tests
  gitignore: Add blueatchat unit tests

 .gitignore              |    2 +
 Makefile.am             |   15 +
 src/shared/blueatchat.c |  503 ++++++++++++++++++++++++++
 src/shared/blueatchat.h |   82 +++++
 src/shared/cbuffer.c    |  239 +++++++++++++
 src/shared/cbuffer.h    |   49 +++
 src/shared/dparser.c    |   84 +++++
 src/shared/dparser.h    |   26 ++
 unit/test-blueatchat.c  |  901 +++++++++++++++++++++++++++++++++++++++++++++++
 unit/test-cbuffer.c     |  550 +++++++++++++++++++++++++++++
 10 files changed, 2451 insertions(+)
 create mode 100644 src/shared/blueatchat.c
 create mode 100644 src/shared/blueatchat.h
 create mode 100644 src/shared/cbuffer.c
 create mode 100644 src/shared/cbuffer.h
 create mode 100644 src/shared/dparser.c
 create mode 100644 src/shared/dparser.h
 create mode 100644 unit/test-blueatchat.c
 create mode 100644 unit/test-cbuffer.c

--
1.7.9.5

