Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/7] CCC persistence
Date: Thu, 13 Oct 2011 11:43:17 -0300
Message-Id: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches implement the storage of the Client Characteristic
Configuration: controls notification & indication.

Bonding verification is coming in the next patch series.

Based on the requirements of the available profiles attrib server will
require some changes. The future plan is to move attribute values to
plugins (eg: time) and keep only the attribute declaration in the attrib
server.

Claudio Takahasi (6):
  Remove CCC for read by group
  Remove CCC for read by type
  Add CCC persistence in attrib server
  Remove notification and indication from server
  Remove CCC entries when device is removed
  Add generic function to delete by pattern

Vinicius Costa Gomes (1):
  Add storage functions to deal with CCC

 src/attrib-server.c |  217 ++++++++++-----------------------------------------
 src/storage.c       |  100 +++++++++++++++++-------
 src/storage.h       |    4 +
 3 files changed, 116 insertions(+), 205 deletions(-)

-- 
1.7.7

