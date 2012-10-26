Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 00/10] mSBC tests
Date: Fri, 26 Oct 2012 19:20:26 +0200
Message-Id: <1351272036-4875-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v3 integrate latest comments from Marcel, hope it is fine now!

How to use:
sample.au should be an .au audio file 16000hz 16bits 1 channel pcm.
$ src/sbcenc  -m -b26 -B16 -s8   sample.au > sample.au.msbc
$ src/sbcinfo sample.au.msbc
$ src/sbcdec  -m -f sample.au.msbc.au sample.au.msbc
$ mplayer sample.au.msbc.au

Regards,
Frederic


Frédéric Dalleau (10):
  sbc: Add encoder_state to process input functions
  sbc: Add encoder_state to analysis functions
  sbc: Break 4 blocks processing to variable steps
  sbc: Add msbc flag and generic C primitive
  sbc: Add support for mSBC frame header
  sbc: Add mmx primitive for 1b 8s analyse
  sbc: Update sbcdec for msbc
  sbc: Update sbcenc for msbc
  sbc: Update sbcinfo for msbc
  sbc: Update copyrights

 sbc/sbc.c                   |  275 ++++++++++++++++++++++++++-----------------
 sbc/sbc.h                   |    3 +
 sbc/sbc_primitives.c        |  105 +++++++++++++----
 sbc/sbc_primitives.h        |   23 ++--
 sbc/sbc_primitives_armv6.c  |    6 +-
 sbc/sbc_primitives_iwmmxt.c |    8 +-
 sbc/sbc_primitives_mmx.c    |   27 ++++-
 sbc/sbc_primitives_neon.c   |   40 +++----
 src/sbcdec.c                |   18 ++-
 src/sbcenc.c                |   26 +++-
 src/sbcinfo.c               |   52 +++++---
 11 files changed, 392 insertions(+), 191 deletions(-)

-- 
1.7.9.5

