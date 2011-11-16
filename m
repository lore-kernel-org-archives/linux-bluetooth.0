Return-Path: <cyrus@holtmann.org>
Message-ID: <4EC3B36C.60105@bmw-carit.de>
Date: Wed, 16 Nov 2011 13:58:20 +0100
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <Mikel.Astiz@bmw-carit.de>
Subject: [PATCH 0/3] A2DP sources with Media API
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches have been useful to make PulseAudio work using
the media API.

Mikel Astiz (3):
   media: release transport locks on acquisition failure
   media: sep registration fix
   a2dp: avoid conversion between guint and pointers

  audio/a2dp.c      |   65 
++++++++++++++++++++++++++++++++++++++++++++++++-----
  audio/media.c     |    2 +-
  audio/transport.c |    1 +
  3 files changed, 61 insertions(+), 7 deletions(-)

-- 
1.7.6.4

