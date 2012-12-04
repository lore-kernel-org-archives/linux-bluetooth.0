Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 0/3] Remove access rights from MediaTransport
Date: Tue,  4 Dec 2012 18:13:47 +0100
Message-Id: <1354641230-3667-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The accessrights used in the Acquire() method are not very useful and can thus be removed. This simplifies both the D-Bus API and the internal implementation significantly.

Mikel Astiz (3):
  media: Remove transport access type from D-Bus API
  media: Remove internal transport locks
  media: Remove transport owner list

 doc/media-api.txt          |  30 ++----
 profiles/audio/transport.c | 238 ++++++++++-----------------------------------
 2 files changed, 59 insertions(+), 209 deletions(-)

-- 
1.7.11.7

