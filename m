Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v5 0/4] Optional acquire in Media API and related
Date: Fri, 14 Sep 2012 14:55:56 +0200
Message-Id: <1347627360-13997-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Same as v4 but rebased on the latest pushed patches.

>From original patch:

This patch reopens the discussion started by the thread "when is acquire
ok to call". The race condition seems to be real (even thought difficult
to reproduce), and I couldn't think of any approach to solve this
without altering the Media API.

Mikel Astiz (4):
  media: Split transport state based on playing flag
  media: Expose transport state in D-Bus
  media: Automatically release transport when HUP
  media: Extend media API with optional acquire

 audio/transport.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++-----
 doc/media-api.txt |   19 +++++++++
 2 files changed, 121 insertions(+), 11 deletions(-)

-- 
1.7.7.6

