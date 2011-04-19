Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 0/4] Remove deprecated fields from struct hci_dev
Date: Tue, 19 Apr 2011 16:33:59 -0400
Message-Id: <1303245243-12116-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches remove unused fields from struct hci_dev. The adapter name is
moved to struct btd_adapter. The entire struct hci_dev will be gone once the
device discovery logic is moved to the hciops/mgmtops plugin.

The last patch removes the read_local_version() from struct btd_adapter_ops. It
was being used only by code which was removed, but we left it in a separate
patch because we don't know if it is okay to remove it completely.

Note that no removed fields are used on D-Bus API nor internally.

Bruna Moreira (4):
  Remove ssp_mode from struct hci_dev
  Remove LMP/HCI version and manufacturer from struct hci_dev
  Move adapter name from struct hci_dev to struct btd_adapter
  Remove read_local_version() from struct btd_adapter_ops

 plugins/hciops.c  |   21 ---------------------
 plugins/mgmtops.c |   18 ------------------
 src/adapter.c     |   52 ++++++++++++++--------------------------------------
 src/adapter.h     |    9 ---------
 4 files changed, 14 insertions(+), 86 deletions(-)

