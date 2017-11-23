Return-Path: <andriy.shevchenko@linux.intel.com>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] seq_file, Bluetooth: introduce DEFINE_SHOW_ATTRIBUTE()
Date: Thu, 23 Nov 2017 22:36:03 +0200
Message-Id: <20171123203605.44954-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Introduce a helper macro for attributes that have only ->show() defined.

P.S. I have few more clean ups locally, thus it would be nice to have an
immutable branch for the rest patches which would like to utilize the new
macro.

In v2:
- introduce for all users followed by an example clean up of hci_debugfs.c

Andy Shevchenko (2):
  seq_file: Introduce DEFINE_SHOW_ATTRIBUTE() helper macro
  Bluetooth: Re-use DEFINE_SHOW_ATTRIBUTE() macro

 include/linux/seq_file.h    |  13 +++
 net/bluetooth/hci_debugfs.c | 193 ++++----------------------------------------
 2 files changed, 29 insertions(+), 177 deletions(-)

-- 
2.15.0
