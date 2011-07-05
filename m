Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 00/12] On demand connection management
Date: Tue,  5 Jul 2011 10:55:56 -0300
Message-Id: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches implement a mechanism to allow GATT based profiles
to request on demand connections. The ideia is to control connections based
on registered "connection" callbacks.

This patch series replaces partially the initial proposal "[RFC] Attribute
IO Driver". GATT based profiles can use "device" driver, we will extend later
if necessary or create a new "driver" to addresss LSTO, connection intervals
and other connection requirements for GATT based profiles.

Next step is to fix Generic Attribute API and Proximity to use this new
approach.

Claudio Takahasi (12):
  Add ATT connection callback registration
  Add a function to remove ATT connection callback
  Fix crash when create device is cancelled
  Notify the GAttrib instance if already connected
  Add ATT disconnect callback
  Add auto connection based on registered callbacks
  Enable ATT re-connection
  Drop GAttrib ref if callback list is empty
  Try to connect when registering the first callback
  Manage GAttrib refs based on registered callbacks
  Postpone calling connected callback
  Address remote initiated disconnection

 Makefile.am  |    2 +-
 src/attio.h  |   33 +++++++
 src/device.c |  265 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 276 insertions(+), 24 deletions(-)
 create mode 100644 src/attio.h

-- 
1.7.6

