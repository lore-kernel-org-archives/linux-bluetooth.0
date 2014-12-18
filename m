Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 0/3] attrib/gattrib: Add tracking request id
Date: Thu, 18 Dec 2014 14:46:04 +0100
Message-Id: <1418910367-19792-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this set, gattrib is tracking it's internal request id.
This is important for the user of gattrib, as now user is sure that request id
he has is valid during whole gattrib operation. Even gattrib is doing more then one
ATT request.

v1: Track only user defined request id's.
v2: Handle Marcel's comments to patch 01 and added patch 03\03 which add
support to track all the gattrib requests. So now if gattrib user does cancel_all
only gattrib request will be canceled. This is needed as bt_att is shared.

First two patches help us to solve issues in Android, third one is not needed by
Android but for normal BlueZ.


Lukasz Rymanowski (2):
  attrib/gattrib: Add track for internal request id
  attrib/gatt: Fix for search services

*** BLURB HERE ***

Lukasz Rymanowski (3):
  attrib/gattrib: Add track for request ids
  attrib/gatt: Fix for search services
  attrib/gattrib: Add tracking all the internal request id

 attrib/gatt.c    | 43 ++++++++++++++++++-------
 attrib/gattrib.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 14 deletions(-)

-- 
1.8.4

