Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 00/16] attrib: Replace GLib basic data types usage
Date: Thu, 28 Mar 2013 11:39:04 -0400
Message-Id: <1364485160-22720-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are some places that we don't need to use GLib date types. For instance
local variables, fields that dont't go through GLib or return vars.
That patch series do some atomic changes over attrib/gattrib for this purpose.

More changes are coming over attrib/ dir in next days.

Jefferson Delfes (16):
  attrib: Simplify boolean tests
  attrib: Change GAttrib->stale type from gboolean
  attrib: Change command->sent type from gboolean
  attrib: Change is_response return type from gboolean
  attrib: Change match_event return type from gboolean
  attrib: Change g_attrib_set_destroy_function return type
  attrib: Change g_attrib_cancel/_all return type
  attrib: Change g_attrib_unregister/_all return type
  attrib: Change g_attrib_set_debug return type from gboolean
  attrib: Change g_attrib_set_mtu return type from gboolean
  attrib: Change g_attrib_is_encrypted return type from gboolean
  attrib: Change command->opcode type from guint8
  attrib: Change event->handle type from guint16
  attrib: Change command->id type from guint
  attrib: Change event->id type from guint
  attrib: Change command->pdu pointer type from guint8

 attrib/gatt.c        |   5 +-
 attrib/gattrib.c     | 129 ++++++++++++++++++++++++++-------------------------
 attrib/gattrib.h     |  28 +++++------
 attrib/gatttool.c    |   9 ++--
 attrib/interactive.c |   1 +
 attrib/utils.c       |   1 +
 src/attrib-server.c  |   2 +-
 7 files changed, 90 insertions(+), 85 deletions(-)

-- 
1.8.2

