Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Replace btd_attribute with atrribute's handle
Date: Thu,  3 Apr 2014 08:31:54 +0200
Message-Id: <1396506715-21949-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This change can simplify creating gatt server which is considered
as common for Android and dbus.
This approach was discussed with Claudio on IRC.
For now handle is representation of attribute in gatt API.

Comments are welcome

Marcin Kraglak (1):
  gatt: Use attribute's handles instead of btd_attribute in gatt API

 src/gatt-dbus.c | 29 ++++++++++++++++-------------
 src/gatt.c      | 22 +++++++++++-----------
 src/gatt.h      | 42 +++++++++++++++++++++---------------------
 3 files changed, 48 insertions(+), 45 deletions(-)

-- 
1.8.3.1

