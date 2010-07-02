Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 0/5] SBC encoder optimizations for ARM processors
Date: Fri,  2 Jul 2010 15:25:37 +0300
Message-Id: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

This patch series adds a bunch of ARM assembly optimizations.

Now all the functions from 'sbc_primitives.c' got NEON optimized
variants. As benchmarked with the common A2DP case (44100kHz audio
with bitpool set to 53, 8 subbands, joint stereo), SBC encoding is
now approximately 1.6x faster overall when compared to bluez-4.66.
Some more room for improvement still exists though.

For ARMv6 processors, only analysis filter has been implemented
(using dual 16-bit multiply-accumulate instructions). But that's
the most important optimization and it doubles performance already.
And older processors such as ARM11 are much slower, so they
definitely benefit more on a relative scale (Nokia N800/N810 users
may find this update useful).

All the optimizations are bitexact. Given the same input, they provide
the same output as the SBC encoder from the previous bluez versions.

Patches are also available in the branch 'sbc-arm-optimizations' here:
git://gitorious.org/system-performance/bluez-sbc.git

Siarhei Siamashka (5):
  sbc: ARM NEON optimized joint stereo processing in SBC encoder
  sbc: ARM NEON optimizations for input permutation in SBC encoder
  sbc: slightly faster 'sbc_calc_scalefactors_neon'
  sbc: faster 'sbc_calculate_bits' function
  sbc: ARMv6 optimized version of analysis filter for SBC encoder

 Makefile.am                |    3 +-
 sbc/sbc.c                  |   43 ++-
 sbc/sbc_primitives.c       |    4 +
 sbc/sbc_primitives_armv6.c |  299 +++++++++++++++++++++
 sbc/sbc_primitives_armv6.h |   52 ++++
 sbc/sbc_primitives_neon.c  |  618 ++++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 988 insertions(+), 31 deletions(-)
 create mode 100644 sbc/sbc_primitives_armv6.c
 create mode 100644 sbc/sbc_primitives_armv6.h

