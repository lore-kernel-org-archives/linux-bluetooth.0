Return-Path: <cyrus@holtmann.org>
From: Andrew Earl <andrewx.earl@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrew Earl <andrewx.earl@intel.com>
Subject: Re: [PATCH] bluetooth: Fix aborting eSCO connection in case of error 0x20 
Date: Mon, 10 Mar 2014 10:31:03 +0000
Message-Id: <1394447464-29164-1-git-send-email-andrewx.earl@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A new patch fix has been created with updated commit message containing the btmon trace and sign off as requested.

Thanks,

Andrew


Andrew Earl (1):
  bluetooth: Fix aborting eSCO connection in case of error 0x20

 net/bluetooth/hci_event.c | 1 +
 1 file changed, 1 insertion(+)

-- 
1.7.11.7

