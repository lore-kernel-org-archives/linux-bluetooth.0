Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/2] Three-wire (H5) support in btproxy
Date: Fri, 27 Nov 2015 16:38:10 +0200
Message-Id: <1448635092-20531-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1448551424-18448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1448551424-18448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* v1: Split code to h5.[ch], remove global vars, add callbacks
	* RFC: Initial code

With H5 support it is possible to create pts and attach to it using
hciattach ot btattach with 3wire protocol. This is useful for testing
and developing three-wire protocol.
Implementation is based on kernel hci_h5.c H5 protocol.

Simple usage:
To open virtual pts run:
$ sudo tools/btproxy -d --pty -3
Opening pseudoterminal
New pts created: /dev/pts/2
Opening user channel for hci0

Now attach to it using hciattach:
$ sudo hciattach -n /dev/pts/2 3wire
Device setup complete

Andrei Emeltchenko (2):
  btproxy: Add support for creating pseudoterminal
  btproxy: Add three-wire (h5) protocol initial support

 Makefile.tools  |   2 +-
 tools/btproxy.c | 111 +++++++++++-
 tools/h5.c      | 553 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/h5.h      |  71 ++++++++
 4 files changed, 730 insertions(+), 7 deletions(-)
 create mode 100644 tools/h5.c
 create mode 100644 tools/h5.h

-- 
2.5.0

