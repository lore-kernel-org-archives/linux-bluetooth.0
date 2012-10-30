Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 00/16] mSBC tests
Date: Tue, 30 Oct 2012 10:39:19 +0100
Message-Id: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v4 integrate latest comments from Siarhei:
 - remove state->pending field from sbc_encoder_state
 - add armv6 and iwmmxt primitives
 - use simd primitive instead of neon
 - reorder patches so that the SBC_MSBC flag is exposed to users only when
implementation is complete.

I could only build armv6 code.

Regards,
Frederic


Frédéric Dalleau (16):
  sbc: Add encoder_state to analysis functions
  sbc: Break 4 blocks processing to variable steps
  sbc: Rename sbc_analyze_4b_xx to sbc_analyze_xx
  sbc: add odd member variable to sbc_encoder_state
  sbc: Add mmx primitive for 1b 8s analysis
  sbc: Add armv6 primitive for 1b 8s analysis
  sbc: Add iwmmxt primitive for 1b 8s encoding
  sbc: Add simd primitive for 1b 8s analysis
  sbc: Use simd primitive if doing msbc on neon
  sbc: simd support for 8 multiples block size
  sbc: Add SBC_MSBC flag to enable 15 block encoding
  sbc: Add support for mSBC frame header
  sbc: Update sbcdec for msbc
  sbc: Update sbcenc for msbc
  sbc: Update sbcinfo for msbc
  sbc: Update copyrights

 sbc/sbc.c                   |  277 ++++++++++++++++++++++++++-----------------
 sbc/sbc.h                   |    3 +
 sbc/sbc_primitives.c        |   71 +++++++++--
 sbc/sbc_primitives.h        |   14 ++-
 sbc/sbc_primitives_armv6.c  |   26 +++-
 sbc/sbc_primitives_iwmmxt.c |   28 ++++-
 sbc/sbc_primitives_mmx.c    |   29 ++++-
 sbc/sbc_primitives_neon.c   |   12 +-
 src/sbcdec.c                |   18 ++-
 src/sbcenc.c                |   26 +++-
 src/sbcinfo.c               |   52 +++++---
 11 files changed, 389 insertions(+), 167 deletions(-)

-- 
1.7.9.5

