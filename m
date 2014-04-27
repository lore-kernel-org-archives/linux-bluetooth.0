Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 0/2] Client connection handling refactor
Date: Sun, 27 Apr 2014 17:04:49 +0200
Message-Id: <1398611091-4048-1-git-send-email-jakub.tyszkowski@tieto.com>
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
and now device is accessed from connection record having unique
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

v2 changes:
 * various name fixes
 * simplified some function flow containing if statements and returns
 * added helper for finding device in one of two possible states to avoid
 	double device list iteration, checking for CONNECTING and
 	CONNECTION_PENDING devices
 * removed check for ref counter being decrement below 0 in destroy_connection,
 	as it is the only place where decrementation and destruction are done
 * added missing device free if it cannot be pushed to list
 * removed connection id quasi reuse mechanism in favor of static counter
 * few function renames
 * added CONNECTING device state to postpone scan triggering when some
 	device's connection is ongoing

v3 changes:
 * device state names were changed to better represent their purpose
 * device reference counting was added to safely pass device references to
 	asynchronous callbacks, avoiding dangling pointers
 * failed device connection attempts now sets device to proper DISCONNECTED
 	state instead of CONNECT_INIT

Jakub Tyszkowski (2):
  android/gatt: Refactor client connection handling
  android/gatt: Add DEVICE_CONNECTING state

 android/gatt.c | 1021 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 547 insertions(+), 474 deletions(-)

--
1.9.1

