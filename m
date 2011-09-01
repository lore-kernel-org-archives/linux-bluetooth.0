Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 0/7] EFS: extended flow specification option support
Date: Thu,  1 Sep 2011 14:07:29 +0300
Message-Id: <1314875256-6904-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implementation of EFS based upon series of patches sent upstream 22 Aug 2010.

Changes:
	* RFC: initial release
	* RFCv2: rebase & take care about comments:
		- use flag in l2cap_chan instead of variable
		- move channel init out from parse_conf_req
		- other style fixes

Andrei Emeltchenko (7):
  Bluetooth: L2CAP extended feature mask update
  Bluetooth: EFS: definitions and headers for EFS
  Bluetooth: EFS: add disable_flowspec kernel param
  Bluetooth: parse EFS in l2cap config request
  Bluetooth: parse EFS in l2cap config response
  Bluetooth: add EFS option in l2cap conf req
  Bluetooth: EFS: parse l2cap config rsp pending

 include/net/bluetooth/l2cap.h |   49 ++++++++++-
 net/bluetooth/l2cap_core.c    |  208 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 252 insertions(+), 5 deletions(-)

-- 
1.7.4.1

