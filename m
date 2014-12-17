Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/2] attrib/gattrib: Add tracking request id
Date: Wed, 17 Dec 2014 16:26:13 +0100
Message-Id: <1418829975-17375-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this set, gattrib is tracking it's internal request id.
This is important for the user of gattrib, as now user is sure that request id
he has is valid during whole gattrib operation. Even gattrib is doing more then one
ATT request.

Lukasz Rymanowski (2):
  attrib/gattrib: Add track for internal request id
  attrib/gatt: Fix for search services

 attrib/gatt.c    |  43 ++++++++++++++++++------
 attrib/gattrib.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 130 insertions(+), 13 deletions(-)

-- 
1.8.4

