Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <naresh.gupta@stericsson.com>,
	Vishal Agarwal <vishal.agarwal@stericsson.com>
Subject: [PATCH BlueZ v3 0/2] Add Support for BLE Services to Adapter
Date: Tue, 24 Jan 2012 09:19:58 +0530
Message-ID: <1327377000-17048-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When DBUS command of "GetProperties is sent to BlueZ on ADAPTER_INTERFACE, it is expected that in the property "UUIDs" it should return uuids of all the profiles and services that it supports. But right now it does not include uuids of BLE services. For example UUIDs of LinkLossService, ImmediateAlert etc are not included in the list of UUIDs returned by BlueZ in response of GetProperties.


As the structures of sdp-record (for BR/EDR profiles) and primary-services (for BLE services) is different, I propose to have another variable "primary" (of type GSList*) in btd_adapter.It will contain UUIDs of all the primary services.


Vishal Agarwal (2):
  Adapter-Add-Support-for-BLE-Services-to-Adapter
  Add-support-for-proximity-UUIDs-in-adapter

 lib/sdp.h           |    3 ++
 proximity/manager.c |   23 ++++++++++++++++++
 src/adapter.c       |   63 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.h       |    2 +
 4 files changed, 89 insertions(+), 2 deletions(-)

