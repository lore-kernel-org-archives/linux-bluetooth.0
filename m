Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v2 0/3] Issue with incoming connections
Date: Tue,  7 May 2013 18:58:12 +0200
Message-Id: <1367945895-18926-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

v2 fixes the error message in patch 3/3 as pointed out by Vinicius. The rest remains unchanged.

>From original cover-letter:

Vinicius reported this issue and tried to fix it in his patch "profile: Create a service for incomming connections".

As compared to his original patch, this patchset avoid creating an additional service instance (which should already be created) and instead performs a search within the list of existing services for the given device.

Mikel Astiz (3):
  device: Add function to find a given service
  profile: Fix remotely initiated connections without service
  profile: Error-cases for incoming connections

 src/device.c  | 16 ++++++++++++++++
 src/device.h  |  3 +++
 src/profile.c | 29 ++++++++++++++++++++++++-----
 3 files changed, 43 insertions(+), 5 deletions(-)

-- 
1.8.1.4

