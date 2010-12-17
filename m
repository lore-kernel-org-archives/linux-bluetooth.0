Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
Cc: rshaffer@codeaurora.org, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
Subject: [RFC 0/1] Implement Compound (Multi-step) GATT Procedure Support
Date: Fri, 17 Dec 2010 14:48:50 -0800
Message-Id: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


The following two proposed patches implement a method for correctly
staging GATT procedures that require multiple ATT req/resp exchanges.

The first RFC / PATCH is gattrib.[ch], which allows the caller to specify
a gboolean indicating that the command being queued is Compound
(even if the procedure ends up being single/atomic) and a queue ID
number, which allows the caller to cancel the GATT procedure at any
stage of the transaction.

IF -
The ATT opcode being queued is specified as compound, the resulting response
will not cause the next item in the queue to be sent until *after* the
response has been forwarded to the caller via the response callback.

IF -
The ATT opcode being queued is *not* compound, the resulting response
will service the pkt queue immediately (legacy functionality).

IF -
The ID passed to g_attrib_send_seq is ZERO, the command pkt will
be added to the TAIL of the queue, and a new ID assigned to it.
(Legacy functionality)

IF -
The ID passed to g_attrib_send_seq is NON-ZERO, the command pkt
will be added to the HEAD of the queue, causing it to be the next
pkt sent to the remote device.  The NON-ZERO ID is also then able
to cancel the command.


The second RFC / PATCH is to gatt.c. It modifies the existing gatt_read_char()
function to recognize the need for a compound Read procedure, and implements
it as a READ_REQ + READ_BLOB_REQ + READ_BLOB_REQ ...<etc> as needed, using
the g_attrib_send_seq() logic from the first RFC / PATCH.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
