Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 BlueZ 00/12] Store address type in BR/EDR and shared files
Date: Fri, 27 Jul 2012 16:43:11 -0300
Message-Id: <1343418203-15335-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Just an updated version of the storage patches that Paulo Alcantara sent some
time ago.

Changes from last version:
 * delete_entry now has address and address type parameters;
 * When removing entries, we also remove the entries that have the old format
 (without address type);

Cheers,


Claudio Takahasi (1):
  storage: Store address type in "blocked" file

Paulo Alcantara (10):
  storage: Store address type in "aliases" file
  core: Fix reading from "aliases" and "names" file
  storage: Store address type in "lastseen" file
  storage: Store address type in "lastused" file
  storage: Store address type in "profiles" file
  storage: Store address type in "did" file
  storage: Store address type in "linkkeys" file
  storage: Store address type in "trusts" file
  storage: Store address type in "eir" file
  storage: Store address type in "sdp" file

Vinicius Costa Gomes (1):
  storage: Make it clear that delete_entry only works for addresses

 profiles/input/device.c |    5 +-
 src/adapter.c           |   41 +++++--
 src/device.c            |   70 ++++++------
 src/event.c             |   20 ++--
 src/storage.c           |  286 ++++++++++++++++++++++++++++++++++-------------
 src/storage.h           |   58 ++++++----
 6 files changed, 330 insertions(+), 150 deletions(-)

--
1.7.10.4
