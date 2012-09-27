Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/5] mSBC tests
Date: Thu, 27 Sep 2012 16:44:23 +0200
Message-Id: <1348757068-31048-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi folks,

I wanted to know more about mSBC and I look into the spec and saw it was just
a set of settings for SBC. So I tried to exercise them using sbcenc and sbcdec
and found it wasn't possible, I ended modifying SBC library and now it should
be possible to use mSBC settings.
Using 15 block doesn't work using SIMD processing because of data
reordering so I recalled some legacy C code from an older release
(sbc_analyse_eight) and put in a separate primitives file.

Work done from the spec, not tested with any reference encoder.

How to use:
sample.au should be an .au audio file 16000hz 16bits 1 channel pcm.
$ src/sbcenc  -m -b26 -B16 -s8   sample.au > sample.au.msbc
$ src/sbcinfo sample.au.msbc
$ src/sbcdec  -m -f sample.au.msbc.au sample.au.msbc
$ mplayer sample.au.msbc.au

Note sure there is any application yet but I thought I should share.

Regards,
Frederic


Frédéric Dalleau (5):
  Add msbc encoding and decoding flag
  Add support for mSBC frame header
  update sbcdec for msbc
  update sbcenc for msbc
  update sbcinfo for msbc

 Makefile.am               |    1 +
 sbc/sbc.c                 |  227 +++++++++++++++++++-------------
 sbc/sbc.h                 |    3 +
 sbc/sbc_primitives.c      |    8 +-
 sbc/sbc_primitives.h      |    7 +-
 sbc/sbc_primitives_stdc.c |  321 +++++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives_stdc.h |   36 +++++
 src/sbcdec.c              |   17 ++-
 src/sbcenc.c              |   25 +++-
 src/sbcinfo.c             |   51 ++++---
 10 files changed, 574 insertions(+), 122 deletions(-)
 create mode 100644 sbc/sbc_primitives_stdc.c
 create mode 100644 sbc/sbc_primitives_stdc.h

-- 
1.7.9.5

