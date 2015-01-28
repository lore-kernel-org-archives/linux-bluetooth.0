Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [RFC BlueZ 0/1] Introduce LE Advertising data
Date: Wed, 28 Jan 2015 10:52:15 -0800
Message-Id: <1422471136-18575-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an RFC for introducing a new D-Bus api for manipulating the LE
Advertising data that is sent.  Implementing this will mean some MGMT level
changes to support sending the HCI command correctly and not overwriting the
data when switching modes.

This is meant to be a generic API for setting the data and not specifically
targetted for any particular application, so the goal is completeness to the
spec and clarity while introducing a higher level of abstraction than
"use these bytes".

Michael Janssen (1):
  doc: Add Advertising API documentation

 doc/advertising-api.txt | 124 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 doc/advertising-api.txt

-- 
2.2.0.rc0.207.ga3a616c

