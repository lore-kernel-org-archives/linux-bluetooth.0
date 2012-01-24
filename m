Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: GATT service improvements
Date: Tue, 24 Jan 2012 12:06:20 +0100
Message-Id: <1327403188-21981-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set of patches enables GATT service definitions using 128-bit
UUIDs. At the present, only 16 bit UUIDs are allowed in gatt-service.
Furthermore, these patches fix the problem of having multiple
service declarations for both 16 and 128 bit by allocating the former
ones at the beginning of the database, and 128-bit services at the
end. This feature is required in GATT when multiple services exist,
service definitions with service declarations using 16-bit UUID should
be grouped together and 128-bit UUID serviecs should be grouped
together as well. BT 4.0 [Vol 3] 3.1.

These patches also replace the single database list for handlers with
a double linked list in order to improve allocation operations for
128-bit service declaration at the end of the list.

Comments are welcome.

[PATCH 1/8] gatt-service: Add support for 128-bit Bluetooth UUIDs
[PATCH 2/8] gatt-service: Move va_end just after processing the
[PATCH 3/8] gatt-service: Provide service uuid in
[PATCH 4/8] attrib-server: Allocate 16-bits UUIDS at the begining of
[PATCH 5/8] attrib-server: Set database uuids as a double linked
[PATCH 6/8] glib-compat: Add g_list_free_full to deal with issues in
[PATCH 7/8] attrib-server: Allocate 128-bits UUIDs using highest
[PATCH 8/8] gatt-example: Fix g_assert checks when an uint16_t value
