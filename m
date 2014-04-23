Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/gatt: Client connection handling refactor
Date: Wed, 23 Apr 2014 14:26:06 +0200
Message-Id: <1398255967-22167-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is rather big connection handling refactor but each of those little
changes, significantly change connection handling logic. For the reason of not
rewriting it again and again for every change made, single patch was done.
Multiple, connection specific device lists were replaced with one, while
devices store their connection state instead. Client list in each device were
replaced with single, global list, storing (connection_id, client*, device*)
tuples. This seams to be more natural and easier to pass required data to
other functions as most actions are performed by specific clients on specific
device or connection.

Storing such connection describing triplets allows search for the rest
of those three entities, knowing one of them, i.e. when client unregisters
(disconnect all devices connected to client), device disconnects
(notify all clients about disconnection) or specific client disconnects from
single device.

As connection id was previously assigned to and accessed from device,
and now device is accessed from connection record, having unique
connection_id, quite a lot of logic had to be changed, including
notification handling. This change was needed as Android uses
connection_id to identify particular client<->device and not the physical
adapter<->device connection, which is irrelevant on HAL API level.

Changes in compare to RFC:
 * notification destroy invalid read fixed by freeing notifcations
 	before connection are freed
 * renamed device state enum values
 * renamed free_connection to destroy_connection
 * do device's connection reference counting only in create/destroy
 	connection functions for better reference tracking and use
 	destroy_connection on profile cleanup
 * remove double client and device searches in connect handler and move
 	new device creation from connection search helper to connect handler
 * proper connect notifications with GATT_FAILURE are now send on
 	disconnecting devices in connection_pending and connectable states
 * on removal of device in connectable/connection_pending, state check
 	if scan should be stopped was added

Jakub Tyszkowski (1):
  android/gatt: Refactor client connection handling

 android/gatt.c | 957 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 495 insertions(+), 462 deletions(-)

--
1.9.1

