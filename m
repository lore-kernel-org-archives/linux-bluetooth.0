Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/5] Storage cleanup
Date: Fri,  9 Sep 2011 09:51:04 -0300
Message-Id: <1315572669-5006-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dependency: SMP patches needs to be applied first due conflicts in
storage.{c, h} => "[PATCH BlueZ 00/12] Support for the new mgmt SMP
messages"

This patch series removes useless code in storage.c and contains minor
cosmetic changes.

Claudio Takahasi (5):
  Remove storing device type
  Remove create_file calls for read operations
  Remove not referenced function in storage.c
  Remove unneeded headers included in storage.c
  Fix magic numbers for local/remote name length

 src/adapter.c |   28 -----------------
 src/device.c  |    2 -
 src/storage.c |   91 ++++-----------------------------------------------------
 src/storage.h |    4 --
 4 files changed, 6 insertions(+), 119 deletions(-)

-- 
1.7.6

