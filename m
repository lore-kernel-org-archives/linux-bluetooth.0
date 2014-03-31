Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 0/3] Add basic GATT descriptors
Date: Mon, 31 Mar 2014 09:13:12 -0300
Message-Id: <1396267995-17271-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remaining patches of "[PATCH BlueZ v0 0/5] Add basic GATT descriptors"

This patchset adds the basic support for GATT descriptors (local GATT
services) implemented according to doc/gatt-api.txt

"UUID", and "Value" properties are implemented by this patchset.
"Characteristic" (parent) is still pending. "Permissions" support is
not defined yet.

Changes v0-v1:
  * Fixed memory leak of descriptor's object path

Claudio Takahasi (3):
  tools: Add testing descriptor for IAS Alert Level
  tools: Add Get/Set descriptor
  tools: Add emitting descriptor PropertiesChanged

 tools/gatt-service.c | 128 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 114 insertions(+), 14 deletions(-)

-- 
1.8.3.1

