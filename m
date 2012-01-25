Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: GATT improvements v2
Date: Wed, 25 Jan 2012 11:03:02 +0100
Message-Id: <1327485790-26249-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set includes all changes suggested in previous version.

[PATCH 1/8] gatt-service: Add support for 128-bit Bluetooth UUIDs
[PATCH 2/8] gatt-service: Move va_end just after processing the
[PATCH 3/8] gatt-service: Provide service uuid in
[PATCH 4/8] attrib-server: Allocate 16-bits UUIDS at the begining of
[PATCH 5/8] attrib-server: Set database uuids as a double linked
[PATCH 6/8] glib-compat: Add g_list_free_full to deal with issues in
[PATCH 7/8] attrib-server: Allocate 128-bits UUIDs using highest
[PATCH 8/8] gatt-example: Fix g_assert checks when an uint16_t value
