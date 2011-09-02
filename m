Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 0/3] Fix Legacy Pairing using the mgmt interface
Date: Fri,  2 Sep 2011 14:51:19 -0300
Message-Id: <1314985882-24059-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

During tests it was found a problem that when using the mgmt to pair
devices that only support Legacy Pairing, it was not working. Here are
some logs[1].

The problem is that pairing was using the HIGH security level, which
for devices without SSP support means using a 16 digit pin code. Which
is unacceptable in most scenarios.

One question that might be asked is why this isn't a problem when not
using the mgmt interface. The problem doesn't happen when using the
hciops backend because the way that the pin code is requested in
userspace (the interesting bit is at plugins/hciops.c:1348, inside
pin_code_request()), userspace at that point has no information if the
pin code request should be marked as "secure" or not.

The solution for this problem is divided in two main parts, adding one
more condition for deciding whether to authenticate the link, if the
link requires MITM protection no matter the security level we should
authenticate the link. The other part is to decrease the requested
security level when pairing using the mgmt interface.


Cheers,
--

[1] http://littlechina.org/~vcgomes/hcidump-master.txt
    http://littlechina.org/~vcgomes/hcidump-slave.txt
    http://littlechina.org/~vcgomes/kernel-log.txt


Vinicius Costa Gomes (3):
  Bluetooth: Require authentication if MITM protection is requested
  Bluetooth: Fix not sending a Link Key Negative Reply
  Bluetooth: Use the MEDIUM security level for pairings

 net/bluetooth/hci_event.c |   13 ++++++++-----
 net/bluetooth/mgmt.c      |    8 +++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

--
1.7.6.1

