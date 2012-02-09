Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/7] ATT connection management improvements
Date: Thu,  9 Feb 2012 12:56:02 -0300
Message-Id: <1328802969-20244-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches are cleaning and consolidating ATT connection
management in device.c

Claudio Takahasi (6):
  device: Consolidate ATT connection management
  device: Fix notifying ATTIO drivers when browsing
  attrib-server: Remove GAttrib disconnect callback
  device: Remove GAttrib disconnect callback
  device: Add common ATT connection cleanup function
  GAttrib: Remove unused function

Vinicius Costa Gomes (1):
  device: Fix trying to connect if already connected

 attrib/gattrib.c    |   22 +----
 attrib/gattrib.h    |    3 -
 src/attrib-server.c |   30 ++++--
 src/attrib-server.h |    2 +-
 src/device.c        |  253 ++++++++++++++++++++++++++++-----------------------
 5 files changed, 160 insertions(+), 150 deletions(-)

-- 
1.7.8.4

