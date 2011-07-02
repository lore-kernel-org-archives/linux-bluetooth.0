Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sat, 2 Jul 2011 13:44:46 -0400
Subject: [PATCH v2 0/1] Bluetooth: Add NULL ACL packet stat
Message-ID: <1309628686.22449.11.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remote devices use the FLOW indicator in the ACL baseband 
packet header to indicate to transmitting devices that the RX
buffer is full. In heavily asymmetric traffic, this can generate
NULL ACL packets (0-length, ACL continuation fragments).

Rather than emit log errors, track this as a device statistic instead.
The corresponding user-space patch to hciconfig outputs the accumulated
NULL packets with the other device statistics.

In reviewing the ioctl (HCIGETDEVINFO) used between km <-> um, I noticed
there is no versioning or size information to prevent km from
overwriting the um stack (eg., using an earlier version of user-space
tools).

Is it generally accepted to force new Bluez with new kernel (and vice
versa)?  In a related query, will the mgmtops interface subsume/replace
this ioctl usage as well?

Peter Hurley (1):
  Bluetooth: l2cap: fix NULL ACL packet handling

 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/l2cap_core.c  |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

-- 
1.7.4.1

