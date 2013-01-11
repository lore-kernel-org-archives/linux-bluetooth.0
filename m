Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Christian Fetzer <christian.fetzer@bmw-carit.de>
Subject: [PATCH 0/8] Obexd / MAP-client bug fixes
Date: Fri, 11 Jan 2013 16:55:49 +0100
Message-Id: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This patch set fixes a couple of small issues in the MAP-client implementation
and in the generic obexd client code.

Christian Fetzer (8):
  obexd: Handle empty path name in SetPath
  obexd: Add property exist functions to map client
  obexd: Fix infinite loop in ListMessages with filter "Types"
  obexd: Fix FILTER_ALL in MAP client to set 16 bit
  obexd: Fix segfault in parse_filter_read and parse_filter_priority
  obexd: Use defines for values in parse_filter_read parse_filter_priority
  obexd: Change behavior of parse_filter_read
  obexd: Remove transferred file only if the GET operation failed

 obexd/client/map.c      | 108 +++++++++++++++++++++++++++++++++++++++++-------
 obexd/client/session.c  |   2 +-
 obexd/client/transfer.c |   3 +-
 3 files changed, 96 insertions(+), 17 deletions(-)

-- 
1.8.1

