Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 00/11] mSBC tests
Date: Thu, 18 Oct 2012 18:15:00 +0200
Message-Id: <1350576911-14678-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi folks,

For version 2, I figured out what the SIMD code is doing and managed to make it
work using 15 blocks. Marcel's comments were taken into account.
The accuracy may not be perfect, but the result is hearable. So good time to post.

How to use:
sample.au should be an .au audio file 16000hz 16bits 1 channel pcm.
$ src/sbcenc  -m -b26 -B16 -s8   sample.au > sample.au.msbc
$ src/sbcinfo sample.au.msbc
$ src/sbcdec  -m -f sample.au.msbc.au sample.au.msbc
$ mplayer sample.au.msbc.au

Regards,
Frederic


Frédéric Dalleau (11):
  Pass encoder_state to process input functions
  Add encoder_state parameter to analysis functions
  Make increment variable
  Add msbc encoding and decoding flag
  Add simd primitive for 1b 8s analyse
  Add support for mSBC frame header
  Add mmx primitive for 1b 8s analyse
  update sbcdec for msbc
  update sbcenc for msbc
  update sbcinfo for msbc
  Update copyrights

 sbc/sbc.c                   |  275 +++++++++++++++++++++++++++----------------
 sbc/sbc.h                   |    3 +
 sbc/sbc_primitives.c        |  102 +++++++++++++---
 sbc/sbc_primitives.h        |   22 ++--
 sbc/sbc_primitives_armv6.c  |    6 +-
 sbc/sbc_primitives_iwmmxt.c |    8 +-
 sbc/sbc_primitives_mmx.c    |   24 +++-
 sbc/sbc_primitives_neon.c   |   40 +++----
 src/sbcdec.c                |   18 ++-
 src/sbcenc.c                |   26 +++-
 src/sbcinfo.c               |   52 +++++---
 11 files changed, 391 insertions(+), 185 deletions(-)

-- 
1.7.9.5

