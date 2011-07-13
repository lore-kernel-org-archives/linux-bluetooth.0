Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/3] Initial Proximity Monitor implementation
Date: Wed, 13 Jul 2011 09:37:54 -0300
Message-Id: <1310560677-2773-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches don't require the previously submitted patches.

Adds the plugin and device driver for Proximity Monitor. Service is not
functional yet.

Claudio Takahasi (3):
  Add Proximity Profile plugin skeleton
  Add Proximity Monitor skeleton
  Add Link Loss device driver skeleton

 Makefile.am         |    7 ++++
 acinclude.m4        |    6 ++++
 bootstrap-configure |    1 +
 proximity/main.c    |   60 ++++++++++++++++++++++++++++++++++++
 proximity/manager.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 proximity/manager.h |   26 ++++++++++++++++
 proximity/monitor.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 proximity/monitor.h |   26 ++++++++++++++++
 8 files changed, 294 insertions(+), 0 deletions(-)
 create mode 100644 proximity/main.c
 create mode 100644 proximity/manager.c
 create mode 100644 proximity/manager.h
 create mode 100644 proximity/monitor.c
 create mode 100644 proximity/monitor.h

-- 
1.7.6

