Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 0/2] Add support for find included services
Date: Tue, 27 Mar 2012 10:06:04 -0400
Message-Id: <1332857166-25002-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series introduces support for find included services.
The interactive mode of gatttool receives a new command "included" that
uses gatt_find_included to find these services in given range.

We don't have any way to test find included services with 128-bit UUID128. Yet in PTS, there is only a 16-bit UUID test case. So if anyone can test this, would be great.
We can also extend plugins/gatt-example.c to test 128-bit UUID includes.

Jefferson Delfes (2):
  GATT: Add support for find included services
  gatttool: Add "included" command

 attrib/gatt.c        |  173 ++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gatt.h        |    9 +++
 attrib/interactive.c |   54 ++++++++++++++++
 3 files changed, 236 insertions(+)

-- 
1.7.9.4

