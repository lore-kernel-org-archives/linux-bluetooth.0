Return-Path: <cyrus@holtmann.org>
From: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/1] avrcp: Add support for multiple players on the CT side
Date: Tue, 26 Feb 2013 18:11:07 +0100
Message-Id: <1361898668-16959-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for multiple player support. This is only the controller
functionality for targets with AVRCP 1.4+. Until the target side is implemented
avrcp needs two methods for destroyed the created players as the CT side handles
them in a hash table and for now the TG side understands only one.

Alexandros Antonopoulos (1):
  avrcp: Add support for multiple players on the CT side

 profiles/audio/avrcp.c  | 267 +++++++++++++++++++++++++++++++++++++-----------
 profiles/audio/avrcp.h  |   2 +
 profiles/audio/player.c |   5 +-
 profiles/audio/player.h |   3 +-
 4 files changed, 213 insertions(+), 64 deletions(-)

-- 
1.8.1.4

