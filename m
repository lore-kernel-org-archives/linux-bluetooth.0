Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 0/7] Manager/Adapter transition to ObjectManager
Date: Thu,  8 Nov 2012 15:30:08 +0100
Message-Id: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

(This is sent as RFC since I haven't done proper testing, and furthermore the test scripts haven't been updated)

While thinking about how profile and their states should be exposed in D-Bus (see previous RFC), I found several potential improvements in the current version of the Manager and Adapter APIs.

Basically, this patchset removes some properties and methods that seem duplicated.

There are other similar methods/properties that could be simplified as well, but for practical reasons I started with the most obvious ones.

Mikel Astiz (7):
  manager: Expose default adapter using property
  manager: Remove redundant D-Bus signals
  manager: Remove redundant Adapters property
  adapter: Remove redundant D-Bus signals
  adapter: Remove DevicesFound signal
  adapter: Remove redundant Devices property
  adapter: Remove FindDevice method from D-Bus API

 doc/adapter-api.txt |  32 +--------
 doc/manager-api.txt |  28 +-------
 src/adapter.c       | 187 +---------------------------------------------------
 src/manager.c       | 103 +++++++----------------------
 4 files changed, 29 insertions(+), 321 deletions(-)

-- 
1.7.11.7

