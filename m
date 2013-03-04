Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 0/6] attrib: Remove glib basic data types usage
Date: Mon,  4 Mar 2013 16:58:44 -0400
Message-Id: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series do a cleanup of glib basic data types usage. Types as
gpointer, guint, gint, gchar and gsize were replaced by standard types without
any extra effort. The only exception was gboolean which needs stdbool.h.
Some variables were mainted as gboolean, because are passed as parameter to
glib functions.

Jefferson Delfes (6):
  gattrib: remove glib basic data types usage
  GATT: remove glib basic data types usage
  attrib: remove glib basic data types usage
  gatttool: remove glib basic data types usage
  attrib: simplify boolean tests
  attrib: removing gboolean usage when possible

 attrib/att-database.h |   6 +-
 attrib/gatt-service.c |  32 ++++-----
 attrib/gatt-service.h |   2 +-
 attrib/gatt.c         | 183 ++++++++++++++++++++++++++------------------------
 attrib/gatt.h         |  48 ++++++-------
 attrib/gattrib.c      | 181 +++++++++++++++++++++++++------------------------
 attrib/gattrib.h      |  44 ++++++------
 attrib/gatttool.c     | 104 ++++++++++++++--------------
 attrib/gatttool.h     |   8 +--
 attrib/interactive.c  |  55 ++++++++-------
 attrib/utils.c        |   7 +-
 11 files changed, 337 insertions(+), 333 deletions(-)

-- 
1.8.1.4

