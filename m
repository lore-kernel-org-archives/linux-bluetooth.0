Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH v3 BlueZ 0/2] Add support for find included services
Date: Mon, 30 Jul 2012 11:24:33 -0400
Message-Id: <1343661875-27700-1-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series introduces support for find included services.
The interactive mode of gatttool receives a new command "included" that
uses gatt_find_included to find these services in given range.

After some refactors, that version looks a lot easier to read and understand.
It was tested with PTS v4.5.0.10.

Jefferson Delfes (2):
  GATT: Add support for find included services
  gatttool: Add "included" command

 attrib/gatt.c        | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gatt.h        |   9 +++
 attrib/interactive.c |  60 ++++++++++++++++
 3 files changed, 264 insertions(+)

-- 
1.7.11.3

