Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v7 00/16] mSBC investigations
Date: Thu, 28 Mar 2013 11:18:47 +0100
Message-Id: <1364465943-959-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v7 features bool instead of int for odd state. uint8_t instead of int for
increment. Little refactoring of sbcinfo and copyrights update for 2013. No
longer bumps version number.

v6 implements sbc_init_msbc(). The SBC_MSBC flag is removed from sbc.h and
replace by an internal flag in sbc_priv structure.
The decoder has been validated to mSBC packets sent by an iPhone.
The encoder couldn't be validated, but at least we know that libsbc encoded
packets can be decoded by libsbc.
I bumped version number to 1.1 to help compile time detection.

v5 shoudl fix the few remaining issues.  I could test neon and armv6
and raised verbosity of commit messages.

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
  sbc: Add plain C primitive for 1b 8s analysis
  sbc: Use plain C primitive if doing msbc on neon
  sbc: Fix input reordering for 15 blocks case
  sbc: Add a private boolean flag to enable 15 block encoding
  sbc: Declare and implement sbc_init_msbc
  sbc: Add support for mSBC frame header
  sbc: Update sbcdec for msbc
  sbc: Update sbcenc for msbc
  sbc: Update sbcinfo for msbc

 sbc/sbc.c                   |  321 ++++++++++++++++++++++++++++---------------
 sbc/sbc.h                   |    1 +
 sbc/sbc.sym                 |    1 +
 sbc/sbc_primitives.c        |   98 ++++++++++++-
 sbc/sbc_primitives.h        |   13 +-
 sbc/sbc_primitives_armv6.c  |   27 +++-
 sbc/sbc_primitives_iwmmxt.c |   29 +++-
 sbc/sbc_primitives_mmx.c    |   29 +++-
 sbc/sbc_primitives_neon.c   |   13 +-
 src/sbcdec.c                |   23 +++-
 src/sbcenc.c                |  107 +++++++++------
 src/sbcinfo.c               |   54 ++++++--
 12 files changed, 511 insertions(+), 205 deletions(-)

-- 
1.7.9.5

