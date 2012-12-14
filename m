Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v5 00/16] mSBC tests
Date: Fri, 14 Dec 2012 16:03:21 +0100
Message-Id: <1355497417-10357-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v5 shoudl fix the few remaining issues.  I could test neon and armv6
and raised verbosity of commit messages.

However, before releasing a new version of the library, I believe we should
write some sort of automated testing and test against another implementation.
Siarhei shared a script some time ago, it could be a good start.
But where could we store some decent audio materials? Should we use generators
like sine wave, or just record ambient sound??

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
  sbc: Add SBC_MSBC flag to enable 15 block encoding
  sbc: Add support for mSBC frame header
  sbc: Update sbcdec for msbc
  sbc: Update sbcenc for msbc
  sbc: Update sbcinfo for msbc
  sbc: Update copyrights

 sbc/sbc.c                   |  289 +++++++++++++++++++++++++++----------------
 sbc/sbc.h                   |    3 +
 sbc/sbc_primitives.c        |   97 +++++++++++++--
 sbc/sbc_primitives.h        |   14 ++-
 sbc/sbc_primitives_armv6.c  |   26 +++-
 sbc/sbc_primitives_iwmmxt.c |   28 ++++-
 sbc/sbc_primitives_mmx.c    |   29 ++++-
 sbc/sbc_primitives_neon.c   |   12 +-
 src/sbcdec.c                |   18 ++-
 src/sbcenc.c                |   26 +++-
 src/sbcinfo.c               |   52 +++++---
 11 files changed, 427 insertions(+), 167 deletions(-)

-- 
1.7.9.5

