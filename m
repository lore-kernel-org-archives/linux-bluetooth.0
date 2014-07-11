Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: netdev@vger.kernel.org
Cc: marcel@holtmann.org,
	jukka.rissanen@linux.intel.com,
	linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH net-next 0/2] Introduce generic 6LoWPAN branch
Date: Fri, 11 Jul 2014 10:24:17 +0200
Message-Id: <1405067059-18782-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this patch series add a new branch "net/6lowpan" for generic 6LoWPAN code.

Since commit 8df8c56a5abc70af5862aa7cac2875aeeb17a42b ("6lowpan: Moving
generic compression code into 6lowpan_iphc.c") the IPHC compression is shared
between bluetooth 6LoWPAN and IEEE 802.15.4 6LoWPAN. The new 6LoWPAN directory
will contain generic code for 6LoWPAN and futhermore 6LoWPAN upper layer
protocols.

The shared code between bluetooth and 802.15.4 should be review from both
communities. The current behaviour is that get_maintainers.pl returns the
IEEE 802.15.4 community only.


I request a new mailinglist for the IEEE 802.15.4 subsystem at vger but I didn't
get a response now so I add the current sourceforge IEEE 802.15.4 mailinglist to
the MAINTAINERS file. I will update them soon.

- Alex

Alexander Aring (2):
  6lowpan: introduce new net/6lowpan directory
  MAINTAINERS: add net/6lowpan/ maintainer entry

 MAINTAINERS                                       | 7 +++++++
 net/6lowpan/Kconfig                               | 6 ++++++
 net/6lowpan/Makefile                              | 3 +++
 net/{ieee802154/6lowpan_iphc.c => 6lowpan/iphc.c} | 0
 net/Kconfig                                       | 1 +
 net/Makefile                                      | 3 ++-
 net/bluetooth/Kconfig                             | 3 +--
 net/ieee802154/Kconfig                            | 9 +--------
 net/ieee802154/Makefile                           | 5 ++---
 9 files changed, 23 insertions(+), 14 deletions(-)
 create mode 100644 net/6lowpan/Kconfig
 create mode 100644 net/6lowpan/Makefile
 rename net/{ieee802154/6lowpan_iphc.c => 6lowpan/iphc.c} (100%)

-- 
2.0.1
