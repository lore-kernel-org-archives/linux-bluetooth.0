Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 0/3] Change the way GATT Plugins are enabled/disabled
Date: Wed, 14 Mar 2012 10:07:10 +0200
Message-Id: <1331712433-27930-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

This patch set is a result of the discussion on the #bluez channel.

Consolidate the --enable_<profile> for gatt profiles into a single
switch, called --enable_gatt.

In addition, modify the AttributeServer propery in the main.conf to
EnableGatt option (default=false) and make sure all GATT plugins query 
this option before trying to load (in the _init function of the 
plugin)

Chen Ganir (3):
  GATT: Remove individual config switches
  GATT: Rename Attribute Server switch
  GATT: Profile support for EnableGatt

 Makefile.am            |   38 ++++++++++----------------------------
 Makefile.tools         |    8 +++++---
 acinclude.m4           |   32 ++++----------------------------
 alert/main.c           |    8 ++++----
 bootstrap-configure    |    6 +-----
 plugins/gatt-example.c |    6 +++---
 proximity/main.c       |   10 +++++++++-
 proximity/reporter.c   |    6 +++---
 src/adapter.c          |    8 ++++----
 src/hcid.h             |    2 +-
 src/main.c             |    4 ++--
 src/main.conf          |    5 ++---
 thermometer/main.c     |   11 +++++++++++
 time/main.c            |    8 ++++----
 14 files changed, 63 insertions(+), 89 deletions(-)

-- 
1.7.4.1

