Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 0/3] EFS: last chunks
Date: Mon, 17 Oct 2011 14:35:29 +0300
Message-Id: <1318851332-23700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implementation of EFS based upon series of patches sent upstream in Aug 2010
by Haijun Liu.

http://marc.info/?a=128277503500005&r=1&w=2

Changes:
	* RFC: initial release
	* RFCv2: rebase & take care about comments:
		- use flag in l2cap_chan instead of variable
		- move channel init out from parse_conf_req
		- other style fixes
	* PATCHv1: support only Best Effort channels for now.
	* PATCHv2: disable_flowspec -> enable_hs, style fixes
	* PATCHv3: rebase, split functionality to appropriate
		patches, taking comments from ML.
	* PATCHv4: simplify logic in parse_conf_req function
		following Gustavo comments.

Andrei Emeltchenko (3):
  Bluetooth: EFS: parse L2CAP config request
  Bluetooth: EFS: parse L2CAP config response
  Bluetooth: EFS: implement L2CAP config pending state

 include/net/bluetooth/l2cap.h |    3 +
 net/bluetooth/l2cap_core.c    |  115 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)

-- 
1.7.4.1

