Return-Path: <stephen@networkplumber.org>
From: Stephen Hemminger <stephen@networkplumber.org>
To: yisen.zhuang@huawei.com,
	salil.mehta@huawei.com,
	davem@davemloft.net,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH net-next 0/3] net: make dev_close void
Date: Tue, 18 Jul 2017 15:59:24 -0700
Message-Id: <20170718225927.15944-1-sthemmin@microsoft.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Noticed while working on other changes. Why is dev_close()
returning int, it should be void.  Should also change
ndo_close to be void, but that requires more work and someone
with more coccinelle foo (smpl) than me.

Stephen Hemminger (3):
  bluetooth: 6lowpan dev_close never returns error
  hns: remove useless void cast
  net: make dev_close and related functions void

 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c |  2 +-
 include/linux/netdevice.h                        |  4 ++--
 net/bluetooth/6lowpan.c                          |  4 +---
 net/core/dev.c                                   | 26 ++++++++++--------------
 4 files changed, 15 insertions(+), 21 deletions(-)

-- 
2.11.0
