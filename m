Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v1 0/3] Issue with incoming connections
Date: Tue,  7 May 2013 09:44:01 +0200
Message-Id: <1367912644-17401-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Vinicius reported this issue and tried to fix it in his patch "profile: Create a service for incomming connections".

As compared to his original patch, this patchset avoid creating an additional service instance (which should already be created) and instead performs a search within the list of existing services for the given device.

Patch 2/3 is the actual fix which makes use of patch 1/1.

Patch 3/3 is an attempt to make the code more robust, but I'm not 100% sure if there are cases where the device can be set to NULL as handled in the upstream create_conn() body as first introduced in 86842030039583d092a1d3ce5004e7bc5b7d2b01.

Mikel Astiz (3):
  device: Add function to find a given service
  profile: Fix remotely initiated connections without service
  profile: Error-cases for incoming connections

 src/device.c  | 16 ++++++++++++++++
 src/device.h  |  3 +++
 src/profile.c | 26 +++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

-- 
1.8.1.4

