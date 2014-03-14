Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <ncopa@alpinelinux.org>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH 0/3] Various build fixes for building bluez with musl libc
Date: Fri, 14 Mar 2014 09:59:24 +0000
Message-Id: <1394791167-29933-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following fixes are needed to make bluez build on Alpine Linuz with
musl libc.

This is kind of a rebase of the previously posted patches:
http://www.spinics.net/lists/linux-bluetooth/msg43070.html

Changes since then are:
- mention Alpine Linux in commit message
- rebase to current git
- added fix for proper header include for be32toh, htobe32 and htobe64

Please note that "unit: prevent unintended use of glibc's error(3)"
fixes a bug in the unit test that affects glibc too. I suppose that if
you add a testcase that triggers any error logging from sdpd-request.c
it will likely segfault instead of gracfully hande the error condition.
(it only affects the unit test though)

Natanael Copa (3):
  shared: include endian.h for be32toh, htobe32 and htobe64 functions
  unit: prevent unintended use of glibc's error(3)
  bnep: avoid use of caddr_t

 Makefile.am             | 1 +
 profiles/network/bnep.c | 4 ++--
 src/shared/btsnoop.c    | 1 +
 unit/test-sdp.c         | 9 +++------
 4 files changed, 7 insertions(+), 8 deletions(-)

-- 
1.9.0

