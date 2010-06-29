Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: [PATCH 0/3] SBC encoder optimizations (scale factors)
Date: Tue, 29 Jun 2010 16:48:44 +0300
Message-Id: <1277819327-28592-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some patches for making SBC encoding up to 10% faster on ARM and x86.

Also available in git://gitorious.org/system-performance/bluez-sbc.git
branch 'sbc-fast-scalefactors-for-master'

Siarhei Siamashka (3):
  sbc: new 'sbc_calc_scalefactors_j' function added to sbc primitives
  sbc: MMX optimization for scale factors calculation
  sbc: ARM NEON optimization for scale factors calculation

 sbc/sbc.c                 |   94 ++++++++++++---------------------------------
 sbc/sbc_primitives.c      |   75 ++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives.h      |    4 ++
 sbc/sbc_primitives_mmx.c  |   54 ++++++++++++++++++++++++++
 sbc/sbc_primitives_neon.c |   58 +++++++++++++++++++++++++++
 5 files changed, 216 insertions(+), 69 deletions(-)

