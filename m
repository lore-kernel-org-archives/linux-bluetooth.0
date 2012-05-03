Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v0 0/2] D-Bus error from GError
Date: Thu,  3 May 2012 11:44:33 +0200
Message-Id: <1336038275-19591-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

It is common that a D-Bus error message must be create from a GError object. Often this also involves freeing the GError's memory, which leads to boilerplate code. This RFC proposes a helper function in gdbus in order to remove this code.

The proposed name is g_dbus_steal_from_gerror(), which creates a DBusMessage out of a GError object, automatically frees the memory, and sets the pointer to NULL.

This removes 75 error-handling lines from the obex-client codebase, as included in patch 2/2. There are some other occurrences in the server side and also in BlueZ, but these have not been included here.

As returning GError objects starts to be more common in internal APIs (as planned for obex-client), this helper function would be even more convenient.

Mikel Astiz (2):
  gdbus: Add helper function for error-handling
  client: Use new D-Bus helper function

 client/ftp.c     |   85 +++++++++++++++--------------------------------------
 client/manager.c |   12 ++-----
 client/map.c     |   31 ++++++--------------
 client/pbap.c    |   29 +++++-------------
 client/sync.c    |   20 ++++---------
 gdbus/gdbus.h    |    4 ++
 gdbus/object.c   |   11 +++++++
 7 files changed, 66 insertions(+), 126 deletions(-)

-- 
1.7.7.6

