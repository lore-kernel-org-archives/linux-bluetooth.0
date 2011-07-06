Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 00/12] On demand connection management
Date: Wed,  6 Jul 2011 18:22:40 -0300
Message-Id: <1309987360-9821-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches implement a mechanism to allow GATT based profiles
to request on demand connections. The ideia is to control connections based
on registered "connection" callbacks.

This patch series replaces partially the initial proposal "[RFC] Attribute
IO Driver". GATT based profiles can use "device" driver, we will extend later
if necessary or create a new "driver" to addresss LSTO, connection intervals
and other connection requirements for GATT based profiles.

No changes from the RFC.

Links for curious developers:
[1] git://git.infradead.org/users/cktakahasi/bluez.git generic-api (using on demand connection)
[2] git://git.infradead.org/users/cktakahasi/bluez.git proximity-devel (under development)

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

