Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCHv2 BlueZ 0/2] Add support for find included services
Date: Fri, 13 Apr 2012 17:01:02 -0400
Message-Id: <1334350864-5509-1-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1333572353-10332-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series introduces support for find included services.
The interactive mode of gatttool receives a new command "included" that
uses gatt_find_included to find these services in given range.

Jefferson Delfes (2):
  GATT: Add support for find included services
  gatttool: Add "included" command

 attrib/gatt.c        |  198 ++++++++++++++++++++++++++++++++++++++++++++++++++
 attrib/gatt.h        |    9 +++
 attrib/interactive.c |   54 ++++++++++++++
 3 files changed, 261 insertions(+)

-- 
1.7.10

